From: stefan@agner.ch (Stefan Agner)
Date: Sat, 02 Jul 2016 16:12:07 -0700
Subject: [PATCH RFC 0/7] support clk setting during kernel early boot
In-Reply-To: <20160702011216.GR27880@codeaurora.org>
References: <1467208335-29876-1-git-send-email-aisheng.dong@nxp.com>
 <20160702011216.GR27880@codeaurora.org>
Message-ID: <bab9b9bacc16a42cf9ca93973ea5de68@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016-07-01 18:12, Stephen Boyd wrote:
> On 06/29, Dong Aisheng wrote:
>> Recently several people met the kernel complaining
>> "bad: scheduling from the idle thread!" issue which caused by
>> sleeping during kernel early booting phase by calling clk
>> APIs like clk_prepare_enable.
>>
>> See:
>> https://lkml.org/lkml/fancy/2016/1/29/695
>> https://lkml.org/lkml/2016/6/10/779
>> http://www.spinics.net/lists/linux-clk/msg08635.html
> 
> That last one was another bug that happened to trigger this
> problem mistakenly. I doubt critical clks are an issue (more
> below).
> 
>>
>> The calling sequence simply could be like:
>> start_kernel
>>   ->time_init
>>     ->of_clk_init
>>       ->clk_core_prepare
>>         ->clk_pllv3_prepare
>>           ->usleep_range
>>             ->dequeue_task_idle
>>
>> This issue is mainly caused during time_init, the irq is still
>> not enabled and scheduler is still not ready, thus there's no way
>> to allow sleep at that time.
>>
>> However, there're many exist platforms calling clk_prepare_enable/
>> clk_get_rate/clk_set_parent at that time in CLK_OF_DECLARE init
>> function.
>> e.g
>> drivers/clk/imx/clk-{soc}.c
>> drivers/clk/rockchip/clk-rk3188.c
>> drivers/clk/ti/clk-44xx.c
>> ...
>>
>> And irqchip and clock source is also initialized before it which
>> may requires to do clk settings.
>>
>> Furthermore, current clk framework also supports critical clocks
>> flagged by CLK_IS_CRITICAL which will be prepared and
>> enabled during clk_register by clk core, that is also happened
>> quite early in of_clk_init usually.
>>
>> And clk framework also supports assign default clk rate and parent for
>> each registered clk provider which also happens early in of_clk_init.
>> (see of_clk_set_defaults())
>>
>> Above are all possible cases which may cause sleeping during kernel
>> early booting.
> 
> How many of these cases are really happening and causing problems
> though?
> 
>>
>> So it seems we'd like to have the requirement to make kernel support
>> calling clk APIs during kernel early boot without sleep.
> 
> I wonder if the problem is more that the framework doesn't know
> the hardware state of on/off when it initializes? So we call the
> clk_ops prepare/enable functions when we really shouldn't be
> doing that at all because the clk is already prepared/enabled.
> Presumably for critical clks, we shouldn't go and touch any
> hardware to turn them on, because by definition they're critical
> and should already be on anyway.

I found that remark interesting, and agree here with Stephen, critical
clks should be already on and everything else should be controlled from
drivers.

With that in mind I went on and looked again what is currently (after
the parents enable patchset) still wrong on i.MX 7. Turned out to be not
that much, and I think it should be fixable with that:
https://lkml.org/lkml/2016/7/2/138

--
Stefan
