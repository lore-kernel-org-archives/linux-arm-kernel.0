From: jmarchan@redhat.com (Jerome Marchand)
Date: Wed, 17 Jan 2018 16:03:13 +0100
Subject: [PATCH v3] arm64: fix unwind_frame() for filtered out fn for
 function graph tracing
In-Reply-To: <20180116175734.4rp4bewr7us4jypk@armageddon.cambridge.arm.com>
References: <20180112104832.9417-1-jmarchan@redhat.com>
 <20180116175734.4rp4bewr7us4jypk@armageddon.cambridge.arm.com>
Message-ID: <ae2880e9-0d59-19fc-0d1f-80c2f011415f@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/01/18 18:57, Catalin Marinas wrote:
> On Fri, Jan 12, 2018 at 11:48:32AM +0100, Jerome Marchand wrote:
>> diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
>> index 76809ccd309c..5a528c58ef68 100644
>> --- a/arch/arm64/kernel/stacktrace.c
>> +++ b/arch/arm64/kernel/stacktrace.c
>> @@ -59,6 +59,10 @@ int notrace unwind_frame(struct task_struct *tsk, struct stackframe *frame)
>>  #ifdef CONFIG_FUNCTION_GRAPH_TRACER
>>  	if (tsk->ret_stack &&
>>  			(frame->pc == (unsigned long)return_to_handler)) {
>> +		WARN_ON(frame->graph == -1);
>> +		if (frame->graph < -1)
>> +			frame->graph += FTRACE_NOTRACE_DEPTH;
>> +
>>  		/*
>>  		 * This is a case where function graph tracer has
>>  		 * modified a return address (LR) in a stack frame
> 
> So do we still allow this to continue if graph == -1? The following line
> doesn't seem safe:
> 
> 		frame->pc = tsk->ret_stack[frame->graph--].ret;
> 

You're right. We probably should return a error (-EINVAL I guess) if
this happens. Note that this shouldn't happen here and if we're
confident enough that profile_pc() was the only faulty caller, we could
just drop the warning.

Jerome

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180117/2bb52dbe/attachment.sig>
