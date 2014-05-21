From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 21 May 2014 16:52:59 +0530
Subject: [PATCH] cpufreq: exynos: Fix driver compilation with
 ARCH_MULTIPLATFORM
In-Reply-To: <537C8B5C.3050401@samsung.com>
References: <537C6350.2010707@gmail.com>
 <1400670752-673-1-git-send-email-t.figa@samsung.com>
 <537C8B5C.3050401@samsung.com>
Message-ID: <CAKohpo=4nzSiqcMzgOka_jDco7FZ+3PHPa3ZWv++Pf7EAera2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 May 2014 16:47, Tomasz Figa <t.figa@samsung.com> wrote:

Mostly nitpicks ..

>> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
>>  config ARM_EXYNOS4X12_CPUFREQ
>>       bool "SAMSUNG EXYNOS4x12"
>> -     depends on (SOC_EXYNOS4212 || SOC_EXYNOS4412) && !ARCH_MULTIPLATFORM
>> +     depends on (SOC_EXYNOS4212 || SOC_EXYNOS4412)

Get rid of () as well..

>> diff --git a/drivers/cpufreq/exynos-cpufreq.h b/drivers/cpufreq/exynos-cpufreq.h
>> index a28ee9d..8dfebac 100644
>> --- a/drivers/cpufreq/exynos-cpufreq.h
>> +++ b/drivers/cpufreq/exynos-cpufreq.h
>> @@ -50,6 +50,7 @@ struct exynos_dvfs_info {
>>       struct cpufreq_frequency_table  *freq_table;
>>       void (*set_freq)(unsigned int, unsigned int);
>>       bool (*need_apll_change)(unsigned int, unsigned int);
>> +     void __iomem    *cmu_regs;

s/tab/space ? before *cmu_regs ..

>> diff --git a/drivers/cpufreq/exynos4210-cpufreq.c b/drivers/cpufreq/exynos4210-cpufreq.c
>> @@ -143,6 +160,8 @@ int exynos4210_cpufreq_init(struct exynos_dvfs_info *info)
>>       info->freq_table = exynos4210_freq_table;
>>       info->set_freq = exynos4210_set_frequency;
>>
>> +     cpufreq = info;

I couldn't find this variable .. i.e. 'cpufreq'

>> +
>>       return 0;
>>
>>  err_mout_apll:
>> diff --git a/drivers/cpufreq/exynos4x12-cpufreq.c b/drivers/cpufreq/exynos4x12-cpufreq.c

>>  int exynos4x12_cpufreq_init(struct exynos_dvfs_info *info)
>>  {
>> +     struct device_node *np;
>>       unsigned long rate;
>>
>> +     np = of_find_compatible_node(NULL, NULL, "samsung,exynos4412-clock");
>> +     if (!np) {
>> +             pr_err("%s: failed to find clock controller DT node\n",
>> +                     __func__);
>> +             return -ENODEV;
>> +     }
>> +
>> +     info->cmu_regs = of_iomap(np, 0);
>> +     if (!info->cmu_regs) {
>> +             pr_err("%s: failed to map CMU registers\n", __func__);
>> +             return -EFAULT;
>> +     }
>> +

Don't replicate. Create a routine for all this..
