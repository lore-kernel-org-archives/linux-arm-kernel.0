From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 21 Jun 2013 14:52:19 +0100
Subject: BUG: commit "ARM: Remove __ARCH_WANT_INTERRUPTS_ON_CTXSW on
 pre-ARMv6 CPUs" breaks armv5 with CONFIG_PREEMPT
In-Reply-To: <51C42AE0.9070506@pengutronix.de>
References: <51C2C0B5.8020802@pengutronix.de> <20130620095705.GA18536@arm.com>
 <51C2D5EF.3040803@pengutronix.de> <20130620102856.GC18536@arm.com>
 <20130620111255.GD18536@arm.com> <51C2E917.9000708@pengutronix.de>
 <51C2EA04.4060701@pengutronix.de> <51C2EBCD.4070206@pengutronix.de>
 <51C42AE0.9070506@pengutronix.de>
Message-ID: <20130621135219.GC4099@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 21, 2013 at 11:28:48AM +0100, Marc Kleine-Budde wrote:
> On 06/20/2013 01:47 PM, Marc Kleine-Budde wrote:
> > From 306d84d5f0645a86e86d539be0546c4ac758d3d4 Mon Sep 17 00:00:00 2001
> > From: Catalin Marinas <catalin.marinas@arm.com>
> > Date: Thu, 20 Jun 2013 12:12:55 +0100
> > Subject: [PATCH] arm: Fix deferred mm switch on VIVT processors
> > 
> > As of commit b9d4d42ad9 (ARM: Remove __ARCH_WANT_INTERRUPTS_ON_CTXSW on
> > pre-ARMv6 CPUs), the mm switching on VIVT processors is done in the
> > finish_arch_post_lock_switch() function to avoid whole cache flushing
> > with interrupts disabled. The need for deferred mm switch is stored as a
> > thread flag (TIF_SWITCH_MM). However, with preemption enabled, we can
> > have another thread switch before finish_arch_post_lock_switch(). If the
> > new thread has the same mm as the previous 'next' thread, the scheduler
> > will not call switch_mm() and the TIF_SWITCH_MM flag won't be set for
> > the new thread.
> > 
> > This patch moves the switch pending flag to the mm_context_t structure
> > since this is specific to the mm rather than thread.
> > 
> > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> > Reported-by: Marc Kleine-Budde <mkl@pengutronix.de>
> > [mkl: add check for mm]
> > Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> 
> Works on $CUSTOMERS's hardware.
> 
> Tested-by: Marc Kleine-Budde <mkl@pengutronix.de>

Thanks.

> Catalin, do you take care of the patch? Please add stable on Cc. The fix
> is needed on kernels >= v3.5.

I'll send it to Russell, if possible it should go in for 3.10. I already
added CC stable in my copy (3.5+).

-- 
Catalin
