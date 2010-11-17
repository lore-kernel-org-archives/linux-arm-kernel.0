From: dave.martin@linaro.org (Dave Martin)
Date: Wed, 17 Nov 2010 09:16:40 +0000
Subject: [PATCH 7/7] ARM: Thumb-2: Restore sensible zImage header layout
	for CONFIG_THUMB2_KERNEL
In-Reply-To: <20101116203520.GE21926@n2100.arm.linux.org.uk>
References: <1289913277-8822-1-git-send-email-dave.martin@linaro.org>
	<1289913277-8822-7-git-send-email-dave.martin@linaro.org>
	<20101116182643.GC21926@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1011161517260.6448@xanadu.home>
	<20101116203520.GE21926@n2100.arm.linux.org.uk>
Message-ID: <AANLkTim5Nv_oFgpfYL7jtjcMP10ND6wp5B50veURVPcn@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 16, 2010 at 6:26 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Nov 16, 2010 at 01:14:37PM +0000, Dave Martin wrote:
>> The code which makes up the zImage header clearly intends to
>> leave a vector-table-sized gap of 8 words (NOPs, in fact),
>> followed by a branch to the real entry point, a magic number,
>> and a word containing the absolute entry point address.
>
> That's an incorrect assumption.  The set of 8 words have nothing to do
> with the CPUs vector table at all - it has more to do with compatibility
> with a.out built kernels, where the a.out header was 32 bytes.

[...]

Fair enough -- that was just guesswork on my part.

[...]

On Tue, Nov 16, 2010 at 8:35 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Nov 16, 2010 at 03:28:44PM -0500, Nicolas Pitre wrote:
>> On Tue, 16 Nov 2010, Russell King - ARM Linux wrote:
>> > Not used anymore - it's practically zero (and unused) for most cases
>> > now anyway.
>>
>> I think it is worth preserving this layout regardless. ?First of all
>> this is really cheap to do, and if whatever bootloader out there is
>> relying on it, at least the magic number, then better not break it
>> freely.
>
> It's already broken by the relocatable format - which has zero as the
> start address. ?That's been in for a few years now, and no one even
> noticed that this header ended up with zero as the entry address.
> Therefore, I suggest that no one at all is using it.
>
>> On the other hand... we could simply decide _not_ to fix it on the
>> basis that this will create a different header for a pure Thumb2
>> image.
>>
>> Maybe it is a better idea to preserve the current header as is with the
>> ARM mode nops and perform the switch to Thumb mode using the branch
>> instruction after those 8 nops. ?This way the kernel image format will
>> remain compatible with existing bootloaders without a need for
>> bootloaders to know if the image is ARM or Thumb mode.
>
> That is definitely worth doing, and sounds like a better idea.
>

OK, that sounds reasonable -- I can try and propose a patch for this.
If the contents of the first 32 bytes doesn't matter, we can replace
the first two words with something like

adr r12, BSYM(real_start)
bx r12

.rept 6
