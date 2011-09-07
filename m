From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 7 Sep 2011 15:46:24 +0800
Subject: [PATCH 4/6] arm/imx6q: add smp and cpu hotplug support
In-Reply-To: <CAMQu2gwcT4CnDXHLzH1+awvULaHfOyQdpgc+qKj0xhFkV7-0Pw@mail.gmail.com>
References: <1315303120-24203-1-git-send-email-shawn.guo@linaro.org>
	<1315303120-24203-5-git-send-email-shawn.guo@linaro.org>
	<1588593.gaQsrFqt8B@wuerfel>
	<20110907044144.GD8148@S2100-06.ap.freescale.net>
	<CAMQu2gwcT4CnDXHLzH1+awvULaHfOyQdpgc+qKj0xhFkV7-0Pw@mail.gmail.com>
Message-ID: <20110907074623.GF8148@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 07, 2011 at 10:38:10AM +0530, Shilimkar, Santosh wrote:
> On Wed, Sep 7, 2011 at 10:11 AM, Shawn Guo <shawn.guo@freescale.com> wrote:
> > On Tue, Sep 06, 2011 at 08:53:07PM +0200, Arnd Bergmann wrote:
> >> On Tuesday 06 September 2011 17:58:38 Shawn Guo wrote:
> >> > It adds smp and cpu hotplug support for imx6q.
> >> > +static u32 twd_saved_regs[4];
> >> > +static int twd_irq;
> >> > +
> >> > +/*
> >> > + * Resuming from ARM Dormant/Shutdown mode, the boot procedure will
> >> > + * re-setup local timer for secondary cores. ?For primary core, it
> >> > + * has to take care of itself with the following pair of functions
> >> > + * during suspend/resume.
> >> > + */
> >> > +void imx_local_timer_pre_suspend(void)
> >> > +{
> >> > + ? twd_saved_regs[0] = __raw_readl(twd_base + TWD_TIMER_LOAD);
> >> > + ? twd_saved_regs[1] = __raw_readl(twd_base + TWD_TIMER_COUNTER);
> >> > + ? twd_saved_regs[2] = __raw_readl(twd_base + TWD_TIMER_CONTROL);
> >> > + ? twd_saved_regs[3] = __raw_readl(twd_base + TWD_TIMER_INTSTAT);
> >> > +}
> >> > +
> >> > +void imx_local_timer_post_resume(void)
> >> > +{
> >> > + ? __raw_writel(twd_saved_regs[0], twd_base + TWD_TIMER_LOAD);
> >> > + ? __raw_writel(twd_saved_regs[1], twd_base + TWD_TIMER_COUNTER);
> >> > + ? __raw_writel(twd_saved_regs[2], twd_base + TWD_TIMER_CONTROL);
> >> > + ? __raw_writel(twd_saved_regs[3], twd_base + TWD_TIMER_INTSTAT);
> >> > +
> >> > + ? gic_enable_ppi(twd_irq);
> >> > +}
> >>
> >> readl_relaxed()?
> >>
> > Ok. ?You get the best judgement on this.
> >
> You don't have to save local timer registers any more. The local timer
> is always re-configued and this is already handled in common kernel.
> 
> You can drop above change and test your patches. I am sure they will
> still work.
> 
Ah, yes.  This registers saving/restoring was added together with
cpu0 twd_irq enabling when I use git_reinit() approach, which turns
out to be unnecessary.  This pair of imx_local_timer_pre_suspend/resume
can totally be removed now, since "CPU PM notifiers" patches come to
play.

Thanks for catching this, Santosh.

-- 
Regards,
Shawn
