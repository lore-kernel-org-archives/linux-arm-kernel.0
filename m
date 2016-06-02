From: hl@rock-chips.com (hl)
Date: Thu, 2 Jun 2016 09:54:32 +0800
Subject: [RFC PATCH 3/4] PM / devfreq: rockchip: add devfreq driver for
 rk3399 dmc
In-Reply-To: <CAJ0PZbQaPm1YjgAgEzGbPYSzfi7kk5NG=zAj80t4XmBV5MqEqg@mail.gmail.com>
References: <1464773739-18152-1-git-send-email-hl@rock-chips.com>
 <1464773739-18152-4-git-send-email-hl@rock-chips.com>
 <CAJ0PZbQaPm1YjgAgEzGbPYSzfi7kk5NG=zAj80t4XmBV5MqEqg@mail.gmail.com>
Message-ID: <574F91D8.70606@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Myungloo Ham,


On 2016?06?01? 18:47, MyungJoo Ham wrote:
> On Wed, Jun 1, 2016 at 6:35 PM, Lin Huang <hl@rock-chips.com> wrote:
>> there is dfi controller on rk3399 platform, it can monitor
>> ddr load, register this controller to devfreq framework, and
>> default to use simple_ondeamnd policy, and do ddr frequency
>> scaling base on this result.
>>
>> Signed-off-by: Lin Huang <hl@rock-chips.com>
>> ---
>>   drivers/devfreq/Kconfig                 |   2 +-
>>   drivers/devfreq/Makefile                |   1 +
>>   drivers/devfreq/rockchip/Kconfig        |  14 +
>>   drivers/devfreq/rockchip/Makefile       |   2 +
>>   drivers/devfreq/rockchip/rk3399_dmc.c   | 438 ++++++++++++++++++++++++++++++++
>>   drivers/devfreq/rockchip/rockchip_dmc.c | 132 ++++++++++
>>   include/soc/rockchip/rockchip_dmc.h     |  44 ++++
>>   7 files changed, 632 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/devfreq/rockchip/Kconfig
>>   create mode 100644 drivers/devfreq/rockchip/Makefile
>>   create mode 100644 drivers/devfreq/rockchip/rk3399_dmc.c
>>   create mode 100644 drivers/devfreq/rockchip/rockchip_dmc.c
>>   create mode 100644 include/soc/rockchip/rockchip_dmc.h
>>
>> +
>> +       /* check the rate we get whether correct */
>> +       dmcfreq->rate = clk_get_rate(dmcfreq->dmc_clk);
>> +       if (dmcfreq->rate != target_rate) {
>> +               dev_err(dev, "get wrong ddr frequency, Request freq %lu,\
>> +                       Current freq %lu\n", target_rate, dmcfreq->rate);
>> +               regulator_set_voltage(dmcfreq->vdd_center, dmcfreq->volt,
>> +                                     dmcfreq->volt);
> Why do you need to check this and
> more importantly, why do you assume that dmvfreq->volt
> will be safe in this case? (what if the new dmcfreq->rate is
> larger than the old dmcfreq->rate after clk_get_rate?)
> Note that you didn't update dmcfreq->volt after clk_get_rate()
     Now we will set the ddr clock rate in bl31 use dcf controller(as i 
show in the patch cover letter),
      and there only two result we can get, set clock rate fail(ddr 
clock still in old rate) or set clock rate
     sucessful(use the new ddr rate), if the set rate fail, we should 
keep the voltage old value. Ah, you
     remind me, i should check clock rate before:
         if (old_clk_rate > target_rate)
     otherwise there have chance set high rate fail and use low voltage.

     And about the dmcfreq->volt, i will update this value when into the 
function, throuth

     opp = devfreq_recommended_opp(dev, &dmcfreq->rate, flags);
     if (IS_ERR(opp)) {
         rcu_read_unlock();
         return PTR_ERR(opp);
     }
     dmcfreq->volt = dev_pm_opp_get_voltage(opp);
>
>> +EXPORT_SYMBOL_GPL(dmc_event);
>> +EXPORT_SYMBOL_GPL(rockchip_dmc_enabled);
>> +EXPORT_SYMBOL_GPL(rockchip_dmc_enable);
>> +EXPORT_SYMBOL_GPL(rockchip_dmc_disable);
>> +EXPORT_SYMBOL_GPL(dmc_register_notifier);
>> +EXPORT_SYMBOL_GPL(dmc_unregister_notifier);
>> +EXPORT_SYMBOL_GPL(rockchip_dmc_get);
>> +EXPORT_SYMBOL_GPL(rockchip_dmc_put);
> Do you really need to export all these device driver specific
> functions? Looks like a design flaw here.
>
     there is some situation we need to disable ddr frequency 
scaling(connect two panel etc)
     on rk3399 platform, and it should be also needed on other rockchip 
platform, so i move these
     funticon as separate file.
>
> Cheers,
> MyungJoo
>
>

-- 
Lin Huang
