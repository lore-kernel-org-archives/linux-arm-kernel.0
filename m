From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 13 Jan 2014 14:18:11 +0000
Subject: [PATCH RFC 00/26] Migrate more OMAP DMA code to DMA engine
In-Reply-To: <20140109152437.GB27282@n2100.arm.linux.org.uk>
References: <20140102150836.GA3826@n2100.arm.linux.org.uk>
 <20140108012110.GL5074@atomide.com>
 <20140109152437.GB27282@n2100.arm.linux.org.uk>
Message-ID: <20140113141811.GD27282@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 09, 2014 at 03:24:37PM +0000, Russell King - ARM Linux wrote:
> On Tue, Jan 07, 2014 at 05:21:11PM -0800, Tony Lindgren wrote:
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [140102 07:11]:
> > > The following patch series moves code to setup the DMA hardware and
> > > service interrupts from the hardware to the DMA engine driver.  This
> > > reduces the dependency on the legacy DMA implementation.
> > > 
> > > This series does not remove the channel allocation/freeing hooks which
> > > are used to manage the allocation of physical channels - this is the
> > > next step in the evolution.
> > > 
> > > The patches which move the interrupt handling are currently less than
> > > perfect since they're writing to ENABLE_L0 under a different spinlock,
> > > and hence RFC only at the moment.
> > 
> > Nice to see this happening. These seem to work for me based on a quick
> > try on omap2+, but on omap1 the build fails:
> > 
> > arch/arm/mach-omap1/dma.c: In function ?dma_write?:
> > arch/arm/mach-omap1/dma.c:186: error: ?const struct omap_dma_reg? has no member named ?size?
> 
> Right, needs this incremental patch:
> 
> diff --git a/arch/arm/mach-omap1/dma.c b/arch/arm/mach-omap1/dma.c
> index 3afde9628839..404f89e3eeb8 100644
> --- a/arch/arm/mach-omap1/dma.c
> +++ b/arch/arm/mach-omap1/dma.c
> @@ -183,7 +183,7 @@ static inline void dma_write(u32 val, int reg, int lch)
>  	addr += reg_map[reg].stride * lch;
>  
>  	__raw_writew(val, addr);
> -	if (reg_map[reg].size == OMAP_DMA_REG_2X16BIT)
> +	if (reg_map[reg].type == OMAP_DMA_REG_2X16BIT)
>  		__raw_writew(val >> 16, addr + 2);
>  }
>  
> @@ -196,7 +196,7 @@ static inline u32 dma_read(int reg, int lch)
>  	addr += reg_map[reg].stride * lch;
>  
>  	val = __raw_readw(addr);
> -	if (reg_map[reg].size == OMAP_DMA_REG_2X16BIT)
> +	if (reg_map[reg].type == OMAP_DMA_REG_2X16BIT)
>  		val |= __raw_readw(addr + 2) << 16;
>  
>  	return val;
> 

Any news on this?

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
