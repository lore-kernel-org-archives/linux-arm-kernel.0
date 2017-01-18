From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Wed, 18 Jan 2017 10:33:07 +0100
Subject: [PATCH v2 2/3] spi: pxa2xx: Prepare for edge-triggered interrupts
In-Reply-To: <87r340eq28.fsf@belgarion.home>
References: <cover.1484592296.git.jan.kiszka@siemens.com>
 <cover.1484592296.git.jan.kiszka@siemens.com>
 <7b15a0910a3ad861fd32161c72559bafa7b71e29.1484592296.git.jan.kiszka@siemens.com>
 <87ziiqdstr.fsf@belgarion.home>
 <4d97e416-4d32-3b9f-0695-de116a4b26bd@siemens.com>
 <87r340eq28.fsf@belgarion.home>
Message-ID: <b3e0d393-b841-1556-ddd2-5634f12b6f2c@siemens.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017-01-18 09:21, Robert Jarzmik wrote:
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> 
>> On 2017-01-17 08:54, Robert Jarzmik wrote:
>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>
>>>> When using the a device with edge-triggered interrupts, such as MSIs,
>>>> the interrupt handler has to ensure that there is a point in time during
>>>> its execution where all interrupts sources are silent so that a new
>>>> event can trigger a new interrupt again.
>>>>
>>>> This is achieved here by looping over SSSR evaluation. We need to take
>>>> into account that SSCR1 may be changed by the transfer handler, thus we
>>>> need to redo the mask calculation, at least regarding the volatile
>>>> interrupt enable bit (TIE).
>>>>
>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>> Hi Jan,
>>>
>>>> +	while (1) {
>>> This bit worries me a bit, as this can be either :
>>>  - hogging the SoC's CPU, endlessly running
>>>  - or even worse, blocking the CPU for ever
>>>
>>> The question behind is, should this be done in a top-half, or moved to a irq
>>> thread ?
>>
>> Every device with a broken interrupt source can hog CPUs, nothing
>> special with this one. If you don't close the loop in the handler
>> itself, you close it over the hardware retriggering the interrupt over
>> and over again.
> I'm not speaking of a broken interrupt source, I'm speaking of a broken code,
> such as in the handler, or broken status readback, or lack of understanding on
> the status register which may imply the while(1) to loop forever.
> 
>> So, I don't see a point in offloading to a thread. The normal case is
>> some TX done (FIFO available) event followed by an RX event, then the
>> transfer is complete, isn't it?
> The point is if you stay forever in the while(1) loop, you can at least have a
> print a backtrace (LOCKUP_DETECTOR).

I won't consider "debugability" as a good reason to move interrupt
handlers into threads. There should be real workload that requires
offloading or specific prioritization.

> 
>>> Imagine that on first iteration the handler returns IRQ_NONE, and on second
>>> IRQ_HANDLED. This makes ret IRQ_HANDLED. Yet after the first iteration the
>>> handler should have exited, especially if the interrupt is shared with another
>>> driver.
>>
>> That would be a bug in transfer_handler, because we don't enter it
>> without a reason (status != 0).
> Sure, but can you be sure that all the people modifying the code after you will
> see that also ? The other way will _force_ them to see it.
> 
>>> Another thing which is along what Andy already said : it would be better
>>> practice to have this loop in the form :
>>> do {
>>> ...
>>> } while (exit_condition_not_met);
>>
>> This implies code duplication in order to calculate the condition
>> (mask...). I can do this if desired, I wouldn't do this to my own code,
>> though.
> Okay, that's acceptable.
> Why not have something like this :
> 
> sccr1_reg = pxa2xx_spi_read(drv_data, SSCR1);
> if (!(sccr1_reg & SSCR1_TIE))
> 	mask &= ~SSSR_TFS;
> 
> /* Ignore RX timeout interrupt if it is disabled */
> if (!(sccr1_reg & SSCR1_TINTE))
> 	mask &= ~SSSR_TINT;
> 
> status = pxa2xx_spi_read(drv_data, SSR);
> while (status & mask) {
>    ... handlers etc ...
>    status = pxa2xx_spi_read(drv_data, SSR);
> };
> 
> There is a duplication of the status read, but that looks acceptable, and the
> mask calculation is moved out of the loop (this should be checked more
> thoroughly as it looked to me only probe() would change these values, yet I
> might be wrong).

Unfortunately, mask can change if SSCR1_TIE is cleared. So this is not
correct.

What would be an alternative to looping is masking (would be required
for threaded irq anyway - but then we won't need to loop in the first
place): disable all irq sources, check the status bits once, re-enable
according to a potentially updated set, leave the handler and let the
hardware call us again.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux
