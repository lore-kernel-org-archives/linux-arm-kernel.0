From: anup.patel@broadcom.com (Anup Patel)
Date: Fri, 18 Aug 2017 17:06:46 +0530
Subject: [PATCH v2 11/16] dmaengine: bcm-sba-raid: Peek mbox when we have
 no free requests
In-Reply-To: <20170817064008.GB3053@localhost>
References: <1501583880-32072-1-git-send-email-anup.patel@broadcom.com>
 <1501583880-32072-12-git-send-email-anup.patel@broadcom.com>
 <20170817064008.GB3053@localhost>
Message-ID: <CAALAos9Wzk3LF9hOn+Wc_7ieyeXgq2M=Zk11rsrr38fZs25g2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 17, 2017 at 12:10 PM, Vinod Koul <vinod.koul@intel.com> wrote:
> On Tue, Aug 01, 2017 at 04:07:55PM +0530, Anup Patel wrote:
>> When setting up RAID array on several NVMe disks we observed that
>> sba_alloc_request() start failing (due to no free requests left)
>> and RAID array setup becomes very slow.
>>
>> To improve performance, we do mbox channel peek when we have
>> no free requests. This improves performance of RAID array setup
>> because mbox requests that were completed but not processed by
>> mbox completion worker will be processed immediately by mbox
>> channel peek.
>>
>> Signed-off-by: Anup Patel <anup.patel@broadcom.com>
>> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
>> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
>> ---
>>  drivers/dma/bcm-sba-raid.c | 25 ++++++++++++++++++++-----
>>  1 file changed, 20 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/dma/bcm-sba-raid.c b/drivers/dma/bcm-sba-raid.c
>> index f14ed0a..399250e 100644
>> --- a/drivers/dma/bcm-sba-raid.c
>> +++ b/drivers/dma/bcm-sba-raid.c
>> @@ -200,6 +200,14 @@ static inline u32 __pure sba_cmd_pq_c_mdata(u32 d, u32 b1, u32 b0)
>>
>>  /* ====== General helper routines ===== */
>>
>> +static void sba_peek_mchans(struct sba_device *sba)
>> +{
>> +     int mchan_idx;
>> +
>> +     for (mchan_idx = 0; mchan_idx < sba->mchans_count; mchan_idx++)
>> +             mbox_client_peek_data(sba->mchans[mchan_idx]);
>> +}
>> +
>>  static struct sba_request *sba_alloc_request(struct sba_device *sba)
>>  {
>>       unsigned long flags;
>> @@ -211,8 +219,17 @@ static struct sba_request *sba_alloc_request(struct sba_device *sba)
>>       if (req)
>>               list_move_tail(&req->node, &sba->reqs_alloc_list);
>>       spin_unlock_irqrestore(&sba->reqs_lock, flags);
>> -     if (!req)
>> +
>> +     if (!req) {
>> +             /*
>> +              * We have no more free requests so, we peek
>> +              * mailbox channels hoping few active requests
>> +              * would have completed which will create more
>> +              * room for new requests.
>> +              */
>> +             sba_peek_mchans(sba);
>>               return NULL;
>> +     }
>>
>>       req->flags = SBA_REQUEST_STATE_ALLOCED;
>>       req->first = req;
>> @@ -560,17 +577,15 @@ static enum dma_status sba_tx_status(struct dma_chan *dchan,
>>                                    dma_cookie_t cookie,
>>                                    struct dma_tx_state *txstate)
>>  {
>> -     int mchan_idx;
>>       enum dma_status ret;
>>       struct sba_device *sba = to_sba_device(dchan);
>>
>> -     for (mchan_idx = 0; mchan_idx < sba->mchans_count; mchan_idx++)
>> -             mbox_client_peek_data(sba->mchans[mchan_idx]);
>> -
>>       ret = dma_cookie_status(dchan, cookie, txstate);
>>       if (ret == DMA_COMPLETE)
>>               return ret;
>>
>> +     sba_peek_mchans(sba);
>
> why do you want to do this while checking status..?

The dma_tx_state is only updated via sba_receive_message()
which in-turn is called by mailbox framework upon completion
of a request.

Placing the sba_peek_mchans() here helps polling based
DMA client by not waiting for IRQ worker to schedule and
process the completions.

Regards,
Anup
