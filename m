From: premi@ti.com (Premi, Sanjeev)
Date: Fri, 11 Nov 2011 10:21:44 +0000
Subject: [PATCH] ARM: OMAP: PM: only register TWL with voltage layer
 when device is present
In-Reply-To: <8762irg73n.fsf@ti.com>
References: <1320797670-21460-1-git-send-email-khilman@ti.com>
 <E28AAFD00EFAA646AE3DF9B89CD24A89036E64@DBDE01.ent.ti.com>
 <8762irg73n.fsf@ti.com>
Message-ID: <E28AAFD00EFAA646AE3DF9B89CD24A8903E1A5@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 

> -----Original Message-----
> From: Hilman, Kevin 
> Sent: Friday, November 11, 2011 12:04 AM
> To: Premi, Sanjeev
> Cc: linux-omap at vger.kernel.org; 
> linux-arm-kernel at lists.infradead.org; Koyamangalath, Abhilash
> Subject: Re: [PATCH] ARM: OMAP: PM: only register TWL with 
> voltage layer when device is present
> 
> "Premi, Sanjeev" <premi@ti.com> writes:
> 
> >> Current code registers voltage layer details for TWL PMIC 
> even when a
> >> TWL has not been registered.  Fix this to only register 
> the TWL with
> >> voltage layer when the TWL PMIC is initialized by board-level code.
> >> 
> >> Signed-off-by: Kevin Hilman <khilman@ti.com>
> 
> [...]
> 
> > I have been out-of-loop from PM for some time. So my query may be
> > redundant:
> >
> > 1) What happens when different PMIC (not TWL series) is registered
> >    for AM35x? e.g. TPS65023
> >    http://www.spinics.net/lists/linux-omap/msg48630.html
> >
> > 2) Wouldn't we still fall back into omap3_twl_init()?
> 
> I'm not sure I follow the question.
> 
> If you're not using a TWL PMIC (or similar derivative) then
> omap*_twl_init() should not be called.
> 
> If you are using a TWL PMIC, then no, the omap*_twl_init functions
> should not be called.

When I read this function (in the patch), if pmic_i2c_board_info.irq
is non-zero, omap3_twl_init() and omap4_twl_init() are called.

So my question was, for the case when PMIC is not TWL family. Then,
is checking ".irq" sufficient to prevent the execution of twl specific
functions.

 void __init omap_pmic_late_init(void)
 {
 	/* Init the OMAP TWL parameters (if PMIC has been registerd) */
 	if (!pmic_i2c_board_info.irq)
 		return;
 
 	omap3_twl_init();
 	omap4_twl_init();
 }

Shouldn't we check for some "signature" or equiv, before calling the
PMIC specific init? This "signature" can be set when the PMIC is
registered?

Another simplification would be to register the PMIC specific init
function itself during registration; and call here.

~sanjeev

> 
> Kevin
> 
