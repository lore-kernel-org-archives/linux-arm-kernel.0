From: b32955@freescale.com (Huang Shijie)
Date: Mon, 28 Mar 2011 10:04:14 +0800
Subject: [ PATCH V2 4/7] MTD : add the common code for GPMI controller
	driver
In-Reply-To: <20110326000148.GB13574@n2100.arm.linux.org.uk>
References: <1301048581-21321-1-git-send-email-b32955@freescale.com>
	<1301048581-21321-5-git-send-email-b32955@freescale.com>
	<20110326000148.GB13574@n2100.arm.linux.org.uk>
Message-ID: <4D8FEC9E.1000900@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi:

> On Fri, Mar 25, 2011 at 06:22:58PM +0800, Huang Shijie wrote:
>> +/* Can we use the upper's buffer directly for DMA? */
>> +void prepare_data_dma(struct gpmi_nfc_data *this, enum dma_data_direction dr)
>> +{
>> +	struct mil *mil =&this->mil;
>> +	struct scatterlist *sgl =&mil->data_sgl;
>> +	int ret;
>> +
>> +	mil->direct_dma_map_ok = true;
>> +
>> +	/* first try to map the upper buffer directly */
>> +	sg_init_one(sgl, mil->upper_buf, mil->upper_len);
>> +	ret = dma_map_sg(this->dev, sgl, 1, dr);
>> +	if (ret == 0) {
>> +		/* We have to use our own DMA buffer. */
>> +		sg_init_one(sgl, mil->data_buffer_dma, PAGE_SIZE);
>> +		ret = dma_map_sg(this->dev, sgl, 1, dr);
>> +		BUG_ON(ret == 0);
>> +
>> +		if (dr == DMA_TO_DEVICE)
>> +			memcpy(mil->data_buffer_dma, mil->upper_buf,
>> +				mil->upper_len);
> Buggy.  Ensure data is present in the buffers _before_ mapping.
>
thanks.

>> +	case DMA_FOR_READ_DATA:
>> +		if (mil->direct_dma_map_ok == false)
>> +			memcpy(mil->upper_buf, (char *)mil->data_buffer_dma,
>> +				mil->upper_len);
>> +		dma_unmap_sg(this->dev,&mil->data_sgl, 1, DMA_FROM_DEVICE);
> Buggy.  Only read data from buffers _after_ unmapping.
>
thanks.

Best Regards
Huang Shijie
