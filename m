From: okaya@codeaurora.org (Sinan Kaya)
Date: Thu, 4 Jan 2018 07:26:51 -0500
Subject: [PATCH V4 09/26] drm/nouveau: deprecate pci_get_bus_and_slot()
In-Reply-To: <1513661883-28662-10-git-send-email-okaya@codeaurora.org>
References: <1513661883-28662-1-git-send-email-okaya@codeaurora.org>
 <1513661883-28662-10-git-send-email-okaya@codeaurora.org>
Message-ID: <80a0f0ae-af61-f718-74f1-bc330edfff5c@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/19/2017 12:37 AM, Sinan Kaya wrote:
> pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
> where a PCI device is present. This restricts the device drivers to be
> reused for other domain numbers.
> 
> Getting ready to remove pci_get_bus_and_slot() function in favor of
> pci_get_domain_bus_and_slot().
> 
> Replace pci_get_bus_and_slot() with pci_get_domain_bus_and_slot()
> and extract the domain number from
> 1. struct pci_dev
> 2. struct pci_dev through drm_device->pdev
> 3. struct pci_dev through fb->subdev->drm_device->pdev
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  drivers/gpu/drm/nouveau/dispnv04/arb.c           |  4 +++-
>  drivers/gpu/drm/nouveau/dispnv04/hw.c            | 10 +++++++---
>  drivers/gpu/drm/nouveau/nouveau_drm.c            |  3 ++-
>  drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramnv1a.c | 10 +++++++++-
>  4 files changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/dispnv04/arb.c b/drivers/gpu/drm/nouveau/dispnv04/arb.c
> index 90075b6..c79160c 100644
> --- a/drivers/gpu/drm/nouveau/dispnv04/arb.c
> +++ b/drivers/gpu/drm/nouveau/dispnv04/arb.c
> @@ -213,8 +213,10 @@ struct nv_sim_state {
>  	if ((dev->pdev->device & 0xffff) == 0x01a0 /*CHIPSET_NFORCE*/ ||
>  	    (dev->pdev->device & 0xffff) == 0x01f0 /*CHIPSET_NFORCE2*/) {
>  		uint32_t type;
> +		int domain = pci_domain_nr(dev->pdev->bus);
>  
> -		pci_read_config_dword(pci_get_bus_and_slot(0, 1), 0x7c, &type);
> +		pci_read_config_dword(pci_get_domain_bus_and_slot(domain, 0, 1),
> +				      0x7c, &type);
>  
>  		sim_data.memory_type = (type >> 12) & 1;
>  		sim_data.memory_width = 64;
> diff --git a/drivers/gpu/drm/nouveau/dispnv04/hw.c b/drivers/gpu/drm/nouveau/dispnv04/hw.c
> index b985990..0c9bdf0 100644
> --- a/drivers/gpu/drm/nouveau/dispnv04/hw.c
> +++ b/drivers/gpu/drm/nouveau/dispnv04/hw.c
> @@ -216,12 +216,15 @@
>  {
>  	struct nvkm_pll_vals pllvals;
>  	int ret;
> +	int domain;
> +
> +	domain = pci_domain_nr(dev->pdev->bus);
>  
>  	if (plltype == PLL_MEMORY &&
>  	    (dev->pdev->device & 0x0ff0) == CHIPSET_NFORCE) {
>  		uint32_t mpllP;
> -
> -		pci_read_config_dword(pci_get_bus_and_slot(0, 3), 0x6c, &mpllP);
> +		pci_read_config_dword(pci_get_domain_bus_and_slot(domain, 0, 3),
> +				      0x6c, &mpllP);
>  		mpllP = (mpllP >> 8) & 0xf;
>  		if (!mpllP)
>  			mpllP = 4;
> @@ -232,7 +235,8 @@
>  	    (dev->pdev->device & 0xff0) == CHIPSET_NFORCE2) {
>  		uint32_t clock;
>  
> -		pci_read_config_dword(pci_get_bus_and_slot(0, 5), 0x4c, &clock);
> +		pci_read_config_dword(pci_get_domain_bus_and_slot(domain, 0, 5),
> +				      0x4c, &clock);
>  		return clock / 1000;
>  	}
>  
> diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
> index 8d4a5be..33b6139 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_drm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
> @@ -524,7 +524,8 @@ static int nouveau_drm_probe(struct pci_dev *pdev,
>  	}
>  
>  	/* subfunction one is a hdmi audio device? */
> -	drm->hdmi_device = pci_get_bus_and_slot((unsigned int)pdev->bus->number,
> +	drm->hdmi_device = pci_get_domain_bus_and_slot(pci_domain_nr(pdev->bus),
> +						(unsigned int)pdev->bus->number,
>  						PCI_DEVFN(PCI_SLOT(pdev->devfn), 1));
>  
>  	if (!drm->hdmi_device) {
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramnv1a.c b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramnv1a.c
> index 4c07d10..18241c6 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramnv1a.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramnv1a.c
> @@ -28,8 +28,16 @@
>  {
>  	struct pci_dev *bridge;
>  	u32 mem, mib;
> +	int domain = 0;
> +	struct pci_dev *pdev = NULL;
>  
> -	bridge = pci_get_bus_and_slot(0, PCI_DEVFN(0, 1));
> +	if (dev_is_pci(fb->subdev.device->dev))
> +		pdev = to_pci_dev(fb->subdev.device->dev);
> +
> +	if (pdev)
> +		domain = pci_domain_nr(pdev->bus);
> +
> +	bridge = pci_get_domain_bus_and_slot(domain, 0, PCI_DEVFN(0, 1));
>  	if (!bridge) {
>  		nvkm_error(&fb->subdev, "no bridge device\n");
>  		return -ENODEV;
> 

Any feedback here? I don't have any hardware to test the changes. I just did a compile test.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
