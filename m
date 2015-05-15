From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 15 May 2015 11:10:28 +0100
Subject: [PATCH v2] ARM: l2c: Add support for the "arm, shared-override"
 property
In-Reply-To: <20150507160257.GA11067@e104818-lin.cambridge.arm.com>
References: <1430990831-23825-1-git-send-email-geert+renesas@glider.be>
 <20150507160257.GA11067@e104818-lin.cambridge.arm.com>
Message-ID: <20150515101028.GH2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 07, 2015 at 05:02:57PM +0100, Catalin Marinas wrote:
> On Thu, May 07, 2015 at 11:27:11AM +0200, Geert Uytterhoeven wrote:
> > diff --git a/Documentation/devicetree/bindings/arm/l2cc.txt b/Documentation/devicetree/bindings/arm/l2cc.txt
> > index 0dbabe9a6b0abb91..2484aed78c86546d 100644
> > --- a/Documentation/devicetree/bindings/arm/l2cc.txt
> > +++ b/Documentation/devicetree/bindings/arm/l2cc.txt
> > @@ -67,6 +67,12 @@ Optional properties:
> >    disable if zero.
> >  - arm,prefetch-offset : Override prefetch offset value. Valid values are
> >    0-7, 15, 23, and 31.
> > +- arm,shared-override : The default behavior of the pl310 cache controller with
> > +  respect to the shareable attribute is to transform "normal memory
> > +  non-cacheable transactions" into "cacheable no allocate" (for reads) or
> > +  "write through no write allocate" (for writes).
> > +  On systems where this may cause DMA buffer corruption, this property must be
> > +  specified to indicate that such transforms are precluded.
> >  
> >  Example:
> >  
> > diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
> > index e309c8f35af5af61..86d0e7461e5b0b18 100644
> > --- a/arch/arm/mm/cache-l2x0.c
> > +++ b/arch/arm/mm/cache-l2x0.c
> > @@ -1149,6 +1149,11 @@ static void __init l2c310_of_parse(const struct device_node *np,
> >  		}
> >  	}
> >  
> > +	if (of_property_read_bool(np, "arm,shared-override")) {
> > +		*aux_val |= L2C_AUX_CTRL_SHARED_OVERRIDE;
> > +		*aux_mask &= ~L2C_AUX_CTRL_SHARED_OVERRIDE;
> > +	}
> > +
> >  	prefetch = l2x0_saved_regs.prefetch_ctrl;
> >  
> >  	ret = of_property_read_u32(np, "arm,double-linefill", &val);
> 
> It looks fine to me.
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> 
> (even better if a subsequent patch adds this property to all the dts
> files containing "arm,pl310" ;))

Even better would be for the boot loader/firmware to set the bit.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
