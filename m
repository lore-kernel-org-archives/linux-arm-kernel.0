From: huawei.libin@huawei.com (libin)
Date: Thu, 3 Dec 2015 17:21:22 +0800
Subject: [PATCH] arm64: ftrace: stop using kstop_machine to enable/disable
 tracing
In-Reply-To: <20151202123654.GC4523@arm.com>
References: <1448697009-17211-1-git-send-email-huawei.libin@huawei.com>
 <20151202123654.GC4523@arm.com>
Message-ID: <56600992.4040005@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


on 2015/12/2 20:36, Will Deacon wrote:
> On Sat, Nov 28, 2015 at 03:50:09PM +0800, Li Bin wrote:
>> On arm64, kstop_machine which is hugely disruptive to a running
>> system is not needed to convert nops to ftrace calls or back,
>> because that modifed code is a single 32bit instructions which
>> is impossible to cross cache (or page) boundaries, and the used str
>> instruction is single-copy atomic.
> This commit message is misleading, since the single-copy atomicity
> guarantees don't apply to the instruction-side. Instead, the architecture
> calls out a handful of safe instructions in "Concurrent modification and
> execution of instructions".

Right, thank you for your comments.

> Now, those safe instructions *do* include NOP, B and BL, so that should
> be sufficient for ftrace provided that we don't patch condition codes
> (and I don't think we do).

Yes, and so far this assumption has no probem, but in order to avoid exceeding these
safe insturctions in the future, we can use aarch64_insn_hotpatch_safe() to verify the
instruction to determine whether needs stop_machine() to synchronize or use
aarch64_insn_patch_text directly. Right or I am missing something?

Thanks,
Li Bin

>> Cc: <stable@vger.kernel.org> # 3.18+
> I don't think this is stable material.
>
> Will
>
>> Signed-off-by: Li Bin <huawei.libin@huawei.com>
>> ---
>>  arch/arm64/kernel/ftrace.c |    5 +++++
>>  1 files changed, 5 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
>> index c851be7..9669b33 100644
>> --- a/arch/arm64/kernel/ftrace.c
>> +++ b/arch/arm64/kernel/ftrace.c
>> @@ -93,6 +93,11 @@ int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
>>  	return ftrace_modify_code(pc, old, new, true);
>>  }
>>  
>> +void arch_ftrace_update_code(int command)
>> +{
>> +	ftrace_modify_all_code(command);
>> +}
>> +
>>  int __init ftrace_dyn_arch_init(void)
>>  {
>>  	return 0;
>> -- 
>> 1.7.1
>>
> .
>
