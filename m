From: dave.martin@linaro.org (Dave Martin)
Date: Mon, 14 Feb 2011 12:51:02 +0000
Subject: [PATCH 2/2] P2V: Thumb2 support
In-Reply-To: <alpine.LFD.2.00.1102130841240.14920@xanadu.home>
References: <alpine.LFD.2.00.1102121331220.14920@xanadu.home>
	<20110213114243.GC4799@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1102130841240.14920@xanadu.home>
Message-ID: <AANLkTinO58TS+YuhV2uL2LFtKcqLYtrcn-Gb_qmRNMs4@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 13, 2011 at 1:56 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Sun, 13 Feb 2011, Russell King - ARM Linux wrote:
>
>> On Sat, Feb 12, 2011 at 01:33:42PM -0500, Nicolas Pitre wrote:
>> > ?__fixup_a_pv_table:
>> > +#ifdef CONFIG_THUMB2_KERNEL
>> > +#ifdef CONFIG_ARM_PATCH_PHYS_VIRT_16BIT
>> > + ? lsls ? ?r0, r6, #24
>> > + ? lsr ? ? r6, #8
>> > + ? beq ? ? 1f
>> > + ? clz ? ? r7, r0
>> > + ? lsrs ? ?r0, #24
>> > + ? lsls ? ?r0, r7
>>
>> Why do these instructions need to update the PSR?
>
> Strictly speaking they don't. ?It's just a size optimization. ?There is
> a 16-bit encoding for them while their non-PSR-updating counterparts
> have only a 32-bit encoding.

More optimisations are available, but in general I'd advise against
this kind of optimisation for hand-written assembler -- it's unlikely
to help performance and impacts readability.

Using a low register in place of ip would shrink most of the loads and
stores to 16 bits for free though, if a suitable register is available
(r0?).

Cheers
---Dave
