From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 15 Apr 2016 09:40:28 -0600
Subject: [PATCH V2 03/15] coresight: tmc: re-implementing
 tmc_read_prepare/unprepare() functions
In-Reply-To: <570FCF45.8010809@arm.com>
References: <1460483692-25061-1-git-send-email-mathieu.poirier@linaro.org>
 <1460483692-25061-4-git-send-email-mathieu.poirier@linaro.org>
 <570FCF45.8010809@arm.com>
Message-ID: <CANLsYkzm+=Aec+bXp7htTwr6O3ObSjaQJmSUTjgr608gH7Abhg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 April 2016 at 11:11, Suzuki K Poulose <Suzuki.Poulose@arm.com> wrote:
> On 12/04/16 18:54, Mathieu Poirier wrote:
>>
>> In their current implementation the tmc_read_prepare/unprepare()
>> are a lump of if/else that is difficult to read.  This patch is
>> alleviating that by using a switch statement.  The latter also
>> allows for a better control on the error path.
>>
>> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>> ---
>>   drivers/hwtracing/coresight/coresight-tmc.c | 56
>> ++++++++++++++++++-----------
>>   1 file changed, 36 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-tmc.c
>> b/drivers/hwtracing/coresight/coresight-tmc.c
>> index 66fa7736d12f..d211aeec49f8 100644
>> --- a/drivers/hwtracing/coresight/coresight-tmc.c
>> +++ b/drivers/hwtracing/coresight/coresight-tmc.c
>> @@ -431,7 +431,7 @@ static const struct coresight_ops tmc_etf_cs_ops = {
>>
>>   static int tmc_read_prepare(struct tmc_drvdata *drvdata)
>>   {
>> -       int ret;
>> +       int ret = 0;
>>         unsigned long flags;
>>         enum tmc_mode mode;
>>
>> @@ -439,25 +439,31 @@ static int tmc_read_prepare(struct tmc_drvdata
>> *drvdata)
>>         if (!drvdata->enable)
>>                 goto out;
>>
>> -       if (drvdata->config_type == TMC_CONFIG_TYPE_ETB) {
>> +       switch (drvdata->config_type) {
>> +       case TMC_CONFIG_TYPE_ETB:
>>                 tmc_etb_disable_hw(drvdata);
>> -       } else if (drvdata->config_type == TMC_CONFIG_TYPE_ETR) {
>> -               tmc_etr_disable_hw(drvdata);
>> -       } else {
>> +               break;
>> +       case TMC_CONFIG_TYPE_ETF:
>> +               /* There is no point in reading a TMC in HW FIFO mode */
>>                 mode = readl_relaxed(drvdata->base + TMC_MODE);
>> -               if (mode == TMC_MODE_CIRCULAR_BUFFER) {
>> -                       tmc_etb_disable_hw(drvdata);
>> -               } else {
>> -                       ret = -ENODEV;
>> +               if (mode != TMC_MODE_CIRCULAR_BUFFER) {
>> +                       ret = -EINVAL;
>>                         goto err;
>>                 }
>
>
> Nit. If you move the TMC_CONFIG_TYPE_ETB here, you could fall through from
> TYPE_ETF: i.e,

Yes, that's what the end result look like [1].  I will refactor to
make the transition cleaner.

[1]. https://git.linaro.org/kernel/coresight.git/blob/refs/heads/next:/drivers/hwtracing/coresight/coresight-tmc.c#l76

>                 /* Fall through to ETB mode */
>         case TMC_CONFIG_TYPE_ETB:
>>
>> +
>> +               tmc_etb_disable_hw(drvdata);
>> +               break;
>
>
>
>
>> +       case TMC_CONFIG_TYPE_ETR:
>> +               tmc_etr_disable_hw(drvdata);
>> +               break;
>> +       default:
>> +               ret = -EINVAL;
>> +               goto err;
>>         }
>> +
>
>
>
>>         return ret;
>> @@ -472,20 +478,30 @@ static void tmc_read_unprepare(struct tmc_drvdata
>> *drvdata)
>>         if (!drvdata->enable)
>>                 goto out;
>>
>> -       if (drvdata->config_type == TMC_CONFIG_TYPE_ETB) {
>> +       switch (drvdata->config_type) {
>> +       case TMC_CONFIG_TYPE_ETB:
>>                 tmc_etb_enable_hw(drvdata);
>> -       } else if (drvdata->config_type == TMC_CONFIG_TYPE_ETR) {
>> -               tmc_etr_enable_hw(drvdata);
>> -       } else {
>> +               break;
>> +       case TMC_CONFIG_TYPE_ETF:
>> +               /* Make sure we don't re-enable a TMC in HW FIFO mode */
>>                 mode = readl_relaxed(drvdata->base + TMC_MODE);
>> -               if (mode == TMC_MODE_CIRCULAR_BUFFER)
>> -                       tmc_etb_enable_hw(drvdata);
>> +               if (mode != TMC_MODE_CIRCULAR_BUFFER)
>> +                       goto err;
>> +
>> +               tmc_etb_enable_hw(drvdata);
>> +               break;
>
>
> Same as above.
>
>> +       case TMC_CONFIG_TYPE_ETR:
>> +               tmc_etr_disable_hw(drvdata);
>> +               break;
>> +       default:
>> +               goto err;
>>         }
>> +
>
>
> Otherwise,
>
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>
>
