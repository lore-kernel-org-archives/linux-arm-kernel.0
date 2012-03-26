From: tsoni@codeaurora.org (Trilok Soni)
Date: Mon, 26 Mar 2012 12:25:56 +0530
Subject: [PATCH v5 1/2] dmaengine: Add context parameter to prep_dma_sg
 and prep_interleaved_dma
In-Reply-To: <1332743073.19804.26.camel@vkoul-udesk3>
References: <1332426167-25213-1-git-send-email-kumarrav@codeaurora.org>
 <1332743073.19804.26.camel@vkoul-udesk3>
Message-ID: <4F7012FC.10203@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/26/2012 11:54 AM, Vinod Koul wrote:
> On Thu, 2012-03-22 at 19:52 +0530, Ravi Kumar V wrote:
>> Add new context parameter to DMA SG and Interleaveid mode for passing
> Typo					  ^^^^^^^^^^^^

Sorry, we will fix this.

>> diff --git a/drivers/misc/carma/carma-fpga-program.c b/drivers/misc/carma/carma-fpga-program.c
>> index a2d25e4..3739a12 100644
>> --- a/drivers/misc/carma/carma-fpga-program.c
>> +++ b/drivers/misc/carma/carma-fpga-program.c
>> @@ -530,7 +530,7 @@ static noinline int fpga_program_dma(struct fpga_dev *priv)
>>   	}
>>
>>   	/* setup and submit the DMA transaction */
>> -	tx = chan->device->device_prep_dma_sg(chan,
>> +	tx = chan->device->dmaengine_prep_dma_sg(chan,
>>   					      table.sgl, num_pages,
>>   					      vb->sglist, vb->sglen, 0);
> No the idea is that clients will not know anything about additionlay
> parameter hence avoiding abuse. You need to reread the patches sent by
> Alexandre.
>
> You need to
> 1) add wrappers over interleaved api which dont expose this additional
> parameter
> 2) move existing users to use these wrappers

Above two steps would be exactly same as 
https://lkml.org/lkml/2012/3/8/401 - [PATCH 1/2 V2] dmaengine/dma_slave: 
introduce inline wrappers, right?

> 3) add a new API which has your additional argument (not an opaque
> object) and this calls .device_xx callback with additional arg.
> 4. Above can be under conditional of your specific subsystem where these
> parameters are valid.

Now, this would be different from what Alexandre had submitted, since he 
had added "void *context" parameter directly to existing callbacks 
dma_slave_sg and and cyclic under struct dma_device.

And you prefer that we add new callbacks under "struct dma_device" for 
our specific requirement with new name and with that extra non-opaque 
object. After that add wrappers for these two new callbacks say
dmaengine_prep_dma_sg_ext and dmagengine_prep_interleaved_dma_ext (same
name goes for callback).

---Trilok Soni

-- 
--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
