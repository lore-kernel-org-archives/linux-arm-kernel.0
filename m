From: wangnan0@huawei.com (Wang Nan)
Date: Sat, 30 Aug 2014 09:28:37 +0800
Subject: [PATCH v5 1/3] ARM: probes: check stack operation when decoding
In-Reply-To: <1409302042.1247.27.camel@computer5.home>
References: <1409144552-12751-1-git-send-email-wangnan0@huawei.com>	
 <1409144552-12751-2-git-send-email-wangnan0@huawei.com>	
 <53FEFB93.2010009@hitachi.com>	
 <20140828102021.GC30401@n2100.arm.linux.org.uk>	
 <20140828102406.GH22580@arm.com> <1409302042.1247.27.camel@computer5.home>
Message-ID: <540128C5.6050101@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014/8/29 16:47, Jon Medhurst (Tixy) wrote:
> On Thu, 2014-08-28 at 11:24 +0100, Will Deacon wrote:
>> On Thu, Aug 28, 2014 at 11:20:21AM +0100, Russell King - ARM Linux wrote:
>>> On Thu, Aug 28, 2014 at 06:51:15PM +0900, Masami Hiramatsu wrote:
>>>> (2014/08/27 22:02), Wang Nan wrote:
>>>>> This patch improves arm instruction decoder, allows it check whether an
>>>>> instruction is a stack store operation. This information is important
>>>>> for kprobe optimization.
>>>>>
>>>>> For normal str instruction, this patch add a series of _SP_STACK
>>>>> register indicator in the decoder to test the base and offset register
>>>>> in ldr <Rt>, [<Rn>, <Rm>] against sp.
>>>>>
>>>>> For stm instruction, it check sp register in instruction specific
>>>>> decoder.
>>>>
>>>> OK, reviewed. but since I'm not so sure about arm32 ISA,
>>>> I need help from ARM32 maintainer to ack this.
>>>
>>> What you actually need is an ack from the ARM kprobes people who
>>> understand this code.  That would be much more meaningful than my
>>> ack.  They're already on the Cc list.
>>
>> Tixy, can you take a look please?
> 
> I'll take an in depth look on Monday as I'm currently on holiday, so for
> now just some brief and possibly not well thought out comments...
> 
> - If the intent is to not optimise stack push operations, then this
> actually excludes the main use of kprobes which I believe is to insert
> probes at the start of functions (there's even a specific jprobes API
> for that) this is because functions usually start by saving registers on
> the stack.

Agree. If the decoder can bring up more information, kprobeopt can dynamically
compute the range of stack an instruction require, then adjust stack protection range.
This need ARM decoder bring up more information. For example: for a "push {r4, r5}"
instruction, decoder should report it is a stack store operation, require 8 bytes
of stack, then when composing trampoline code, we can put registers at
[sp, #-8]. Only instructions such as "str r0, [sp, r1]" should be prevented.

However, this need more improvement on decoder: all store operations should use
a special decorer then. What do you think?

> 
> - Crowbarring in special case testing for stack operations looks a bit
> inelegant and not a sustainable way of doing this, what about the next
> special case we need? However, stack push operations _are_ a general
> special cases for instruction emulation so perhaps that's OK, and leads
> me to...
> 
> - The current 'unoptimised' kprobes implementation allows for pushing on
> the stack (see __und_svc and the unused (?) jprobe_return) but this is
> just aimed at stm instructions, not things like "str r0, [sp, -imm]!"
> that might be used to simultaneously save a register and reserve an
> arbitrary amount of stack space. Probing such instructions could lead to
> the kprobes code trashing the kernel stack.

By a quick search I just find tow instructions matching "str.*\[sp,[^\]]*-[^4]",
one in Ldiv0_64, another in Ldiv0, both are "str     lr, [sp, #-8]!". So I think
such instructions are very special.

Furthermore, I thought "unoptimised" kprobe use another stack, could you please
explain how such probing trashing normal kernel stack?

Thank you.
