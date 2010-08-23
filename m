From: kmpark@infradead.org (Kyungmin Park)
Date: Mon, 23 Aug 2010 11:59:22 +0900
Subject: [PATCH 2/3] ARM: S5P: Add initial map for GPIO2 and GPIO3
In-Reply-To: <005e01cb4269$081cb710$18562530$%kim@samsung.com>
References: <1282307628-5254-1-git-send-email-kgene.kim@samsung.com>
	<1282307628-5254-3-git-send-email-kgene.kim@samsung.com>
	<AANLkTimBMaVaZTEXG2HDYf1F98kYnRfWDn_BnT=pL85U@mail.gmail.com>
	<005401cb4258$bc135550$3439fff0$%kim@samsung.com>
	<AANLkTi=gnAthBXd0oyNzMySKt2Cv4C57kc2kM1LnCvAt@mail.gmail.com>
	<005e01cb4269$081cb710$18562530$%kim@samsung.com>
Message-ID: <AANLkTika2OCdbp2SutRUFR3198XO3XHT2BpGrf0z1_Ua@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 23, 2010 at 11:15 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Kyungmin Park wrote:
>>
>> On Mon, Aug 23, 2010 at 9:18 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:
>> > Kyungmin Park wrote:
>> >>
>> >> NAK.
>> >>
>> > I don't know why I need your ack for this...if any opinions, just
> comments
>> > is enough.
>>
>> Okay I said in other word, I can't agree this patch.
>>
>> >
>> >> This approach don't make a common GPIO framework. I already send the
>> >> common GPIO framework which send the base address to GPIO framework
>> >> and handle it regradless GPIO is one or three.
>> >>
>> > I don't think that your that RFC GPIO patch is common GPIO framework.
>> >
>> >>
>> >
> http://lists.infradead.org/pipermail/linux-arm-kernel/2010-August/022513.htm
>> > l
>> >>
>> >> With this patch, we can use the common GPIO framework and remove the
>> >> VA_GPIO dependency.
>> >>
>> > Why do you think your patch is common?
>>
>> In another patch, you just write the driver strength with
>> readl/writel. even though gpiolib already has interface,
>> s5p_gpio_set_drvstr
>>
> I missed gpio driver strength driver. Will fix it.
> But this issue is not regarding gpio driver strength.
>
>> and how to you implement the gpio_to_irq at both GPIO and EINT?
>>
> Will sort it out.
>
>> The "common" means GPIO related function should use the gpiolib
>> functions only. No direct access.
>>
> It means don't need to use your previous patch which is just RFC regarding
> removing VA_GPIO.
and make it for multiple GPIOs such as s5pc210. also make it simple
for GPIOs and EINT.
It's also cover the gpio_to_irq to use the similar scheme either GPIOs or EINT.

>
>> If your patch match these criteria then I'll ack your patch.
>>
> Hmm...
>
>> All
>> >
>> >> Thank you,
>> >> Kyungmin Park
>> >>
>> >> On Fri, Aug 20, 2010 at 9:33 PM, Kukjin Kim <kgene.kim@samsung.com>
> wrote:
>> >> > From: Jongpill Lee <boyko.lee@samsung.com>
>> >> >
>> >> > This patch adds initial map for GPIO2 and GPIO3.
>> >> > S5PV310/S5PC210 has separated GPIO1, GPIO2 and GPIO3.
>> >> >
>> >> > Signed-off-by: Jongpill Lee <boyko.lee@samsung.com>
>> >> > Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
>> >> > ---
>> >> > ?arch/arm/mach-s5pv310/cpu.c ? ? ? ? ? ? ?| ? 10 ++++++++++
>> >> > ?arch/arm/plat-s5p/include/plat/map-s5p.h | ? ?2 ++
>> >> > ?2 files changed, 12 insertions(+), 0 deletions(-)
>> >> >
>> >> > diff --git a/arch/arm/mach-s5pv310/cpu.c
> b/arch/arm/mach-s5pv310/cpu.c
>> >> > index 196c9f1..db4f55a 100644
>> >> > --- a/arch/arm/mach-s5pv310/cpu.c
>> >> > +++ b/arch/arm/mach-s5pv310/cpu.c
>> >> > @@ -45,6 +45,16 @@ static struct map_desc s5pv310_iodesc[] __initdata
> =
>> > {
>> >> > ? ? ? ? ? ? ? ?.pfn ? ? ? ? ? ?= __phys_to_pfn(S5PV310_PA_L2CC),
>> >> > ? ? ? ? ? ? ? ?.length ? ? ? ? = SZ_4K,
>> >> > ? ? ? ? ? ? ? ?.type ? ? ? ? ? = MT_DEVICE,
>> >> > + ? ? ? }, {
>> >> > + ? ? ? ? ? ? ? .virtual ? ? ? ?= (unsigned long)S5P_VA_GPIO2,
>> >> > + ? ? ? ? ? ? ? .pfn ? ? ? ? ? ?= __phys_to_pfn(S5PV310_PA_GPIO2),
>> >> > + ? ? ? ? ? ? ? .length ? ? ? ? = SZ_4K,
>> >> > + ? ? ? ? ? ? ? .type ? ? ? ? ? = MT_DEVICE,
>> >> > + ? ? ? }, {
>> >> > + ? ? ? ? ? ? ? .virtual ? ? ? ?= (unsigned long)S5P_VA_GPIO3,
>> >> > + ? ? ? ? ? ? ? .pfn ? ? ? ? ? ?= __phys_to_pfn(S5PV310_PA_GPIO3),
>> >> > + ? ? ? ? ? ? ? .length ? ? ? ? = SZ_256K,
>> >> > + ? ? ? ? ? ? ? .type ? ? ? ? ? = MT_DEVICE,
>> >> > ? ? ? ?},
>> >> > ?};
>> >> >
>> >> > diff --git a/arch/arm/plat-s5p/include/plat/map-s5p.h
> b/arch/arm/plat-
>> >> s5p/include/plat/map-s5p.h
>> >> > index 54e9fb9..bc52595 100644
>> >> > --- a/arch/arm/plat-s5p/include/plat/map-s5p.h
>> >> > +++ b/arch/arm/plat-s5p/include/plat/map-s5p.h
>> >> > @@ -15,6 +15,8 @@
>> >> >
>> >> > ?#define S5P_VA_CHIPID ? ? ? ? ?S3C_ADDR(0x00700000)
>> >> > ?#define S5P_VA_GPIO ? ? ? ? ? ?S3C_ADDR(0x00500000)
>> >> > +#define S5P_VA_GPIO2 ? ? ? ? ? S3C_ADDR(0x00510000)
>> >> > +#define S5P_VA_GPIO3 ? ? ? ? ? S3C_ADDR(0x00520000)
>> >> > ?#define S5P_VA_SYSTIMER ? ? ? ? ? ? ? ?S3C_ADDR(0x01200000)
>> >> > ?#define S5P_VA_SROMC ? ? ? ? ? S3C_ADDR(0x01100000)
>> >> >
>> >> > --
>> >
>> >
>
>
> Thanks.
>
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
>
>
