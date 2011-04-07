From: frank.hofmann@tomtom.com (Frank Hofmann)
Date: Thu, 7 Apr 2011 15:24:37 +0100 (BST)
Subject: [RFC PATCH] ARM: fiq: Refactor {get,set}_fiq_regs() for
 Thumb-2
In-Reply-To: <BANLkTi==oi+Ebj3vrwB3Ev_49Gfj80gsAA@mail.gmail.com>
References: <mailman.19600.1302086322.1534.linux-arm-kernel@lists.infradead.org>
	<alpine.DEB.2.00.1104061208310.15572@localhost6.localdomain6>
	<BANLkTi=q=A=RBh-mQgZ_4S6NkUJ0O7ERig@mail.gmail.com>
	<alpine.DEB.2.00.1104071133340.1147@localhost6.localdomain6>
	<BANLkTi==oi+Ebj3vrwB3Ev_49Gfj80gsAA@mail.gmail.com>
Message-ID: <alpine.DEB.2.00.1104071503340.1147@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 7 Apr 2011, Dave Martin wrote:

> On Thu, Apr 7, 2011 at 12:35 PM, Frank Hofmann <frank.hofmann@tomtom.com> wrote:
>> On Thu, 7 Apr 2011, Dave Martin wrote:
>>
>> [ ... ]
>>>
>>> Well, I'm not hoping for the assembly to be inlined, *just* the C
>>> wrapper. ?Since the C wrapper is trivial, I prefer to avoid emitting a
>>> function body for this.
>>
>> _That_ specific bit is what isn't going to happen; it's a separate
>> compilation unit, it needs to be callable from places not known at compile
>> nor link time, and the function isn't "static". The "inline" is meaningless
>> here.
>
> The wrapper functions _are_ static:
>
> +static inline void set_fiq_regs(struct pt_regs const *regs)
> +{
> +       __set_fiq_regs(&regs->ARM_r8);
> +}
> +
> +static inline void get_fiq_regs(struct pt_regs *regs)
> +{
> +       __get_fiq_regs(&regs->ARM_r8);
> +}

Ah ok ... now I get that bit, sorry <facepalm> - I had a patch mixup ...
You're right. When in the header these are fine.

Thx for the coding style pointer :)


> IIUC, <arm/assembler.h> establishes the standard environment for .S
> files for arm, which includes <asm/ptrace.h>.  kernel/entry-header.S
> gets those bit definitions by the same route, for example.

You're sure ? Sorry for being nitpicky there. "arm" vs. "asm", single 
character typo.

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=arch/arm/kernel/entry-header.S;h=051166c2a932cfed1620bb3a5612383ffff12149;hb=HEAD#l4

says:

4 #include <asm/assembler.h>

"grep -r arm/assembler.h" on my tree comes out empty.

Besides, without <linux/linkage.h> the ENTRY/ENDPROC aren't defined; where 
does your environment pick them up from ? <asm/assembler.h> doesn't 
include it.

>
>>
>>
>> [ ... ]
>>>
>>> Does that answer your concerns?
>>
>> I agree with you that this should be assembly, no arguing it's better to nip
>> gcc's optimizer escapades in the bud ...
>>
>> The urgency I don't get, though; this code still looks a bit "hot".
>
> Well, I didn't say it was urgent...  What do you mean by "hot"?

Not perfect ;-)

FrankH.

>
> Cheers
> ---Dave
>
