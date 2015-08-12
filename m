From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Thu, 13 Aug 2015 00:18:49 +0900
Subject: [PATCH] arm64: Add __exception_irq_entry definition for function
 graph
In-Reply-To: <20150812150232.GI23540@arm.com>
References: <1439388979-1518-1-git-send-email-jungseoklee85@gmail.com>
 <20150812150232.GI23540@arm.com>
Message-ID: <9C0002C4-EEC5-415F-A0BC-2284E662D308@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Aug 13, 2015, at 12:02 AM, Will Deacon wrote:

Hi Will,

> On Wed, Aug 12, 2015 at 03:16:19PM +0100, Jungseok Lee wrote:
>> The gic_handle_irq() is defined with __exception_irq_entry attribute.
>> A single remaining work is to add its definition as ARM did. Below
>> shows how function graph data is changed with these hunks.
> 
> [...]
> 
>> diff --git a/arch/arm64/include/asm/traps.h b/arch/arm64/include/asm/traps.h
>> index 232e4ba..0cc2f29 100644
>> --- a/arch/arm64/include/asm/traps.h
>> +++ b/arch/arm64/include/asm/traps.h
>> @@ -34,13 +34,32 @@ struct undef_hook {
>> void register_undef_hook(struct undef_hook *hook);
>> void unregister_undef_hook(struct undef_hook *hook);
>> 
>> +#ifdef CONFIG_FUNCTION_GRAPH_TRACER
>> +static inline int __in_irqentry_text(unsigned long ptr)
>> +{
>> +	extern char __irqentry_text_start[];
>> +	extern char __irqentry_text_end[];
>> +
>> +	return ptr >= (unsigned long)&__irqentry_text_start &&
>> +	       ptr < (unsigned long)&__irqentry_text_end;
>> +}
>> +#else
>> +static inline int __in_irqentry_text(unsigned long ptr)
>> +{
>> +	return 0;
>> +}
>> +#endif
>> +
>> static inline int in_exception_text(unsigned long ptr)
>> {
>> 	extern char __exception_text_start[];
>> 	extern char __exception_text_end[];
>> +	int in;
>> +
>> +	in = ptr >= (unsigned long)&__exception_text_start &&
>> +	     ptr < (unsigned long)&__exception_text_end;
>> 
>> -	return ptr >= (unsigned long)&__exception_text_start &&
>> -	       ptr < (unsigned long)&__exception_text_end;
>> +	return in ? : __in_irqentry_text(ptr);
>> }
> 
> On arm64, this function is only called from dump_backtrace, so I'm
> struggling to see why this change makes any difference to the ftrace
> output.
> 
> What am I missing?

As you mentioned, the above hunk does not change the ftrace behavior.

The first diff directly affects the first condition check in print_graph_irq
function in kernel/trace/trace_functions_graph.c. The code snippet is as follows.

if (addr < (unsigned long)__irqentry_text_start ||
	addr >= (unsigned long)__irqentry_text_end)
	return;

I hope it would be helpful.

Best Regards
Jungseok Lee
