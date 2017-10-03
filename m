From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 3 Oct 2017 11:57:14 +0100
Subject: [PATCH 3/5] firmware: arm_scpi: pre-populate dvfs info in
 scpi_probe
In-Reply-To: <db4476f4-df96-6ce5-ca5f-95141364fa62@gmail.com>
References: <c245d2fa-2aa0-fa40-21a7-318e8db3b763@gmail.com>
 <c8c0ff86-de14-f157-68e0-9df005defffa@gmail.com>
 <d6578a58-b7ab-9770-d78d-1971d1e702d4@arm.com>
 <db4476f4-df96-6ce5-ca5f-95141364fa62@gmail.com>
Message-ID: <0e5959a7-6826-1909-1509-f6627a9688ed@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/10/17 23:07, Heiner Kallweit wrote:
> Am 02.10.2017 um 13:17 schrieb Sudeep Holla:
>> 
>> 
>> On 29/09/17 22:44, Heiner Kallweit wrote:
>>> Pre-populating the dvfs info data in scpi_probe allows to make 
>>> all memory allocations device-managed. This helps to simplify 
>>> scpi_remove and eventually to get rid of scpi_remove completely.
>>> 
>>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

[...]

>> Does it make sense to continue to complete all MAX_DVFS_DOMAINS ? 
>> Just wondering if there will be any firmware that returns errors 
>> for few domains(e.g. not supported in initial versions of 
>> firmware). I don't want to stop probing due to that. Let me know 
>> what you think.
>> 
> The (legacy) SCPI firmware on my system seems to ignore the domain
> in CMD_GET_DVFS_INFO. It returns the same dvfs info independent of
> the domain parameter. So indeed prepopulating may not be the best
> idea.
> 

I can't follow that. Does the behavior change probe time vs runtime ?
I am fine with probe time populate, just that we can't stop or propagate
any error as it fails to probe other dependent drivers which may work
fine without DVFS(e.g. clocks, sensors and power domains)

> Still we need to do something in the remove callback to deal with the
> scenario you describe (error for few domains).

devm_* APIs will take care of freeing DVFS domain info, so what else
needs to be done ? I just noticed devm_kfree(NULL) can produce WARN_ON
splat, is that what you are referring ?

> 
> Remove does for (i = 0; i < MAX_DVFS_DOMAINS && info->dvfs[i]; i++) {
> and therefore stops at the first unpopulated domain and doesn't free
> the memory for further populated domains. I'll provide a patch for
> it.
> 

Does that mean you are re-introducing scpi_remove ? I kind of liked
removing it.

-- 
Regards,
Sudeep
