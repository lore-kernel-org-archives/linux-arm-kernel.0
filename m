From: b32955@freescale.com (Huang Shijie)
Date: Thu, 31 Mar 2011 16:50:07 +0800
Subject: [PATCH V3 2/6] dmaengine: add interrupt check for GPMI controller
In-Reply-To: <19860.13566.651111.241538@ipc1.ka-ro>
References: <19858.62649.218523.984252@ipc1.ka-ro>	<1301554968-29066-1-git-send-email-b32955@freescale.com>
	<19860.13566.651111.241538@ipc1.ka-ro>
Message-ID: <4D94403F.6000000@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi:
> Hi,
>
> Huang Shijie writes:
>> The GPMI may have many DMA channels, such as the imx23 has
>> four DMA channels. All these DMA channels share the same interrupt.
>> Add the interrupt check for the GPMI, only the first DMA channel will
>> register the irq.
>>
>> Signed-off-by: Huang Shijie<b32955@freescale.com>
>> ---
>>   drivers/dma/mxs-dma.c |   36 ++++++++++++++++++++++++++++++++----
>>   1 files changed, 32 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
>> index 88aad4f..db36bf1 100644
>> --- a/drivers/dma/mxs-dma.c
>> +++ b/drivers/dma/mxs-dma.c
>> @@ -26,6 +26,8 @@
>>   #include<asm/irq.h>
>>   #include<mach/mxs.h>
>>   #include<mach/dma.h>
>> +#include<mach/mx23.h>
>> +#include<mach/mx28.h>
>>   #include<mach/common.h>
>>
>>   /*
>> @@ -306,6 +308,30 @@ static irqreturn_t mxs_dma_int_handler(int irq, void *dev_id)
>>   	return IRQ_HANDLED;
>>   }
>>
>> +/* The GPMI has several DMA channels, only the first can register the irq. */
>> +static bool irq_check(struct mxs_dma_chan *mxs_chan)
>> +{
>> +	int irq_num = mxs_chan->chan_irq;
>> +
>> +#ifdef CONFIG_SOC_IMX23
>> +	if (cpu_is_mx23()&&  irq_num == MX23_INT_GPMI_DMA) {
>> +		if (mxs_chan->chan.chan_id == MX23_DMA_GPMI0)
>> +			return true;
>> +		else
>> +			return false;
>> +	}
>> +#endif
>> +#ifdef CONFIG_SOC_IMX28
>> +	if (cpu_is_mx28()&&  irq_num == MX28_INT_GPMI_DMA) {
>> +		if (mxs_chan->chan.chan_id == MX28_DMA_GPMI0)
>> +			return true;
>> +		else
>> +			return false;
>> +	}
>> +#endif
>> +	return true;
>> +}
>>
> You should make the distinction based on the platform_id, which would
> save you the ugly ifdef's and cpu_is_... macros.
>
>
This in the DMA driver.
Do you want me to change the DMA driver to add the platform_id?
The DMA driver has already used the cpu_is_xx() macros.

Best Regards
Huang Shijie

> Lothar Wa?mann
