From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Thu, 8 Sep 2011 14:40:13 +0530
Subject: [PATCH v2 6/6] ARM: EXYNOS4: Limit usage of pl330 device instance
	to non-dt build
In-Reply-To: <001901cc6b8b$0f450730$2dcf1590$%kim@samsung.com>
References: <1314867882-11755-1-git-send-email-thomas.abraham@linaro.org>
	<1314867882-11755-2-git-send-email-thomas.abraham@linaro.org>
	<1314867882-11755-3-git-send-email-thomas.abraham@linaro.org>
	<1314867882-11755-4-git-send-email-thomas.abraham@linaro.org>
	<1314867882-11755-5-git-send-email-thomas.abraham@linaro.org>
	<1314867882-11755-6-git-send-email-thomas.abraham@linaro.org>
	<1314867882-11755-7-git-send-email-thomas.abraham@linaro.org>
	<001901cc6b8b$0f450730$2dcf1590$%kim@samsung.com>
Message-ID: <CAJuYYwSB3f8BPQx1jgsSykKKMMGsbeCCj7zSLp2-+gtonBrdVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Mr. Kim,

On 5 September 2011 10:47, Kukjin Kim <kgene.kim@samsung.com> wrote:
>> Subject: [PATCH v2 6/6] ARM: EXYNOS4: Limit usage of pl330 device instance
> to
>> non-dt build
>>
>> The pl330 device instances and associated platform data is required only
>> for non-device-tree builds. With device tree, all of this information is
>> obtained from the device tree.
>>
>> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
>> ---
>> ?arch/arm/mach-exynos4/Kconfig ?| ? ?7 +++++++
>> ?arch/arm/mach-exynos4/Makefile | ? ?3 ++-
>> ?2 files changed, 9 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-exynos4/Kconfig b/arch/arm/mach-exynos4/Kconfig
>> index d4d401c..3edbf37 100644
>> --- a/arch/arm/mach-exynos4/Kconfig
>> +++ b/arch/arm/mach-exynos4/Kconfig
>> @@ -21,6 +21,13 @@ config EXYNOS4_MCT
>> ? ? ? help
>> ? ? ? ? Use MCT (Multi Core Timer) as kernel timers
>>
>> +config EXYNOS4_DEV_DMA
>> + ? ? bool
>> + ? ? default y if !OF
>> + ? ? help
>> + ? ? ? Compile in amba device definitions for DMA controller if OF
>> + ? ? ? is not enabled.
>> +
>> ?config EXYNOS4_DEV_AHCI
>> ? ? ? bool
>> ? ? ? help
>> diff --git a/arch/arm/mach-exynos4/Makefile
> b/arch/arm/mach-exynos4/Makefile
>> index d2bf5bf..a2f33dc 100644
>> --- a/arch/arm/mach-exynos4/Makefile
>> +++ b/arch/arm/mach-exynos4/Makefile
>> @@ -13,7 +13,8 @@ obj- ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?:=
>> ?# Core support for EXYNOS4 system
>>
>> ?obj-$(CONFIG_CPU_EXYNOS4210) += cpu.o init.o clock.o irq-combiner.o
>> -obj-$(CONFIG_CPU_EXYNOS4210) += setup-i2c0.o irq-eint.o dma.o
>> pmu.o
>> +obj-$(CONFIG_CPU_EXYNOS4210) += setup-i2c0.o irq-eint.o pmu.o
>> +obj-$(CONFIG_EXYNOS4_DEV_DMA) ? ? ? ?+= dma.o
>
> Do we need _really_ EXYNOS4_DEV_DMA here?
> How about to use like following?
>
> +obj-$(!CONFIG_OF) ? ? ? ? ? ? ?+= dma.o
>
> If any problems, let me know.

While trying out your suggestion, I found a issue with this patch
related to compiling a kernel with both dt and non-dt board files
included in the build.

When compiling a single kernel image with mach-smdkv310.c file and
exynos4 device tree enabled machine file, since CONFIG_OF is enabled,
dma platform data does not get compiled which is required for
mach-smdkv310. So, I would like to resubmit this patch and the updated
diff is listed below. Could you please review the following diff.


diff --git a/arch/arm/mach-exynos4/Kconfig b/arch/arm/mach-exynos4/Kconfig
index d4d401c..953ead7 100644
--- a/arch/arm/mach-exynos4/Kconfig
+++ b/arch/arm/mach-exynos4/Kconfig
@@ -21,6 +21,11 @@ config EXYNOS4_MCT
 	help
 	  Use MCT (Multi Core Timer) as kernel timers

+config EXYNOS4_DEV_DMA
+	bool
+	help
+	  Compile in amba device definitions for DMA controller
+
 config EXYNOS4_DEV_AHCI
 	bool
 	help
@@ -129,6 +134,7 @@ config MACH_SMDKC210
 	select EXYNOS4_SETUP_FIMD0
 	select EXYNOS4_SETUP_I2C1
 	select EXYNOS4_SETUP_SDHCI
+	select EXYNOS4_DEV_DMA
 	help
 	  Machine support for Samsung SMDKC210

@@ -153,6 +159,7 @@ config MACH_SMDKV310
 	select EXYNOS4_SETUP_I2C1
 	select EXYNOS4_SETUP_KEYPAD
 	select EXYNOS4_SETUP_SDHCI
+	select EXYNOS4_DEV_DMA
 	help
 	  Machine support for Samsung SMDKV310

@@ -191,6 +198,7 @@ config MACH_UNIVERSAL_C210
 	select EXYNOS4_SETUP_I2C3
 	select EXYNOS4_SETUP_I2C5
 	select EXYNOS4_SETUP_SDHCI
+	select EXYNOS4_DEV_DMA
 	help
 	  Machine support for Samsung Mobile Universal S5PC210 Reference
 	  Board.
@@ -215,6 +223,7 @@ config MACH_NURI
 	select EXYNOS4_SETUP_USB_PHY
 	select SAMSUNG_DEV_PWM
 	select SAMSUNG_DEV_ADC
+	select EXYNOS4_DEV_DMA
 	help
 	  Machine support for Samsung Mobile NURI Board.

diff --git a/arch/arm/mach-exynos4/Makefile b/arch/arm/mach-exynos4/Makefile
index 929262a..a2f33dc 100644
--- a/arch/arm/mach-exynos4/Makefile
+++ b/arch/arm/mach-exynos4/Makefile
@@ -14,7 +14,8 @@ obj-				:=

 obj-$(CONFIG_CPU_EXYNOS4210)	+= cpu.o init.o clock.o irq-combiner.o
-obj-$(CONFIG_CPU_EXYNOS4210)	+= setup-i2c0.o irq-eint.o dma.o pmu.o
+obj-$(CONFIG_CPU_EXYNOS4210)	+= setup-i2c0.o irq-eint.o pmu.o
+obj-$(CONFIG_EXYNOS4_DEV_DMA)	+= dma.o
 obj-$(CONFIG_PM)		+= pm.o sleep.o
 obj-$(CONFIG_CPU_IDLE)		+= cpuidle.o



Thanks,
Thomas.
