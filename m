From: kmpark@infradead.org (Kyungmin Park)
Date: Wed, 28 Jul 2010 16:21:26 +0900
Subject: [PATCH] S5PV310: Define the OneNAND platform and interrupt
	definition
In-Reply-To: <000001cb2e20$c998da20$5cca8e60$%kim@samsung.com>
References: <20100728011724.GA1886@july>
	<000001cb2e20$c998da20$5cca8e60$%kim@samsung.com>
Message-ID: <AANLkTimNvuB=5cVXqQcLvOh=sZ_2vBxG3Nw6zuGh8BOz@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 28, 2010 at 3:47 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Kyungmin Park wrote:
>>
>> From: Kyungmin Park <kyungmin.park@samsung.com>
>>
>> s5pc210(aka S5PV310) has same OneNAND controller as s5pc110.
>>
>> It's against the Kukjin's latest s5pv310 tree.
>>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
>
> Hmm...as I said to MyungJoo just now, it would be helpful if you could make
> patchset not each patch.
> Because your 3 OneNAND patches are for support S5PC210 OneNAND...and there
> are some dependencies each other.

No Problem, I recognized it after sent, you can find a patch build
only on s5pc110 and s5pc210.

>
>> ?arch/arm/mach-s5pv310/include/mach/irqs.h | ? ?2 ++
>> ?arch/arm/plat-s5p/dev-onenand.c ? ? ? ? ? | ? 19 ++++++++++++++++++-
>> ?2 files changed, 20 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-s5pv310/include/mach/irqs.h b/arch/arm/mach-
>> s5pv310/include/mach/irqs.h
>> index 56885ca..f7fb2b8 100644
>> --- a/arch/arm/mach-s5pv310/include/mach/irqs.h
>> +++ b/arch/arm/mach-s5pv310/include/mach/irqs.h
>> @@ -66,6 +66,8 @@
>>
>> ?#define IRQ_IIC ? ? ? ? ? ? ? ? ? ? ?COMBINER_IRQ(27, 0)
>>
>> +#define IRQ_ONENAND_AUDI ? ? COMBINER_IRQ(34, 0)
>> +
>> ?/* Set the default NR_IRQS */
>> ?#define NR_IRQS
>> ? ? ? COMBINER_IRQ(MAX_COMBINER_NR, 0)
>>
>> diff --git a/arch/arm/plat-s5p/dev-onenand.c
> b/arch/arm/plat-s5p/dev-onenand.c
>> index 00facbe..8d191c5 100644
>> --- a/arch/arm/plat-s5p/dev-onenand.c
>> +++ b/arch/arm/plat-s5p/dev-onenand.c
>> @@ -29,11 +29,17 @@ static struct resource s5pc110_onenand_resources[] = {
>> ? ? ? },
>> ? ? ? [1] = {
>> ? ? ? ? ? ? ? .start ?= S5PC110_PA_ONENAND_DMA,
>> - ? ? ? ? ? ? .end ? ?= S5PC110_PA_ONENAND_DMA + SZ_2K - 1,
>> + ? ? ? ? ? ? .end ? ?= S5PC110_PA_ONENAND_DMA + SZ_8K - 1,
>> ? ? ? ? ? ? ? .flags ?= IORESOURCE_MEM,
>> ? ? ? },
>> + ? ? [2] = {
>> + ? ? ? ? ? ? .start ?= IRQ_ONENAND_AUDI,
>> + ? ? ? ? ? ? .end ? ?= IRQ_ONENAND_AUDI,
>
> Hmm...according to your first patch, always compile this file in plat-s5p...
> But other S5P SoCs don't have IRQ_ONENAND_AUDI definition...:-(

I will be build only on s5pc110 & s5pc210.

>
> Please make sure your patch doesn't any problem before submitting.
>
>> + ? ? ? ? ? ? .flags ?= IORESOURCE_IRQ,
>> + ? ? },
>> ?};
>>
>> +#ifdef CONFIG_ARCH_S5PV210
>> ?struct platform_device s5pc110_device_onenand = {
>> ? ? ? .name ? ? ? ? ? = "s5pc110-onenand",
>> ? ? ? .id ? ? ? ? ? ? = -1,
>> @@ -50,3 +56,14 @@ void s5pc110_onenand_set_platdata(struct
>> onenand_platform_data *pdata)
>> ? ? ? ? ? ? ? printk(KERN_ERR "%s: no memory for platform data\n",
>> __func__);
>> ? ? ? s5pc110_device_onenand.dev.platform_data = pd;
>> ?}
>> +#endif
>> +
>> +#ifdef CONFIG_ARCH_S5PV310
>> +/* Note that S5PC210(aka S5PV310) has same OneNAND controller as s5pc110
> */
>
> So...why did you separate s5pc110_device_onenand and
> s5pc210_device_onenand...
> I think just s5p_device_onenand is enough..
But other s5p cpu don't have it. e.g., s5p6440, s5p6410, s5pc100.
>
>> +struct platform_device s5pc210_device_onenand = {
>> + ? ? .name ? ? ? ? ? = "s5pc110-onenand",
>> + ? ? .id ? ? ? ? ? ? = -1,
>> + ? ? .num_resources ?= ARRAY_SIZE(s5pc110_onenand_resources),
>> + ? ? .resource ? ? ? = s5pc110_onenand_resources,
>> +};
>> +#endif
>> --
> Hmm...I wonder that should be separated S5PC110(S5PV210) and
> S5PC210(S5PV310)
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
