From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Tue, 17 Jan 2017 09:05:14 +0100
Subject: [PATCH v2 2/3] spi: pxa2xx: Prepare for edge-triggered interrupts
In-Reply-To: <87ziiqdstr.fsf@belgarion.home>
References: <cover.1484592296.git.jan.kiszka@siemens.com>
 <cover.1484592296.git.jan.kiszka@siemens.com>
 <7b15a0910a3ad861fd32161c72559bafa7b71e29.1484592296.git.jan.kiszka@siemens.com>
 <87ziiqdstr.fsf@belgarion.home>
Message-ID: <4d97e416-4d32-3b9f-0695-de116a4b26bd@siemens.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017-01-17 08:54, Robert Jarzmik wrote:
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> 
>> When using the a device with edge-triggered interrupts, such as MSIs,
>> the interrupt handler has to ensure that there is a point in time during
>> its execution where all interrupts sources are silent so that a new
>> event can trigger a new interrupt again.
>>
>> This is achieved here by looping over SSSR evaluation. We need to take
>> into account that SSCR1 may be changed by the transfer handler, thus we
>> need to redo the mask calculation, at least regarding the volatile
>> interrupt enable bit (TIE).
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> Hi Jan,
> 
>> +	while (1) {
> This bit worries me a bit, as this can be either :
>  - hogging the SoC's CPU, endlessly running
>  - or even worse, blocking the CPU for ever
> 
> The question behind is, should this be done in a top-half, or moved to a irq
> thread ?

Every device with a broken interrupt source can hog CPUs, nothing
special with this one. If you don't close the loop in the handler
itself, you close it over the hardware retriggering the interrupt over
and over again.

So, I don't see a point in offloading to a thread. The normal case is
some TX done (FIFO available) event followed by an RX event, then the
transfer is complete, isn't it?

> 
>> +		/* Ignore possible writes if we don't need to write */
>> +		if (!(sccr1_reg & SSCR1_TIE))
>> +			mask &= ~SSSR_TFS;
>>  
>> -	if (!drv_data->master->cur_msg) {
>> -		handle_bad_msg(drv_data);
>> -		/* Never fail */
>> -		return IRQ_HANDLED;
>> -	}
>> +		if (!(status & mask))
>> +			return ret;
>> +
>> +		if (!drv_data->master->cur_msg) {
>> +			handle_bad_msg(drv_data);
>> +			/* Never fail */
>> +			return IRQ_HANDLED;
>> +		}
>> +
>> +		ret |= drv_data->transfer_handler(drv_data);
> Mmm that looks weird to me, oring a irqreturn.

Not really an uncommon pattern, though.

> 
> Imagine that on first iteration the handler returns IRQ_NONE, and on second
> IRQ_HANDLED. This makes ret IRQ_HANDLED. Yet after the first iteration the
> handler should have exited, especially if the interrupt is shared with another
> driver.

That would be a bug in transfer_handler, because we don't enter it
without a reason (status != 0).

> 
> Another thing which is along what Andy already said : it would be better
> practice to have this loop in the form :
> do {
> ...
> } while (exit_condition_not_met);

This implies code duplication in order to calculate the condition
(mask...). I can do this if desired, I wouldn't do this to my own code,
though.

Jan

> 
> Just for maintainability, it's better, and it concentrates the test on the
> "exit_condition_not_met" in one place, which will enable us to review better the
> algorithm.
> 
> Cheers.
> 


-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux
