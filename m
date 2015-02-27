From: galak@codeaurora.org (Kumar Gala)
Date: Fri, 27 Feb 2015 16:01:50 -0600
Subject: [PATCH v2] qcom: scm: Add qcom_scm_set_warm_boot_addr function
In-Reply-To: <20150227215125.GF1678@linaro.org>
References: <1425070047-53449-1-git-send-email-lina.iyer@linaro.org>
 <EB14AE95-372C-4908-AD4B-D354A01197B7@codeaurora.org>
 <20150227215125.GF1678@linaro.org>
Message-ID: <BAA7F8B7-B616-46B1-9753-18A8A1637BF6@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Feb 27, 2015, at 3:51 PM, Lina Iyer <lina.iyer@linaro.org> wrote:

> On Fri, Feb 27 2015 at 14:33 -0700, Kumar Gala wrote:
>> 
>> On Feb 27, 2015, at 2:47 PM, Lina Iyer <lina.iyer@linaro.org> wrote:
>> 
>>> A core can be powered down for cpuidle or when it is hotplugged off. In
>>> either case, the warmboot return address would be different. Allow
>>> setting the warmboot address for a specific cpu, optimize and write to
>>> the firmware, if the address is different than the previously set
>>> address.
>>> 
>>> Export qcom_scm_set_warm_boot_addr function move the warm boot flags to
>>> implementation.
>>> 
>>> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
>>> ---
>>> drivers/firmware/qcom_scm.c | 36 ++++++++++++++++++++++++++++++++++++
>>> include/linux/qcom_scm.h    |  5 +----
>>> 2 files changed, 37 insertions(+), 4 deletions(-)
>>> 
>>> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
>>> index 6e7a72b..19133ca 100644
>>> --- a/drivers/firmware/qcom_scm.c
>>> +++ b/drivers/firmware/qcom_scm.c
>>> @@ -34,6 +34,23 @@
>>> #define QCOM_SCM_ERROR		-1
>>> #define QCOM_SCM_INTERRUPTED	1
>>> 
>>> +#define QCOM_SCM_FLAG_WARMBOOT_CPU0	0x04
>>> +#define QCOM_SCM_FLAG_WARMBOOT_CPU1	0x02
>>> +#define QCOM_SCM_FLAG_WARMBOOT_CPU2	0x10
>>> +#define QCOM_SCM_FLAG_WARMBOOT_CPU3	0x40
>>> +
>>> +struct scm_warmboot {
>>> +	int flag;
>>> +	void *entry;
>>> +};
>>> +
>>> +static struct scm_warmboot scm_flags[] = {
>>> +	{ .flag = QCOM_SCM_FLAG_WARMBOOT_CPU0 },
>>> +	{ .flag = QCOM_SCM_FLAG_WARMBOOT_CPU1 },
>>> +	{ .flag = QCOM_SCM_FLAG_WARMBOOT_CPU2 },
>>> +	{ .flag = QCOM_SCM_FLAG_WARMBOOT_CPU3 },
>>> +};
>>> +
>>> static DEFINE_MUTEX(qcom_scm_lock);
>>> 
>>> /**
>>> @@ -342,3 +359,22 @@ int qcom_scm_set_boot_addr(u32 addr, int flags)
>>> 			&cmd, sizeof(cmd), NULL, 0);
>>> }
>>> EXPORT_SYMBOL(qcom_scm_set_boot_addr);
>>> +
>> 
>> Since you are adding a new interface, can you add Kdoc style comment header.  I need to do this for the other interfaces as well.
> 
> OK.
> 
>> 
>>> +int qcom_scm_set_warm_boot_addr(void *entry, int cpu)
>> 
>> I?d really like to see if we could make the set_boot_addr and set_warm_boot_addr have the same interfaces.
> 
> I am working on making the interfaces similar. There is some check in
> the platsmp.c that uses the cold boot flag array to determine the
> present cpus. Do you think, we can ignore that check over there? If that
> can be done, I will change the interface for cold boot too.

I don?t see any reason we can?t add qcom_scm_set_cold_boot_addr() move the flags such that they only exist in qcom_scm_set_boot_addr and make qcom_scm_set_boot_addr static.

- k

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
