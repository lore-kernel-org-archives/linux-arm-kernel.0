From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Tue, 20 Jul 2010 16:00:10 +0900
Subject: [PATCH v3 7/7] ARM: S5PV210: Initial CPUFREQ Support
In-Reply-To: <006301cb27a3$bd8d55e0$38a801a0$%kim@samsung.com>
References: <1279517483-22751-1-git-send-email-myungjoo.ham@samsung.com>
	<1279517483-22751-2-git-send-email-myungjoo.ham@samsung.com>
	<1279517483-22751-3-git-send-email-myungjoo.ham@samsung.com>
	<1279517483-22751-4-git-send-email-myungjoo.ham@samsung.com>
	<1279517483-22751-5-git-send-email-myungjoo.ham@samsung.com>
	<1279517483-22751-6-git-send-email-myungjoo.ham@samsung.com>
	<1279517483-22751-7-git-send-email-myungjoo.ham@samsung.com>
	<1279517483-22751-8-git-send-email-myungjoo.ham@samsung.com>
	<006301cb27a3$bd8d55e0$38a801a0$%kim@samsung.com>
Message-ID: <AANLkTincP954dBuRIN8KwiQPo1CDkykRKv1vIMFYcnyo@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 20, 2010 at 9:37 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> MyungJoo Ham wrote:
>>
>> S5PV210 CPUFREQ Support.
>>
>> This CPUFREQ may work without PMIC's DVS support. However, it is not
>> as effective without DVS support as supposed. AVS is not supported in
>> this version.
>>
>> Note that CLK_SRC of some clocks including ARMCLK, G3D, G2D, MFC,
>> and ONEDRAM are modified directly without updating clksrc_src
>> representations of the clocks. ?Because CPUFREQ reverts the CLK_SRC
>> to the supposed values, this does not affect the consistency as long as
>> there are no other modules that modifies clock sources of ARMCLK, G3D,
>> G2D, MFC, and ONEDRAM (and only CPUFREQ should have the control). As
>> soon as clock framework is settled, we may update source clocks
>> (.parent field) of those clocks accordingly later.
>>
> As you know memory composition such as mDDR, (mDDR, OneDRAM), DDR2 and so on
> differs in MCP type of each S5PC110, and single type of S5PV210.
> So basically, this code can available only for some S5PC110 MCP types...only
> some machines.
> It means can occur problem on some boards...if you use ARCH dependency
> configuration...
> And need to add comment about tested boards.

Although selecting "ARCH_HAS_CPUFREQ" does not make choosing
ARCH_S5PV210 depend on CPUFREQ as it does NOT turn on CPUFREQ
automatically or forcibly, do you think we need to block being able to
turn on CPUFREQ if it is not one of the test boards?

However, in the next patch version, I'm going to use the memory clock
setting values set before initializing cpufreq so that we have no
compatibility issues on memory configurations.

>
>>

(snip)

>> +
>> +# CPUFREQ (DVFS)
>
> No need above comment.

should be fixed.

>
>> +obj-$(CONFIG_CPU_FREQ) ? ? ? ? ? ? ? += cpufreq-s5pv210.o
>
> As I said, should be having machine dependency configuration...

going to remove memory-configuration dependency...

>
>> diff --git a/arch/arm/mach-s5pv210/cpufreq-s5pv210.c b/arch/arm/mach-
>> s5pv210/cpufreq-s5pv210.c
>> new file mode 100644
>> index 0000000..38de3ac
>> --- /dev/null
>> +++ b/arch/arm/mach-s5pv210/cpufreq-s5pv210.c
>
> 'cpufreq.c' is enough.

fine.

>
>> @@ -0,0 +1,766 @@
>> +/* ?linux/arch/arm/plat-s5pc11x/s5pc11x-cpufreq.c
>
> Please correct above comment.

sure.

>
>> + *

(snip)

>> +#ifdef CONFIG_S5PC110_EVT0_WORKAROUND
>
> As I said, please don't add EVT0 code in here.
>

Um.. then, what you want to do is to branch to the WORKAROUND codes in
run-time (based on the board-specific setting), not in compile-time?

(snip)

>> +#if defined(CONFIG_S5PC110_H_TYPE)
>
> Where is S5PC110_H_TYPE?
> Please don't add not available code in here.

will remove every H_TYPE.

>

(snip)

>> + ? ? mpu_clk = clk_get(NULL, MPU_CLK);
>
> Just use 'armclk' instead of MPU_CLK definition...
>

Yes.

(snip)

>> +
>> +#ifndef _ARCH_ARM_MACH_S5PV210_INCLUDE_MACH_CPU_FREQ_H_
>> +#define _ARCH_ARM_MACH_S5PV210_INCLUDE_MACH_CPU_FREQ_H_
>
> How about __ASM_ARCH_CPU_FREQ_H ?

Fine.

>
>> +
>> +#include <linux/cpufreq.h>
>> +
>> +#ifdef CONFIG_CPU_S5PV210
>
> Do we really need above #ifdef?

Not really. I'll remove it.

>
>> +
>> +#define USE_FREQ_TABLE
>> +
>> +#define KHZ_T ? ? ? ? ? 1000
>
> Already said about that.
>
>> +
>> +#define MPU_CLK ? ? ? ? "armclk"
>
> Already said about that...
>
>> +
>> +enum perf_level {
>> + ? ? L0 = 0,
>> + ? ? L1,
>> + ? ? L2,
>> + ? ? L3,
>> + ? ? L4,
>> +};
>> +
>> +/* APLL,HCLK_MSYS,PCLK_MSYS mask value */
>> +#define CLK_DIV0_MASK ? ((0x7<<0)|(0x7<<8)|(0x7<<12))
>
> Here is right?

Found that it's no more needed. I'll get rid of it.

>
>> +
>> +#ifdef CONFIG_PM
>> +#define SLEEP_FREQ ? ? ?(800 * 1000) /* Use 800MHz when entering sleep */
>> +
>> +/* additional symantics for "relation" in cpufreq with pm */
>> +#define DISABLE_FURTHER_CPUFREQ ? ? ? ? 0x10
>> +#define ENABLE_FURTHER_CPUFREQ ? ? ? ? ?0x20
>> +#define MASK_FURTHER_CPUFREQ ? ? ? ? ? ?0x30
>> +/* With 0x00(NOCHANGE), it depends on the previous "further" status */
>> +
>> +#endif
>> +
>> +
>
> 1 empty line is enough...
>
>> +#endif /* CONFIG_CPU_S5PV210 */
>> +#endif /* _ARCH_ARM_MACH_S5PV210_INCLUDE_MACH_CPU_FREQ_H_ */
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



-- 
MyungJoo Ham (???), Ph.D.
Mobile Software Platform Lab,
Digital Media and Communications (DMC) Business
Samsung Electronics
cell: 82-10-6714-2858
