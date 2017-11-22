From: linux@roeck-us.net (Guenter Roeck)
Date: Wed, 22 Nov 2017 07:07:51 -0800
Subject: [11/30] hwmon: (coretemp) deprecate pci_get_bus_and_slot()
In-Reply-To: <1511328675-21981-12-git-send-email-okaya@codeaurora.org>
References: <1511328675-21981-12-git-send-email-okaya@codeaurora.org>
Message-ID: <20171122150751.GA25158@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 22, 2017 at 12:30:56AM -0500, Sinan Kaya wrote:
> pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
> where a PCI device is present. This restricts the device drivers to be
> reused for other domain numbers.
> 
> Use pci_get_domain_bus_and_slot() with a domain number of 0 where we can't
> extract the domain number. Other places, use the actual domain number from
> the device.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  drivers/hwmon/coretemp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
> index c13a4fd..4bdbf77 100644
> --- a/drivers/hwmon/coretemp.c
> +++ b/drivers/hwmon/coretemp.c
> @@ -246,7 +246,8 @@ static int adjust_tjmax(struct cpuinfo_x86 *c, u32 id, struct device *dev)
>  	int err;
>  	u32 eax, edx;
>  	int i;
> -	struct pci_dev *host_bridge = pci_get_bus_and_slot(0, PCI_DEVFN(0, 0));
> +	u16 devfn = PCI_DEVFN(0, 0);
> +	struct pci_dev *host_bridge = pci_get_domain_bus_and_slot(0, 0, devfn);
>  
>  	/*
>  	 * Explicit tjmax table entries override heuristics.
