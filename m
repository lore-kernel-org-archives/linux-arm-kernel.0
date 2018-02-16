From: helgaas@kernel.org (Bjorn Helgaas)
Date: Fri, 16 Feb 2018 08:54:44 -0600
Subject: [PATCH V3 09/29] drm/i915: deprecate pci_get_bus_and_slot()
In-Reply-To: <1511801886-6753-10-git-send-email-okaya@codeaurora.org>
References: <1511801886-6753-1-git-send-email-okaya@codeaurora.org>
 <1511801886-6753-10-git-send-email-okaya@codeaurora.org>
Message-ID: <20180216145444.GA11014@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 27, 2017 at 11:57:46AM -0500, Sinan Kaya wrote:
> pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
> where a PCI device is present. This restricts the device drivers to be
> reused for other domain numbers.
> 
> Getting ready to remove pci_get_bus_and_slot() function in favor of
> pci_get_domain_bus_and_slot().
> 
> Extract the domain number from drm_device and pass it into
> pci_get_domain_bus_and_slot() function.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>

I don't know what happened to this, and it didn't make it into
v4.16-rc1.  I applied it to pci/deprecate-get-bus-and-slot for v4.17
along with the patch that actually removes pci_get_bus_and_slot().

> ---
>  drivers/gpu/drm/i915/i915_drv.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/i915_drv.c b/drivers/gpu/drm/i915/i915_drv.c
> index 9f45cfe..5a8cb79 100644
> --- a/drivers/gpu/drm/i915/i915_drv.c
> +++ b/drivers/gpu/drm/i915/i915_drv.c
> @@ -419,7 +419,10 @@ static int i915_getparam(struct drm_device *dev, void *data,
>  
>  static int i915_get_bridge_dev(struct drm_i915_private *dev_priv)
>  {
> -	dev_priv->bridge_dev = pci_get_bus_and_slot(0, PCI_DEVFN(0, 0));
> +	int domain = pci_domain_nr(dev_priv->drm.pdev->bus);
> +
> +	dev_priv->bridge_dev =
> +		pci_get_domain_bus_and_slot(domain, 0, PCI_DEVFN(0, 0));
>  	if (!dev_priv->bridge_dev) {
>  		DRM_ERROR("bridge device not found\n");
>  		return -1;
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
