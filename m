From: ronald.wahl@raritan.com (Ronald Wahl)
Date: Wed, 13 Aug 2014 11:38:27 +0200
Subject: [PATCH] spi: atmel: fix corruption caused by too early transfer
 completion
In-Reply-To: <20140813091650.GH2452@ldesroches-Latitude-E6320>
References: <1407330035-2212-1-git-send-email-ronald.wahl@raritan.com>
 <B256D81BAE5131468A838E5D7A2436419D1F2032@penmbx01>
 <20140813061638.GF2452@ldesroches-Latitude-E6320>
 <B256D81BAE5131468A838E5D7A2436419D1F4087@penmbx01>
 <20140813081346.GG2452@ldesroches-Latitude-E6320>
 <53EB213F.60207@raritan.com>
 <20140813091650.GH2452@ldesroches-Latitude-E6320>
Message-ID: <53EB3213.5070905@raritan.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 13.08.2014 11:16, Ludovic Desroches wrote:
> On Wed, Aug 13, 2014 at 10:26:39AM +0200, Ronald Wahl wrote:
>>
>>
>> On 13.08.2014 10:13, Desroches, Ludovic wrote:
>>> On Wed, Aug 13, 2014 at 09:05:22AM +0200, Yang, Wenyou wrote:
>>>>
>>>>
>>>>> -----Original Message-----
>>>>> From: Ludovic Desroches [mailto:ludovic.desroches at atmel.com]
>>>>> Sent: Wednesday, August 13, 2014 2:17 PM
>>>>> To: Yang, Wenyou
>>>>> Cc: Ronald Wahl; linux-arm-kernel at lists.infradead.org; Ferre, Nicolas
>>>>> Subject: Re: [PATCH] spi: atmel: fix corruption caused by too early transfer
>>>>> completion
>>>>>
>>>>> Hi,
>>>>>
>>>>> On Wed, Aug 13, 2014 at 01:20:13AM +0000, Yang, Wenyou wrote:
>>>>>> Hi,
>>>>>>> -----Original Message-----
>>>>>>> From: linux-arm-kernel
>>>>>>> [mailto:linux-arm-kernel-bounces at lists.infradead.org] On Behalf Of
>>>>>>> Ronald Wahl
>>>>>>> Sent: Wednesday, August 06, 2014 9:01 PM
>>>>>>> To: linux-arm-kernel at lists.infradead.org
>>>>>>> Subject: [PATCH] spi: atmel: fix corruption caused by too early
>>>>>>> transfer completion
>>>>>>>
>>>>>>> The PDC (peripheral DMA controller) on AT91 supports two transfer
>>>>>>> counters and associated registers - one for current and one for the
>>>>>>> next transfer. If the current transfer is done the next transfer is
>>>>>>> moved into the current transfer. Now there are two interrupts: one
>>>>>>> is raised whenever a single transfer is done (ENDRX) and the other one is
>>>>> raised when the current and the next transfer has finished (RXBUFF).
>>>>>>> The issue is that the driver only enables the ENDRX interrupt which
>>>>>>> may lead to queuing a new request while there is still a transfer running.
>>>>>>> This can lead to overruns and/or corruption. By using the RXBUFF
>>>>>>> interrupt only we queue new requests only when the hardware queue is
>>>>>>> empty avoiding this problem.
>>>>>>
>>>>>> The patch can work, but it maybe decrease the performance.
>>>>>
>>>>> Can you give more details? I had also the same feeling at the beginning but due to
>>>>> the way pdc is implemented in the spi driver (doesn't really take advantage of the
>>>>> double buffer), I think it should not change performances.
>>>> I am not sure, but the next transfer registers is used in the driver code
>>>
>>> Yes it is used but not in the optimal way. Here, we configure the
>>> transfer to send two buffers. Once done, we will do it again if needed.
>>>
>>> Taking advantage of the double buffer means when we receive ENDRX we
>>> immediately prepare the next transfer. Then we won't have dead time.
>>> Since it's not done in this way in the driver I don't think it will
>>> decrease performances.
>>
>> In kernel 3.10 the code was designed this way (programming next
>> transfer registers while a transfer was still running). Scheduling
>> the next transfer was happening from ENDRX interrupt context. The
>> only thing I'm not sure about is if it behaves correctly when the
>> primary transfer finishes but the driver thinks it is still running
>> and so only programs the next transfer. Will this transfer start?
>>
>
> I don't see in which case it can progam only the next transfer (on
> 3.16). It configures the primary transfer and the next transfer if there
> are remaining bytes but maybe I miss something.
 >
> In a general way, when using PDC, at the end of the primary transfer, if
> RNCR is not zero then RNPR and RNCR are copied to RPR and RCR. So yes,
> PDC will start the transfer.

Current driver design does not have this issue but also does not make 
efficient use of the double buffering. My question above was related to 
the driver design in 3.10 where the double buffering was used more 
effectively.

So what happens if primary and next transfer is RCR and RNCR are both 
already zero (hence no transfer running anymore) and only RNCR is 
programmed? I think this can happen in the old driver design in 3.10. I 
ask just because someone might want to rearrage the driver so that it 
uses the next transfer more effectively as it was in 3.10.

