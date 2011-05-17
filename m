From: premi@ti.com (Premi, Sanjeev)
Date: Tue, 17 May 2011 21:17:38 +0530
Subject: [PATCHv2 0/2] [RFC] Shrink clock data utilizing preprocessor
In-Reply-To: <87r57x4gt8.fsf@ti.com>
References: <1305495958-2236-1-git-send-email-vzapolskiy@gmail.com>
	<87r57x4gt8.fsf@ti.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024CF13F57@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-omap-owner at vger.kernel.org 
> [mailto:linux-omap-owner at vger.kernel.org] On Behalf Of Hilman, Kevin
> Sent: Tuesday, May 17, 2011 6:37 PM
> To: Vladimir Zapolskiy
> Cc: Tony Lindgren; Cousson, Benoit; 
> linux-omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCHv2 0/2] [RFC] Shrink clock data utilizing 
> preprocessor
> 
> Vladimir Zapolskiy <vzapolskiy@gmail.com> writes:
> 
> > This change shows a possibility to utilize C preprocessor to remove
> > redundant data from clock definitions for OMAP4 architecture.
> >
> > If the change is evaluated as a positive one, the same 
> approach could
> > be applied in reducing LOCs from other files, which contain 
> monotonous
> > data enumeration.
> 
> Now that I can apply these patches and look at the result, I 
> still have
> the same opinion.  For me, this results in a major loss of 
> readability.

[sp] I agree here. __VA_ARGS__ in most of the macros make it difficult
     to undertsand the containment relation.

     Multiple inclusion of macros within another makes it difficult
     to follow the chain/ sequence.

     Using a set of changes to illustrate issue with scalability of
     the macros as well:

-static const struct clksel dpll_core_m2_div[] = {
-	{ .parent = &dpll_core_ck, .rates = div31_1to31_rates },
-	{ .parent = NULL },
-};
+DEFINE_CLKSEL(dpll_core_m2_div, dpll_core_ck, div31_1to31_rates);
...
... many lines below...
...
-static const struct clksel iva_hsd_byp_clk_mux_sel[] = {
-	{ .parent = &sys_clkin_ck, .rates = div_1_0_rates },
-	{ .parent = &div_iva_hs_clk, .rates = div_1_1_rates },
-	{ .parent = NULL },
-};
+DEFINE_CLKSEL2(iva_hsd_byp_clk_mux_sel, sys_clkin_ck, div_iva_hs_clk);

    In DEFINE_CLKSEL() we need to pass the "rate" as argument
    and in DEFINE_CLKSEL2() it isn't because we they are hardcoded
    for current implementation.

    But then,

+#define DEFINE_CLKSEL3(_name, _parent0, _parent1, _parent2)		\
+	static const struct clksel _name[] = {				\
+		{ .parent = &_parent0, .rates = div_1_0_rates },	\
+		{ .parent = &_parent1, .rates = div_1_1_rates },	\
+		{ .parent = &_parent2, .rates = div_1_2_rates },	\
+		{ .parent = NULL },					\
+	}
 
    All these definitions don't scale well.

~sanjeev

> 
> Changes just to make nice diffstats are fine, but not when it impacts
> readability, etc.  Especially since this data will likely be 
> eventually
> moved to device tree, I'd rather see consolidation efforts focused
> elsewhere.
> 
> Kevin
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
