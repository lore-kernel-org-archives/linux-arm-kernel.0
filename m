From: spjoshi@codeaurora.org (Sarangdhar Joshi)
Date: Thu, 22 Dec 2016 16:07:54 -0800
Subject: [PATCH 1/2] soc: ti: Use remoteproc auto_boot feature
In-Reply-To: <20161222130246.GA8359@builder>
References: <1481846632-4778-1-git-send-email-spjoshi@codeaurora.org>
 <1f5b2631-f744-a5c1-55c1-82eb27d5cbd7@ti.com> <20161222130246.GA8359@builder>
Message-ID: <b7457597-d69c-4d2c-5229-0678d7c41f48@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/22/2016 5:02 AM, Bjorn Andersson wrote:
> On Wed 21 Dec 19:16 PST 2016, Suman Anna wrote:
>
>> Hi Sarang,
>>
>> On 12/15/2016 06:03 PM, Sarangdhar Joshi wrote:
>>> The function wkup_m3_rproc_boot_thread waits for asynchronous
>>> firmware loading to complete successfully before calling
>>> rproc_boot(). The same can be achieved by just setting
>>> rproc->auto_boot flag. Change this. As a result this change
>>> removes wkup_m3_rproc_boot_thread and moves m3_ipc->sync_complete
>>> initialization to the wkup_m3_ipc_probe().
>>>
>>> Other than the current usage, the firmware_loading_complete is
>>> only used in rproc_del() where it's no longer needed.  This
>>> change is in preparation for removing firmware_loading_complete
>>> completely.
>>
>> Based on the comments so far, I am assuming that you are dropping this
>> series.
>>
>
> Following up on those comments only revealed that we have several other
> similar race conditions, so I'm hoping that Sarangdhar will continue to
> work on fixing those - and in this process get rid of this completion.
>
>> In any case, this series did break our PM stack. We definitely don't
>> want to auto-boot the wkup_m3_rproc device, that responsibility will
>> need to stay with the wkup_m3_ipc driver.
>>
>
> Reviewing the wkup_m3 situation again I see that as we have moved the
> resource table parsing to the rproc_boot() path there's no longer any
> need for the wkup_m3_ipc driver to wait for the remoteproc-core-internal
> completion.
>
> If rproc_get_by_phandle() returns non-NULL it is initialized. We still
> don't want to call rproc_boot() from wkup_m3_ipc_probe(), so let's keep
> the wkup_m3_rproc_boot_thread().

Did you mean it's okay to call rproc_boot() from wkup_m3_ipc_probe()? 
rproc_boot() calls request_firmware() anyways and so there is no need to 
wait for completion of asynchronous firmware loading.

>
> Sarangdhar, could you update the wkup_m3_ipc patch to just drop the
> wait_for_completion() call?

Sure, assuming we should still keep the rproc_boot() call in the kthread.

Regards,
Sarang

>
> Regards,
> Bjorn
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-remoteproc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
