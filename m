From: nm@ti.com (Nishanth Menon)
Date: Fri, 7 Feb 2014 09:52:07 -0600
Subject: [PATCH v2 1/2] PM / OPP: Allow boost frequency to be looked up
 from device tree
In-Reply-To: <CAJuA9aiEDXyK8ABNznbzjk7s2uMfwo_diRpmLNsKBFd+pH=ffQ@mail.gmail.com>
References: <1391786342-11812-1-git-send-email-thomas.ab@samsung.com>	<1391786342-11812-2-git-send-email-thomas.ab@samsung.com>	<CAGo_u6qsh0wVLGjvqKmaXjDGVyy2tKgSzkh-t9RZCQS-JJND8g@mail.gmail.com>
 <CAJuA9aiEDXyK8ABNznbzjk7s2uMfwo_diRpmLNsKBFd+pH=ffQ@mail.gmail.com>
Message-ID: <52F50127.606@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/07/2014 09:38 AM, Thomas Abraham wrote:
[...]
>>> diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
>>> index fa41874..b636826 100644
>>> --- a/drivers/base/power/opp.c
>>> +++ b/drivers/base/power/opp.c
>>> @@ -628,7 +628,8 @@ int dev_pm_opp_init_cpufreq_table(struct device *dev,
>>>         struct device_opp *dev_opp;
>>>         struct dev_pm_opp *opp;
>>>         struct cpufreq_frequency_table *freq_table;
>>> -       int i = 0;
>>> +       int i = 0, j, len, ret;
>>> +       u32 *boost_freqs = NULL;
>>>
>>>         /* Pretend as if I am an updater */
>>>         mutex_lock(&dev_opp_list_lock);
>>> @@ -650,10 +651,35 @@ int dev_pm_opp_init_cpufreq_table(struct device *dev,
>>>                 return -ENOMEM;
>>>         }
>>>
>>> +       if (of_find_property(dev->of_node, "boost-frequency", &len)) {
>>> +               if (len == 0 || (len & (sizeof(u32) - 1)) != 0) {
>>> +                       dev_err(dev, "%s: invalid boost frequency\n", __func__);
>>> +                       ret = -EINVAL;
>>> +                       goto err_boost;
>>> +               }
>>> +
>>> +               boost_freqs = kzalloc(len, GFP_KERNEL);
>>> +               if (!boost_freqs) {
>>> +                       dev_warn(dev, "%s: no memory for boost freq table\n",
>>> +                                       __func__);
>>> +                       ret = -ENOMEM;
>>> +                       goto err_boost;
>>> +               }
>>> +               of_property_read_u32_array(dev->of_node, "boost-frequency",
>>> +                       boost_freqs, len / sizeof(u32));
>>> +       }
>>> +
>>>         list_for_each_entry(opp, &dev_opp->opp_list, node) {
>>>                 if (opp->available) {
>>>                         freq_table[i].driver_data = i;
>>>                         freq_table[i].frequency = opp->rate / 1000;
>>> +                       for (j = 0; j < len / sizeof(u32) && boost_freqs; j++) {
>>> +                               if (boost_freqs[j] == freq_table[i].frequency) {
>>> +                                       freq_table[i].driver_data =
>>> +                                                       CPUFREQ_BOOST_FREQ;
>>> +                                       break;
>>> +                               }
>>> +                       }
>>
>> What if any one of the boost_freqs are not contained in the enabled frequencies?
> 
> It is not used as a boost frequency because its corresponding voltage
> is not known. If required a warning can be printed out for the same.

yes - that would be good, as it helps debug if there are developer
errors in dts.


-- 
Regards,
Nishanth Menon
