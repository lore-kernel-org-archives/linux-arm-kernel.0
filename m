From: romain.perier@collabora.com (Romain Perier)
Date: Tue, 4 Jul 2017 10:55:45 +0200
Subject: [PATCH 1/7] serial: imx: only set DMA rx-ing when DMA starts
In-Reply-To: <20170703064840.pttfudcv7xsnbki3@pengutronix.de>
References: <20170630120446.13994-1-romain.perier@collabora.com>
 <20170630120446.13994-2-romain.perier@collabora.com>
 <20170703064840.pttfudcv7xsnbki3@pengutronix.de>
Message-ID: <709d972a-aae5-e487-958f-48abefd06ebc@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,


Le 03/07/2017 ? 08:48, Uwe Kleine-K?nig a ?crit :
> Hello,
>
> On Fri, Jun 30, 2017 at 02:04:40PM +0200, Romain Perier wrote:
>> From: Nandor Han <nandor.han@ge.com>
>>
>> Avoid the situation when `dma_is_rxing` could incorrectly signal that
>> DMA RX channel is receiving data in case DMA preparation or sg mapping
>> fails.
> Just from reading the commit log and the patch I didn't understand the
> problem that is supposed to be fixed here. After looking at it for some
> I understood. I don't suggest a new commit log here as it has to look
> different if you pick up my comment below.
>
>> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
>> index 5437b34..1d35293 100644
>> --- a/drivers/tty/serial/imx.c
>> +++ b/drivers/tty/serial/imx.c
>> @@ -725,11 +725,11 @@ static irqreturn_t imx_rxint(int irq, void *dev_id)
>>  	return IRQ_HANDLED;
>>  }
>>  
>> -static void imx_disable_rx_int(struct imx_port *sport)
>> +static void imx_disable_rx_int(struct imx_port *sport, bool is_rxing)
>>  {
>>  	unsigned long temp;
>>  
>> -	sport->dma_is_rxing = 1;
>> +	sport->dma_is_rxing = is_rxing;
>>  
>>  	/* disable the receiver ready and aging timer interrupts */
>>  	temp = readl(sport->port.membase + UCR1);
>> @@ -762,7 +762,7 @@ static void imx_dma_rxint(struct imx_port *sport)
>>  	temp = readl(sport->port.membase + USR2);
>>  	if ((temp & USR2_RDR) && !sport->dma_is_rxing) {
>>  
>> -		imx_disable_rx_int(sport);
>> +		imx_disable_rx_int(sport, false);
>>  
>>  		/* tell the DMA to receive the data. */
>>  		start_rx_dma(sport);
>> @@ -1083,6 +1083,7 @@ static int start_rx_dma(struct imx_port *sport)
>>  	desc->callback_param = sport;
>>  
>>  	dev_dbg(dev, "RX: prepare for the DMA.\n");
>> +	sport->dma_is_rxing = 1;
>>  	sport->rx_cookie = dmaengine_submit(desc);
>>  	dma_async_issue_pending(chan);
>>  	return 0;
>> @@ -1362,7 +1363,7 @@ static int imx_startup(struct uart_port *port)
>>  		spin_unlock(&tty->files_lock);
>>  
>>  		if (readcnt > 0) {
>> -			imx_disable_rx_int(sport);
>> +			imx_disable_rx_int(sport, true);
> I wonder if it would be saner to not assign to dma_is_rxing in
> imx_disable_rx_int() at all but do this only in start_rx_dma() and
> imx_dma_rxint().

It was "mostly" done, in 4.11 in fact.  dma_is_rxing was set to 0 from
imx_dma_rxint() and was not set
at all from start_rx_dma(), resulting to the same issue. We could move
assignment of dma_is_rxing out of imx_disable_rx_int()
and set it to one from start_rx_dma() only. What do you think ?

Best Regards,
Romain

>
> Best regards
> Uwe
>
