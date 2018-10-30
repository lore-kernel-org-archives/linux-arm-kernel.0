From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 30 Oct 2018 09:32:39 +0000
Subject: [PATCH 4/6] of/fdt: Populate phys_initrd_start/phys_initrd_size
 from FDT
In-Reply-To: <20181029235206.30060-5-f.fainelli@gmail.com>
References: <20181029235206.30060-1-f.fainelli@gmail.com>
 <20181029235206.30060-5-f.fainelli@gmail.com>
Message-ID: <20181030093239.GJ30658@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 29, 2018 at 04:52:04PM -0700, Florian Fainelli wrote:
> If the architecture implements ARCH_HAS_PHYS_INITRD, make the FDT
> scanning code populate the physical address of the start of the FDT and
> its size.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  arch/arm/mm/init.c | 2 +-
>  drivers/of/fdt.c   | 4 ++++
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
> index 8f364aa24172..517e95cfb5d2 100644
> --- a/arch/arm/mm/init.c
> +++ b/arch/arm/mm/init.c
> @@ -237,7 +237,7 @@ static void __init arm_initrd_init(void)
>  	phys_addr_t start;
>  	unsigned long size;
>  
> -	/* FDT scan will populate initrd_start */
> +	/* FDT scan will populate initrd_start and phys_initrd_start */
>  	if (initrd_start && !phys_initrd_size) {
>  		phys_initrd_start = __virt_to_phys(initrd_start);
>  		phys_initrd_size = initrd_end - initrd_start;

We should be able to delete the whole if () { } block and comment as
a result of this series - it was added by Rob in 65939301acdb to
unify the DT initrd code.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
