From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Mon, 25 Jul 2011 20:33:23 +0530
Subject: [PATCH] dmaengine: pl330: make platform data optional
In-Reply-To: <1311603872.8206.15.camel@vkoul-mobl4>
References: <1310518811-379-1-git-send-email-robherring2@gmail.com>
	<1311603872.8206.15.camel@vkoul-mobl4>
Message-ID: <CABb+yY1mVHHLdmBh-3RJxc9zSNQkxQQrTiLsD6OJC1rSN3WW9w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 25, 2011 at 7:54 PM, Vinod Koul <vkoul@infradead.org> wrote:
> On Tue, 2011-07-12 at 20:00 -0500, Rob Herring wrote:
>> From: Rob Herring <rob.herring@calxeda.com>
>>
>> The pl330 needs platform data for describing peripheral connections, but
>> some platforms may only support memory to memory dma channels. In this
>> case, we can probe for how many channels there are and don't need the
>> platform data.
>>
>> As memcpy requests don't need channel private data to hold peripheral
>> info, allow private data to be NULL in this case.
>>
>> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
>> Cc: Jassi Brar <jassi.brar@samsung.com>
>> Cc: Vinod Koul <vinod.koul@intel.com>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> ---
>> ?drivers/dma/pl330.c | ? 64 ++++++++++++++++++++++++++++----------------------
>> ?1 files changed, 36 insertions(+), 28 deletions(-)
> Applied, Thanks

Oops, sorry Rob. I failed to reply as I assured you. I have been just
too deep into other stuff.

>> @@ -717,27 +717,35 @@ pl330_probe(struct amba_device *adev, const struct amba_id *id)
>> ? ? ? INIT_LIST_HEAD(&pd->channels);
>>
>> ? ? ? /* Initialize channel parameters */
>> - ? ? for (i = 0; i < pdat->nr_valid_peri; i++) {
>> - ? ? ? ? ? ? struct dma_pl330_peri *peri = &pdat->peri[i];
>> - ? ? ? ? ? ? pch = &pdmac->peripherals[i];
>> + ? ? num_chan = max(pdat->nr_valid_peri, (u8)pi->pcfg.num_chan);
Perhaps you need to check against NULL pointer on 'pdat' ?

Rest looks ok.

thnx
