From: spjoshi@codeaurora.org (Sarangdhar Joshi)
Date: Tue, 3 Jan 2017 15:52:14 -0800
Subject: [PATCH 1/2] soc: ti: Use remoteproc auto_boot feature
In-Reply-To: <6a5a9c8a-cca7-0740-4879-dd6c01e60548@ti.com>
References: <1481846632-4778-1-git-send-email-spjoshi@codeaurora.org>
 <1f5b2631-f744-a5c1-55c1-82eb27d5cbd7@ti.com>
 <9092e066-b2ad-ee42-de5f-d66b84a10cfd@codeaurora.org>
 <1f847af8-6bde-4645-aea4-7e9b02306e39@ti.com>
 <6a5a9c8a-cca7-0740-4879-dd6c01e60548@ti.com>
Message-ID: <1003ab4a-b481-4f60-097a-2ce607fa2961@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/23/2016 03:57 PM, Suman Anna wrote:
> On 12/23/2016 11:05 AM, Suman Anna wrote:
>> Hi Sarang,
>>
>>>>
>>>> On 12/15/2016 06:03 PM, Sarangdhar Joshi wrote:
>>>>> The function wkup_m3_rproc_boot_thread waits for asynchronous
>>>>> firmware loading to complete successfully before calling
>>>>> rproc_boot(). The same can be achieved by just setting
>>>>> rproc->auto_boot flag. Change this. As a result this change
>>>>> removes wkup_m3_rproc_boot_thread and moves m3_ipc->sync_complete
>>>>> initialization to the wkup_m3_ipc_probe().
>>>>>
>>>>> Other than the current usage, the firmware_loading_complete is
>>>>> only used in rproc_del() where it's no longer needed.  This
>>>>> change is in preparation for removing firmware_loading_complete
>>>>> completely.
>>>>
>>>> Based on the comments so far, I am assuming that you are dropping this
>>>> series.
>>>
>>> No, may not be dropping this. Will try to handle it differently in
>>> rproc_del() (probably by making use of some state flag).
>>>>
>>>> In any case, this series did break our PM stack. We definitely don't
>>>> want to auto-boot the wkup_m3_rproc device, that responsibility will
>>>> need to stay with the wkup_m3_ipc driver.
>>>
>>> Which scenario did it break? Booting up rproc device before
>>> wkup_m3_ipc_probe() causes issues?
>>
>> Yes, our state machine requires the wkup_m3_ipc driver to control the
>> boot of the wkup_m3 remoteproc. The wkup_m3 is not a typical remoteproc,
>> it is our PM master and is responsible for putting the host processor
>> into suspend and waking it up in system suspend/cpuidle paths.
>> The remoteproc infrastructure is only used for load/boot, but the Linux
>> PM state machine and communication is all controlled by the wkup_m3_ipc
>> driver.

Thanks for explaining. I was missing the fact that the resource table 
parsing during asynchronous call and the one in rproc_boot() are 
different.

>>
>>>
>>> Nevertheless, I think Bjorn's suggestion of just dropping the call to
>>> wait_for_completion() and keeping kthread looks good, also because of
>>> the fact that rproc_boot() anyways calls request_firmware() and no
>>> longer needed to wait on asynchronous loading of firmware.
>>
>> Yeah, I will have to test this, but looking at current code, this should
>> mostly be ok because of the remoteproc core changes w.r.t resource table
>> parsing.
>
> Tested with just the wait_for_completion() removed and it works fine. I
> can send a patch for the same if you prefer me to send it.

Thanks for testing it. I have sent the patch.

Regards,
Sarang

>
> regards
> Suman
>
>>
>> regards
>> Suman
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-remoteproc" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-remoteproc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
