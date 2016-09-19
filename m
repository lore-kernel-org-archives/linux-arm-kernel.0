From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Mon, 19 Sep 2016 17:59:04 +0100
Subject: [PATCH] coresight: tmc: Cleanup operation mode handling
In-Reply-To: <CANLsYkxWSQFgBYHi6dosjut78uohCtX8Wv3Kw=eHk0L_7jmFVw@mail.gmail.com>
References: <1473861230-5666-1-git-send-email-suzuki.poulose@arm.com>
 <CANLsYkxWSQFgBYHi6dosjut78uohCtX8Wv3Kw=eHk0L_7jmFVw@mail.gmail.com>
Message-ID: <b693447b-e89c-d4ea-bc57-6c447d688055@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/09/16 18:07, Mathieu Poirier wrote:
> On 14 September 2016 at 07:53, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>> The mode of operation of the TMC tracked in drvdata->mode is defined
>> as a local_t type. This is always checked and modified under the
>> drvdata->spinlock and hence we don't need local_t for it and the
>> unnecessary synchronisation instructions that comes with it. This
>> change makes the code a bit more cleaner.
>>
>> Also fixes the order in which we update the drvdata->mode to
>> CS_MODE_DISABLED. i.e, in tmc_disable_etX_sink we change the
>> mode to CS_MODE_DISABLED before invoking tmc_disable_etX_hw()
>> which in turn depends on the mode to decide whether to dump the
>> trace to a buffer.
>
> Thank you for the patch - just a few comments below.
>


>> @@ -194,17 +192,17 @@ static int tmc_enable_etf_sink_perf(struct coresight_device *csdev, u32 mode)
>>                 goto out;
>>         }
>>
>> -       val = local_xchg(&drvdata->mode, mode);
>>         /*
>>          * In Perf mode there can be only one writer per sink.  There
>>          * is also no need to continue if the ETB/ETR is already operated
>>          * from sysFS.
>>          */
>> -       if (val != CS_MODE_DISABLED) {
>> +       if (drvdata->mode != CS_MODE_DISABLED) {
>>                 ret = -EINVAL;
>>                 goto out;
>>         }
>>
>> +       drvdata->mode = mode;
>
> Given the way tmc_enable_etf_sink_perf() is called in
> tmc_enable_etf_sink(), I think it is time to get rid of the 'mode'
> parameter - it doesn't do anything nowadays.  Same thing for
> tmc_enable_etf_sink_sysfs() and ETR.

Sure, makes sense. I will clean it up.

>> @@ -279,8 +277,8 @@ static void tmc_disable_etf_link(struct coresight_device *csdev,
>>                 return;
>>         }
>>
>> +       drvdata->mode = CS_MODE_DISABLED;
>>         tmc_etf_disable_hw(drvdata);
>> -       local_set(&drvdata->mode, CS_MODE_DISABLED);
>
> I think setting the mode should come after tmc_etf_disable_hw(), as it
> was before.

You're right, I will change it.


Thanks for the review. Will send the updated series soon.

Cheers
Suzuki
IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
