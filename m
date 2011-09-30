From: premi@ti.com (Premi, Sanjeev)
Date: Fri, 30 Sep 2011 17:39:27 +0530
Subject: [PATCH-V3 2/4] arm:omap:am33xx: Update common OMAP machine
	specific sources
In-Reply-To: <87fwjjcfbt.fsf@ti.com>
References: <hvaibhav@ti.com>
	<1316529142-27564-3-git-send-email-hvaibhav@ti.com>
	<87fwjjcfbt.fsf@ti.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB5930257840691@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-omap-owner at vger.kernel.org 
> [mailto:linux-omap-owner at vger.kernel.org] On Behalf Of Hilman, Kevin
> Sent: Tuesday, September 27, 2011 12:16 AM
> To: Hiremath, Vaibhav
> Cc: linux-omap at vger.kernel.org; paul at pwsan.com; 
> tony at atomide.com; linux-arm-kernel at lists.infradead.org; 
> Mohammed, Afzal
> Subject: Re: [PATCH-V3 2/4] arm:omap:am33xx: Update common 
> OMAP machine specific sources
> 
> <hvaibhav@ti.com> writes:
> 
> > From: Afzal Mohammed <afzal@ti.com>
> >
> > This patch updates the common machine specific source files for
> > support for AM33XX/AM335x with cpu type, macros for 
> identification of
> > AM33XX/AM335X device.
> >
> > Signed-off-by: Afzal Mohammed <afzal@ti.com>
> > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> 
> [...]
> 
> > @@ -3576,7 +3579,8 @@ int __init omap3xxx_clk_init(void)
> >  	 * Lock DPLL5 -- here only until other device init code can
> >  	 * handle this
> >  	 */
> > -	if (!cpu_is_ti816x() && (omap_rev() >= OMAP3430_REV_ES2_0))
> > +	if (!cpu_is_ti816x() && !cpu_is_am33xx() &&
> > +			(omap_rev() >= OMAP3430_REV_ES2_0))
> >  		omap3_clk_lock_dpll5();
> 
> This is getting ugly.  
> 
> Instead of continuing to expand this if-list, I think it's time for a
> new feature-flag for whether or not an SoC has DPLL5 instead.

I agree that the code is really getting ugly here. But, isn't
feature-flag going to be over-used with this and similar features?

Just thinking ahead, for these possible cases:
1) An soc adds DPLL6.
2) An soc uses DPLL5, but mechanism to lock is different.

Wouldn't it be better to have a scheme like this:
1) Define a simple structure for DPLLs.
2) Initialize the unused DPLLs to be null/ -1 early
   in arch/soc specific init.
3) The DPLL functions check for corresponding flag on
   entry.

~sanjeev

> 
> Kevin
> 
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
