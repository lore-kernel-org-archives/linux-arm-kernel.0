From: lixiaoping3@huawei.com (Lixiaoping (Timmy))
Date: Mon, 24 Apr 2017 08:25:07 +0000
Subject: [PATCH v3 15/18] arm64: arch_timer: Enable CNTVCT_EL0 trap if
 workaround is enabled
In-Reply-To: <95ac3477-436a-22ad-80f4-d4bed6c73e1c@arm.com>
References: <20170404171826.25030-1-marc.zyngier@arm.com>
 <20170404171826.25030-16-marc.zyngier@arm.com> <58FDB05B.6020108@huawei.com>
 <95ac3477-436a-22ad-80f4-d4bed6c73e1c@arm.com>
Message-ID: <AF3DCEF48831C6498A12720ADD13CD7F2A5DACA8@dggeml506-mbs.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

Sorry about previous email's confidential info. Please forget it.

+#define ESR_ELx_SYS64_ISS_SYS_CNTFRQ	(ESR_ELx_SYS64_ISS_SYS_VAL(3, 3, 14, 0, 0) | \
+					 ESR_ELx_SYS64_ISS_DIR_READ)

I think (3, 3, 14, 0, 0) should be (3, 3, 0, 14, 0)?

-----------------------------------------------------------------------------
Best Regards,

Timmy Li (Lixiaoping)

-----Original Message-----
From: Marc Zyngier [mailto:marc.zyngier at arm.com] 
Sent: Monday, April 24, 2017 4:13 PM
To: Guohanjun (Hanjun Guo) <guohanjun@huawei.com>; linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>; Catalin Marinas <catalin.marinas@arm.com>; Daniel Lezcano <daniel.lezcano@linaro.org>; Will Deacon <will.deacon@arm.com>; Scott Wood <oss@buserror.net>; Hanjun Guo <hanjun.guo@linaro.org>; Dingtianhong <dingtianhong@huawei.com>; dann frazier <dann.frazier@canonical.com>; Thomas Gleixner <tglx@linutronix.de>; Lixiaoping (Timmy) <lixiaoping3@huawei.com>
Subject: Re: [PATCH v3 15/18] arm64: arch_timer: Enable CNTVCT_EL0 trap if workaround is enabled

