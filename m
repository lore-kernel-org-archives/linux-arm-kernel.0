From: eric.y.miao@gmail.com (Eric Miao)
Date: Fri, 1 Jan 2010 11:46:14 +0800
Subject: [patch 2/4] [ARM] mmp: support marvell ARMADA610
In-Reply-To: <771cded00912310642x5ffeb071pcf6ade605138bb63@mail.gmail.com>
References: <771cded00912062219p79048babs669abf275419a2b9@mail.gmail.com>
	<f17812d70912281949r57e1ca83q65c3fb38c4675056@mail.gmail.com>
	<771cded00912310642x5ffeb071pcf6ade605138bb63@mail.gmail.com>
Message-ID: <f17812d70912311946n42b6eb13q78afdbd92d2708e9@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 31, 2009 at 10:42 PM, Haojian Zhuang
<haojian.zhuang@gmail.com> wrote:
> On Mon, Dec 28, 2009 at 10:49 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
>> Haojian,
>>
>> Several suggestions:
>>
>> 1. entry-macro.S, could we simplify (and improve the performance a bit) to
>> something like (haven't tested yet - let me know the result):
>>
>> ? ? ? ?.macro ?get_irqnr_preamble, base, tmp
>> ? ? ? ?mrc ? ? p15, 0, \tmp, c0, c0, 0 ? ? ? ? @ CPUID
>> ? ? ? ?mov ? ? \tmp, \tmp, lsr #4
>> ? ? ? ?and ? ? \tmp, \tmp, #0xfff
>
> We shouldn't use #0xfff in and instruction. Immediate number shouldn't
> beyond 8bit. We have to use ldr instruction or multiple instrunctions.

Well, 0xff0 then, or ldr, whichever I don't mind.

>
>> ? ? ? ?cmp ? ? \tmp, #0x581 ? ? ? ? ? ? ? ? ? ?@ MMP2
>> ? ? ? ?moveq ? \base, #MMP2_ICU_PJ4_IRQ_SEL
>> ? ? ? ?movne ? \base, #ICU_AP_IRQ_SEL_INT_NUM
>> ? ? ? ?.endm
>>
>> ? ? ? ?.macro ?arch_ret_to_user, tmp1, tmp2
>> ? ? ? ?.endm
>>
>> ? ? ? ?.macro ?get_irqnr_and_base, irqnr, irqstat, base, tmp
>> ? ? ? ?ldr ? ? \tmp, [\base, #0]
>> ? ? ? ?and ? ? \irqnr, \tmp, #0x3f ? ? ? ? ? ? @ Interrupt Number
>> ? ? ? ?tst ? ? \tmp, #(1 << 6) ? ? ? ? ? ? ? ? @ Interrupt Pending ?
>> ? ? ? ?.endm
>>
>
> I don't like this way. Although more jump instructions are used in irq
> entry, it can be extended easier for supporting more silicons.
>

It really hurt performance a lot. While the difference between MMP series
is just the offset of the IRQ_NUM register, it could be calculated in
get_irqnr_preamble, which doesn't have to be executed each time
in the IRQ handling loop. See arch/arm/kernel/entry-armv.S

PXA is different since PXA25x checks the IRQ status by MMIO
register while PXA27x and above check that by co-processor.

> I've updated these patches in attached mail.
>

Thanks, I'll take a look and happy new year.
