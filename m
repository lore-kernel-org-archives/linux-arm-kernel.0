From: tglx@linutronix.de (Thomas Gleixner)
Date: Sun, 27 Mar 2011 10:07:15 +0200 (CEST)
Subject: [patch 02/23] arm: tegra: Remove unused function which fiddles
	with irq_desc
In-Reply-To: <AANLkTi=y9JkpJVCq5G151G9k3d0rAcSH13gi6uGB_gDX@mail.gmail.com>
References: <20110325131617.258789658@linutronix.de>
	<20110325132047.552074703@linutronix.de>
	<4D8E4897.5030705@nvidia.com>
	<alpine.LFD.2.00.1103262118010.31464@localhost6.localdomain6>
	<AANLkTi=y9JkpJVCq5G151G9k3d0rAcSH13gi6uGB_gDX@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1103271004560.31464@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 26 Mar 2011, Colin Cross wrote:

> On Sat, Mar 26, 2011 at 1:24 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > On Sun, 27 Mar 2011, Varun Wadekar wrote:
> >>
> >> Thomas, then how do you think we should handle restoring of gpio states
> >> across suspend-resume cycles?
> >
> > That code is unused. Period. No caller, nothing nada. So what does it
> > handle?
> 
> Tegra suspend support didn't make it into 2.6.39, but should get
> merged in 2.6.40, and will call tegra_gpio_suspend/resume.
> 
> >> > -
> >> > - ? for (i = INT_GPIO_BASE; i < (INT_GPIO_BASE + TEGRA_NR_GPIOS); i++) {
> >> > - ? ? ? ? ? struct irq_desc *desc = irq_to_desc(i);
> >> > - ? ? ? ? ? if (!desc || (desc->status & IRQ_WAKEUP))
> >> > - ? ? ? ? ? ? ? ? ? continue;
> >> > - ? ? ? ? ? enable_irq(i);
> >> > - ? }
> >
> > And this part is totally unacceptable and should have never been
> > merged. Further it is in the way of cleanups to the core code and as
> > there is no user I'm not willing to even think about what it does and
> > why it is there.
> >
> > FYI, the core code deals with interrupt suspending/resuming
> > already. So if there is a problem with that which does not cover your
> > specific problem, then you better talk to me before hacking up such
> > private workarounds and expecting that I tolerate them in unused code.
> 
> Yes, the existing code wrong, and unnecessary.  It was copied from
> mach-tegra/irq.c, which I later fixed, but I missed this one.  I'll
> take this patch for 2.6.39-rc1, which will prevent merge conflicts
> between your tree and the tegra tree in 2.6.40.

You can keep the functions if you need them anyway, but the irq
fiddling needs to go now as it blocks core code cleanups.

Thanks,

	tglx
