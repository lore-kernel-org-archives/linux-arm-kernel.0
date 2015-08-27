From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Thu, 27 Aug 2015 21:28:18 +0800
Subject: [PATCH 1/5] DMA: pl330: support burst mode for dev-to-mem and
 mem-to-dev transmit
In-Reply-To: <CAJKOXPdw+ZZURRPUNvKHdx7wRG7M-Frqmvq46KFM_ckGq8h0Yg@mail.gmail.com>
References: <1440665280-31557-1-git-send-email-shawn.lin@rock-chips.com>
 <1440665313-31603-1-git-send-email-shawn.lin@rock-chips.com>
 <CAJKOXPdw+ZZURRPUNvKHdx7wRG7M-Frqmvq46KFM_ckGq8h0Yg@mail.gmail.com>
Message-ID: <55DF1072.1070905@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2015/8/27 20:57, Krzysztof Kozlowski ??:
> 2015-08-27 17:48 GMT+09:00 Shawn Lin <shawn.lin@rock-chips.com>:
>>
>> This patch adds to support burst mode for dev-to-mem and
>> mem-to-dev transmit.
>>
>> Signed-off-by: Boojin Kim <boojin.kim@samsung.com>
>> Signed-off-by: Addy Ke <addy.ke@rock-chips.com>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>> cc: Heiko Stuebner <heiko@sntech.de>
>> cc: Doug Anderson <dianders@chromium.org>
>> cc: Olof Johansson <olofj@google.com>
>> Reviewed-and-tested-by: Sonny Rao <sonnyrao@chromium.org>
>
> For the entire patchset: I would prefer to see someone's
> reviewed/tested tag in his response. Sending a version 1 of patchset
> (regardless of Boojin Kim's work two years ago) with such tag could
> mean anything. I cannot verify it easily (unless digging somewhere...
> or asking people). You could add for example: Reviewed-by Santa Claus.
> Should I sent a letter to him asking for confirmation? :)
>

:) yes, you are right. I should comply with the rule, even if the 
patchest had been reviewed or tested by someone on another tree.

> More seriously - reviewed-by is a statement (please look at
> Documentation/SubmittingPatches) and you cannot force someone to make
> that statement. He must make such statement on his own.
>
> That's all from my side since I don't feel skilled enough to review the code.
>
> Best regards,
> Krzysztof
>
>>
>> ---
>>
>>   drivers/dma/pl330.c | 18 ++++++++++++------
>>   1 file changed, 12 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
>> index ecab4ea0..0d544d2 100644
>> --- a/drivers/dma/pl330.c
>> +++ b/drivers/dma/pl330.c
>> @@ -1141,10 +1141,13 @@ static inline int _ldst_devtomem(unsigned dry_run, u8 buf[],
>>                  const struct _xfer_spec *pxs, int cyc)
>>   {
>>          int off = 0;
>> +       enum pl330_cond cond;
>> +
>> +       cond = (pxs->desc->rqcfg.brst_len == 1) ? SINGLE : BURST;
>>
>>          while (cyc--) {
>> -               off += _emit_WFP(dry_run, &buf[off], SINGLE, pxs->desc->peri);
>> -               off += _emit_LDP(dry_run, &buf[off], SINGLE, pxs->desc->peri);
>> +               off += _emit_WFP(dry_run, &buf[off], cond, pxs->desc->peri);
>> +               off += _emit_LDP(dry_run, &buf[off], cond, pxs->desc->peri);
>>                  off += _emit_ST(dry_run, &buf[off], ALWAYS);
>>                  off += _emit_FLUSHP(dry_run, &buf[off], pxs->desc->peri);
>>          }
>> @@ -1156,11 +1159,14 @@ static inline int _ldst_memtodev(unsigned dry_run, u8 buf[],
>>                  const struct _xfer_spec *pxs, int cyc)
>>   {
>>          int off = 0;
>> +       enum pl330_cond cond;
>> +
>> +       cond = (pxs->desc->rqcfg.brst_len == 1) ? SINGLE : BURST;
>>
>>          while (cyc--) {
>> -               off += _emit_WFP(dry_run, &buf[off], SINGLE, pxs->desc->peri);
>> +               off += _emit_WFP(dry_run, &buf[off], cond, pxs->desc->peri);
>>                  off += _emit_LD(dry_run, &buf[off], ALWAYS);
>> -               off += _emit_STP(dry_run, &buf[off], SINGLE, pxs->desc->peri);
>> +               off += _emit_STP(dry_run, &buf[off], cond, pxs->desc->peri);
>>                  off += _emit_FLUSHP(dry_run, &buf[off], pxs->desc->peri);
>>          }
>>
>> @@ -2557,7 +2563,7 @@ static struct dma_async_tx_descriptor *pl330_prep_dma_cyclic(
>>
>>                  desc->rqtype = direction;
>>                  desc->rqcfg.brst_size = pch->burst_sz;
>> -               desc->rqcfg.brst_len = 1;
>> +               desc->rqcfg.brst_len = pch->burst_len;
>>                  desc->bytes_requested = period_len;
>>                  fill_px(&desc->px, dst, src, period_len);
>>
>> @@ -2702,7 +2708,7 @@ pl330_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
>>                  }
>>
>>                  desc->rqcfg.brst_size = pch->burst_sz;
>> -               desc->rqcfg.brst_len = 1;
>> +               desc->rqcfg.brst_len = pch->burst_len;
>>                  desc->rqtype = direction;
>>                  desc->bytes_requested = sg_dma_len(sg);
>>          }
>> --
>> 2.3.7
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe dmaengine" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>


-- 
Best Regards
Shawn Lin
