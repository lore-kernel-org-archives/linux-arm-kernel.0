From: jinkun.hong@rock-chips.com (Hong jinkun)
Date: Wed, 29 Oct 2014 09:00:09 +0800
Subject: [PATCH v7 1/3] power-domain: add power domain drivers for Rockchip
 platform
In-Reply-To: <20141027233904.GD7594@dtor-ws>
References: <1414135761-3406-1-git-send-email-jinkun.hong@rock-chips.com>
 <1414135761-3406-2-git-send-email-jinkun.hong@rock-chips.com>
 <20141024164431.GE19933@dtor-ws> <20141027233904.GD7594@dtor-ws>
Message-ID: <54503C19.9060607@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


? 2014/10/28 7:39, Dmitry Torokhov ??:
> On Fri, Oct 24, 2014 at 09:44:31AM -0700, Dmitry Torokhov wrote:
>> Hi Jinkun,
>>
>> On Fri, Oct 24, 2014 at 12:29:19AM -0700, jinkun.hong wrote:
>>> +static int rockchip_pd_power(struct rockchip_domain *pd, bool power_on)
>>> +{
>>> +	int ret = 0;
>>> +	struct rockchip_dev_entry *de;
>>> +
>>> +	mutex_lock(&pd->dev_lock);
>>> +	/* no clk, set power domain will fail */
>>> +	if (list_empty(&pd->dev_list)) {
>>> +		pr_err("%s: no devices in %s power domain\n", __func__,
>>> +			pd->base.name);
>>> +		goto out;
>>> +	}
>>> +
>>> +	list_for_each_entry(de, &pd->dev_list, node) {
>>> +		pm_clk_resume(de->dev);
>>> +	}
>>> +
>>> +	ret = rockchip_pmu_set_power_domain(pd, power_on);
>>> +
>>> +	list_for_each_entry(de, &pd->dev_list, node) {
>>> +		pm_clk_suspend(de->dev);
>>> +	}
>>> +out:
>>> +	mutex_unlock(&pd->dev_lock);
>>> +	return ret;
>>> +}
>> For my education, could you please tell me why we need to enable all
>> clocks of all devices in a power domain when we are talking to the PMU
>> and then turn them immediately off?
Sorry for late reply.RK3288 reset circuit are first asynchronous reset 
and then sync revoked.
All reset revocation actions are needed to synchronize the clocks.
If there is no clock open, power_up reset will cause the corresponding 
reset can not be undone, there will be risks.
>> Would not we want to enable clocks
>> in start()) callbacks, like Ulf mentioned?
Can you tell me which one patch it. Thank you!
> Jinkun, any update on this question?
>
> Thanks.
>
