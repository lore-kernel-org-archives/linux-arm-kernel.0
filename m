From: dan.j.williams@intel.com (Dan Williams)
Date: Thu, 23 Sep 2010 14:16:10 -0700
Subject: [PATCH] dmaengine: fix interrupt clearing for mv_xor
In-Reply-To: <AANLkTimybyerarsWzh_4sqZj_BUXrox022f2fhPbhp6+@mail.gmail.com>
References: <1284759231-3188-1-git-send-email-simon@sequanux.org>
	<AANLkTimybyerarsWzh_4sqZj_BUXrox022f2fhPbhp6+@mail.gmail.com>
Message-ID: <AANLkTim41FbqW62q-MQAATrNqdzFd+XDZF-aFtSRYroy@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 19, 2010 at 7:12 AM, saeed bishara <saeed.bishara@gmail.com> wrote:
> On Fri, Sep 17, 2010 at 11:33 PM, Simon Guinot <simon@sequanux.org> wrote:
>> From: Simon Guinot <sguinot@lacie.com>
>>
>> When using simultaneously the two DMA channels on a same engine, some
>> transfers are never completed. For example, an endless lock can occur
>> while writing heavily on a RAID5 array (with async-tx offload support
>> enabled).
>>
>> Note that this issue can also be reproduced by using the DMA test
>> client.
>>
>> On a same engine, the interrupt cause register is shared between two
>> DMA channels. This patch make sure that the cause bit is only cleared
>> for the requested channel.
>>
>> Signed-off-by: Simon Guinot <sguinot@lacie.com>
>> Tested-by: Luc Saillard <luc@saillard.org>
>> ---
>> ?drivers/dma/mv_xor.c | ? ?2 +-
>> ?1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
>> index 86c5ae9..411d5bf 100644
>> --- a/drivers/dma/mv_xor.c
>> +++ b/drivers/dma/mv_xor.c
>> @@ -162,7 +162,7 @@ static int mv_is_err_intr(u32 intr_cause)
>>
>> ?static void mv_xor_device_clear_eoc_cause(struct mv_xor_chan *chan)
>> ?{
>> - ? ? ? u32 val = (1 << (1 + (chan->idx * 16)));
>> + ? ? ? u32 val = ~(1 << (chan->idx * 16));
>> ? ? ? ?dev_dbg(chan->device->common.dev, "%s, val 0x%08x\n", __func__, val);
>> ? ? ? ?__raw_writel(val, XOR_INTR_CAUSE(chan));
>> ?}
> The patch looks fine, it clears the "End Of Descriptor" interrupt that
> set by mv_chan_unmask_interrupts, and it clears that interrupt by
> writing 0 only to that one.
> saeed

Thanks, applied with your acked-by.
