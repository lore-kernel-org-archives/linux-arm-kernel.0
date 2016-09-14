From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Wed, 14 Sep 2016 10:56:31 +0100
Subject: [PATCH] coresight: tmc: fix for trace collection bug in sysFS mode
In-Reply-To: <CANLsYkzNqMuwcmYJtoORXrON54Wt1oj5uyp2NQpKYM2AN4F26g@mail.gmail.com>
References: <1473769245-18159-1-git-send-email-venkatesh.vivekanandan@broadcom.com>
 <CANLsYkzNqMuwcmYJtoORXrON54Wt1oj5uyp2NQpKYM2AN4F26g@mail.gmail.com>
Message-ID: <a8232b7a-3d38-efb1-4c71-8dcb12f89dad@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/09/16 16:41, Mathieu Poirier wrote:
> On 13 September 2016 at 06:20, Venkatesh Vivekanandan
> <venkatesh.vivekanandan@broadcom.com> wrote:
>> tmc_etb_dump_hw is never called in sysFS mode to collect trace from
>> hardware, because drvdata->mode is set to CS_MODE_DISABLED at
>> tmc_disable_etf/etr_sink
>>
>> static void tmc_etb_disable_hw(struct tmc_drvdata *drvdata)
>> {
>>         .
>>         .
>>         if (local_read(&drvdata->mode) == CS_MODE_SYSFS)
>>                 tmc_etb_dump_hw(drvdata);
>>         .
>>         .
>> }
>>
>> static void tmc_disable_etf_sink(struct coresight_device *csdev)
>> {
>>        .
>>        .
>>         val = local_xchg(&drvdata->mode, CS_MODE_DISABLED);
>>         /* Disable the TMC only if it needs to */
>>         if (val != CS_MODE_DISABLED)
>>                 tmc_etb_disable_hw(drvdata);
>
> You are correct.
>
>>        .
>>        .
>> }
>>
>> Signed-off-by: Venkatesh Vivekanandan <venkatesh.vivekanandan@broadcom.com>
>> ---
>>  drivers/hwtracing/coresight/coresight-tmc-etf.c | 9 +++++----
>>  drivers/hwtracing/coresight/coresight-tmc-etr.c | 9 +++++----
>>  2 files changed, 10 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
>> index 466af86..c7fb7f7 100644
>> --- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
>> +++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
>> @@ -61,6 +61,8 @@ static void tmc_etb_dump_hw(struct tmc_drvdata *drvdata)
>>
>>  static void tmc_etb_disable_hw(struct tmc_drvdata *drvdata)
>>  {
>> +       long val;
>> +
>>         CS_UNLOCK(drvdata->base);
>>
>>         tmc_flush_and_stop(drvdata);
>> @@ -68,7 +70,8 @@ static void tmc_etb_disable_hw(struct tmc_drvdata *drvdata)
>>          * When operating in sysFS mode the content of the buffer needs to be
>>          * read before the TMC is disabled.
>>          */
>> -       if (local_read(&drvdata->mode) == CS_MODE_SYSFS)
>> +       val = local_xchg(&drvdata->mode, CS_MODE_DISABLED);
>> +       if (val == CS_MODE_SYSFS)
>>                 tmc_etb_dump_hw(drvdata);
>>         tmc_disable_hw(drvdata);
>>
>> @@ -225,7 +228,6 @@ static int tmc_enable_etf_sink(struct coresight_device *csdev, u32 mode)
>>
>>  static void tmc_disable_etf_sink(struct coresight_device *csdev)
>>  {
>> -       long val;
>>         unsigned long flags;
>>         struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>>
>> @@ -235,9 +237,8 @@ static void tmc_disable_etf_sink(struct coresight_device *csdev)
>>                 return;
>>         }
>>
>> -       val = local_xchg(&drvdata->mode, CS_MODE_DISABLED);
>>         /* Disable the TMC only if it needs to */
>> -       if (val != CS_MODE_DISABLED)
>> +       if (local_read(&drvdata->mode) != CS_MODE_DISABLED)
>>                 tmc_etb_disable_hw(drvdata);
>
> This would work but tmc_enable_etf_sink() and tmc_disable_etf_sink()
> are no longer balanced.  Another approach would be to add a "mode"
> parameter to tmc_etb_disable_hw() and so something like:
>
> if (val != CS_MODE_DISABLED)
>         tmc_etb_disable_hw(drvdata, val);
>
> In tmc_etb_disable_hw(), if mode == CS_MODE_SYSFS then we can move
> ahead with the dump operation.  The same apply for ETR

I think we should :

1) First switch the drvdata->mode to a normal type from local_t. Using an
atomic type for mode is completely unnecessary and comes with the overhead
of barriers/synchronisation instructions, while all accesses, including read/write
are performed under the drvdata->spinlock. I have a patch already for this, which
I plan to send it soon.

and

2) Do something like :

void  tmc_disable_etX_sink()
{
	if (drvdata->mode != CS_MODE_DISABLED) {
		tmc_etX_disable_hw(drvdata);
		drvdata->mode = CS_MODE_DISABLED;
	}
}

Leaving the tmc_etX_disable_hw() untouched.


Suzuki

	
