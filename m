From: amit.kachhap@gmail.com (Amit Kachhap)
Date: Tue, 29 Apr 2014 11:44:14 +0530
Subject: [PATCH 2/2] cpufreq: Remove exynos_sort_descend_freq_table in
 exynos5440-cpufreq.c
In-Reply-To: <CAKohpo=ei0v69iQtjd6cjmfUCo-+sd1JzNc4RDza92nxaPoiVg@mail.gmail.com>
References: <000701cf636b$3d1d13c0$b7573b40$@samsung.com>
 <CAKohpo=ei0v69iQtjd6cjmfUCo-+sd1JzNc4RDza92nxaPoiVg@mail.gmail.com>
Message-ID: <CADGdYn7cA940sxPszP5TA5tMnXD_=QkH3U3Wedy2DoC++rwRkQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/29/14, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 29 April 2014 10:54, Jonghwan Choi <jhbird.choi@samsung.com> wrote:
>> diff --git a/drivers/cpufreq/exynos5440-cpufreq.c
>> -static void exynos_sort_descend_freq_table(void)
>> -{
>> -       struct cpufreq_frequency_table *freq_tbl = dvfs_info->freq_table;
>> -       int i = 0, index;
>> -       unsigned int tmp_freq;
>> -       /*
>> -        * Exynos5440 clock controller state logic expects the cpufreq
>> table
>> to
>> -        * be in descending order. But the OPP library constructs the
>> table
>> in
>> -        * ascending order. So to make the table descending we just need
>> to
>> -        * swap the i element with the N - i element.
>> -        */
>
> What I am more focused is on: Why do we need to worry about order at
> all in the first place.
>
> Okay, above comment says something about it but I couldn't understand
> what's the logic behind that. Why do we need same order as of clock
> controller. Please point out relevant code pieces as well..
>
> @Amit: Your comments on this ?

Hi Viresh/Jonghwan,

In the frequency table dts file, the frequencies are arranged in
descending order which maps 1 to 1 with other frequency parameter to
be calculated and programmed in some registers.
But the OPP library works by generating the frequencies in ascending
order which breaks the above logic. Ideally i should expect frequency
values in same order as what is supplied.
So OPP library should not change the order or should take input flags
flags like,
dev_pm_opp_init_cpufreq_table(TABLE_ORDER_ASCEND|
TABLE_ORDER_DESCEND|TABLE_ORDER_ORIGINAL )

Thanks,
Amit Daniel
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
