From: srinidhi.kasagar@stericsson.com (Srinidhi Kasagar)
Date: Tue, 29 Jan 2013 17:08:53 +0530
Subject: [PATCH v1 1/5] ARM: cache-l2x0: add 'smc' identifier
In-Reply-To: <20130129113325.GG2637@n2100.arm.linux.org.uk>
References: <20130129101328.GA11878@bnru10>
 <20130129113325.GG2637@n2100.arm.linux.org.uk>
Message-ID: <20130129113853.GA22145@bnru10>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 29, 2013 at 12:33:25 +0100, Russell King - ARM Linux wrote:
> On Tue, Jan 29, 2013 at 03:43:31PM +0530, srinidhi kasagar wrote:
> > Add 'smc' (Secure Monitor Call) identifier to differentiates
> > the platforms which implements this.
> 
> This patch makes no sense.
> 
> So, if setting 'smc' in the DT description is supposed to mean that
> the platform has a secure monitor then...
> 
> > +	is_smc = of_property_read_bool(np, "smc");
> > +
> > +	if (is_smc) {
> > +		/* set the debug interface */
> > +		outer_cache.set_debug = pl310_set_debug;
> > +	}
> 
> Now, let's look at what pl310_set_debug() does:
> 
> static void pl310_set_debug(unsigned long val)
> {
>         writel_relaxed(val, l2x0_base + L2X0_DEBUG_CTRL);
> }
> 
> Can you explain where the secure monitor call is there please, because
> I can't see one.  In fact, this is the function used when there _isn't_
> a secure monitor.  So this patch just seems totally wrong to me.

Today, one and only platform is omap. Please check below snapshot: 

--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -51,6 +51,7 @@
 		reg = <0x48242000 0x1000>;
 		cache-unified;
 		cache-level = <2>;
+		smc;
 	};

[...]

--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -214,7 +214,7 @@ static int __init omap_l2_cache_init(void)
 	if (of_have_populated_dt())
 		l2x0_of_init(aux_ctrl, L2X0_AUX_CTRL_MASK);
 	else
-		l2x0_init(l2cache_base, aux_ctrl, L2X0_AUX_CTRL_MASK);
+		l2x0_init(l2cache_base, aux_ctrl, L2X0_AUX_CTRL_MASK, true);


regards/srinidhi
