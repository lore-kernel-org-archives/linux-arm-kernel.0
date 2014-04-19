From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 19 Apr 2014 20:43:34 +0100
Subject: [PATCH v2 5/7] ARM: dma: Use dma_pfn_offset for dma address
 translation
In-Reply-To: <1397917972-6293-6-git-send-email-santosh.shilimkar@ti.com>
References: <1397917972-6293-1-git-send-email-santosh.shilimkar@ti.com>
 <1397917972-6293-6-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20140419194334.GL24070@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 19, 2014 at 10:32:50AM -0400, Santosh Shilimkar wrote:
> From: Grygorii Strashko <grygorii.strashko@ti.com>
> 
> In most of cases DMA addresses can be performed using offset value of
>  Bus address space relatively to physical address space as following:
> 
> PFN->DMA:
>  __pfn_to_phys(pfn + [-]dma_pfn_offset)
> 
> DMA->PFN:
>  __phys_to_pfn(dma_addr) + [-]dma_pfn_offset
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: Grant Likely <grant.likely@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/include/asm/dma-mapping.h |   17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
> index e701a4d..8c12149 100644
> --- a/arch/arm/include/asm/dma-mapping.h
> +++ b/arch/arm/include/asm/dma-mapping.h
> @@ -58,22 +58,31 @@ static inline int dma_set_mask(struct device *dev, u64 mask)
>  #ifndef __arch_pfn_to_dma
>  static inline dma_addr_t pfn_to_dma(struct device *dev, unsigned long pfn)
>  {
> -	return (dma_addr_t)__pfn_to_bus(pfn);
> +	if (!dev)
> +		return DMA_ERROR_CODE;
> +	return (dma_addr_t)__pfn_to_bus(pfn - dev->dma_pfn_offset);

How do ISA devices (iow, those which pass a NULL device) work with this?
This looks to me like it ends up breaking some drivers.

I've also seen some drivers (such as the Freescale FEC driver) which
perform DMA coherent allocations with a NULL device - technically, that's
a bug in the driver, but the above change will cause them to regress.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
