From: nleeder@codeaurora.org (Leeder, Neil)
Date: Wed, 6 Dec 2017 16:19:24 -0500
Subject: [PATCH] perf: qcom_l2_pmu: don't allow guest access
In-Reply-To: <20171206161149.ezlzzcuvxbot5tio@lakrids.cambridge.arm.com>
References: <1512575733-923-1-git-send-email-nleeder@codeaurora.org>
 <20171206161149.ezlzzcuvxbot5tio@lakrids.cambridge.arm.com>
Message-ID: <bc650fac-702c-e554-43ca-9cd3cfed9696@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/6/2017 11:11 AM, Mark Rutland wrote:
> On Wed, Dec 06, 2017 at 10:55:33AM -0500, Neil Leeder wrote:
>> Guests cannot access IMPDEF system registers, which are used
>> by this driver. Disable the driver if it's running in a guest VM.
>>
>> Signed-off-by: Neil Leeder <nleeder@codeaurora.org>
>> ---
>>  drivers/perf/qcom_l2_pmu.c | 4 ++++
>>  1 file changed, 4 insertions(+)
> 
> Hi Neil,
> 
> I'm a little confused by this. Why is this hypervisor providing a
> QCOM8130 device to the guest that it cannot use?
> 
> Could you elaborate on what's going on?
> 
Hi Mark,

While there's an argument that the guest shouldn't be loading the driver
in the first place, we can't control everyone's guest configuration or what
their hypervisor does.

>>
>> diff --git a/drivers/perf/qcom_l2_pmu.c b/drivers/perf/qcom_l2_pmu.c
>> index 4fdc848..49dc954 100644
>> --- a/drivers/perf/qcom_l2_pmu.c
>> +++ b/drivers/perf/qcom_l2_pmu.c
>> @@ -1057,6 +1057,10 @@ static int __init register_l2_cache_pmu_driver(void)
>>  {
>>  	int err;
>>  
>> +	/* Don't enable driver if running as guest */
>> +	if (!is_hyp_mode_available())
>> +		return 0;
>> +
>>  	err = cpuhp_setup_state_multi(CPUHP_AP_PERF_ARM_QCOM_L2_ONLINE,
>>  				      "AP_PERF_ARM_QCOM_L2_ONLINE",
>>  				      l2cache_pmu_online_cpu,
>> -- 
>> Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies Inc.
>> Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
>> a Linux Foundation Collaborative Project.
>>

Neil
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
