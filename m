From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 04 Aug 2016 09:33:32 +0900
Subject: [PATCH v4 6/7] PM / devfreq: rockchip: add devfreq driver for
 rk3399 dmc
In-Reply-To: <57A19F60.7090700@rock-chips.com>
References: <1469779021-10426-1-git-send-email-hl@rock-chips.com>
 <CGME20160729075807epcas1p2432f667d41dadcaae7b813e151f2ab0b@epcas1p2.samsung.com>
 <1469779021-10426-7-git-send-email-hl@rock-chips.com>
 <579F2445.1020200@samsung.com> <579FF164.2000907@rock-chips.com>
 <57A01FD2.2060806@samsung.com> <57A19F60.7090700@rock-chips.com>
Message-ID: <57A28D5C.40507@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lin,

On 2016? 08? 03? 16:38, hl wrote:
> 
> Hi Chanwoo Choi,
> On 2016?08?02? 12:21, Chanwoo Choi wrote:
>> Hi Lin,
>>
>> On the next version, I'd like you to add the 'linux-pm at vger.kernel.org'
>> because devfreq is a subsystem of power management.
> Sure, will do it next version.
>> On 2016? 08? 02? 10:03, hl wrote:
>>> Hi Chanwoo Choi,
>>>
>>>      Thanks for reviewing so carefully. And i have some question:
>>>
>>> On 2016?08?01? 18:28, Chanwoo Choi wrote:
>>>> Hi Lin,
>>>>
>>>> As I mentioned on patch5, you better to make the documentation as following:
>>>> - Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
>>>> And, I add the comments.
>>>>
>>>>
>>>> On 2016? 07? 29? 16:57, Lin Huang wrote:
>>>>> base on dfi result, we do ddr frequency scaling, register
>>>>> dmc driver to devfreq framework, and use simple-ondemand
>>>>> policy.
>>>>>
>>>>> Signed-off-by: Lin Huang <hl@rock-chips.com>
>>>>> ---
>>>>> Changes in v4:
>>>>> - use arm_smccc_smc() function talk to bl31
>>>>> - delete rockchip_dmc.c file and config
>>>>> - delete dmc_notify
>>>>> - adjust probe order
>>>>>    Changes in v3:
>>>>> - operate dram setting through sip call
>>>>> - imporve set rate flow
>>>>>
>>>>> Changes in v2:
>>>>> - None
>>>>>    Changes in v1:
>>>>> - move dfi controller to event
>>>>> - fix set voltage sequence when set rate fail
>>>>> - change Kconfig type from tristate to bool
>>>>> - move unuse EXPORT_SYMBOL_GPL()
>>>>>
>>>>>    drivers/devfreq/Kconfig               |   1 +
>>>>>    drivers/devfreq/Makefile              |   1 +
>>>>>    drivers/devfreq/rockchip/Kconfig      |   8 +
>>>>>    drivers/devfreq/rockchip/Makefile     |   1 +
>>>>>    drivers/devfreq/rockchip/rk3399_dmc.c | 473 ++++++++++++++++++++++++++++++++++
>>>>>    5 files changed, 484 insertions(+)
>>>>>    create mode 100644 drivers/devfreq/rockchip/Kconfig
>>>>>    create mode 100644 drivers/devfreq/rockchip/Makefile
>>>>>    create mode 100644 drivers/devfreq/rockchip/rk3399_dmc.c
>>>>>
>> [snip]
>>
>>>>> +
>>>>> +static int rk3399_dmcfreq_target(struct device *dev, unsigned long *freq,
>>>>> +                 u32 flags)
>>>>> +{
>>>>> +    struct platform_device *pdev = container_of(dev, struct platform_device,
>>>>> +                            dev);
>>>>> +    struct rk3399_dmcfreq *dmcfreq = platform_get_drvdata(pdev);
>>>> You can use the 'dev_get_drvdata()' to simplify it instead of 'platform_get_drvdata()'.
>>>>
>>>>      struct rk3399_dmcfreq *dmcfreq = dev_get_drvdata(dev);
>>>>
>>>>> +    struct dev_pm_opp *opp;
>>>>> +    unsigned long old_clk_rate = dmcfreq->rate;
>>>>> +    unsigned long target_volt, target_rate;
>>>>> +    int err;
>>>>> +
>>>>> +    rcu_read_lock();
>>>>> +    opp = devfreq_recommended_opp(dev, freq, flags);
>>>>> +    if (IS_ERR(opp)) {
>>>>> +        rcu_read_unlock();
>>>>> +        return PTR_ERR(opp);
>>>>> +    }
>>>>> +
>>>>> +    target_rate = dev_pm_opp_get_freq(opp);
>>>>> +    target_volt = dev_pm_opp_get_voltage(opp);
>>>>> +    opp = devfreq_recommended_opp(dev, &dmcfreq->rate, flags);
>>>>> +    if (IS_ERR(opp)) {
>>>>> +        rcu_read_unlock();
>>>>> +        return PTR_ERR(opp);
>>>>> +    }
>>>>> +    dmcfreq->volt = dev_pm_opp_get_voltage(opp);
>>>> If you add the 'curr_opp' variable to struct rk3399_dmcfreq,
>>>> you can remove the calling of devfreq_recommended_opp().
>>>>      dmcfreq->rate = dev_pm_opp_get_freq(dmcfreq->curr_opp);
>>>>      dmcfreq->volt = dev_pm_opp_get_freq(dmcfreq->curr_opp);
>>>>
>>>> Because the current rate and voltage is already decided on previous polling cycle,
>>>> So we don't need to get the opp with devfreq_recommended_opp().
>>> I prefer the way now use, since we get the dmcfreq->rate use clk_get_rate() after,
>>> Base on that,  i do not care the set_rate success or fail. use curr_opp i need to
>>> care about set_rate status, when fail, i must set some rate, when success i must
>>> set other rate.
>> I think that it is not good to get the alrady decided opp
>> by devfreq_recommended_opp(). Usually, devfreq_recommended_opp() is used
>> to get the proper opp which get the close frequency (dmcfreq->rate).
>>
>> Also, When finishing the rk3399_dmcfreq_target(), the rk3399_dmc.c
>> have to know the current opp or rate without any finding sequence.
>> The additional finding procedure is un-needed.
>>
>>>>> +    rcu_read_unlock();
>>>>> +
>>>>> +    if (dmcfreq->rate == target_rate)
>>>>> +        return 0;
>>>>> +
>>>>> +    mutex_lock(&dmcfreq->lock);
>>>>> +
>>>>> +    /*
>>>>> +     * if frequency scaling from low to high, adjust voltage first;
>>>>> +     * if frequency scaling from high to low, adjuset frequency first;
>>>>> +     */
>>>> s/adjuset/adjust
>>>>
>>>> I recommend that you use a captital letter for first character and use the '.'
>>>> instead of ';'.
>>>>
>>>>> +    if (old_clk_rate < target_rate) {
>>>>> +        err = regulator_set_voltage(dmcfreq->vdd_center, target_volt,
>>>>> +                        target_volt);
>>>>> +        if (err) {
>>>>> +            dev_err(dev, "Unable to set vol %lu\n", target_volt);
>>>> To readability, you better to use the corrent word to pass the precise the log message.
>>>> - s/vol/voltage
>>>>
>>>> And, this patch uses the 'Unable to' or 'Cannot' to show the error log.
>>>> I recommend that you use the consistent expression if there is not any specific reason.
>>>>
>>>>      dev_err(dev, "Cannot set the voltage %lu uV\n", target_volt);
>>>>
>>>>> +            goto out;
>>>>> +        }
>>>>> +    }
>>>>> +    dmcfreq->wait_dcf_flag = 1;
>>>>> +    err = clk_set_rate(dmcfreq->dmc_clk, target_rate);
>>>>> +    if (err) {
>>>>> +        dev_err(dev,
>>>>> +            "Unable to set freq %lu. Current freq %lu. Error %d\n",
>>>>> +            target_rate, old_clk_rate, err);
>>>>      dev_err(dev, "Cannot set the frequency %lu (%d)\n", target_rate, err);
>>>>
>>>>> +        regulator_set_voltage(dmcfreq->vdd_center, dmcfreq->volt,
>>>>> +                      dmcfreq->volt);
>>>>> +        goto out;
>>>>> +    }
>>>>> +
>>>>> +    /*
>>>>> +     * wait until bcf irq happen, it means freq scaling finish in bl31,
>>>> ditto.
>>>>
>>>>> +     * use 100ms as timeout time
>>>> s/time/time.
>>>>
>>>>> +     */
>>>>> +    if (!wait_event_timeout(dmcfreq->wait_dcf_queue,
>>>>> +                !dmcfreq->wait_dcf_flag, HZ / 10))
>>>>> +        dev_warn(dev, "Timeout waiting for dcf irq\n");
>>>> If the timeout happen, are there any problem?
>>> When timeout happen , may be we miss interrupt, but it do not affect this
>>> process, since we will check the rate whether success later.
>> OK. But I'd like you to modify the warning message.
>>
>> One more thing, is the dcf interrupt related to the change of clock rate?
>> When the clock rate is changed, the dcf interrupt happen?
> Yes, when clock rate changed sucessful, it will trigger a irq in bl31.

OK.

>>
>>>> After setting the frequency and voltage, store the current opp entry on .curr_opp.
>>>>      dmcfreq->curr_opp = opp;
>>>>
>>>>> +    /*
>>>>> +     * check the dpll rate
>>>>> +     * there only two result we will get,
>>>>> +     * 1. ddr frequency scaling fail, we still get the old rate
>>>>> +     * 2, ddr frequency scaling sucessful, we get the rate we set
>>>>> +     */
>>>>> +    dmcfreq->rate = clk_get_rate(dmcfreq->dmc_clk);
>>>>> +
>>>>> +    /* if get the incorrect rate, set voltage to old value */
>>>>> +    if (dmcfreq->rate != target_rate) {
>>>>> +        dev_err(dev, "get wrong ddr frequency, Request freq %lu,\
>>>>> +            Current freq %lu\n", target_rate, dmcfreq->rate);
>>>>> +        regulator_set_voltage(dmcfreq->vdd_center, dmcfreq->volt,
>>>>> +                      dmcfreq->volt);
>>>> [Without force, it is just my opion about this code:]
>>>> I think that this checking code it is un-needed.
>>>> If this case occur, the rk3399_dmc.c never set the specific frequency
>>>> because the rk3399 clock don't support the specific frequency for rk3399 dmc.
>>>>
>>>> If you want to set the correct frequency,
>>>> When verifying the rk3399 dmc driver, you should check the rk3399 clock driver.
>>>>
>>>> Basically, if the the clock driver don't support the correct same frequency ,
>>>> CCF(Common Clock Framework) set the close frequency. It is not a bad thing.
>>> May be i should remove the regulator_set_voltage() here, but still need to
>>> check whether we get the right frequency, since if we do not get the right frequency,
>> When calling clk_set_rate(), the final frequency only depend on the rk3399 clock driver.
>> But, if you want to check the new rate, I think that you should move this code
>> right after clk_set_rate() when there is any dependency of dcf interrupt.
> it should be after the wait_event, since it indicate the clk_set_rate finish,

OK.

>>
>>> we should send a warn message, to remind that maybe you pass a frequency which
>>> do not support in bl31.
>> Also, I'd like you to explain the 'bl31' and add the description on next version.
>>
>> [snip]
>>
>> Regards,
>> Chanwoo Choi

Regards,
Chanwoo Choi
