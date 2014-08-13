From: ronald.wahl@raritan.com (Ronald Wahl)
Date: Wed, 13 Aug 2014 10:20:15 +0200
Subject: [PATCH] spi: atmel: fix corruption caused by too early transfer
 completion
In-Reply-To: <B256D81BAE5131468A838E5D7A2436419D1F2032@penmbx01>
References: <1407330035-2212-1-git-send-email-ronald.wahl@raritan.com>
 <B256D81BAE5131468A838E5D7A2436419D1F2032@penmbx01>
Message-ID: <53EB1FBF.9050807@raritan.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13.08.2014 03:20, Yang, Wenyou wrote:
> Hi,
>> -----Original Message-----
>> From: linux-arm-kernel [mailto:linux-arm-kernel-bounces at lists.infradead.org] On
>> Behalf Of Ronald Wahl
>> Sent: Wednesday, August 06, 2014 9:01 PM
>> To: linux-arm-kernel at lists.infradead.org
>> Subject: [PATCH] spi: atmel: fix corruption caused by too early transfer
>> completion
>>
>> The PDC (peripheral DMA controller) on AT91 supports two transfer counters and
>> associated registers - one for current and one for the next transfer. If the current
>> transfer is done the next transfer is moved into the current transfer. Now there are
>> two interrupts: one is raised whenever a single transfer is done (ENDRX) and the
>> other one is raised when the current and the next transfer has finished (RXBUFF).
>> The issue is that the driver only enables the ENDRX interrupt which may lead to
>> queuing a new request while there is still a transfer running.
>> This can lead to overruns and/or corruption. By using the RXBUFF interrupt only
>> we queue new requests only when the hardware queue is empty avoiding this
>> problem.
>
> The patch can work, but it maybe decrease the performance.
>
> Could you share the scenario caused the overruns and/or corruption, or log message?

The problem is that without the patch the interrupt handler signals 
completion of the transfer while the next transfer registers are moved 
into the primary transfer registers hence PDC is still active. This 
happens only when the amount of data was large enough so that the next 
transfer register is used. Since we signaled completion the driver can 
schedule the next transfer which then would overwrite (corrupt) the 
possibly still running transfer.

In my specific case a JFFS2 filesystem has been corrupted while 
accessing a cramfs on the same flash chip. The former uses small 
requests that can run as a single pdc spi transfer but the latter used 
16kB transfer requests that are split into 4 pdc spi transfers of 4k each.

>> Signed-off-by: Ronald Wahl <ronald.wahl@raritan.com>
>> ---
>>   drivers/spi/spi-atmel.c | 17 ++++++++---------
>>   1 file changed, 8 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c index 113c83f..3f7d138
>> 100644
>> --- a/drivers/spi/spi-atmel.c
>> +++ b/drivers/spi/spi-atmel.c
>> @@ -775,17 +775,17 @@ static void atmel_spi_pdc_next_xfer(struct spi_master
>> *master,
>>   			(unsigned long long)xfer->rx_dma);
>>   	}
>>
>> -	/* REVISIT: We're waiting for ENDRX before we start the next
>> +	/* REVISIT: We're waiting for RXBUFF before we start the next
>>   	 * transfer because we need to handle some difficult timing
>> -	 * issues otherwise. If we wait for ENDTX in one transfer and
>> -	 * then starts waiting for ENDRX in the next, it's difficult
>> -	 * to tell the difference between the ENDRX interrupt we're
>> -	 * actually waiting for and the ENDRX interrupt of the
>> +	 * issues otherwise. If we wait for TXBUFE in one transfer and
>> +	 * then starts waiting for RXBUFF in the next, it's difficult
>> +	 * to tell the difference between the RXBUFF interrupt we're
>> +	 * actually waiting for and the RXBUFF interrupt of the
>>   	 * previous transfer.
>>   	 *
>>   	 * It should be doable, though. Just not now...
>>   	 */
>> -	spi_writel(as, IER, SPI_BIT(ENDRX) | SPI_BIT(OVRES));
>> +	spi_writel(as, IER, SPI_BIT(RXBUFF) | SPI_BIT(OVRES));
>>   	spi_writel(as, PTCR, SPI_BIT(TXTEN) | SPI_BIT(RXTEN));  }
>>
>> @@ -956,8 +956,7 @@ atmel_spi_pdc_interrupt(int irq, void *dev_id)
>>
>>   		ret = IRQ_HANDLED;
>>
>> -		spi_writel(as, IDR, (SPI_BIT(RXBUFF) | SPI_BIT(ENDRX)
>> -				     | SPI_BIT(OVRES)));
>> +		spi_writel(as, IDR, (SPI_BIT(RXBUFF) | SPI_BIT(OVRES)));
>>
>>   		/* Clear any overrun happening while cleaning up */
>>   		spi_readl(as, SR);
>> @@ -966,7 +965,7 @@ atmel_spi_pdc_interrupt(int irq, void *dev_id)
>>
>>   		complete(&as->xfer_completion);
>>
>> -	} else if (pending & (SPI_BIT(RXBUFF) | SPI_BIT(ENDRX))) {
>> +	} else if (pending & (SPI_BIT(RXBUFF))) {
>>   		ret = IRQ_HANDLED;
>>
>>   		spi_writel(as, IDR, pending);
>> --
>> 1.9.3
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
> Best Regards,
> Wenyou Yang
>

-- 
Ronald Wahl - ronald.wahl at raritan.com - Phone +49 375271349-0 Fax -99
Raritan Deutschland GmbH, Kornmarkt 7, 08056 Zwickau, Germany
USt-IdNr. DE813094160, Steuer-Nr. 227/117/01749
Amtsgericht Chemnitz HRB 23605
Gesch?ftsf?hrung: Stuart Hopper, Ralf Ploenes
