From: nm@ti.com (Nishanth Menon)
Date: Sat, 8 Feb 2014 10:31:50 -0600
Subject: [PATCH v3 1/7] cpufreq: cpufreq-cpu0: allow use of optional boost
 mode frequencies
In-Reply-To: <CAJuA9ah9xHZZknW5yfh8v8GS65TLd4uZedigEt4ATdoiy6-1Gg@mail.gmail.com>
References: <1391788548-13056-1-git-send-email-thomas.ab@samsung.com>
 <1391788548-13056-2-git-send-email-thomas.ab@samsung.com>
 <52F506EC.2070907@ti.com>
 <CAJuA9ah9xHZZknW5yfh8v8GS65TLd4uZedigEt4ATdoiy6-1Gg@mail.gmail.com>
Message-ID: <CAGo_u6qdc=dRgRFNq4f4tSC7+3J5dnZfa63wR5C+HRy-z5LBbw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 7, 2014 at 11:19 PM, Thomas Abraham <ta.omasab@gmail.com> wrote:
>>> --- a/drivers/cpufreq/cpufreq-cpu0.c
>>> +++ b/drivers/cpufreq/cpufreq-cpu0.c
>>> @@ -195,6 +195,9 @@ static int cpu0_cpufreq_probe(struct platform_device *pdev)
>>>                       transition_latency += ret * 1000;
>>>       }
>>>
>>> +     if (of_find_property(cpu_dev->of_node, "boost-frequency", NULL))
>>> +             cpu0_cpufreq_driver.boost_supported = true;
>>> +
>> might as well hide that under the opp api which returns a bool that
>> says if boost is supported or not. that allows the parse to be
>> isolated to a single location.
>
> This is specific to the cpufreq-cpu0 driver. Other cpufreq drivers
> might want to use other methods and additional constraints to
> determine if boost has to be enabled.

struct cpufreq_driver::boost_supported is nothing CPU0 specifc - i am
just saying that the same property "boost-frequency" parsed by in two
places (dev_pm_opp_init_cpufreq_table and cpu0_cpufreq_probe) is a
very bad idea.

you could instead make
int dev_pm_opp_init_cpufreq_table(struct device *dev,
                           struct cpufreq_frequency_table **table)
into:
int dev_pm_opp_init_cpufreq_table(struct device *dev,
                           struct cpufreq_frequency_table **table,
bool *boost_supported);

Then use boost_supported for anything of your driver's choice
(including updating cpufreq_driver::boost_supported).

That allows the property to be isolated into a single function, who
can be modified without impacting other drivers at a later point in
time.

Regards,
Nishanth Menon
