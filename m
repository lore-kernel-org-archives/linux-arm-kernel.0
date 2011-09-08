From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 8 Sep 2011 14:23:02 +0800
Subject: [PATCH 6/6] arm/imx6q: add suspend/resume support
In-Reply-To: <CAGsJ_4x6cUWey=jCxY-LaazxB=WCRAH0tFsKdpJHgy=iMFkjuw@mail.gmail.com>
References: <1315303120-24203-1-git-send-email-shawn.guo@linaro.org>
	<1315303120-24203-7-git-send-email-shawn.guo@linaro.org>
	<CAGsJ_4x6cUWey=jCxY-LaazxB=WCRAH0tFsKdpJHgy=iMFkjuw@mail.gmail.com>
Message-ID: <20110908062301.GK8148@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 07, 2011 at 09:50:44PM +0800, Barry Song wrote:
> > +
> > +static int imx6q_pm_enter(suspend_state_t state)
> > +{
> > + ? ? ? switch (state) {
> > + ? ? ? case PM_SUSPEND_MEM:
> > + ? ? ? ? ? ? ? imx_local_timer_pre_suspend();
> > + ? ? ? ? ? ? ? imx_gpc_pre_suspend();
> > + ? ? ? ? ? ? ? outer_flush_all();
> > + ? ? ? ? ? ? ? outer_disable();
> > + ? ? ? ? ? ? ? imx_set_cpu_jump(0, v7_cpu_resume);
> > +
> > + ? ? ? ? ? ? ? /* Zzz ... */
> > + ? ? ? ? ? ? ? cpu_suspend(0, imx6q_suspend_finish);
> > +
> > + ? ? ? ? ? ? ? imx_smp_prepare();
> > + ? ? ? ? ? ? ? l2x0_of_init(0, ~0UL);
> 
> it is pretty clear and good. i think we can refine
> arch/arm/mach-prima2/pm.c to the way you are suspending/resuming l2.
> on prima2, l2 will totally lose power in suspend cycle. i remember you
> once said imx6q will retain l2 in suspend cycle?
> 
Yes, if you lose L2 power in suspend, it's the easiest way for you to
resume L2.

For my case which retains L2, I actually do not want to call this
function which will invalidate L2.  But since we still have problem
to use rmk's generic suspend/resume updates (ARM: pm: add L2 cache
cleaning for suspend), we have to flush the entire L2 on imx6q for now.

Regards,
Shawn

> > + ? ? ? ? ? ? ? imx_gpc_post_resume();
> > + ? ? ? ? ? ? ? imx_local_timer_post_resume();
> > + ? ? ? ? ? ? ? break;
> > + ? ? ? default:
> > + ? ? ? ? ? ? ? return -EINVAL;
> > + ? ? ? }
> > +
> > + ? ? ? return 0;
> > +}
> thanks
> barry
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
