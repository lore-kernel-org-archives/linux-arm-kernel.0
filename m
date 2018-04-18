From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Wed, 18 Apr 2018 09:39:00 +0300
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
Message-ID: <994c184c-e915-7735-5a8b-81a02c5449b0@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2018-04-17 18:42, Vinod Koul wrote:
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

The DMA does not interpret the metadata, it is information which can be
only understood by the client driver and the remote peripheral. It is
just chunk of data (parameters, timestamps, keys, etc) that needs to
travel along with the payload.

The content is not relevant for the DMA itself.

- P?ter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
