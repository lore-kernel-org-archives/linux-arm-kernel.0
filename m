From: dave.martin@linaro.org (Dave Martin)
Date: Fri, 8 Apr 2011 11:03:19 +0100
Subject: [RFC PATCH] ARM: fiq: Refactor {get,set}_fiq_regs() for Thumb-2
In-Reply-To: <20110407222813.GF17049@n2100.arm.linux.org.uk>
References: <mailman.19600.1302086322.1534.linux-arm-kernel@lists.infradead.org>
	<alpine.DEB.2.00.1104061208310.15572@localhost6.localdomain6>
	<BANLkTi=q=A=RBh-mQgZ_4S6NkUJ0O7ERig@mail.gmail.com>
	<20110407222813.GF17049@n2100.arm.linux.org.uk>
Message-ID: <BANLkTimocsXKuP54PRyCHTdYNqrhy9QQQA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 7, 2011 at 11:28 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Apr 07, 2011 at 11:02:18AM +0100, Dave Martin wrote:
>> The main reason for that is to code the ->ARM_r8 in C (as in the
>> existing code). ?I feel safer doing that than hard-coding an offset in
>> the assembler, though possibly that is overkill since if the layout of
>> struct pt_regs changes we are probably in trouble for all kinds of
>> other reasons anyway...
>
> It may be worth looking up exactly what's allowed with naked functions.
> A naked function tells the compiler to omit the function prologue and
> epologue, which effectively means you can't do very much other than
> inline asm in them. ?So I think we're pretty safe from register
> allocation issues.
>
> If the compiler was to do register allocation for &regs->ARM_r8, and it
> landed up in r8, then that would not only break the code, but also break
> the ABI as the compiler would be unable to save the value of r8.
>
>> I could have used register variables with explicit register
>> assignments.  Alternatively, I could have added r8-r14 to the clobber
>> list -- but then the compiler would generate unnecessary save and
>> restore sequences for all those registers.
>
> I doubt it would for a naked function.  You're expected to handle
> that stuff yourself with such things.
>

It looks like your instinct is correct -- if I add those extra
registers to the clobber list, I get no save/resrote sequences, as you
suggest... but...
