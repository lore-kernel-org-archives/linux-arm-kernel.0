From: enric.balletbo@collabora.com (Enric Balletbo i Serra)
Date: Tue, 24 Apr 2018 10:01:03 +0200
Subject: [PATCH 6/6] devfreq: rk3399_dmc: register devfreq notification to
 dmc driver.
In-Reply-To: <20180424042233epcms1p7b27cb007b11ed467d773ce93d8bc7ed4@epcms1p7>
References: <20180419104019.24406-7-enric.balletbo@collabora.com>
 <20180419104019.24406-1-enric.balletbo@collabora.com>
 <CGME20180419104059epcas2p3fe5aba95859e02307556200a42bc1ac2@epcms1p7>
 <20180424042233epcms1p7b27cb007b11ed467d773ce93d8bc7ed4@epcms1p7>
Message-ID: <a213bb68-2a47-b7b9-d35f-cc5355f9c1be@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On 24/04/18 06:22, MyungJoo Ham wrote:
>> From: Lin Huang <hl@rock-chips.com>
>>
>> Because dmc may also access the PMU_BUS_IDLE_REQ register, we need to
>> ensure that the pd driver and the dmc driver will not access at this
>> register at the same time.
>>
>> Signed-off-by: Lin Huang <hl@rock-chips.com>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> ---
>>
>> drivers/devfreq/rk3399_dmc.c      | 47 +----------------------
>> drivers/soc/rockchip/pm_domains.c | 31 +++++++++++++++
>> include/soc/rockchip/rk3399_dmc.h | 63 +++++++++++++++++++++++++++++++
>> 3 files changed, 96 insertions(+), 45 deletions(-)
>> create mode 100644 include/soc/rockchip/rk3399_dmc.h
>>
>> diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
>> index 5bfca028eaaf..a1f320634d69 100644
>> --- a/drivers/devfreq/rk3399_dmc.c
>> +++ b/drivers/devfreq/rk3399_dmc.c
> []
>> diff --git a/drivers/soc/rockchip/pm_domains.c b/drivers/soc/rockchip/pm_domains.c
>> index 53efc386b1ad..7acc836e7eb7 100644
>> --- a/drivers/soc/rockchip/pm_domains.c
>> +++ b/drivers/soc/rockchip/pm_domains.c
> []
>> +static int dmc_notify(struct notifier_block *nb, unsigned long event,
>> +		      void *data)
>> +{
>> +	if (event == DEVFREQ_PRECHANGE)
>> +		mutex_lock(&dmc_pmu->mutex);
>> +	else if (event == DEVFREQ_POSTCHANGE)
>> +		mutex_unlock(&dmc_pmu->mutex);
>> +
>> +	return NOTIFY_OK;
>> +}
>> +
> 
> Doesn't this incur a deadlock?
> 
> 1. devfreq.c:update_freq calls devfreq_notify_transition(DEVFREQ_PRECHANGE)
> 2. pm_domain.c:dmc_notify calls mutex_lock(dmc_pmu->mutex)
> 3. devfreq.c:update_freq calls target callback
> 4. rk3399_dmc.c:rk3399_dmcfreq_target calls mutex_lock(&dmcfreq->lock)
>    >>>>>> update_freq cannot proceed. <<<<
> 

Mmm, makes sense, but I did not detect this deadlock.

As this patch is controversial let me remove this patch from these series and
I'll send again with the other series that applies on top of these, the series I
am working on are to add ddrfreq support in the drm rockchip driver. Thinking
about it I guess makes more sense as 1-5 are just cleanups, 6 is a bit
different, maybe more related to the work I am doing.

Best regards,
  Enric

> 
> Cheers,
> MyungJoo
> 
