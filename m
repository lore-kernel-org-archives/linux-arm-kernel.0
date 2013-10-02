From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 2 Oct 2013 11:59:21 +0200
Subject: [PATCH] serial: mxs-auart: wait for DMA buffer to flush before
 shutdown
In-Reply-To: <524BDD64.70309@digi.com>
References: <1380644315-31581-1-git-send-email-hector.palacios@digi.com>
 <20131001194800.GL2548@pengutronix.de> <524BCBC4.5050708@digi.com>
 <20131002074436.GM2548@pengutronix.de> <524BD4A6.5060208@digi.com>
 <20131002083014.GN2548@pengutronix.de> <524BDD64.70309@digi.com>
Message-ID: <20131002095921.GP2548@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hector,

On Wed, Oct 02, 2013 at 10:46:28AM +0200, Hector Palacios wrote:
> On 10/02/2013 10:30 AM, Uwe Kleine-K?nig wrote:
> >On Wed, Oct 02, 2013 at 10:09:10AM +0200, Hector Palacios wrote:
> >>On 10/02/2013 09:44 AM, Uwe Kleine-K?nig wrote:
> >>>Ah, right. (BTW, uart_update_timeout should better round up instead of
> >>>round down, i.e.
> >>>-	port->timeout = (HZ * bits) / baud + HZ/50;
> >>>+	port->timeout = DIV_ROUND_UP(HZ * bits, baud) + HZ/50;
> >>>)
> >>>
> >>>>UART_XMIT_SIZE is the number of bytes in the DMA buffer, so I divide
> >>>>the max number of bytes in the FIFO by the FIFO size and multiply by
> >>>>the FIFO timeout.
> >>>ditto here, better round up. Although I think using a completion could
> >>>shorten the timeout considerably because there are often less than
> >>>UART_XMIT_SIZE chars in the buffer?!
> >>
> >>I'm not really waiting the full timeout. I'm checking for TX fifo
> >>empty every 1ms and for a maximum of 'to' ms.
> >Correct. Still using DIV_ROUND_UP would be better, right?
> 
> I think it is not really needed, after all the code is adding HZ/50
> of slop which acts like a round up, doesn't it?
> 
> 	/*
> 	 * Figure the timeout to send the above number of bits.
> 	 * Add .02 seconds of slop
> 	 */
> 	port->timeout = (HZ * bits) / baud + HZ/50;
According to my understanding (which could well be wrong) the slop of
HZ/50 isn't there to fix rounding issues in the previous division. But
yes, if it's calculated generously there is no technical need to fix the
rounding issue.

Still it might be worth to fix it to be a better reference. I don't care
much.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
