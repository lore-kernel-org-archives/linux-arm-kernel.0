From: sjg@chromium.org (Simon Glass)
Date: Tue, 20 Sep 2011 00:06:22 -0700
Subject: Link failures due to __bug_table in current -next
In-Reply-To: <20110919200317.GC16381@n2100.arm.linux.org.uk>
References: <20110919120954.GA20314@opensource.wolfsonmicro.com>
	<20110919200317.GC16381@n2100.arm.linux.org.uk>
Message-ID: <CAPnjgZ3+b=nhApZxV1aBGejxEr7MGN1e8neP-ychtVO2Ego2yQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Mon, Sep 19, 2011 at 1:03 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Sep 19, 2011 at 01:09:54PM +0100, Mark Brown wrote:
>> I'm seeing linker failures in -next as of today:
>>
>> `.exit.text' referenced in section `__bug_table' of fs/built-in.o:
>> defined in discarded section `.exit.text' of fs/built-in.o
>> `.exit.text' referenced in section `__bug_table' of crypto/built-in.o:
>> defined in discarded section `.exit.text' of crypto/built-in.o
>> `.exit.text' referenced in section `__bug_table' of net/built-in.o:
>> defined in discarded section `.exit.text' of net/built-in.o
>> `.exit.text' referenced in section `__bug_table' of net/built-in.o:
>> defined in discarded section `.exit.text' of net/built-in.o
>>
>> which appears to be due to the chnage to use generic BUG() introduced in
>> commit 5254a3 (ARM: 7017/1: Use generic BUG() handler), reverting that
>> commit resolves the issue for me.

Gosh this does seem a bit odd. Ordering seems to be clearly implied by
the file syntax and I agree we should seek guidance from binutils
people.

I added the BUG condition to CONFIG_SMP_ON_UP and
CONFIG_DEBUG_SPINLOCK which were already there. If BUG is causing
problems, I wonder why these are not? Have we just been lucky, or have
I crossed a line? Or perhaps there are no spinlocks in exit text?

One option is to keep all exit text around - i.e. never discard it at
link time. From memory it is only 4-8KB. Doubtless many would be upset
with this, but it could be an option until this binutils behaviour is
resolved.

Another is to declare that it is a bug to use BUG in an exit section.
I was thinking about that at the time, but decided it was probably too
radical. There are only a small number of references in the kernel I
think (again from memory - this was back in April I think). Not
trivial to enforce, and the error you get is not exactly informative.

Yes another even stranger might be to ask the linker to leave the
references to discarded sections from the bug table unresolved, and
perhaps make them zero, like a weak reference. Is that even possible?
This would work since the bug scanning code can skip over these
entries. Even better if the linker could remove them but this is going
far beyond the job of a humble linker script.

While a bug-fix or feature change in binutils might get us there, I
worry that it would be years before it became widespread enough that
we could turn it on.

>
> This might solve the problem - could you check please?

Hope so. Thanks for your efforts on this. It would be nice not to have
to dump generic BUG due to this technicality.

Regards,
Simon

>
> ?arch/arm/kernel/vmlinux.lds.S | ? 15 ++++++++++++---
> ?1 files changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
> index 7b2541e..20b3041 100644
> --- a/arch/arm/kernel/vmlinux.lds.S
> +++ b/arch/arm/kernel/vmlinux.lds.S
> @@ -24,8 +24,10 @@
> ?#if (defined(CONFIG_SMP_ON_UP) && !defined(CONFIG_DEBUG_SPINLOCK)) || \
> ? ? ? ?defined(CONFIG_GENERIC_BUG)
> ?#define ARM_EXIT_KEEP(x) ? ? ? x
> +#define ARM_EXIT_DISCARD(x)
> ?#else
> ?#define ARM_EXIT_KEEP(x)
> +#define ARM_EXIT_DISCARD(x) ? ?x
> ?#endif
>
> ?OUTPUT_ARCH(arm)
> @@ -40,6 +42,11 @@ jiffies = jiffies_64 + 4;
> ?SECTIONS
> ?{
> ? ? ? ?/*
> + ? ? ? ?* XXX: The linker does not define how output sections are
> + ? ? ? ?* assigned to input sections when there are multiple statements
> + ? ? ? ?* matching the same input section name. ?There is no documented
> + ? ? ? ?* order of matching.
> + ? ? ? ?*
> ? ? ? ? * unwind exit sections must be discarded before the rest of the
> ? ? ? ? * unwind sections get included.
> ? ? ? ? */
> @@ -48,6 +55,9 @@ SECTIONS
> ? ? ? ? ? ? ? ?*(.ARM.extab.exit.text)
> ? ? ? ? ? ? ? ?ARM_CPU_DISCARD(*(.ARM.exidx.cpuexit.text))
> ? ? ? ? ? ? ? ?ARM_CPU_DISCARD(*(.ARM.extab.cpuexit.text))
> + ? ? ? ? ? ? ? ARM_EXIT_DISCARD(EXIT_TEXT)
> + ? ? ? ? ? ? ? ARM_EXIT_DISCARD(EXIT_DATA)
> + ? ? ? ? ? ? ? EXIT_CALL
> ?#ifndef CONFIG_HOTPLUG
> ? ? ? ? ? ? ? ?*(.ARM.exidx.devexit.text)
> ? ? ? ? ? ? ? ?*(.ARM.extab.devexit.text)
> @@ -59,6 +69,8 @@ SECTIONS
> ?#ifndef CONFIG_SMP_ON_UP
> ? ? ? ? ? ? ? ?*(.alt.smp.init)
> ?#endif
> + ? ? ? ? ? ? ? *(.discard)
> + ? ? ? ? ? ? ? *(.discard.*)
> ? ? ? ?}
>
> ?#ifdef CONFIG_XIP_KERNEL
> @@ -280,9 +292,6 @@ SECTIONS
>
> ? ? ? ?STABS_DEBUG
> ? ? ? ?.comment 0 : { *(.comment) }
> -
> - ? ? ? /* Default discards */
> - ? ? ? DISCARDS
> ?}
>
> ?/*
>
>
