From: jingchang.lu@freescale.com (Jingchang Lu)
Date: Thu, 25 Sep 2014 06:42:00 +0000
Subject: [PATCHv3] dmaengine: fsl-edma: fixup reg offset and hw S/G
 support in big-endian model
In-Reply-To: <20140924130510.62d78440@ipc1.ka-ro>
References: <1411550642-12577-1-git-send-email-jingchang.lu@freescale.com>
 <20140924130510.62d78440@ipc1.ka-ro>
Message-ID: <7635751d171a401d88ce70f9adee88bb@BL2PR03MB467.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>-----Original Message-----
>From: Lothar Wa?mann [mailto:LW at KARO-electronics.de]
>Sent: Wednesday, September 24, 2014 7:05 PM
>To: Lu Jingchang-B35083
>Cc: vinod.koul at intel.com; linux at arm.linux.org.uk; arnd at arndb.de; linux-
>kernel at vger.kernel.org; dmaengine at vger.kernel.org; linux-arm-
>kernel at lists.infradead.org
>Subject: Re: [PATCHv3] dmaengine: fsl-edma: fixup reg offset and hw S/G
>support in big-endian model
>
>Hi,
>
>Jingchang Lu wrote:
>> The offset of all 8-/16-bit register in big-endian eDMA model are
>s/register/registers/
>
>> swapped in a 32-bit size opposite those in the little-endian model.
>>
>> The hardware Scatter/Gather requires the subsequent TCDs in memory to
>> be auto loaded should retain little endian independent of the register
>> endian model, the dma engine will do the swap if need.
>>
>> This patch also use regular assignment for tcd variables r/w instead
>> of with io function previously that may not always be true.
>>
>> Signed-off-by: Jingchang Lu <jingchang.lu@freescale.com>
>> ---
>> changes in v3:
>>  use unsigned long instead of u32 in reg offset swap cast to avoid
>warning.
>>
>> changes in v2:
>>  simplify register offset swap calculation.
>>  use regular assignment for tcd variables r/w instead of io function.
>>
>>  drivers/dma/fsl-edma.c | 106
>> ++++++++++++++++++++++++++-----------------------
>>  1 file changed, 57 insertions(+), 49 deletions(-)
>>
>> diff --git a/drivers/dma/fsl-edma.c b/drivers/dma/fsl-edma.c index
>> 3c5711d..9ca55ee 100644
>> --- a/drivers/dma/fsl-edma.c
>> +++ b/drivers/dma/fsl-edma.c
>> @@ -177,16 +177,10 @@ struct fsl_edma_engine {
>>  /*
>>   * R/W functions for big- or little-endian registers
>>   * the eDMA controller's endian is independent of the CPU core's endian.
>> + * for the big-endian IP module, the offset for 8-bit or 16-bit
>> + register
>s/for/For/
>
>> + * should also be swapped oposite to that in little-endian IP.
>s/oposite/opposite/
>
>[...]
>> @@ -459,20 +460,27 @@ static void fill_tcd_params(struct fsl_edma_engine
>*edma,
>>  	u16 csr = 0;
>>
>>  	/*
>> -	 * eDMA hardware SGs require the TCD parameters stored in memory
>> -	 * the same endian as the eDMA module so that they can be loaded
>> -	 * automatically by the engine
>> +	 * eDMA hardware SGs requires the TCDs to be auto loaded
>> +	 * in the little endian whenver the register endian model,
>"in little endian whatever the register endian model"
>
>> +	 * So we put the value in little endian in memory, waitting
>s/waitting/waiting/
>
>> +	 * for fsl_set_tcd_params doing the swap.
>fsl_set_tcd_params()
>
>
>
>Lothar Wa?mann
>--
Thanks, I will amend them in the next version patch.

Best Regards,
Jingchang
