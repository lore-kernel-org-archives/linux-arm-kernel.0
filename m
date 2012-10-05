From: grinberg@compulab.co.il (Igor Grinberg)
Date: Fri, 05 Oct 2012 17:32:41 +0200
Subject: [PATCH 14/16] ARM: pxa: armcore: fix PCI PIO warnings
In-Reply-To: <1349448930-23976-15-git-send-email-arnd@arndb.de>
References: <1349448930-23976-1-git-send-email-arnd@arndb.de>
 <1349448930-23976-15-git-send-email-arnd@arndb.de>
Message-ID: <506EFD99.70007@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/05/12 16:55, Arnd Bergmann wrote:
> The it8152 PCI host used on the pxa/cm_x2xx machines
> uses the old-style I/O window registration. This should
> eventually get converted to pci_ioremap_io() but for
> now, let's cast the IT8152_IO_BASE constant to an integer
> type to get rid of the warnings.
> 
> Without this patch, building cm_x2xx_defconfig results in:
> 
> arch/arm/common/it8152.c: In function 'it8152_pci_setup':
> arch/arm/common/it8152.c:287:18: warning: assignment makes integer from pointer without a cast [enabled by default]
> arch/arm/common/it8152.c:288:16: warning: assignment makes integer from pointer without a cast [enabled by default]
> arch/arm/common/it8152.c:291:17: warning: assignment makes integer from pointer without a cast [enabled by default]
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Krzysztof Halasa <khc@pm.waw.pl>
> Cc: Mike Rapoport <mike@compulab.co.il>
> Cc: Igor Grinberg <grinberg@compulab.co.il>
> Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
> Cc: Eric Miao <eric.y.miao@gmail.com>

Acked-by: Igor Grinberg <grinberg@compulab.co.il>

Thanks!

> ---
>  arch/arm/common/it8152.c |   12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/common/it8152.c b/arch/arm/common/it8152.c
> index c4110d1..001f491 100644
> --- a/arch/arm/common/it8152.c
> +++ b/arch/arm/common/it8152.c
> @@ -284,11 +284,17 @@ int dma_set_coherent_mask(struct device *dev, u64 mask)
>  
>  int __init it8152_pci_setup(int nr, struct pci_sys_data *sys)
>  {
> -	it8152_io.start = IT8152_IO_BASE + 0x12000;
> -	it8152_io.end	= IT8152_IO_BASE + 0x12000 + 0x100000;
> +	/*
> +	 * FIXME: use pci_ioremap_io to remap the IO space here and
> +	 * move over to the generic io.h implementation.
> +	 * This requires solving the same problem for PXA PCMCIA
> +	 * support.
> +	 */
> +	it8152_io.start = (unsigned long)IT8152_IO_BASE + 0x12000;
> +	it8152_io.end	= (unsigned long)IT8152_IO_BASE + 0x12000 + 0x100000;
>  
>  	sys->mem_offset = 0x10000000;
> -	sys->io_offset  = IT8152_IO_BASE;
> +	sys->io_offset  = (unsigned long)IT8152_IO_BASE;
>  
>  	if (request_resource(&ioport_resource, &it8152_io)) {
>  		printk(KERN_ERR "PCI: unable to allocate IO region\n");

-- 
Regards,
Igor.
