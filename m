From: anup.patel@broadcom.com (Anup Patel)
Date: Fri, 18 Aug 2017 10:31:51 +0530
Subject: [PATCH v2 10/16] dmaengine: bcm-sba-raid: Alloc resources before
 registering DMA device
In-Reply-To: <20170817063812.GA3053@localhost>
References: <1501583880-32072-1-git-send-email-anup.patel@broadcom.com>
 <1501583880-32072-11-git-send-email-anup.patel@broadcom.com>
 <20170817063812.GA3053@localhost>
Message-ID: <CAALAos-i22Mm5R1U-GGHPBZE74nKkHH-z_v4y48oD8nHZ6uscA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 17, 2017 at 12:08 PM, Vinod Koul <vinod.koul@intel.com> wrote:
> On Tue, Aug 01, 2017 at 04:07:54PM +0530, Anup Patel wrote:
>> We should allocate DMA channel resources before registering the
>> DMA device in sba_probe() because we can get DMA request soon
>> after registering the DMA device. If DMA channel resources are
>> not allocated before first DMA request then SBA-RAID driver will
>> crash.
>>
>> Signed-off-by: Anup Patel <anup.patel@broadcom.com>
>> ---
>>  drivers/dma/bcm-sba-raid.c | 30 +++++++++++++++---------------
>>  1 file changed, 15 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/dma/bcm-sba-raid.c b/drivers/dma/bcm-sba-raid.c
>> index f6616da..f14ed0a 100644
>> --- a/drivers/dma/bcm-sba-raid.c
>> +++ b/drivers/dma/bcm-sba-raid.c
>> @@ -1478,13 +1478,13 @@ static int sba_prealloc_channel_resources(struct sba_device *sba)
>>       int i, j, ret = 0;
>>       struct sba_request *req = NULL;
>>
>> -     sba->resp_base = dma_alloc_coherent(sba->dma_dev.dev,
>> +     sba->resp_base = dma_alloc_coherent(sba->mbox_dev,
>
> how does this qualify as move before registering, you seem to be using
> different device now

The sba->dma_dev.dev is assigned in sba_async_register().

Now, if we are calling sba_async_register() after
sba_prealloc_channel_resources() then we cannot
use sba->dma_dev.dev in sba_prealloc_channel_resources()

Regards,
Anup
