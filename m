From: lars@metafoo.de (Lars-Peter Clausen)
Date: Tue, 17 Apr 2018 17:44:00 +0200
Subject: [RFC 2/6] dmaengine: xilinx_dma: Pass AXI4-Stream control words
 to netdev dma client
In-Reply-To: <20180417154231.GV6014@localhost>
References: <1522665546-10035-1-git-send-email-radheys@xilinx.com>
 <1522665546-10035-3-git-send-email-radheys@xilinx.com>
 <20180411090854.GY6014@localhost>
 <BN6PR02MB32825FDF8601D8A310C2270BC7B70@BN6PR02MB3282.namprd02.prod.outlook.com>
 <7f549d2e-fc96-8c7e-d839-edb86ae088a5@metafoo.de>
 <4ba085c7-5256-6c8a-5697-c0d5736a6e46@ti.com>
 <20180417154231.GV6014@localhost>
Message-ID: <9458b509-f3bd-2aae-58f6-24bc83629cb3@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/17/2018 05:42 PM, Vinod Koul wrote:
> On Tue, Apr 17, 2018 at 04:46:43PM +0300, Peter Ujfalusi wrote:
> 
>> @@ -709,6 +709,11 @@ struct dma_filter {
>>   *	be called after period_len bytes have been transferred.
>>   * @device_prep_interleaved_dma: Transfer expression in a generic way.
>>   * @device_prep_dma_imm_data: DMA's 8 byte immediate data to the dst address
>> + * @device_attach_metadata: Some DMA engines can send and receive side band
>> + *	information, commands or parameters which is not transferred within the
>> + *	data stream itself. In such case clients can set the metadata to the
>> + *	given descriptor and it is going to be sent to the peripheral, or in
>> + *	case of DEV_TO_MEM the provided buffer will receive the metadata.
>>   * @device_config: Pushes a new configuration to a channel, return 0 or an error
>>   *	code
>>   * @device_pause: Pauses any transfer happening on a channel. Returns
>> @@ -796,6 +801,9 @@ struct dma_device {
>>  		struct dma_chan *chan, dma_addr_t dst, u64 data,
>>  		unsigned long flags);
>>  
>> +	int (*device_attach_metadata)(struct dma_async_tx_descriptor *desc,
>> +				      void *data, size_t len);
> 
> while i am okay with the concept, I would not want to go again the custom
> pointer route, this is a no-go for me.
> 
> Instead lets add the vendor data, define that explicitly. We can use struct,
> tokens or something else to define these. But lets try to stay away from
> opaque objects please :-)

Well, for all the DMA core cares about the meta-data stream would be as
opaque as the data stream itself. The data is in the end client specific. It
is data that sits somewhere in memory that should be send along with the
actual data to the client.
