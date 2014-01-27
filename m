From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 27 Jan 2014 10:51:02 -0500 (EST)
Subject: [PATCH 2/9] ARM64: get rid of arch_cpu_idle_prepare()
In-Reply-To: <20140127154315.GG32608@arm.com>
References: <1390802904-28399-1-git-send-email-nicolas.pitre@linaro.org>
 <1390802904-28399-3-git-send-email-nicolas.pitre@linaro.org>
 <20140127154315.GG32608@arm.com>
Message-ID: <alpine.LFD.2.11.1401271047240.1652@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 27 Jan 2014, Catalin Marinas wrote:

> On Mon, Jan 27, 2014 at 06:08:17AM +0000, Nicolas Pitre wrote:
> > ARM and ARM64 are the only two architectures implementing
> > arch_cpu_idle_prepare() simply to call local_fiq_enable().
> > 
> > We have secondary_start_kernel() already calling local_fiq_enable() and
> > this is done a second time in arch_cpu_idle_prepare() in that case. And
> > enabling FIQs has nothing to do with idling the CPU to start with.
> > 
> > So let's introduce init_fiq_boot_cpu() to take care of FIQs on the boot
> > CPU and remove arch_cpu_idle_prepare(). This is now done a bit earlier
> > at late_initcall time but this shouldn't make a difference in practice
> > given that FIQs are not currently used on ARM64.
> > 
> > Signed-off-by: Nicolas Pitre <nico@linaro.org>
> 
> For arm64, we could simply remove any reference to FIQs. I'm not aware
> of anyone using them.

OK. What if I sumply remove arch_cpu_idle_prepare() and let you do the 
remove the rest?

IMHO I'd simply remove local_fiq_{enable/disable}() from 
arm64/kernel/smp.c and leave the infrastructure in place in case someone 
needs it eventually.  In which case I could include that into my patch 
as well.


Nicolas
