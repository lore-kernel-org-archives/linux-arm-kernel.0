From: rostedt@goodmis.org (Steven Rostedt)
Date: Thu, 17 Sep 2015 09:14:51 -0400
Subject: [PATCH v2] arm: add cpu_idle tracepoints to arch_cpu_idle
In-Reply-To: <20150917164424.513801a6@xhacker>
References: <1442424760-4104-1-git-send-email-jszhang@marvell.com>
 <20150917160744.52400e0e@xhacker> <20150917164424.513801a6@xhacker>
Message-ID: <20150917091451.28ce10af@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 17 Sep 2015 16:44:24 +0800
Jisheng Zhang <jszhang@marvell.com> wrote:

> Dear Steven,
> 
> On Thu, 17 Sep 2015 16:07:44 +0800
> Jisheng Zhang <jszhang@marvell.com> wrote:
> 
> > Dear all,
> > 
> > On Thu, 17 Sep 2015 01:32:40 +0800
> > Jisheng Zhang <jszhang@marvell.com> wrote:
> > 
> > > Currently, if cpuidle is disabled or not supported, powertop reports
> > > zero wakeups and zero events. This is due to the cpu_idle tracepoints
> > > are missing.
> > > 
> > > This patch is to make cpu_idle tracepoints always available even if
> > > cpuidle is disabled or not supported.
> > > 
> > > Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> > > ---
> > >  Since v1:
> > >    - ignore arm_pm_idle.
> > 
> > Something related: let's have a look at arch/arm/mach-omap2/pm34xx.c
> > the omap3_pm_idle(void) function, it uses trace_cpu_idle(), should we
> > use the _rcuidle version as below:
> 
> 484546509ce5 ("x86/tracing: Denote the power and cpuidle tracepoints as
> _rcuidle()") make me think we need to fix omap3_pm_idle, right?
> 

Probably. If those tracepoints can be called after rcu_idle_enter()
(see cpuidle_idle_call()), then yes.

-- Steve