> Nevertheless, it will be safer to use RXBUFF before configuring PDC
> again because it can cause some corruption as you observed.
>
>>>>> My only concern is why ENDRX was chosen instead of RXBUFF? Simple bug or
>>>>> to manage a specific case we are thinking about.
>>>> Both the current transfer and the next transfer is done,  RXBUFF bit  is set.
>>>> Either the current transfer or the next transfer is done, ENDRX bit set.
>>>> I think it is OK.
>>>>
>>>>>
>>>>>>
>>>>>> Could you share the scenario caused the overruns and/or corruption, or log
>>>>> message?
>>>>>>
>>>>>>>
>>>>>>> Signed-off-by: Ronald Wahl <ronald.wahl@raritan.com>
>>>>>>> ---
>>>>>>>   drivers/spi/spi-atmel.c | 17 ++++++++---------
>>>>>>>   1 file changed, 8 insertions(+), 9 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c index
>>>>>>> 113c83f..3f7d138
>>>>>>> 100644
>>>>>>> --- a/drivers/spi/spi-atmel.c
>>>>>>> +++ b/drivers/spi/spi-atmel.c
>>>>>>> @@ -775,17 +775,17 @@ static void atmel_spi_pdc_next_xfer(struct
>>>>>>> spi_master *master,
>>>>>>>   			(unsigned long long)xfer->rx_dma);
>>>>>>>   	}
>>>>>>>
>>>>>>> -	/* REVISIT: We're waiting for ENDRX before we start the next
>>>>>>> +	/* REVISIT: We're waiting for RXBUFF before we start the next
>>>>>>>   	 * transfer because we need to handle some difficult timing
>>>>>>> -	 * issues otherwise. If we wait for ENDTX in one transfer and
>>>>>>> -	 * then starts waiting for ENDRX in the next, it's difficult
>>>>>>> -	 * to tell the difference between the ENDRX interrupt we're
>>>>>>> -	 * actually waiting for and the ENDRX interrupt of the
>>>>>>> +	 * issues otherwise. If we wait for TXBUFE in one transfer and
>>>>>>> +	 * then starts waiting for RXBUFF in the next, it's difficult
>>>>>>> +	 * to tell the difference between the RXBUFF interrupt we're
>>>>>>> +	 * actually waiting for and the RXBUFF interrupt of the
>>>>>>>   	 * previous transfer.
>>>>>>>   	 *
>>>>>>>   	 * It should be doable, though. Just not now...
>>>>>>>   	 */
>>>>>>> -	spi_writel(as, IER, SPI_BIT(ENDRX) | SPI_BIT(OVRES));
>>>>>>> +	spi_writel(as, IER, SPI_BIT(RXBUFF) | SPI_BIT(OVRES));
>>>>>>>   	spi_writel(as, PTCR, SPI_BIT(TXTEN) | SPI_BIT(RXTEN));  }
>>>>>>>
>>>>>>> @@ -956,8 +956,7 @@ atmel_spi_pdc_interrupt(int irq, void *dev_id)
>>>>>>>
>>>>>>>   		ret = IRQ_HANDLED;
>>>>>>>
>>>>>>> -		spi_writel(as, IDR, (SPI_BIT(RXBUFF) | SPI_BIT(ENDRX)
>>>>>>> -				     | SPI_BIT(OVRES)));
>>>>>>> +		spi_writel(as, IDR, (SPI_BIT(RXBUFF) | SPI_BIT(OVRES)));
>>>>>>>
>>>>>>>   		/* Clear any overrun happening while cleaning up */
>>>>>>>   		spi_readl(as, SR);
>>>>>>> @@ -966,7 +965,7 @@ atmel_spi_pdc_interrupt(int irq, void *dev_id)
>>>>>>>
>>>>>>>   		complete(&as->xfer_completion);
>>>>>>>
>>>>>>> -	} else if (pending & (SPI_BIT(RXBUFF) | SPI_BIT(ENDRX))) {
>>>>>>> +	} else if (pending & (SPI_BIT(RXBUFF))) {
>>>>>>>   		ret = IRQ_HANDLED;
>>>>>>>
>>>>>>>   		spi_writel(as, IDR, pending);
>>>>>>> --
>>>>>>> 1.9.3
>>>>>>>
>>>>>>>
>>>>>>> _______________________________________________
>>>>>>> linux-arm-kernel mailing list
>>>>>>> linux-arm-kernel at lists.infradead.org
>>>>>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>>>>>
>>>>>> Best Regards,
>>>>>> Wenyou Yang
>>>>>>
>>>>>> _______________________________________________
>>>>>> linux-arm-kernel mailing list
>>>>>> linux-arm-kernel at lists.infradead.org
>>>>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>>
>>
>> --
>> Ronald Wahl - ronald.wahl at raritan.com - Phone +49 375271349-0 Fax -99
>> Raritan Deutschland GmbH, Kornmarkt 7, 08056 Zwickau, Germany
>> USt-IdNr. DE813094160, Steuer-Nr. 227/117/01749
>> Amtsgericht Chemnitz HRB 23605
>> Gesch?ftsf?hrung: Stuart Hopper, Ralf Ploenes
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>

-- 
Ronald Wahl - ronald.wahl at raritan.com - Phone +49 375271349-0 Fax -99
Raritan Deutschland GmbH, Kornmarkt 7, 08056 Zwickau, Germany
USt-IdNr. DE813094160, Steuer-Nr. 227/117/01749
Amtsgericht Chemnitz HRB 23605
Gesch?ftsf?hrung: Stuart Hopper, Ralf Ploenes
