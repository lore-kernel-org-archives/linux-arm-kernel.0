From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Mon, 4 Jan 2010 06:16:13 -0500
Subject: [patch 2/4] [ARM] mmp: support marvell ARMADA610
In-Reply-To: <20100104102740.GA9107@n2100.arm.linux.org.uk>
References: <771cded00912062219p79048babs669abf275419a2b9@mail.gmail.com>
	<f17812d70912281949r57e1ca83q65c3fb38c4675056@mail.gmail.com>
	<771cded00912310642x5ffeb071pcf6ade605138bb63@mail.gmail.com>
	<f17812d70912311946n42b6eb13q78afdbd92d2708e9@mail.gmail.com>
	<771cded01001031827j28dc6aa9l5425669f2ceeb27a@mail.gmail.com>
	<f17812d71001031849y294b0a99jdde0aa3e504a04fe@mail.gmail.com>
	<771cded01001031929w688217d3g257b395f7544ee7a@mail.gmail.com>
	<f17812d71001032027k17dba375pd29ccbca17034a46@mail.gmail.com>
	<771cded01001040215g55a09005ra8248005fb396a1e@mail.gmail.com>
	<20100104102740.GA9107@n2100.arm.linux.org.uk>
Message-ID: <771cded01001040316j58e07a74gae37e0cabcd60f26@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 4, 2010 at 5:27 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Jan 04, 2010 at 05:15:22AM -0500, Haojian Zhuang wrote:
>> On Sun, Jan 3, 2010 at 11:27 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
>> > ? ? ? ?.macro ?get_irqnr_preamble, base, tmp
>> > ? ? ? ?mrc ? ? p15, 0, \tmp, c0, c0, 0 ? ? ? ? @ CPUID
>> > ? ? ? ?mov ? ? \tmp, \tmp, lsr #4
>> > ? ? ? ?and ? ? \tmp, \tmp, #0xff0
>> > ? ? ? ?cmp ? ? \tmp, #0x580
>>
>> I have some concern on compressing 12-bit to 8-bit. Maybe it would not
>> fit chips in future.
>
> The spec for immediate constants is: any 32-bit constant, which may be
> rotated by an even number of shift places to form a single 8-bit
> constant.
>
> So, 0x0ff00000 is legal (0xff rotated left 20). ?0x07f800000 is not (0xff
> rotated left 19). ?0xfc000003 is legal (0xff rotated left 26).
>
> This comes directly from the instruction coding, which is an 8-bit
> constant plus a 4-bit shift.
>
>> > ? ? ? ?ldrne ? \base, =ICU_AP_IRQ_SEL_INT_NUM
>> > ? ? ? ?ldreq ? \base, =ICU_MMP2_PJ4_IRQ_SEL
>> > ? ? ? ?.endm
>> >
>> > ? ? ? ?.macro ?arch_ret_to_user, tmp1, tmp2
>> > ? ? ? ?.endm
>> >
>> > ? ? ? ?.macro ?get_irqnr_and_base, irqnr, irqstat, base, tmp
>> > ? ? ? ?ldr ? ? \tmp, [\base] ? ? ? ? ? @ AP INT SEL register
>> > ? ? ? ?and ? ? \irqnr, \tmp, #0x3f
>> > ? ? ? ?tst ? ? \tmp, #(1 << 6)
>> > ? ? ? ?.endm
>> >
>> It's wrong at here. Whatever we need to access ICU register in
>> get_irqnr_and_base.
>>
>> ? ? ? ? .macro irq_handler
>> ? ? ? ? get_irqnr_preamble ?r5, lr
>> 1: ? ? get_irqnr_and_base ?r0, r6, r5, lr
>> ? ? ? ? ...
>> ? ? ? ? bne ?asm_do_IRQ
>>
>> If we just keep accessing ICU register in get_irqnr_preamble, we'll
>> find lr register used in asm_do_IRQ. When the loop came back to
>> get_irqnr_and_base(), we'll meet unpredicated value.
>
> I don't see what you're getting at - Eric only uses the 'tmp' register
> as a local temporary in each macro. ?It's entirely local to that
> macro, and each macro doesn't care what value it had previously.
>
> The first thing that get_irqnr_and_base does is overwrite 'lr' with
> the value from the INT SEL register.
>

OK. Update the patches.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001--ARM-mmp-support-marvell-MMP2.patch
Type: text/x-patch
Size: 21193 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100104/cfdd9ce8/attachment-0004.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0002--ARM-mmp-add-device-support-in-mmp2.patch
Type: text/x-patch
Size: 17402 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100104/cfdd9ce8/attachment-0005.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0003--ARM-mmp-support-flint-development-board.patch
Type: text/x-patch
Size: 3895 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100104/cfdd9ce8/attachment-0006.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0004--ARM-mmp-add-mmp2-configuration.patch
Type: text/x-patch
Size: 30784 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100104/cfdd9ce8/attachment-0007.bin>
