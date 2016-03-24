From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Thu, 24 Mar 2016 10:38:18 -0600
Subject: [PATCH 03/14] coresight: tmc: re-implementing
 tmc_read_prepare/unprepare() functions
In-Reply-To: <56F271FE.8060904@arm.com>
References: <1458678202-3447-1-git-send-email-mathieu.poirier@linaro.org>
 <1458678202-3447-4-git-send-email-mathieu.poirier@linaro.org>
 <56F271FE.8060904@arm.com>
Message-ID: <CANLsYkwzpX42TWbf+3gGwqcFBGtE8d1D=U0eV5AjYvJdTMWZaA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23 March 2016 at 04:37, Suzuki K. Poulose <Suzuki.Poulose@arm.com> wrote:
> On 22/03/16 20:23, Mathieu Poirier wrote:
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
>> index f4ba837a0810..208d47dd3083 100644
>> --- a/drivers/hwtracing/coresight/coresight-tmc.c
>> +++ b/drivers/hwtracing/coresight/coresight-tmc.c
>> @@ -430,7 +430,7 @@ static const struct coresight_ops tmc_etf_cs_ops = {
>>
>
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
>> +
>> +               tmc_etb_disable_hw(drvdata);
>> +               break;
>> +       case TMC_CONFIG_TYPE_ETR:
>> +               tmc_etr_disable_hw(drvdata);
>> +               break;
>> +       default:
>> +               ret = -EINVAL;
>> +               goto err;
>>         }
>
>
> We seem to be doing this switch at different places in the code just for
> enable_hw/disable_hw.
> e.g, tmc_enable, tmc_disable
>
> Could we make this a bit more cleaner by introducing something like this ?
>
> struct tmc_hw_ops {
>         int (*enable_hw)(struct tmc_drvdata *drvdata, enum tmc_mode mode);
>         int (*disable_hw)(struct tmc_drvdata *drvdata, enum tmc_mode mode);
> };
>
> struct tmc_hw_ops tmc_etf_ops = {
>         tmc_etf_enable_hw,
>         tmc_etf_disable_hw,
> };
>
> similiarly for etb and etr and then add struct tmc_hw_ops *hw_ops to
> tmc_drvdata, initialised
> at probe time (while reading the config_type).

That is a good idea - let me experiment with it a little...

>
>
> Suzuki
>
