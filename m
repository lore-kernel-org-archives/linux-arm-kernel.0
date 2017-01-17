From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Tue, 17 Jan 2017 19:52:19 +0100
Subject: [PATCH v2 2/3] spi: pxa2xx: Prepare for edge-triggered interrupts
In-Reply-To: <7fd7a8eb-4302-523b-08dd-f2a28b845a5e@siemens.com>
References: <cover.1484592296.git.jan.kiszka@siemens.com>
 <7b15a0910a3ad861fd32161c72559bafa7b71e29.1484592296.git.jan.kiszka@siemens.com>
 <1484593637.2133.152.camel@linux.intel.com>
 <7fd7a8eb-4302-523b-08dd-f2a28b845a5e@siemens.com>
Message-ID: <4253af0f-b2ea-a8ea-0f34-c7c5bc6555f9@siemens.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017-01-16 20:46, Jan Kiszka wrote:
> On 2017-01-16 20:07, Andy Shevchenko wrote:
>> On Mon, 2017-01-16 at 19:44 +0100, Jan Kiszka wrote:
>>> When using the a device with edge-triggered interrupts, such as MSIs,
>>> the interrupt handler has to ensure that there is a point in time
>>> during
>>> its execution where all interrupts sources are silent so that a new
>>> event can trigger a new interrupt again.
>>>
>>> This is achieved here by looping over SSSR evaluation. We need to take
>>> into account that SSCR1 may be changed by the transfer handler, thus
>>> we
>>> need to redo the mask calculation, at least regarding the volatile
>>> interrupt enable bit (TIE).
>>>
>>
>> So, more comments/questions below.
>>
>>>  
>>>  	sccr1_reg = pxa2xx_spi_read(drv_data, SSCR1);
>>>  
>>> -	/* Ignore possible writes if we don't need to write */
>>> -	if (!(sccr1_reg & SSCR1_TIE))
>>> -		mask &= ~SSSR_TFS;
>>> -
>>>  	/* Ignore RX timeout interrupt if it is disabled */
>>>  	if (!(sccr1_reg & SSCR1_TINTE))
>>>  		mask &= ~SSSR_TINT;
>>>  
>>> -	if (!(status & mask))
>>> -		return IRQ_NONE;
>>> +	while (1) {
>>
>> Can we switch to do-while and move previous block here?
> 
> Don't see how this would help (without duplicating more code).
> 
>> Btw, can TINTE
>> bit be set again during a loop?
> 
> Nope, it's statically set, at least so far.
> 
> What we could do is simply restarting ssp_int
> 
>>
>>> +		/* Ignore possible writes if we don't need to write
>>> */
>>> +		if (!(sccr1_reg & SSCR1_TIE))
>>> +			mask &= ~SSSR_TFS;
>>>  
>>> -	if (!drv_data->master->cur_msg) {
>>> -		handle_bad_msg(drv_data);
>>> -		/* Never fail */
>>> -		return IRQ_HANDLED;
>>> -	}
>>> +		if (!(status & mask))
>>> +			return ret;
>>> +
>>> +		if (!drv_data->master->cur_msg) {
>>> +			handle_bad_msg(drv_data);
>>> +			/* Never fail */
>>> +			return IRQ_HANDLED;
>>> +		}
>>> +
>>
>>> +		ret |= drv_data->transfer_handler(drv_data);
>>
>> So, we might call handler several times. This needs to be commented in
>> the code why you do so.
> 
> I can move the commit log into the code.
> 
>>
>>>  
>>> -	return drv_data->transfer_handler(drv_data);
>>> +		status = pxa2xx_spi_read(drv_data, SSSR);
>>
>> Would it be possible to get all 1:s from the register
>> (something/autosuspend just powered off it by timeout?) ?
>>
> 
> Not sure if that can happen, but I guess it would be simpler and more
> readable to simply do this instead:
> 
> 	while (1) {
> 		/*
> 		 * If the device is not yet in RPM suspended state and we get an
> 		 * interrupt that is meant for another device, check if status
> 		 * bits are all set to one. That means that the device is
> 		 * already powered off.
> 		 */
> 		status = pxa2xx_spi_read(drv_data, SSSR);
> 		if (status == ~0)
> 			return ret;
> 
> 		sccr1_reg = pxa2xx_spi_read(drv_data, SSCR1);
> 
> 		/* Ignore RX timeout interrupt if it is disabled */
> 		if (!(sccr1_reg & SSCR1_TINTE))
> 			mask &= ~SSSR_TINT;
> 
> 		/* Ignore possible writes if we don't need to write */
> 		if (!(sccr1_reg & SSCR1_TIE))
> 			mask &= ~SSSR_TFS;
> 
> 		if (!(status & mask))
> 			return ret;
> 
> 		if (!drv_data->master->cur_msg) {
> 			handle_bad_msg(drv_data);
> 			/* Never fail */
> 			return IRQ_HANDLED;
> 		}
> 
> 		ret |= drv_data->transfer_handler(drv_data);
> 	}
> 
> 
> i.e. preserve the current structure, just add the loop.
> 

OK, please let me know if you want a v3 of this patch with the structure
above. If there are further concerns/questions, just let me know as
well, but I'd like to close this topic if possible.

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux
