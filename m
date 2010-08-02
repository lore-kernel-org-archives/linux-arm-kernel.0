From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Mon, 2 Aug 2010 21:37:59 +0900
Subject: [PATCH v5 1/7] ARM: S5PV210: Allow to probe EVT revision number.
In-Reply-To: <018001cb31ea$158c84f0$40a58ed0$%kim@samsung.com>
References: <1280399145-22761-1-git-send-email-myungjoo.ham@samsung.com>
	<1280399145-22761-2-git-send-email-myungjoo.ham@samsung.com>
	<018001cb31ea$158c84f0$40a58ed0$%kim@samsung.com>
Message-ID: <AANLkTik0uD40j7kBEyv8VGOMPR5o-pKRZ1chmRwSb_Wr@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 2, 2010 at 11:26 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> MyungJoo Ham wrote:
>>
>> Early products of S5PV210, EVT0, had several errata that require
>> kernel to avoid using some parts/instructions of the CPU or to
>> add protection instructions. There are products with such early
>> production CPUs; thus, we want to distinguish them in kernel.
>> This patch is to distinguish such products.
>>
>> Include <mach/hardware.h> and call s5pv210_revision().
>>
>> For example,
>>
>> ? ? ? if (s5pv210_revision(EVT0)) {
>> ? ? ? ? ? ? ? ... execute code targeted only to EVT0 ...
>> ? ? ? } else {
>> ? ? ? ? ? ? ? ... execute normal code ...
>> ? ? ? }
>>
>> Call set_s5pv210_revision(EVTx) when the EVT revision number can be
>> identified. We have EVT0, EVT1, and EVT1-Fused avaialble right now and
>> only EVT1-Fused has the unique revision number at chipid (PRO_ID
>> register). A function, get_s5pv210_revision_chipid(), returns EVT
>> revision number if the revision is identified by the chipid; otherwise,
>> the function returns EVT_UNKNOWN. When EVT cannot be identified with
>> chipid, it can be identified at board support file
>> (arch/arm/mach-s5pv210/mach-*.c), not at the cpu file
>> (arch/arm/mach-s5pv210/cpu.c).
>>
>> For Aquila machine. (mach-aquila.c)
>>
>> Part of Aquila machines have the early production CPUs that require
>> to address errata issues. Note that we don't do this for GONI machines
>> because they have never used early production CPUs with errata. Besides,
>> please note that there are other boards that use such early produces
>> other than Aquila. However, those boards/machines are not registered at
>> the /linux/arch/arm/tools/mach-types, yet; thus, we have omitted them
>> in this patch.
>>
>> For Goni machine. (mach-goni.c)
>>
>> It's either EVT1 or EVT1-Fused; thus, it can be identified by
>> get_s5pv210_revision_chipid() function.
>>
>> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> --
>> v5:
>> ? ? ? - rename revision check function.
>> ? ? ? - revise revision check functions so that it does not access
>> ? ? ? ? board-related information.
>> ? ? ? - chipid is used to identify EVT revision.
>> ? ? ? - added "s5pv210_revision_or_later()" function
>> ---
>> ?arch/arm/mach-s5pv210/cpu.c ? ? ? ? ? ? ? ? ? | ? 29
>> +++++++++++++++++++++++++
>> ?arch/arm/mach-s5pv210/include/mach/hardware.h | ? 19 +++++++++++++++-
>> ?arch/arm/mach-s5pv210/mach-aquila.c ? ? ? ? ? | ? 14 ++++++++++++
>> ?arch/arm/mach-s5pv210/mach-goni.c ? ? ? ? ? ? | ? ?8 +++++++
>> ?4 files changed, 69 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-s5pv210/cpu.c b/arch/arm/mach-s5pv210/cpu.c
>> index 94c632b..77bf37d 100644
>> --- a/arch/arm/mach-s5pv210/cpu.c
>> +++ b/arch/arm/mach-s5pv210/cpu.c
>> @@ -24,9 +24,11 @@
>> ?#include <asm/mach/map.h>
>> ?#include <asm/mach/irq.h>
>>
>> +#include <asm/mach-types.h>
>> ?#include <asm/proc-fns.h>
>> ?#include <mach/map.h>
>> ?#include <mach/regs-clock.h>
>> +#include <mach/hardware.h>
>>
>> ?#include <plat/cpu.h>
>> ?#include <plat/devs.h>
>> @@ -128,6 +130,33 @@ static struct sys_device s5pv210_sysdev = {
>> ? ? ? .cls ? ?= &s5pv210_sysclass,
>> ?};
>>
>> +static enum s5pv210_revision s5pv210_evt_number = EVT_UNKNOWN;
>> +
>> +bool s5pv210_revision(enum s5pv210_revision rev)
>> +{
>> + ? ? return rev == s5pv210_evt_number;
>> +}
>> +
>> +bool s5pv210_revision_or_later(enum s5pv210_revision rev)
>> +{
>> + ? ? return rev >= s5pv210_evt_number;
>> +}
>> +
>> +void set_s5pv210_revision(enum s5pv210_revision rev)
>> +{
>> + ? ? s5pv210_evt_number = rev;
>> +}
>> +
>> +enum s5pv210_revision get_s5pv210_revision_chipid(void)
>> +{
>> + ? ? unsigned int reg = __raw_readl(S5P_VA_CHIPID);
>> +
>> + ? ? if ((reg & 0xf0) == 0x20)
>> + ? ? ? ? ? ? return EVT1_FUSED;
>> +
>> + ? ? return EVT_UNKNOWN;
>> +}
>> +
>> ?static int __init s5pv210_core_init(void)
>> ?{
>> ? ? ? return sysdev_class_register(&s5pv210_sysclass);
>> diff --git a/arch/arm/mach-s5pv210/include/mach/hardware.h
> b/arch/arm/mach-
>> s5pv210/include/mach/hardware.h
>> index fada7a3..c1702d6 100644
>> --- a/arch/arm/mach-s5pv210/include/mach/hardware.h
>> +++ b/arch/arm/mach-s5pv210/include/mach/hardware.h
>> @@ -13,6 +13,23 @@
>> ?#ifndef __ASM_ARCH_HARDWARE_H
>> ?#define __ASM_ARCH_HARDWARE_H __FILE__
>>
>> -/* currently nothing here, placeholder */
>> +enum s5pv210_revision { EVT_UNKNOWN = 0,
>> + ? ? EVT0,
>> + ? ? EVT1,
>> + ? ? EVT1_FUSED };
>
> Do we really need checking of 'EVT1_FUSED' in kernel?

Um.. so far, we don't have cases that require FUSED mode separated. I
have added EVT1_FUSED for "future-use". However, it appears that
EVT1_FUSED is not going to affect the kernel-level codes and I think
we may get rid of it for the efficiency.

>
>> +
>> +extern bool s5pv210_revision(enum s5pv210_revision);
>> +extern bool s5pv210_revision_or_later(enum s5pv210_revision);
>> +extern void set_s5pv210_revision(enum s5pv210_revision);
>> +
>> +/*
>> + * get_s5pv210_revision_chipid returns s5pv210_revision if the
>> + * EVT revision can be determined by the chipid(PRO_ID) register.
>> + * However, note that only EVT1-FUSED can be identified from it and
>> + * it cannot distinguish between EVT0 and EVT1. In such case, it
>> + * returns EVT_UNKNOWN. In such case use set_s5pv210_revision() to
>> + * set the revision number manually.
>> + */
>> +extern enum s5pv210_revision get_s5pv210_revision_chipid(void);
>>
>> ?#endif /* __ASM_ARCH_HARDWARE_H */
>> diff --git a/arch/arm/mach-s5pv210/mach-aquila.c
> b/arch/arm/mach-s5pv210/mach-
>> aquila.c
>> index 46d5c7e..25f45d1 100644
>> --- a/arch/arm/mach-s5pv210/mach-aquila.c
>> +++ b/arch/arm/mach-s5pv210/mach-aquila.c
>> @@ -30,6 +30,7 @@
>> ?#include <mach/regs-clock.h>
>> ?#include <mach/regs-fb.h>
>> ?#include <mach/gpio.h>
>> +#include <mach/hardware.h>
>>
>> ?#include <plat/gpio-cfg.h>
>> ?#include <plat/regs-serial.h>
>> @@ -536,6 +537,19 @@ static void __init aquila_map_io(void)
>>
>> ?static void __init aquila_machine_init(void)
>> ?{
>> + ? ? enum s5pv210_revision cpurev = get_s5pv210_revision_chipid();
>> +
>> + ? ? /* CPU Revision (EVTx) */
>> + ? ? if (cpurev == EVT_UNKNOWN) {
>
> If don't need 'EVT1_FUSED', maybe just need to check system_rev.
>
>> + ? ? ? ? ? ? cpurev = EVT1;
>
>> + ? ? ? ? ? ? if (system_rev & 0x0800) {
>> + ? ? ? ? ? ? ? ? ? ? if ((system_rev & 0xF) < 8)
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? cpurev = EVT0;
>
> ...
>
>> + ? ? ? ? ? ? } else if (system_rev & 0x2000)
>> + ? ? ? ? ? ? ? ? ? ? cpurev = EVT0;
>
> ...
>
>> + ? ? }
>> + ? ? set_s5pv210_revision(cpurev);
>> +
>> ? ? ? /* PMIC */
>> ? ? ? aquila_pmic_init();
>> ? ? ? i2c_register_board_info(AP_I2C_GPIO_PMIC_BUS_4,
>> i2c_gpio_pmic_devs,
>> diff --git a/arch/arm/mach-s5pv210/mach-goni.c
> b/arch/arm/mach-s5pv210/mach-
>> goni.c
>> index 380d2ae..25a26ed 100644
>> --- a/arch/arm/mach-s5pv210/mach-goni.c
>> +++ b/arch/arm/mach-s5pv210/mach-goni.c
>> @@ -32,6 +32,7 @@
>> ?#include <mach/regs-clock.h>
>> ?#include <mach/regs-fb.h>
>> ?#include <mach/gpio.h>
>> +#include <mach/hardware.h>
>>
>> ?#include <plat/gpio-cfg.h>
>> ?#include <plat/regs-serial.h>
>> @@ -520,6 +521,13 @@ static void __init goni_map_io(void)
>>
>> ?static void __init goni_machine_init(void)
>> ?{
>> + ? ? enum s5pv210_revision cpurev = get_s5pv210_revision_chipid();
>> +
>> + ? ? /* CPU Revision (EVTx) */
>> + ? ? if (cpurev == EVT_UNKNOWN)
>> + ? ? ? ? ? ? cpurev = EVT1;
>
> is it available only EVT1 on GONI?
>
>> + ? ? set_s5pv210_revision(cpurev);
>> +
>> ? ? ? /* PMIC */
>> ? ? ? goni_pmic_init();
>> ? ? ? i2c_register_board_info(AP_I2C_GPIO_PMIC_BUS_4,
>> i2c_gpio_pmic_devs,
>> --
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
>



-- 
MyungJoo Ham (???), Ph.D.
Mobile Software Platform Lab,
Digital Media and Communications (DMC) Business
Samsung Electronics
cell: 82-10-6714-2858
