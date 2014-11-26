From: khilman@kernel.org (Kevin Hilman)
Date: Wed, 26 Nov 2014 10:27:11 -0800
Subject: [PATCH v12 0/6] cpufreq: use generic cpufreq drivers for exynos
 platforms
In-Reply-To: <7hioi4l92v.fsf@deeprootsystems.com> (Kevin Hilman's message of
 "Mon, 24 Nov 2014 10:58:16 -0800")
References: <1416576682-5255-1-git-send-email-thomas.ab@samsung.com>
 <7hioi4l92v.fsf@deeprootsystems.com>
Message-ID: <7hlhmxes1s.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kevin Hilman <khilman@kernel.org> writes:

> Hi Thomas,
>
> Thomas Abraham <thomas.ab@samsung.com> writes:
>
>> Changes since v11:
>> - Rebased on top of git://linuxtv.org/snawrocki/samsung.git for-v3.19-exynos-clk
>
> Thanks for rebasing/reposting.
>
>> This patch series removes the use of Exynos4210 and Exynos5250 specific cpufreq
>> drivers and enables the use of cpufreq-dt driver for these platforms. This
>> series also enables cpufreq support for Exynos5420 using arm_big_little cpufreq
>> driver.
>>
>> This series is based on the following branch.
>> git://linuxtv.org/snawrocki/samsung.git for-v3.19-exynos-clk
>>
>> This series depends on the following patch which can be picked from
>> git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git samsung/dt
>> e540920cf21c (ARM: dts: add CPU nodes for Exynos4 SoCs).
>>
>> This patch series has been tested on Exynos4210/5250/5420 based boards.
>> Tomasz Figa had plans to take this in the Samsung clock tree for v3.19
>> (http://www.spinics.net/lists/linux-samsung-soc/msg37933.html).
>> Sylwester, could you consider to merge this in your tree?
>
> I tested this on exynos5800-peach-pi, and noticed a few things.
>
> First, since voltage scaling is not currently supported, the CPU cluster
> regulators (vdd_arm, and vdd_kfc) have to be set at sufficietnly high
> voltage to support all the OPPs, otherwise things will likely hang.  I
> think you should include something like the patch below[1] in this
> series as well.
>
> Second, as with earlier versions of this series, I'm still seeing lots
> of "wait_until_divider_stable: timeout in divider stablization" messages
> coming out when running powertop.

And, I just found another issue:

On exynos5800-peach-pi, setting the cpufreq default governor to
performance at compile time (CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y)
makes the kernel boot hang when the cpufreq driver is initialized.

However, setting the compile-time default to the userspace governor, and
then setting the performance governor via sysfs after the boot finishes
seems to work fine.

Kevin
