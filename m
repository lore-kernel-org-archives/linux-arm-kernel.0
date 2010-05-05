From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed, 5 May 2010 03:52:08 -0400
Subject: [PATCH 01/10] [ARM] pxa: extend to support 96 IRQs
In-Reply-To: <z2qf17812d71005041828ocd0ff0cfn33bf32ce9c1d46c3@mail.gmail.com>
References: <j2l771cded01004290115kf0c7b08m8dface1967d26752@mail.gmail.com>
	<z2qf17812d71005041828ocd0ff0cfn33bf32ce9c1d46c3@mail.gmail.com>
Message-ID: <q2m771cded01005050052o51ffbe27jdd66d3117a33c9da@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 4, 2010 at 9:28 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
> On Thu, Apr 29, 2010 at 4:15 PM, Haojian Zhuang
> <haojian.zhuang@gmail.com> wrote:
>> From ea9bcffc52bb7ee542c3615530e1c8e87100c884 Mon Sep 17 00:00:00 2001
>> From: Haojian Zhuang <haojian.zhuang@marvell.com>
>> Date: Thu, 29 Apr 2010 10:22:12 -0400
>> Subject: [PATCH] [ARM] pxa: extend to support 96 IRQs
>>
>> Extend to support 96 IRQs for PXA950.
>>
>> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
>> ---
>> ?arch/arm/mach-pxa/irq.c ? ?| ? ?9 ++++++---
>> ?arch/arm/mach-pxa/pxa3xx.c | ? ?2 +-
>> ?2 files changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/mach-pxa/irq.c b/arch/arm/mach-pxa/irq.c
>> index 1beb40f..bb5a0c7 100644
>> --- a/arch/arm/mach-pxa/irq.c
>> +++ b/arch/arm/mach-pxa/irq.c
>> @@ -27,9 +27,12 @@
>>
>> ?#define MAX_INTERNAL_IRQS ? ? ?128
>>
>> -#define IRQ_BIT(n) ? ? (((n) - PXA_IRQ(0)) & 0x1f)
>> -#define _ICMR(n) ? ? ? (*((((n) - PXA_IRQ(0)) & ~0x1f) ? &ICMR2 : &ICMR))
>> -#define _ICLR(n) ? ? ? (*((((n) - PXA_IRQ(0)) & ~0x1f) ? &ICLR2 : &ICLR))
>> +#define _IDX(n) ? ? ? ? ? ? ? ?((n) - PXA_IRQ(0))
>> +#define IRQ_BIT(n) ? ? (_IDX(n) & 0x1f)
>> +#define _ICMR(n) ? ? ? (*((_IDX(n) < 32) ? &ICMR ? ? ? ? ? ? ? ? ? ? ? \
>> + ? ? ? ? ? ? ? ? ? ? ? : ((_IDX(n) < 64) ? &ICMR2 : &ICMR3)))
>> +#define _ICLR(n) ? ? ? (*((_IDX(n) < 32) ? &ICLR ? ? ? ? ? ? ? ? ? ? ? \
>> + ? ? ? ? ? ? ? ? ? ? ? : ((_IDX(n) < 64) ? &ICLR2 : &ICLR3)))
>>
>
> Instead of making these macros more complicated, I'd prefer that
> we separate them as three IRQ register banks, with the base I/O
> address of these banks in irq_desc.chip_data or some where.
>

If we use irq_desc.chip_data, we have to divide init_irq() into more
parts. Each part is focus on one interrupt bank registers. The
assignment of interrupt priority have to be divided into more parts.
And saving interrupt registers in suspend() may be more complex.

Thanks
Haojian
