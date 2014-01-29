From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 29 Jan 2014 13:00:45 -0500 (EST)
Subject: [PATCH 2/9] ARM64: get rid of arch_cpu_idle_prepare()
In-Reply-To: <20140127155755.GH32608@arm.com>
References: <1390802904-28399-1-git-send-email-nicolas.pitre@linaro.org>
 <1390802904-28399-3-git-send-email-nicolas.pitre@linaro.org>
 <20140127154315.GG32608@arm.com>
 <alpine.LFD.2.11.1401271047240.1652@knanqh.ubzr>
 <20140127155755.GH32608@arm.com>
Message-ID: <alpine.LFD.2.11.1401291249240.1652@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 27 Jan 2014, Catalin Marinas wrote:

> On Mon, Jan 27, 2014 at 03:51:02PM +0000, Nicolas Pitre wrote:
> > On Mon, 27 Jan 2014, Catalin Marinas wrote:
> > 
> > > For arm64, we could simply remove any reference to FIQs. I'm not aware
> > > of anyone using them.
> > 
> > OK. What if I sumply remove arch_cpu_idle_prepare() and let you
> > remove the rest?
> > 
> > IMHO I'd simply remove local_fiq_{enable/disable}() from 
> > arm64/kernel/smp.c and leave the infrastructure in place in case someone 
> > needs it eventually.  In which case I could include that into my patch 
> > as well.
> 
> Sounds good. We can keep the local_fiq_*() functions but remove about 4
> calling sites (process.c and smp.c) until needed.

OK here it is.  Please feel free to merge this into your tree directly 
as it no longer has any dependency issues with other patches.

----- >8
From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: [PATCH] ARM64: FIQs are unused

So any FIQ handling is superfluous at the moment.  The functions to 
disable/enable FIQs is kept around if ever someone needs them in the 
future, but existing calling sites including arch_cpu_idle_prepare() 
may go for now.

Signed-off-by: Nicolas Pitre <nico@linaro.org>

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index de17c89985..adeabe8c6b 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -84,11 +84,6 @@ EXPORT_SYMBOL_GPL(pm_power_off);
 void (*arm_pm_restart)(enum reboot_mode reboot_mode, const char *cmd);
 EXPORT_SYMBOL_GPL(arm_pm_restart);
 
-void arch_cpu_idle_prepare(void)
-{
-	local_fiq_enable();
-}
-
 /*
  * This is our default idle handler.
  */
@@ -135,7 +130,6 @@ void machine_restart(char *cmd)
 
 	/* Disable interrupts first */
 	local_irq_disable();
-	local_fiq_disable();
 
 	/* Now call the architecture specific reboot code. */
 	if (arm_pm_restart)
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index a0c2ca602c..94576c02f5 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -159,7 +159,6 @@ asmlinkage void secondary_start_kernel(void)
 	complete(&cpu_running);
 
 	local_irq_enable();
-	local_fiq_enable();
 	local_async_enable();
 
 	/*
@@ -491,7 +490,6 @@ static void ipi_cpu_stop(unsigned int cpu)
 
 	set_cpu_online(cpu, false);
 
-	local_fiq_disable();
 	local_irq_disable();
 
 	while (1)
