From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Mon, 1 Aug 2011 22:42:04 +0800
Subject: [PATCH v2 1/7] ARM: mmp: parse irq from DT
In-Reply-To: <20110801141036.GA21627@ponder.secretlab.ca>
References: <1311835293-18125-1-git-send-email-haojian.zhuang@marvell.com>
	<1311835293-18125-2-git-send-email-haojian.zhuang@marvell.com>
	<20110729163616.GJ11164@ponder.secretlab.ca>
	<CAN1soZxX6EBRPvzV_00njioBn1NfiAbLBoD7EYc-wV-uQM_VoQ@mail.gmail.com>
	<20110801141036.GA21627@ponder.secretlab.ca>
Message-ID: <CAN1soZwSiEojxC6uBAGYdUxJKPA2X+360ZsLEMyeUcBKdBn_SA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 1, 2011 at 10:10 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
> On Mon, Aug 01, 2011 at 10:47:06AM +0800, Haojian Zhuang wrote:
>> On Sat, Jul 30, 2011 at 12:36 AM, Grant Likely
>> <grant.likely@secretlab.ca> wrote:
>> >> diff --git a/arch/arm/mach-mmp/common.h b/arch/arm/mach-mmp/common.h
>> >> index ec8d65d..1c563c2 100644
>> >> --- a/arch/arm/mach-mmp/common.h
>> >> +++ b/arch/arm/mach-mmp/common.h
>> >> @@ -6,3 +6,4 @@ extern void timer_init(int irq);
>> >>
>> >> ?extern void __init icu_init_irq(void);
>> >> ?extern void __init mmp_map_io(void);
>> >> +extern void __init mmp_init_intc(void);
>> >> diff --git a/arch/arm/mach-mmp/include/mach/irqs.h b/arch/arm/mach-mmp/include/mach/irqs.h
>> >> index a09d328..65ec176 100644
>> >> --- a/arch/arm/mach-mmp/include/mach/irqs.h
>> >> +++ b/arch/arm/mach-mmp/include/mach/irqs.h
>> >> @@ -224,6 +224,6 @@
>> >>
>> >> ?#define IRQ_BOARD_START ? ? ? ? ? ? ? ? ? ? ?(IRQ_GPIO_START + IRQ_GPIO_NUM)
>> >>
>> >> -#define NR_IRQS ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?(IRQ_BOARD_START)
>> >> +#define NR_IRQS ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?0
>> >
>> > Why is NR_IRQs getting changed? ?I think this will break
>> > !CONFIG_SPARSE_IRQS, and it shouldn't be necessary for this
>> > conversion.
>> >
>> If CONFIG_SPARSE_IRQ is enabled, arch_probe_nr_irqs() returns NR_IRQS in arm.
>> It results registering NR_IRQS in early_irq_init(). If NR_IRQS is 200,
>> 200 irqs are
>> registered in early_irq_init(). It's not my requirement. What I need
>> is registering irq
>> from DT.
>>
>> So I have to define NR_IRQS to 0. And CONFIG_SPARSE_IRQS is always enabled
>> in ARCH_MMP. So it's selected in Kconfig by default.
>
> My point is, that applying this patch will break anyone depending on
> non-DT mach-mmp support. ?I'm completely fine with you doing so, but
> you need to be extra careful that it is done in a bisectable way. ?At
> no point in the commit series should the kernel be unable to build a
> working mmp image.
>
> g.
>
>

Since .nr_irqs property is assigned in machine descriptor of brownstone.c or
ttc_dkb.c, nr_irqs equals to machine_desc->nr_irqs (arch/arm/kernel/irq.c).

Even NR_IRQS is defined as 0, machine_desc->nr_irqs can help us to
pre-allocate irq numbers while CONFIG_OF isn't defined.

So it's not an issue in ARCH_MMP. And I tested it that everything is well.

Thanks
Haojian
