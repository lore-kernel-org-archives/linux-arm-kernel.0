From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 18 Jan 2018 12:08:43 +0000
Subject: [PATCH v2 0/2] arm64: Run enable method for errata work arounds
 on late CPUs
In-Reply-To: <5c1945a8-a66d-9306-1c6d-3c1c8febcab2@arm.com>
References: <20180117174220.7959-1-suzuki.poulose@arm.com>
 <20180118114540.GL22781@e103592.cambridge.arm.com>
 <5c1945a8-a66d-9306-1c6d-3c1c8febcab2@arm.com>
Message-ID: <851887b9-974a-6f20-920b-d9149d8122fe@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/01/18 12:00, Robin Murphy wrote:
[...]
>> +struct enable_arg {
>> +??? int (*enable)(struct arm64_cpu_capabilities const *);
>> +??? struct arm64_cpu_capabilities const *cap;
>> +};
>> +
>> +static int __enable_cpu_capability(void *arg)
>> +{
>> +??? struct enable_arg const *e = arg;
>> +
>> +??? return e->enable(e->cap);
>> +}
> 
> AFAICS, you shouldn't even need the intermediate struct - if you were 
> instead to call stop_machine(&caps->enable, ...), the wrapper could be:
> 
>  ????<type> **fn = arg;
>  ????*fn(container_of(fn, struct arm64_cpu_capabilities, enable));
> 
> (cheaty pseudocode because there's no way I'm going to write a 
> pointer-to-function-pointer type correctly in an email client...)
> 
> That's certainly a fair bit simpler in terms of diffstat; whether it's 
> really as intuitive as I think it is is perhaps another matter, though.

Ah, right, but then you'd be back to casting away const, and at that 
point it makes no sense to do the container_of dance instead of just 
passing the struct pointer itself around...

I shall now excuse myself from this discussion, as I'm clearly not 
helping :)

Robin.

>> +
>> ? /*
>> ?? * Run through the enabled capabilities and enable() it on all active
>> ?? * CPUs
>> @@ -1100,13 +1112,19 @@ void __init enable_cpu_capabilities(const 
>> struct arm64_cpu_capabilities *caps)
>> ????????? static_branch_enable(&cpu_hwcap_keys[num]);
>> ????????? if (caps->enable) {
>> +??????????? struct enable_arg e = {
>> +??????????????? .enable??? = caps->enable,
>> +??????????????? .cap??? = caps,
>> +??????????? };
>> +
>> ????????????? /*
>> ?????????????? * Use stop_machine() as it schedules the work allowing
>> ?????????????? * us to modify PSTATE, instead of on_each_cpu() which
>> ?????????????? * uses an IPI, giving us a PSTATE that disappears when
>> ?????????????? * we return.
>> ?????????????? */
>> -??????????? stop_machine(caps->enable, NULL, cpu_online_mask);
>> +??????????? stop_machine(__enable_cpu_capability, &e,
>> +???????????????????? cpu_online_mask);
>> ????????? }
>> ????? }
>> ? }
>> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
>> index fae81f7..b6dcfa3 100644
>> --- a/arch/arm64/kernel/fpsimd.c
>> +++ b/arch/arm64/kernel/fpsimd.c
>> @@ -40,6 +40,7 @@
>> ? #include <linux/sysctl.h>
>> ? #include <asm/fpsimd.h>
>> +#include <asm/cpufeature.h>
>> ? #include <asm/cputype.h>
>> ? #include <asm/simd.h>
>> ? #include <asm/sigcontext.h>
>> @@ -757,7 +758,7 @@ static void __init sve_efi_setup(void)
>> ?? * Enable SVE for EL1.
>> ?? * Intended for use by the cpufeatures code during CPU boot.
>> ?? */
>> -int sve_kernel_enable(void *__always_unused p)
>> +int sve_kernel_enable(struct arm64_cpu_capabilities const 
>> *__always_unused p)
>> ? {
>> ????? write_sysreg(read_sysreg(CPACR_EL1) | CPACR_EL1_ZEN_EL1EN, 
>> CPACR_EL1);
>> ????? isb();
>> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
>> index 3d3588f..2457514 100644
>> --- a/arch/arm64/kernel/traps.c
>> +++ b/arch/arm64/kernel/traps.c
>> @@ -38,6 +38,7 @@
>> ? #include <asm/atomic.h>
>> ? #include <asm/bug.h>
>> +#include <asm/cpufeature.h>
>> ? #include <asm/daifflags.h>
>> ? #include <asm/debug-monitors.h>
>> ? #include <asm/esr.h>
>> @@ -374,7 +375,7 @@ asmlinkage void __exception do_undefinstr(struct 
>> pt_regs *regs)
>> ????? force_signal_inject(SIGILL, ILL_ILLOPC, regs, 0);
>> ? }
>> -int cpu_enable_cache_maint_trap(void *__unused)
>> +int cpu_enable_cache_maint_trap(struct arm64_cpu_capabilities const 
>> *__unused)
>> ? {
>> ????? config_sctlr_el1(SCTLR_EL1_UCI, 0);
>> ????? return 0;
>> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
>> index 9b7f89d..82f6729 100644
>> --- a/arch/arm64/mm/fault.c
>> +++ b/arch/arm64/mm/fault.c
>> @@ -795,7 +795,7 @@ asmlinkage int __exception 
>> do_debug_exception(unsigned long addr,
>> ? NOKPROBE_SYMBOL(do_debug_exception);
>> ? #ifdef CONFIG_ARM64_PAN
>> -int cpu_enable_pan(void *__unused)
>> +int cpu_enable_pan(struct arm64_cpu_capabilities const *__unused)
>> ? {
>> ????? /*
>> ?????? * We modify PSTATE. This won't work from irq context as the PSTATE
>>
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
