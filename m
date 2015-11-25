From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Wed, 25 Nov 2015 14:33:10 +0900
Subject: [PATCH v6 6/6] arm64: ftrace: add a test of function prologue
 analyzer
In-Reply-To: <CA5C2481-E1FA-4A2F-94D8-00EF7391EBBC@gmail.com>
References: <1447828989-4980-1-git-send-email-takahiro.akashi@linaro.org>
 <1447828989-4980-7-git-send-email-takahiro.akashi@linaro.org>
 <CA5C2481-E1FA-4A2F-94D8-00EF7391EBBC@gmail.com>
Message-ID: <56554816.6000208@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/24/2015 10:50 PM, Jungseok Lee wrote:
> On Nov 18, 2015, at 3:43 PM, AKASHI Takahiro wrote:
>> The patch ("arm64: ftrace: add arch-specific stack tracer") introduced
>> a function prologue analyzer.
>>
>> Given that there is no fixed template for a function prologue, at least
>> on gcc for aarch64, a function prologue analyzer may be rather heuristic.
>> So this patch adds a kernel command line option,
>> function_prologue_analyzer_test, in order to run a basic test at startup
>> by executing an analyzer against all the *traceable* functions.
>>
>> For function_prologue_analyzer_test=2, the output looks like:
>>
>>        po sp    fp    symbol
>>        == ==    ==    ======
>>     0: 0  0x040 0x000 gic_handle_irq+0x20/0xa4
>>     1: 0  0x040 0x000 gic_handle_irq+0x34/0x114
>>     2: 0  0x030 0x000 run_init_process+0x14/0x48
>>     3: 0  0x020 0x000 try_to_run_init_process+0x14/0x58
>>     4: 0  0x080 0x000 do_one_initcall+0x1c/0x194
>>     ...
>> 22959: 0  0x020 0x000 tty_lock_slave+0x14/0x3c
>> 22960: 0  0x020 0x000 tty_unlock_slave+0x14/0x3c
>> function prologue analyzer test: 0 errors
>>
>> "po" indicates a position of callsite of mcount(), and should be zero
>> if an analyzer has parsed a function prologue successfully and reached
>> a location where fp is properly updated.
>> "sp" is a final offset to a parent's fp at the exit of function prologue.
>> "fp" is also an ofset against sp at the exit of function prologue.
>> So normally,
>>   <new sp> = <old fp> + <"sp">
>>   <new fp> = <new sp> - <"fp">
>>
>> And the last line shows the number of possible errors in the result.
>>
>> For function_prologue_analyzer_test=1, only the last line will be shown.
>>
>> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
>> ---
>> arch/arm64/include/asm/insn.h  |    2 +-
>> arch/arm64/kernel/stacktrace.c |   52 ++++++++++++++++++++++++++++++++++++++++
>> 2 files changed, 53 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
>> index 8d5c538..1dfae16 100644
>> --- a/arch/arm64/include/asm/insn.h
>> +++ b/arch/arm64/include/asm/insn.h
>> @@ -281,7 +281,7 @@ __AARCH64_INSN_FUNCS(hint,	0xFFFFF01F, 0xD503201F)
>> __AARCH64_INSN_FUNCS(br,	0xFFFFFC1F, 0xD61F0000)
>> __AARCH64_INSN_FUNCS(blr,	0xFFFFFC1F, 0xD63F0000)
>> __AARCH64_INSN_FUNCS(ret,	0xFFFFFC1F, 0xD65F0000)
>> -__AARCH64_INSN_FUNCS(eret,	0xFFFFFFFF, 0xD69F00E0)
>> +__AARCH64_INSN_FUNCS(eret,	0xFFFFFFFF, 0xD69F03E0)
>
> How about folding(squashing) this hunk into [PATCH 4/6]?
>
>> #undef	__AARCH64_INSN_FUNCS
>>
>> diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
>> index 1d18bc4..19dad62 100644
>> --- a/arch/arm64/kernel/stacktrace.c
>> +++ b/arch/arm64/kernel/stacktrace.c
>> @@ -18,6 +18,7 @@
>> #include <linux/kernel.h>
>> #include <linux/export.h>
>> #include <linux/ftrace.h>
>> +#include <linux/kallsyms.h>
>> #include <linux/sched.h>
>> #include <linux/stacktrace.h>
>>
>> @@ -348,5 +349,56 @@ void save_stack_trace_sp(struct stack_trace *trace,
>> {
>> 	__save_stack_trace_tsk(current, trace, stack_dump_sp);
>> }
>> +
>> +static int start_analyzer_test __initdata;
>> +
>> +static int __init enable_analyzer_test(char *str)
>> +{
>> +	get_option(&str, &start_analyzer_test);
>> +	return 0;
>> +}
>> +early_param("function_prologue_analyzer_test", enable_analyzer_test);
>> +
>> +static void __init do_test_function_prologue_analyzer(void)
>> +{
>> +	extern unsigned long __start_mcount_loc[];
>> +	extern unsigned long __stop_mcount_loc[];
>> +	unsigned long count, i, errors;
>> +	int print_once;
>> +
>> +	count = __stop_mcount_loc - __start_mcount_loc;
>> +	errors = print_once = 0;
>> +	for (i = 0; i < count; i++) {
>> +		unsigned long addr, sp_off, fp_off;
>> +		int pos;
>> +		bool check;
>> +		char buf[60];
>> +
>> +		addr = __start_mcount_loc[i];
>> +		pos = analyze_function_prologue(addr, &sp_off, &fp_off);
>> +		check = ((pos != 0) || !sp_off || (sp_off <= fp_off));
>> +		if (check)
>> +			errors++;
>> +		if (check || (start_analyzer_test > 1)) {
>> +			if (!print_once) {
>> +				pr_debug("       po sp    fp    symbol\n");
>> +				pr_debug("       == ==    ==    ======\n");
>> +				print_once++;
>> +			}
>> +			sprint_symbol(buf, addr);
>> +			pr_debug("%5ld: %d  0x%03lx 0x%03lx %s\n",
>> +					i, pos, sp_off, fp_off, buf);
>> +		}
>
> It would be hard to find out which entry has an error if start_analyer_test is
> set to 2. How about adding one more column to mark 'OK' or 'NG'?

Thank you for the comment.

> BTW, as I mentioned in previous thread, I'm also waiting for feedbacks on the
> analyzer itself :)

Me, too.

-Takahiro AKASHI

> Best Regards
> Jungseok Lee
>
