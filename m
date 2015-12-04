From: huawei.libin@huawei.com (Li Bin)
Date: Fri, 4 Dec 2015 11:23:45 +0800
Subject: [PATCH v2 2/2] arm64: ftrace: fix the comments for
 ftrace_modify_code
In-Reply-To: <20151203215001.52fe192f@grimm.local.home>
References: <1449195519-17901-1-git-send-email-huawei.libin@huawei.com>
 <1449195519-17901-3-git-send-email-huawei.libin@huawei.com>
 <20151203215001.52fe192f@grimm.local.home>
Message-ID: <56610741.6060306@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



on 2015/12/4 10:50, Steven Rostedt wrote:
> On Fri, 4 Dec 2015 10:18:39 +0800
> Li Bin <huawei.libin@huawei.com> wrote:
>
>> There is no need to worry about module text disappearing case,
>> because that ftrace has a module notifier that is called when
>> a module is being unloaded and before the text goes away, and this
>> code grabs the ftrace_lock mutex and removes the module functions
>> from the ftrace list, such that it will no longer do any
>> modifications to that module's text.
>> The update to make functions be traced or not is done under the
>> ftrace_lock mutex as well.
>>
>> Signed-off-by: Li Bin <huawei.libin@huawei.com>
>> ---
>>  arch/arm64/kernel/ftrace.c |    5 +----
>>  1 files changed, 1 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
>> index 9669b33..ee91c0c 100644
>> --- a/arch/arm64/kernel/ftrace.c
>> +++ b/arch/arm64/kernel/ftrace.c
>> @@ -29,12 +29,9 @@ static int ftrace_modify_code(unsigned long pc, u32 old, u32 new,
>>  
>>  	/*
>>  	 * Note:
>> -	 * Due to modules and __init, code can disappear and change,
>> +	 * Due to __init, code can disappear and change,
> Init code should not be modified either because it is black listed in
> recordmcount.c.
>
> I say just change the comment to be something like:
>
> We are paranoid about modifying text, as if a bug were to happen, it
> could cause us to read or write to someplace that could cause harm.
> Carefully read and modify the code with aarch64_insn_*() which uses
> probe_kernel_*(), and make sure what we read is what we expected it to
> be before modifying it.

Ok, I will modify it.

Thanks,
Li Bin

> -- Steve
>
>
>>  	 * we need to protect against faulting as well as code changing.
>>  	 * We do this by aarch64_insn_*() which use the probe_kernel_*().
>> -	 *
>> -	 * No lock is held here because all the modifications are run
>> -	 * through stop_machine().
>>  	 */
>>  	if (validate) {
>>  		if (aarch64_insn_read((void *)pc, &replaced))
>
> .
>
