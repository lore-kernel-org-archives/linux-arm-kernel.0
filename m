From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 21 Jun 2016 11:43:32 -0600
Subject: [PATCH] coresight: always use stashed trace id value in
 etm4_trace_id
In-Reply-To: <57697A36.3010105@arm.com>
References: <1466432741-24452-1-git-send-email-sudeep.holla@arm.com>
 <CANLsYkxE3qf0n8N_RvA7a=hX7eWeF+ZjqQZ33Rc7Sh_AsJrnSA@mail.gmail.com>
 <57697A36.3010105@arm.com>
Message-ID: <CANLsYkzDny7dwQrzYJ-0m6YpADdz7e2uM+RU0JEbVY+kfDxwjQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 June 2016 at 11:32, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
>
> On 21/06/16 18:05, Mathieu Poirier wrote:
>>
>> On 20 June 2016 at 08:25, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>>
>>> etm4_trace_id is not guaranteed to be executed on the CPU whose ETM is
>>> being accessed. This leads to exception similar to below one if the
>>> CPU whose ETM is being accessed is in deeper idle states. So it must
>>> be executed on the CPU whose ETM is being accessed.
>>>
>>> Unhandled fault: synchronous external abort (0x96000210) at
>>> 0xffff000008db4040
>>> Internal error: : 96000210 [#1] PREEMPT SMP
>>> Modules linked in:
>>> CPU: 5 PID: 5979 Comm: etm.sh Not tainted 4.7.0-rc3 #159
>>> Hardware name: ARM Juno development board (r2) (DT)
>>> task: ffff80096dd34b00 ti: ffff80096dfe4000 task.ti: ffff80096dfe4000
>>> PC is at etm4_trace_id+0x5c/0x90
>>> LR is at etm4_trace_id+0x3c/0x90
>>> Call trace:
>>>   etm4_trace_id+0x5c/0x90
>>>   coresight_id_match+0x78/0xa8
>>>   bus_for_each_dev+0x60/0xa0
>>>   coresight_enable+0xc0/0x1b8
>>>   enable_source_store+0x3c/0x70
>>>   dev_attr_store+0x18/0x28
>>>   sysfs_kf_write+0x48/0x58
>>>   kernfs_fop_write+0x14c/0x1e0
>>>   __vfs_write+0x1c/0x100
>>>   vfs_write+0xa0/0x1b8
>>>   SyS_write+0x44/0xa0
>>>   el0_svc_naked+0x24/0x28
>>>
>>> However, TRCTRACEIDR is not guaranteed to hold the previous programmed
>>> trace id if it enters deeper idle states. Further, the trace id that is
>>> computed in etm4_init_trace_id is programmed into TRCTRACEIDR only in
>>> etm4_enable_hw which happens much later in the sequence after
>>> coresight_id_match is executed from enable_source_store.
>>>
>>> This patch simplifies etm4_trace_id by returning the stashed trace id
>>> value similar to etm4_cpu_id.
>>>
>>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>>> ---
>>>   drivers/hwtracing/coresight/coresight-etm4x.c | 16 +---------------
>>>   1 file changed, 1 insertion(+), 15 deletions(-)
>>>
>>> Hi Mathieu,
>>>
>>> While trying to support ETM with CPUIdle active, I faced this issue.
>>>
>>> Regards,
>>> Sudeep
>>>
>>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c
>>> b/drivers/hwtracing/coresight/coresight-etm4x.c
>>> index 43fa3beaa0df..d6f1d6d874eb 100644
>>> --- a/drivers/hwtracing/coresight/coresight-etm4x.c
>>> +++ b/drivers/hwtracing/coresight/coresight-etm4x.c
>>> @@ -77,22 +77,8 @@ static int etm4_cpu_id(struct coresight_device *csdev)
>>>   static int etm4_trace_id(struct coresight_device *csdev)
>>>   {
>>>          struct etmv4_drvdata *drvdata =
>>> dev_get_drvdata(csdev->dev.parent);
>>> -       unsigned long flags;
>>> -       int trace_id = -1;
>>>
>>> -       if (!local_read(&drvdata->mode))
>>> -               return drvdata->trcid;
>>> -
>>> -       spin_lock_irqsave(&drvdata->spinlock, flags);
>>> -
>>> -       CS_UNLOCK(drvdata->base);
>>> -       trace_id = readl_relaxed(drvdata->base + TRCTRACEIDR);
>>> -       trace_id &= ETM_TRACEID_MASK;
>>> -       CS_LOCK(drvdata->base);
>>> -
>>> -       spin_unlock_irqrestore(&drvdata->spinlock, flags);
>>> -
>>> -       return trace_id;
>>> +       return drvdata->trcid;
>>>   }
>>
>>
>> This code was written prior to the integration with the Perf core.  To
>> make sure the correct active value was return to users it goes to the
>> HW if the IP is in use.  With the integration with Perf the code was
>> moved around and the traceID is no longer called on the CPU (as you
>> noticed) and has lost the required PM runtime operation.
>>
>
> Is the perf integration already queued ? If not, it good to have this
> until then. I see crashes if I disable idle on one core and enable ETM
> source on that.

Yes, the patches are part of the 4.7 cycle.

>
> With this I don't see any crashes even if we have CPUIdle enabled.
> However the trace collection halts once the core suspends and resumes
> back. I have a simple solution for handling CPUIdle too, will post it soon.

I am quite sure you'll be seeing a lot of crashes/weird things
happening with CPUidle enabled.  I never had the opportunity to test
with PM runtime, even less with CPUidle.

(For those who might be wondering why, this is because the FW never
supported it, something Sudeep is currently fixing.)

>
> --
> Regards,
> Sudeep
