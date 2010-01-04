From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Mon, 4 Jan 2010 05:15:22 -0500
Subject: [patch 2/4] [ARM] mmp: support marvell ARMADA610
In-Reply-To: <f17812d71001032027k17dba375pd29ccbca17034a46@mail.gmail.com>
References: <771cded00912062219p79048babs669abf275419a2b9@mail.gmail.com>
	<f17812d70912281949r57e1ca83q65c3fb38c4675056@mail.gmail.com>
	<771cded00912310642x5ffeb071pcf6ade605138bb63@mail.gmail.com>
	<f17812d70912311946n42b6eb13q78afdbd92d2708e9@mail.gmail.com>
	<771cded01001031827j28dc6aa9l5425669f2ceeb27a@mail.gmail.com>
	<f17812d71001031849y294b0a99jdde0aa3e504a04fe@mail.gmail.com>
	<771cded01001031929w688217d3g257b395f7544ee7a@mail.gmail.com>
	<f17812d71001032027k17dba375pd29ccbca17034a46@mail.gmail.com>
Message-ID: <771cded01001040215g55a09005ra8248005fb396a1e@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 3, 2010 at 11:27 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
> On Mon, Jan 4, 2010 at 11:29 AM, Haojian Zhuang
> <haojian.zhuang@gmail.com> wrote:
>>>>> It really hurt performance a lot. While the difference between MMP series
>>>>> is just the offset of the IRQ_NUM register, it could be calculated in
>>>>> get_irqnr_preamble, which doesn't have to be executed each time
>>>>> in the IRQ handling loop. See arch/arm/kernel/entry-armv.S
>>>>
>>>> get_irqnr_preamble can only carries one base parameter and one tmp
>>>> parameter. base parameter is already used for interrupt control
>>>> register. Only one tmp parameter is left for use. If we want to check
>>>> chip id, one parameter is not enought.
>>>>
>>>
>>> I'm a bit confused, but those are just registers that the macro is able to use,
>>> not something as parameters??
>>>
>>
>> I could totaly use two parameters / registers. One is already used for
>> irq controller. Loading the value from irq controller register needs
>> one register. Storing camparison needs another register. At least, I
>> need two registers except irq controller register. But there's no
>> enough parameter / register in get_irqnr_preamble.
>>
>
> Two solutions:
>
> 1. use the first two nibbles 0x58, 0x80, 0x84 to decide if it's mmp1
> or mmp2, e.g.
>
> ? ? ? ?.macro ?get_irqnr_preamble, base, tmp
> ? ? ? ?mrc ? ? p15, 0, \tmp, c0, c0, 0 ? ? ? ? @ CPUID
> ? ? ? ?mov ? ? \tmp, \tmp, lsr #4
> ? ? ? ?and ? ? \tmp, \tmp, #0xff0
> ? ? ? ?cmp ? ? \tmp, #0x580

I have some concern on compressing 12-bit to 8-bit. Maybe it would not
fit chips in future.

> ? ? ? ?ldrne ? \base, =ICU_AP_IRQ_SEL_INT_NUM
> ? ? ? ?ldreq ? \base, =ICU_MMP2_PJ4_IRQ_SEL
> ? ? ? ?.endm
>
> ? ? ? ?.macro ?arch_ret_to_user, tmp1, tmp2
> ? ? ? ?.endm
>
> ? ? ? ?.macro ?get_irqnr_and_base, irqnr, irqstat, base, tmp
> ? ? ? ?ldr ? ? \tmp, [\base] ? ? ? ? ? @ AP INT SEL register
> ? ? ? ?and ? ? \irqnr, \tmp, #0x3f
> ? ? ? ?tst ? ? \tmp, #(1 << 6)
> ? ? ? ?.endm
>
It's wrong at here. Whatever we need to access ICU register in
get_irqnr_and_base.

        .macro irq_handler
        get_irqnr_preamble  r5, lr
1:     get_irqnr_and_base  r0, r6, r5, lr
        ...
        bne  asm_do_IRQ

If we just keep accessing ICU register in get_irqnr_preamble, we'll
find lr register used in asm_do_IRQ. When the loop came back to
get_irqnr_and_base(), we'll meet unpredicated value.

So I think that there's some flaw on this optimization.

Thanks
Haojian
