From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Thu, 31 Dec 2009 09:42:58 -0500
Subject: [patch 2/4] [ARM] mmp: support marvell ARMADA610
In-Reply-To: <f17812d70912281949r57e1ca83q65c3fb38c4675056@mail.gmail.com>
References: <771cded00912062219p79048babs669abf275419a2b9@mail.gmail.com>
	<f17812d70912281949r57e1ca83q65c3fb38c4675056@mail.gmail.com>
Message-ID: <771cded00912310642x5ffeb071pcf6ade605138bb63@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 28, 2009 at 10:49 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
> Haojian,
>
> Several suggestions:
>
> 1. entry-macro.S, could we simplify (and improve the performance a bit) to
> something like (haven't tested yet - let me know the result):
>
> ? ? ? ?.macro ?get_irqnr_preamble, base, tmp
> ? ? ? ?mrc ? ? p15, 0, \tmp, c0, c0, 0 ? ? ? ? @ CPUID
> ? ? ? ?mov ? ? \tmp, \tmp, lsr #4
> ? ? ? ?and ? ? \tmp, \tmp, #0xfff

We shouldn't use #0xfff in and instruction. Immediate number shouldn't
beyond 8bit. We have to use ldr instruction or multiple instrunctions.

> ? ? ? ?cmp ? ? \tmp, #0x581 ? ? ? ? ? ? ? ? ? ?@ MMP2
> ? ? ? ?moveq ? \base, #MMP2_ICU_PJ4_IRQ_SEL
> ? ? ? ?movne ? \base, #ICU_AP_IRQ_SEL_INT_NUM
> ? ? ? ?.endm
>
> ? ? ? ?.macro ?arch_ret_to_user, tmp1, tmp2
> ? ? ? ?.endm
>
> ? ? ? ?.macro ?get_irqnr_and_base, irqnr, irqstat, base, tmp
> ? ? ? ?ldr ? ? \tmp, [\base, #0]
> ? ? ? ?and ? ? \irqnr, \tmp, #0x3f ? ? ? ? ? ? @ Interrupt Number
> ? ? ? ?tst ? ? \tmp, #(1 << 6) ? ? ? ? ? ? ? ? @ Interrupt Pending ?
> ? ? ? ?.endm
>

I don't like this way. Although more jump instructions are used in irq
entry, it can be extended easier for supporting more silicons.

I've updated these patches in attached mail.

Thanks
Haojian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-mmp-support-marvell-MMP2.patch
Type: text/x-patch
Size: 21538 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091231/acb4ede1/attachment-0004.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0002-mmp-add-device-support-in-mmp2.patch
Type: text/x-patch
Size: 17396 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091231/acb4ede1/attachment-0005.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0003-mmp-support-flint-development-board.patch
Type: text/x-patch
Size: 3889 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091231/acb4ede1/attachment-0006.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0004--ARM-mmp-add-mmp2-configuration.patch
Type: text/x-patch
Size: 30784 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091231/acb4ede1/attachment-0007.bin>