On 24/04/17 08:59, Hanjun Guo wrote:
> Hi Marc,
> 
> On 2017/4/5 1:18, Marc Zyngier wrote:
>> Userspace being allowed to use read CNTVCT_EL0 anytime (and not
>> only in the VDSO), we need to enable trapping whenever a cntvct
>> workaround is enabled on a given CPU.
>>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  drivers/clocksource/arm_arch_timer.c | 45 +++++++++++++++++++++++++-----------
>>  1 file changed, 32 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> [...]
>>  #else
>>  #define arch_timer_check_ool_workaround(t,a)		do { } while(0)
>>  #define erratum_set_next_event_tval_virt(...)		({BUG(); 0;})
>>  #define erratum_set_next_event_tval_phys(...)		({BUG(); 0;})
>>  #define erratum_handler(fn, r, ...)			({false;})
>> +#define arch_timer_this_cpu_has_cntvct_wa()		({false;})
>>  #endif /* CONFIG_ARM_ARCH_TIMER_OOL_WORKAROUND */
>>  
>>  static __always_inline irqreturn_t timer_handler(const int access,
>> @@ -660,15 +680,23 @@ static void arch_counter_set_user_access(void)
>>  {
>>  	u32 cntkctl = arch_timer_get_cntkctl();
>>  
>> -	/* Disable user access to the timers and the physical counter */
>> +	/* Disable user access to the timers and both counters */
>>  	/* Also disable virtual event stream */
>>  	cntkctl &= ~(ARCH_TIMER_USR_PT_ACCESS_EN
>>  			| ARCH_TIMER_USR_VT_ACCESS_EN
>> +		        | ARCH_TIMER_USR_VCT_ACCESS_EN
>>  			| ARCH_TIMER_VIRT_EVT_EN
>>  			| ARCH_TIMER_USR_PCT_ACCESS_EN);
>>  
>> -	/* Enable user access to the virtual counter */
>> -	cntkctl |= ARCH_TIMER_USR_VCT_ACCESS_EN;
>> +	/*
>> +	 * Enable user access to the virtual counter if it doesn't
>> +	 * need to be workaround. The vdso may have been already
>> +	 * disabled though.
>> +	 */
>> +	if (arch_timer_this_cpu_has_cntvct_wa())
>> +		pr_info("CPU%d: Trapping CNTVCT access\n", smp_processor_id());
>> +	else
>> +		cntkctl |= ARCH_TIMER_USR_VCT_ACCESS_EN;
> 
> Since CNTVCT_EL0 and CNTFRQ_EL0 share the same control register,then we
> need to trap CNTFRQ_EL0 as well.
> 
> We hit an "undefined instruction" when running Open MPI, which
> read CNTFRQ_EL0 in the user space:
> 
> https://github.com/open-mpi/ompi/blob/5b40fd267f9ddc6463051e402382a988637c3bb3/opal/include/opal/sys/arm64/timer.h
> 
> static inline opal_timer_t
> opal_sys_timer_freq(void) { opal_timer_t freq; __asm__ __volatile__
> ("mrs %0, CNTFRQ_EL0" : "=r" (freq)); return (opal_timer_t)(freq); }
> Please take look :) Thanks Hanjun

Ah, nice :-/ ... Can you please give the patch below a shot?

Thanks,

	M.

>From 3f13e53878356057bde3e023614789d6c6b73628 Mon Sep 17 00:00:00 2001
From: Marc Zyngier <marc.zyngier@arm.com>
Date: Mon, 24 Apr 2017 09:04:03 +0100
Subject: [PATCH] arm64: Add CNTFRQ_EL0 trap handler

We now trap accesses to CNTVCT_EL0 when the counter is broken
enough to require the kernel to mediate the access. But it
turns out that some existing userspace (such as OpenMPI) do
probe for the counter frequency, leading to an UNDEF exception
as CNTVCT_EL0 and CNTFRQ_EL0 share the same control bit.

The fix is to handle the exception the same way we do for CNTVCT_EL0.

Fixes: a86bd139f2ae ("arm64: arch_timer: Enable CNTVCT_EL0 trap if workaround is enabled")
Reported-by: Hanjun Guo <guohanjun@huawei.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/esr.h |  4 ++++
 arch/arm64/kernel/traps.c    | 14 ++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
index ad42e79a5d4d..8ea134f88fda 100644
--- a/arch/arm64/include/asm/esr.h
+++ b/arch/arm64/include/asm/esr.h
@@ -177,6 +177,10 @@
 
 #define ESR_ELx_SYS64_ISS_SYS_CNTVCT	(ESR_ELx_SYS64_ISS_SYS_VAL(3, 3, 2, 14, 0) | \
 					 ESR_ELx_SYS64_ISS_DIR_READ)
+
+#define ESR_ELx_SYS64_ISS_SYS_CNTFRQ	(ESR_ELx_SYS64_ISS_SYS_VAL(3, 3, 14, 0, 0) | \
+					 ESR_ELx_SYS64_ISS_DIR_READ)
+
 #ifndef __ASSEMBLY__
 #include <asm/types.h>
 
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 1de444e6c669..d4d6ae02cd55 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -513,6 +513,14 @@ static void cntvct_read_handler(unsigned int esr, struct pt_regs *regs)
 	regs->pc += 4;
 }
 
+static void cntfrq_read_handler(unsigned int esr, struct pt_regs *regs)
+{
+	int rt = (esr & ESR_ELx_SYS64_ISS_RT_MASK) >> ESR_ELx_SYS64_ISS_RT_SHIFT;
+
+	pt_regs_write_reg(regs, rt, read_sysreg(cntfrq_el0));
+	regs->pc += 4;
+}
+
 struct sys64_hook {
 	unsigned int esr_mask;
 	unsigned int esr_val;
@@ -537,6 +545,12 @@ static struct sys64_hook sys64_hooks[] = {
 		.esr_val = ESR_ELx_SYS64_ISS_SYS_CNTVCT,
 		.handler = cntvct_read_handler,
 	},
+	{
+		/* Trap read access to CNTFRQ_EL0 */
+		.esr_mask = ESR_ELx_SYS64_ISS_SYS_OP_MASK,
+		.esr_val = ESR_ELx_SYS64_ISS_SYS_CNTFRQ,
+		.handler = cntfrq_read_handler,
+	},
 	{},
 };
 
-- 
2.11.0

-- 
Jazz is not dead. It just smells funny...
