From: dave.martin@linaro.org (Dave Martin)
Date: Wed, 26 Jan 2011 11:11:31 +0000
Subject: [PATCH 03/14] ARM: v6k: remove CPU_32v6K dependencies in
	asm/spinlock.h
In-Reply-To: <alpine.LFD.2.00.1101251618230.8580@xanadu.home>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk>
	<E1PeueP-0003SR-03@rmk-PC.arm.linux.org.uk>
	<AANLkTinnhivretaRHpYwCYouk-_jWKZQEo7x4sbheJVL@mail.gmail.com>
	<20110125165919.GD17286@n2100.arm.linux.org.uk>
	<AANLkTimK06nJPtQoym3HxXeDD-s4nUrN0vWjp_JcgTjx@mail.gmail.com>
	<20110125174636.GE17286@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1101251618230.8580@xanadu.home>
Message-ID: <AANLkTi=zVsr8G=eYfp7v_QQvBBDCX+Es+T-4c4Fu=QVF@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 25, 2011 at 9:21 PM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Tue, 25 Jan 2011, Russell King - ARM Linux wrote:
>
>> On Tue, Jan 25, 2011 at 05:33:14PM +0000, Dave Martin wrote:
>> > On Tue, Jan 25, 2011 at 4:59 PM, Russell King - ARM Linux
>> > <linux@arm.linux.org.uk> wrote:
>> > > On Tue, Jan 25, 2011 at 04:43:52PM +0000, Dave Martin wrote:
>> > >> A couple of questions on this:
>> > >>
>> > >> 1) I notice these spinlock functions are generally marked inline.
>> > >>
>> > >> Is that likely to happen in modules? ?If so, there would be a need to
>> > >> do SMP_ON_UP fixups at module load time -- I don't think that's
>> > >> currently implemented.
>> > >
>> > > No one should be using the arch_* spinlocks directly. ?The spinlocks
>> > > are implemented in out of line code in kernel/spinlock.c
>> >
>> > OK--- do think this is something we need a sanity-check for, or does
>> > this fall into to a category of bad driver implementation which will
>> > get thrown out during peer review?
>>
>> Hmm, actually it looks like you can end up with configurations where the
>> spinlocks are inlined.
>>
>> That means we'll have to get rid of the link-time discarding of the
>> .exit sections, and discard them along with the .init sections.
>
> ... but only when CONFIG_SMP_ON_UP=y.
>
>
> Nicolas

Do we need to consider any other discarded sections?  In vmlinux.lds, I have:

 /* Default discards */
 /DISCARD/ : { *(.exit.text) *(.cpuexit.text) *(.memexit.text)
*(.exit.data) *(.cpuexit.data) *(.cpuexit.rodata) *(.memexit.data)
*(.memexit.rodata) *(.exitcall.exit) *(.discard) *(.discard.*) }


Alternatively, I wonder .alt.smp.init could make weak references
instead of normal references: then if the referenced section is
discarded, the reference will revert to 0 and the fixup code can
ignore it (at the expense of wasting a bit of space in the fixup table
... but it's no worse than the current situation).  From
experimentation, it seems this doesn't work if the referenced symbol
is defined in the same file, since the linker resolves the reference
before discarding sections, but maybe there's a way around it...

This does rely on generating a globally unique symbol name for every
fixup ... we can come close using KBUILD_MODNAME, __LINE__ and/or the
assembler macro widget \@.  But I think that KBUILD_MODNAME doesn't
take the file path into account so may not really be globally unique.

If we put every fixup in its own _section_ we might be able to
collapse those out of the list at link time too.  However, that seems
hard to achieve, since in order to do the correct link-time filtering
we would need the fixup's section name to be based on the referenced
section's name ... due to preprocessor limitations I don't think we
can do that automatically (and manual maintenance would be a bad
plan).

Cheers
---Dave
