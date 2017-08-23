From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 23 Aug 2017 17:34:19 +0200
Subject: [PATCH] ARM: at91: don't select CONFIG_ARM_CPU_SUSPEND for old
 platforms
In-Reply-To: <20170823151951.bfkxypspcrdnc7v4@piout.net>
References: <20170823144636.2333097-1-arnd@arndb.de>
 <20170823151951.bfkxypspcrdnc7v4@piout.net>
Message-ID: <CAK8P3a1nsZaQStGJTe3AXJ=ty-trAtfTAa=c0sZFD2p_-LBxMw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 23, 2017 at 5:19 PM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> On 23/08/2017 at 16:46:15 +0200, Arnd Bergmann wrote:
>> My previous patch fixed a link error for all at91 platforms when
>> CONFIG_ARM_CPU_SUSPEND was not set, however this caused another
>> problem on a configuration that enabled CONFIG_ARCH_AT91 but none
>> of the individual SoCs, and that also enabled CPU_ARM720 as
>> the only CPU:
>>
>> warning: (ARCH_AT91 && SOC_IMX23 && SOC_IMX28 && ARCH_PXA && MACH_MVEBU_V7 && SOC_IMX6 && ARCH_OMAP3 && ARCH_OMAP4 && SOC_OMAP5 && SOC_AM33XX && SOC_DRA7XX && ARCH_EXYNOS3 && ARCH_EXYNOS4 && EXYNOS5420_MCPM && EXYNOS_CPU_SUSPEND && ARCH_VEXPRESS_TC2_PM && ARM_BIG_LITTLE_CPUIDLE && ARM_HIGHBANK_CPUIDLE && QCOM_PM) selects ARM_CPU_SUSPEND which has unmet direct dependencies (ARCH_SUSPEND_POSSIBLE)
>> arch/arm/kernel/sleep.o: In function `cpu_resume':
>> (.text+0xf0): undefined reference to `cpu_arm720_suspend_size'
>> arch/arm/kernel/suspend.o: In function `__cpu_suspend_save':
>> suspend.c:(.text+0x134): undefined reference to `cpu_arm720_do_suspend'
>>
>> This improves the hack some more by only selecting ARM_CPU_SUSPEND
>> for the part that requires it, and changing pm.c to drop the
>> contents of unused init functions so we no longer refer to
>> cpu_resume on at91 platforms that don't need it.
>>
>> Fixes: cc7a938f5f30 ("ARM: at91: select CONFIG_ARM_CPU_SUSPEND")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
>
> I think you can take it directly through arm-soc, I probably won't send
> more for 4.13.

Thanks, applied with your Ack.

      Arnd
