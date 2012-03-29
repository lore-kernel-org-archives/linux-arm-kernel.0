From: tarun.kanti@ti.com (DebBarma, Tarun Kanti)
Date: Thu, 29 Mar 2012 11:04:40 +0530
Subject: [PATCH v2 1/4] ARM: OMAP1: boards: Fix OMAP_GPIO_IRQ usage with
 gpio_to_irq()
In-Reply-To: <CAOesGMg0eZAGdnU4A6Ubbyrn-zZAK4xvBVqoPkhhVReoHTAfaQ@mail.gmail.com>
References: <1332158817-26311-1-git-send-email-tarun.kanti@ti.com>
 <1332158817-26311-2-git-send-email-tarun.kanti@ti.com>
 <CAOesGMg0eZAGdnU4A6Ubbyrn-zZAK4xvBVqoPkhhVReoHTAfaQ@mail.gmail.com>
Message-ID: <CAC83ZvK9eSutCywynvzJRfz0jH-fCATrLH09_Y-G1+hnggfYmQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 29, 2012 at 10:28 AM, Olof Johansson <olof@lixom.net> wrote:
> Hi,
>
> Sorry for the slow reply, I noticed this when dealing with merge
> conflicts pulling in this patch and others from Tony.
>
> On Mon, Mar 19, 2012 at 5:06 AM, Tarun Kanti DebBarma
> <tarun.kanti@ti.com> wrote:
>> With dynamic allocation of IRQ the usage of OMAP_GPIO_IRQ
>> is no longer valid. We should be using gpio_to_irq() instead.
>>
>> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
>> ---
>> ?arch/arm/mach-omap1/board-h2.c ? ? ? ?| ? ?8 ++++----
>> ?arch/arm/mach-omap1/board-h3.c ? ? ? ?| ? ?9 ++++-----
>> ?arch/arm/mach-omap1/board-htcherald.c | ? ?6 +++---
>> ?arch/arm/mach-omap1/board-innovator.c | ? ?4 ++--
>> ?arch/arm/mach-omap1/board-nokia770.c ?| ? ?2 +-
>> ?arch/arm/mach-omap1/board-osk.c ? ? ? | ? 12 ++++++------
>> ?arch/arm/mach-omap1/board-palmte.c ? ?| ? ?2 +-
>> ?arch/arm/mach-omap1/board-palmtt.c ? ?| ? ?2 +-
>> ?arch/arm/mach-omap1/board-palmz71.c ? | ? ?2 +-
>> ?arch/arm/mach-omap1/board-voiceblue.c | ? 16 +++++++---------
>> ?10 files changed, 30 insertions(+), 33 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board-h2.c
>> index 00ad6b2..ad0eece 100644
>> --- a/arch/arm/mach-omap1/board-h2.c
>> +++ b/arch/arm/mach-omap1/board-h2.c
>> @@ -244,8 +244,6 @@ static struct resource h2_smc91x_resources[] = {
>> ? ? ? ? ? ? ? ?.flags ?= IORESOURCE_MEM,
>> ? ? ? ?},
>> ? ? ? ?[1] = {
>> - ? ? ? ? ? ? ? .start ?= OMAP_GPIO_IRQ(0),
>> - ? ? ? ? ? ? ? .end ? ?= OMAP_GPIO_IRQ(0),
>> ? ? ? ? ? ? ? ?.flags ?= IORESOURCE_IRQ | IORESOURCE_IRQ_LOWEDGE,
>> ? ? ? ?},
>> ?};
>> @@ -364,11 +362,9 @@ static struct tps65010_board tps_board = {
>> ?static struct i2c_board_info __initdata h2_i2c_board_info[] = {
>> ? ? ? ?{
>> ? ? ? ? ? ? ? ?I2C_BOARD_INFO("tps65010", 0x48),
>> - ? ? ? ? ? ? ? .irq ? ? ? ? ? ?= OMAP_GPIO_IRQ(58),
>> ? ? ? ? ? ? ? ?.platform_data ?= &tps_board,
>> ? ? ? ?}, {
>> ? ? ? ? ? ? ? ?I2C_BOARD_INFO("isp1301_omap", 0x2d),
>> - ? ? ? ? ? ? ? .irq ? ? ? ? ? ?= OMAP_GPIO_IRQ(2),
>> ? ? ? ?},
>> ?};
>>
>> @@ -437,10 +433,14 @@ static void __init h2_init(void)
>> ? ? ? ?omap_cfg_reg(E19_1610_KBR4);
>> ? ? ? ?omap_cfg_reg(N19_1610_KBR5);
>>
>> + ? ? ? h2_devices[2]->resource[1].start = gpio_to_irq(0);
>> + ? ? ? h2_devices[2]->resource[1].end = gpio_to_irq(0);
>
> Never, ever, ever do this. What happens here when someone else adds
> another device to the h2_devices array before the smc91x one? ?Booom.
> Extremely fragile code.
Ok.

>
> There's already a named resource struct you can use for this
> (h2_smc91x_resources). Use it.
Sure, I will use this one.

>
> Same comments go for the other locations in this file as well as the
> other OMAP2+ patch, where appropriate.
Alright, I will make appropriate changes. Thanks.
--
Tarun

>
> -Olof
