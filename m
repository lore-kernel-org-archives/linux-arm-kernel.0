From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Thu, 27 Sep 2018 09:50:48 +0200
Subject: [PATCH v23 4/4] soc: mediatek: Add Mediatek CMDQ helper
In-Reply-To: <1538013431.17514.31.camel@mhfsdcap03>
References: <1532482002-11164-1-git-send-email-houlong.wei@mediatek.com>
 <1532482002-11164-5-git-send-email-houlong.wei@mediatek.com>
 <ca12e8ab-e3d1-1cf0-8fe9-756d57bd5a3a@gmail.com>
 <1538013431.17514.31.camel@mhfsdcap03>
Message-ID: <3773f620-e135-578d-5307-08483436f4c2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 27/09/2018 03:57, houlong wei wrote:
[...]
>>> +	}
>>> +
>>> +	return client;
>>> +}
>>> +EXPORT_SYMBOL(cmdq_mbox_create);
>>> +
>>> +void cmdq_mbox_destroy(struct cmdq_client *client)
>>> +{
>>> +	if (client->timeout_ms != CMDQ_NO_TIMEOUT) {
>>> +		spin_lock(&client->lock);
>>> +		del_timer_sync(&client->timer);
>>> +		spin_unlock(&client->lock);
>>> +	}
>>> +	mbox_free_channel(client->chan);
>>> +	kfree(client);
>>> +}
>>> +EXPORT_SYMBOL(cmdq_mbox_destroy);
>>> +
>>> +int cmdq_pkt_create(struct cmdq_client *client, struct cmdq_pkt **pkt_ptr,
>>> +		    size_t size)
>>
>> I suppose you are not returning the allocated cmdq_pkt to avoid checks for
>> IS_ERR() logic in the consumer of this API. Am I correct?
>> Do we really need a pointer to a pointer here? Can't we just use a struct
>> cmdq_pkt *pkt as argument? That would make things easier.
> 
> Do you mean we change the argument 'struct cmdq_pkt **pkt_ptr' to
> 'struct cmdq_pkt *pkt', and the consumer allocate a struct cmdq_pkt
> *pkt, then pass pkt as argument of this API?
> If yes, the consumer still need to check the return value of this API.
> For the current implementation, the consumer doesn't need check
> IS_ERR(*pkt_ptr) if the return value equals to 0.
> 
> Since the consumer has to check the return value of this API once, to
> make it simpler, I shall change the prototype to 
> 'struct cmdq_pkt *cmdq_pkt_create(struct cmdq_client *client, size_t
> size)' and change its implementation.
> 

Exactly that's what I proposed. Sorry for not explaining myself :)

>>
>>> +{
>>> +	struct cmdq_pkt *pkt;
>>> +	struct device *dev;
>>> +	dma_addr_t dma_addr;
>>> +
>>> +	pkt = kzalloc(sizeof(*pkt), GFP_KERNEL);
>>> +	if (!pkt)
>>> +		return -ENOMEM;
>>> +	pkt->va_base = kzalloc(size, GFP_KERNEL);
>>> +	if (!pkt->va_base) {
>>> +		kfree(pkt);
>>> +		return -ENOMEM;
>>> +	}
>>> +	pkt->buf_size = size;
>>> +	pkt->cl = (void *)client;
>>> +
>>> +	dev = client->chan->mbox->dev;
>>> +	dma_addr = dma_map_single(dev, pkt->va_base, pkt->buf_size,
>>> +		DMA_TO_DEVICE);
>>> +	if (dma_mapping_error(dev, dma_addr)) {
>>> +		dev_err(dev, "dma map failed, size=%u\n", (u32)(u64)size);
>>> +		kfree(pkt->va_base);
>>> +		kfree(pkt);
>>> +		return -ENOMEM;
>>> +	}
>>> +
>>> +	pkt->pa_base = dma_addr;
>>> +	*pkt_ptr = pkt;
>>> +
>>> +	return 0;
>>> +}
>>> +EXPORT_SYMBOL(cmdq_pkt_create);
>>> +
>>> +void cmdq_pkt_destroy(struct cmdq_pkt *pkt)
>>> +{
>>> +	struct cmdq_client *client = (struct cmdq_client *)pkt->cl;
>>> +
>>> +	dma_unmap_single(client->chan->mbox->dev, pkt->pa_base, pkt->buf_size,
>>> +			 DMA_TO_DEVICE);
>>> +	kfree(pkt->va_base);
>>> +	kfree(pkt);
>>> +}
>>> +EXPORT_SYMBOL(cmdq_pkt_destroy);
>>> +
>>> +static int cmdq_pkt_append_command(struct cmdq_pkt *pkt, enum cmdq_code code,
>>> +				   u32 arg_a, u32 arg_b)
>>> +{
>>> +	u64 *cmd_ptr;
>>> +
>>> +	if (unlikely(pkt->cmd_buf_size + CMDQ_INST_SIZE > pkt->buf_size)) {
>>> +		pkt->cmd_buf_size += CMDQ_INST_SIZE;
>>
>> Why do we update the cmd_buf_size here?
> 
> Because in developing phase of consumer driver, the consumer has to know
> the real command buffer size after adding command failure. Then the
> consumer will increase the size and run the cmdq flow (cmdq_pkt_create,
> cmdq_pkt_write/wfe...) again. Finally, the consumer get the real size
> and fix it.
> 

But the consumer should know the size it needs for it's buffer and if not it
should be able to decide on it's own how much space it needs. If he get's a
-ENOMEM he implicitly knows that he has to increase the buf_size. Now the size
depends on how many command he has pending and wasn't able to write to the cmdq_pkt.

Regards,
Matthias
