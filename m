From: wangnan0@huawei.com (Wang Nan)
Date: Sat, 16 Aug 2014 09:38:21 +0800
Subject: [PATCH v4] kprobes: arm: enable OPTPROBES for ARM 32
In-Reply-To: <53EE25FB.4070201@hitachi.com>
References: <1407819388-52145-1-git-send-email-wangnan0@huawei.com>
 <53EE25FB.4070201@hitachi.com>
Message-ID: <53EEB60D.1030907@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014/8/15 23:23, Masami Hiramatsu wrote:
> (2014/08/12 13:56), Wang Nan wrote:
>> +/* Caller must ensure addr & 3 == 0 */
>> +static int can_optimize(unsigned long paddr)
>> +{
>> +	return 1;
>> +}
> 
> As we have talked on another thread, we'd better filter-out all stack-pushing
> instructions here, since (as you said) that will corrupt pt_regs on the stack.
> 
> Thank you,
> 

So we need to identify the replaced instruction. I think some improvement on
arm instruction decoder is required, else we have to implement another (although simpler)
decoder for memory accessing instructions.

In this situation we are talking about, we need the decoder identify the addressing
information for str/stm instroction. However, decoder can bring up more information such as
instruction type, source/destnation registers, memory access pattern ...
With such information, we can further optimize our trampoline code.
For example: doesn't protect destnation registers, and for some (most of, I think) instruction,
we can direct execute them like x86_64.

What do you think?
