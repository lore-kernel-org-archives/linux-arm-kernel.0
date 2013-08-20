From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 20 Aug 2013 18:41:54 +0200
Subject: [PATCH] irqchip: gic: Allow setting affinity to offline CPUs
In-Reply-To: <52139A5B.5040708@codeaurora.org>
References: <1377015070-26320-1-git-send-email-t.figa@samsung.com>
 <52139A5B.5040708@codeaurora.org>
Message-ID: <3879851.vmCHJ3AcgQ@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 20 of August 2013 09:33:31 Stephen Boyd wrote:
> On 08/20/13 09:11, Tomasz Figa wrote:
> > Sometimes it is necessary to fix interrupt affinity to an offline CPU,
> > for example in initialization of local timers. This patch modifies
> > .set_affinity() operation of irq-gic driver to fall back to any
> > possible
> > CPU if no online CPU can be found in requested CPU mask.
> > 
> > This fixes broken Exynos4210 support since commit
> > 
> > 	ee98d27df6 ARM: EXYNOS4: Divorce mct from local timer API
> > 
> > caused by timer initialization code unable to set affinity for local
> > timer interrupts.
> 
> Care to elaborate further? I don't see how the interrupt affinity is set
> for a CPU that isn't online because the mct code runs on the CPU that
> the affinity is being set to.

Well, please look at secondary_start_kernel() in arch/arm/kernel/smp.c [1]. 
You can see that notify_cpu_starting() (line 348) that fires the notifier 
registered in MCT driver is called before set_cpu_online() (line 359) that 
marks the CPU as online. Also notice that, originally, local timer 
initialization was happening after set_cpu_online() - see line 365.

[1] - http://lxr.free-electrons.com/source/arch/arm/kernel/smp.c?a=arm#L312

Best regards,
Tomasz
