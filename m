From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Thu, 1 Oct 2015 17:16:43 -0600
Subject: [RFC PATCH 19/20] coresight: etm3x: implementing perf's
 user/kernel mode
In-Reply-To: <87mvw4jjps.fsf@ashishki-desk.ger.corp.intel.com>
References: <1442593594-10665-1-git-send-email-mathieu.poirier@linaro.org>
 <1442593594-10665-20-git-send-email-mathieu.poirier@linaro.org>
 <87mvw4jjps.fsf@ashishki-desk.ger.corp.intel.com>
Message-ID: <CANLsYkwe2d3_6m6_0dwOkJfm-7knwp7WJJA7c4Qd9LBKpadB3g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 September 2015 at 04:16, Alexander Shishkin
<alexander.shishkin@linux.intel.com> wrote:
> Mathieu Poirier <mathieu.poirier@linaro.org> writes:
>
>> Configure tracers in accordance with the specification conveyed
>> by the perf cmd line tool.  For example if only user space is
>> requested, configure the address range comparator with the kerne's
>> address range and set the 'exclude' bit, which will result in
>> tracing everything except the kernel.
>>
>> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>> ---
>>  drivers/hwtracing/coresight/coresight-etm3x.c | 36 +++++++++++++++++++++++++++
>>  1 file changed, 36 insertions(+)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
>> index 077b49714259..2f818dbde099 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm3x.c
>> +++ b/drivers/hwtracing/coresight/coresight-etm3x.c
>> @@ -320,6 +320,41 @@ static int etm_parse_event_config(struct etm_drvdata *drvdata,
>>  {
>>       u64 config = event->attr.config;
>>
>> +     if (event->attr.exclude_kernel || event->attr.exclude_user) {
>> +             u32 event_encoding;
>> +             u32 flags = (1 << 0 | /* instruction execute*/
>> +                          3 << 3 | /* ARM instruction */
>> +                          0 << 5 | /* No data value comparison */
>> +                          0 << 7 | /* No exact mach */
>> +                          0 << 8 | /* Ignore context ID */
>> +                          0 << 10); /* Security ignored */
>> +
>> +             /* Bit 0 is address range comparator 1 */
>> +             drvdata->enable_ctrl1 = ETMTECR1_ADDR_COMP_1;
>> +
>> +             /* Bit 24 controls whether the address range should be
>> +              * included or excluded.
>> +              */
>> +             if (event->attr.exclude_kernel)
>> +                     drvdata->enable_ctrl1 |= BIT(24);
>
> Isn't there a privilege level based filtering (OS/USR) in ETM? Shouldn't
> ETMACTRn[10:12] have a setting for that?

Indeed - I'm working with people at ARM on a better solution.

>
>> +
>> +             /* No need to worry about single address comparators */
>> +             drvdata->enable_ctrl2 = 0x0;
>> +
>> +             drvdata->addr_val[0] = (u32) _stext;
>> +             drvdata->addr_val[1] = (u32) _etext;
>
> This doesn't cover kernel modules, afaict.
>
>> +             drvdata->addr_acctype[0] = flags;
>> +             drvdata->addr_acctype[1] = flags;
>> +             drvdata->addr_type[0] = ETM_ADDR_TYPE_RANGE;
>> +             drvdata->addr_type[1] = ETM_ADDR_TYPE_RANGE;
>> +
>> +             event_encoding = 0x00 << 14 | /* Boolean function select A */
>> +                              0x01 << 4  | /* Addr range comparator 0-7 */
>> +                              0x00 << 0;   /* Addr range comparator 1 */
>> +
>> +             drvdata->enable_event = event_encoding;
>> +     }
>> +
>>       /*
>>        * At this time only cycle accurate and timestamp options are
>>        * available.  As such clear everything else that may have been
>> @@ -362,6 +397,7 @@ static void etm_configure_cpu(void *info)
>>       etm_writel(drvdata, drvdata->startstop_ctrl, ETMTSSCR);
>>       etm_writel(drvdata, drvdata->enable_event, ETMTEEVR);
>>       etm_writel(drvdata, drvdata->enable_ctrl1, ETMTECR1);
>> +     etm_writel(drvdata, drvdata->enable_ctrl2, ETMTECR2);
>>       etm_writel(drvdata, drvdata->fifofull_level, ETMFFLR);
>>       for (i = 0; i < drvdata->nr_addr_cmp; i++) {
>>               etm_writel(drvdata, drvdata->addr_val[i], ETMACVRn(i));
>> --
>> 1.9.1
