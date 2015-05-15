From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 15 May 2015 14:55:13 +0100
Subject: [PATCH v2] ARM: l2c: Add support for the "arm, shared-override"
 property
In-Reply-To: <20150515101028.GH2067@n2100.arm.linux.org.uk>
References: <1430990831-23825-1-git-send-email-geert+renesas@glider.be>
 <20150507160257.GA11067@e104818-lin.cambridge.arm.com>
 <20150515101028.GH2067@n2100.arm.linux.org.uk>
Message-ID: <20150515135513.GH19345@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 15, 2015 at 11:10:28AM +0100, Russell King - ARM Linux wrote:
> On Thu, May 07, 2015 at 05:02:57PM +0100, Catalin Marinas wrote:
> > On Thu, May 07, 2015 at 11:27:11AM +0200, Geert Uytterhoeven wrote:
> > > diff --git a/Documentation/devicetree/bindings/arm/l2cc.txt b/Documentation/devicetree/bindings/arm/l2cc.txt
> > > index 0dbabe9a6b0abb91..2484aed78c86546d 100644
> > > --- a/Documentation/devicetree/bindings/arm/l2cc.txt
> > > +++ b/Documentation/devicetree/bindings/arm/l2cc.txt
> > > @@ -67,6 +67,12 @@ Optional properties:
> > >    disable if zero.
> > >  - arm,prefetch-offset : Override prefetch offset value. Valid values are
> > >    0-7, 15, 23, and 31.
> > > +- arm,shared-override : The default behavior of the pl310 cache controller with
> > > +  respect to the shareable attribute is to transform "normal memory
> > > +  non-cacheable transactions" into "cacheable no allocate" (for reads) or
> > > +  "write through no write allocate" (for writes).
> > > +  On systems where this may cause DMA buffer corruption, this property must be
> > > +  specified to indicate that such transforms are precluded.
> > >  
> > >  Example:
> > >  
> > > diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
> > > index e309c8f35af5af61..86d0e7461e5b0b18 100644
> > > --- a/arch/arm/mm/cache-l2x0.c
> > > +++ b/arch/arm/mm/cache-l2x0.c
> > > @@ -1149,6 +1149,11 @@ static void __init l2c310_of_parse(const struct device_node *np,
> > >  		}
> > >  	}
> > >  
> > > +	if (of_property_read_bool(np, "arm,shared-override")) {
> > > +		*aux_val |= L2C_AUX_CTRL_SHARED_OVERRIDE;
> > > +		*aux_mask &= ~L2C_AUX_CTRL_SHARED_OVERRIDE;
> > > +	}
> > > +
> > >  	prefetch = l2x0_saved_regs.prefetch_ctrl;
> > >  
> > >  	ret = of_property_read_u32(np, "arm,double-linefill", &val);
> > 
> > It looks fine to me.
> > 
> > Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> > 
> > (even better if a subsequent patch adds this property to all the dts
> > files containing "arm,pl310" ;))
> 
> Even better would be for the boot loader/firmware to set the bit.

In an ideal world, I agree. But, arguably, we already set other bits in
the PL310 AUXCTRL register (and related cache controllers, just look at
the l2cc.txt bindings).

If you want to rely on firmware, can we at least check this bit and
print a warning? Or go a step further and refuse to enable PL310 when
this bit is clear? Otherwise coherent (non-cacheable) DMA operations are
not safe.

-- 
Catalin
