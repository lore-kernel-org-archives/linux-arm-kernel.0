From: jszhang@marvell.com (Jisheng Zhang)
Date: Thu, 17 Sep 2015 00:56:47 +0800
Subject: [PATCH] arm64: add cpu_idle tracepoints to arch_cpu_idle
In-Reply-To: <20150916161605.GA29663@red-moon>
References: <1442413401-2955-1-git-send-email-jszhang@marvell.com>
 <20150916144738.GA23245@red-moon>	<20150916225312.0d4d32c5@xhacker>
 <20150916231105.11a0e65e@xhacker>	<20150916161605.GA29663@red-moon>
Message-ID: <20150917005647.70dc907f@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 16 Sep 2015 17:16:05 +0100
Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:

> On Wed, Sep 16, 2015 at 04:11:05PM +0100, Jisheng Zhang wrote:
> > Dear Lorenzo,
> > 
> > On Wed, 16 Sep 2015 22:53:12 +0800
> > Jisheng Zhang <jszhang@marvell.com> wrote:
> > 
> > > Dear Lorenzo,
> > > 
> > > On Wed, 16 Sep 2015 15:47:38 +0100
> > > Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
> > > 
> > > > On Wed, Sep 16, 2015 at 03:23:21PM +0100, Jisheng Zhang wrote:
> > > > > Currently, if cpuidle is disabled or not supported, powertop reports
> > > > > zero wakeups and zero events. This is due to the cpu_idle tracepoints
> > > > > are missing.
> > > > > 
> > > > > This patch is to make cpu_idle tracepoints always available even if
> > > > > cpuidle is disabled or not supported.
> > > > > 
> > > > > Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> > > > 
> > > > Is there a reason why this code cannot be moved to the generic idle loop ?
> > > 
> > > Do you mean the cpu_idle_loop() in kernel/sched/idle.c? To be honest, I
> > 
> > Maybe I know now. we need to trace different idle level, for example:
> > 
> > WFI idle: trace_cpu_idle_rcuidle(1, ...);
> > 
> > deeper idle: trace_cpu_idle_rcuidle(2, ...);
> > 
> > Usually, the first argument of trace_cpu_idle_rcuidle() equals to the index
> > of the idle level.
> > 
> > so generic idle loop is not a good candidate.
> 
> You are adding a trace for tracing state 1 (ie default idle state),
> called from arch_cpu_idle(), which is the default idle call when the
> CPUidle framework is not available, so I suggested moving the traces
> you add to arm/arm64 arch_cpu_idle() calls to kernel/sched/idle.c
> (see default_idle_call()) instead of patching architecture code.
> 
> I think you can't do that because on x86 calling arch_cpu_idle()
> does not always mean entering idle state index 1 if I read the code
> correctly (in particular the mwait based implementation - mwait_idle()).
> 
> So never mind, patch is fine (on arm64, on arm you should be careful
> because some arm_pm_idle implementations trace state 1 already -
> see omap3_pm_idle and if you add traces to arch_cpu_idle you should
> remove the traces from mach implementations).

OOPs, I was debugging the cascaded irq issues on Marvell BG4CT SoC. Yes, this
arm_pm_idle should be taken care on arm, I should ignore arm_pm_idle, I'll
cook v2 for arm platform.

Thanks a lot,
Jisheng

> 
> Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
