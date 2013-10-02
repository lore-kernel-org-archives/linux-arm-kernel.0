From: hector.palacios@digi.com (Hector Palacios)
Date: Wed, 2 Oct 2013 10:46:28 +0200
Subject: [PATCH] serial: mxs-auart: wait for DMA buffer to flush before
 shutdown
In-Reply-To: <20131002083014.GN2548@pengutronix.de>
References: <1380644315-31581-1-git-send-email-hector.palacios@digi.com>
 <20131001194800.GL2548@pengutronix.de> <524BCBC4.5050708@digi.com>
 <20131002074436.GM2548@pengutronix.de> <524BD4A6.5060208@digi.com>
 <20131002083014.GN2548@pengutronix.de>
Message-ID: <524BDD64.70309@digi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On 10/02/2013 10:30 AM, Uwe Kleine-K?nig wrote:
> Hello Hector,
>
> On Wed, Oct 02, 2013 at 10:09:10AM +0200, Hector Palacios wrote:
>> On 10/02/2013 09:44 AM, Uwe Kleine-K?nig wrote:
>>> On Wed, Oct 02, 2013 at 09:31:16AM +0200, Hector Palacios wrote:
>>>> On 10/01/2013 09:48 PM, Uwe Kleine-K?nig wrote:
>>>>> On Tue, Oct 01, 2013 at 06:18:35PM +0200, Hector Palacios wrote:
>>>>>> +		/* Wait enough time to flush DMA buffer completely */
>>>>>> +		to = u->timeout * UART_XMIT_SIZE / u->fifosize;
>>>>> u->timeout is the time needed to send one char, right? UART_XMIT_SIZE is
>>>>> the size of the circular buffer, fifosize is the size of the fifo. I
>>>>> don't get what you get by dividing by the fifosize. I would have
>>>>> expected something like:
>>>>>
>>>>> 	u->timeout * min(UART_XMIT_SIZE, u->fifosize)
>>>>>
>>>>> Can you explain, maybe in a comment along the code for the next person
>>>>> not understanding?
>>>>
>>>> u->timeout is *not* the time needed to send one char but the time
>>>> needed to flush the complete port fifo (see uart_update_timeout() in
>>>> serial_core.c where it is set).
>>> Ah, right. (BTW, uart_update_timeout should better round up instead of
>>> round down, i.e.
>>> -	port->timeout = (HZ * bits) / baud + HZ/50;
>>> +	port->timeout = DIV_ROUND_UP(HZ * bits, baud) + HZ/50;
>>> )
>>>
>>>> UART_XMIT_SIZE is the number of bytes in the DMA buffer, so I divide
>>>> the max number of bytes in the FIFO by the FIFO size and multiply by
>>>> the FIFO timeout.
>>> ditto here, better round up. Although I think using a completion could
>>> shorten the timeout considerably because there are often less than
>>> UART_XMIT_SIZE chars in the buffer?!
>>
>> I'm not really waiting the full timeout. I'm checking for TX fifo
>> empty every 1ms and for a maximum of 'to' ms.
> Correct. Still using DIV_ROUND_UP would be better, right?

I think it is not really needed, after all the code is adding HZ/50 of slop which acts 
like a round up, doesn't it?

	/*
	 * Figure the timeout to send the above number of bits.
	 * Add .02 seconds of slop
	 */
	port->timeout = (HZ * bits) / baud + HZ/50;

Best regards,
--
Hector Palacios
