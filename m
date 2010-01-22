From: w.sang@pengutronix.de (Wolfram Sang)
Date: Fri, 22 Jan 2010 12:49:35 +0100
Subject: [PATCH] serial imx.c: fix CTS trigger level lower to avoid
	lost chars
In-Reply-To: <20100122113130.GB10449@n2100.arm.linux.org.uk>
References: <1264109163-28739-1-git-send-email-valentin.longchamp@epfl.ch>
	<20100121220653.GA21010@pengutronix.de>
	<20100121221133.GA30419@n2100.arm.linux.org.uk>
	<4B597A82.4020906@epfl.ch> <20100122110701.GA15699@shareable.org>
	<20100122113130.GB10449@n2100.arm.linux.org.uk>
Message-ID: <20100122114934.GE4782@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> What you're assuming is that flow control was there to prevent overruns
> on the hardware receiver.  That's not the way it works on these devices;
> flow control is entirely managed in software - there is no hardware
> assistance.
> 
> The flow control implemented for non-FIFO and non-hardware assisted
> UARTs is purely to do with preventing the software buffer behind the
> UART from overflowing - it can't prevent the device's receiver buffering
> from overrunning.  (Non-FIFO devices have the shift register and a
> buffer register - complete reception of a second character before the
> first is read causes an overrun condition.)
> 
> If you have overruns on the receiver, that's an interrupt latency
> problem and its an error that's reported to the receiver side only.
> 
> Yes, later devices have the ability in hardware to deassert RTS when
> the receiver FIFO gets above a certain threshold to /help/ prevent
> overruns occuring when there's high interrupt latency - but normal
> system operation should still ensure that the FIFO is emptied in a
> timely manner.
> 
> They also gained the ability to stop the transmitter once CTS is
> deasserted, mainly because the transmitter FIFOs in these devices
> is soo large (maybe 32 to 128 bytes deep.)

Russell, thanks for this explanation. Patch seems principally OK to me, then.

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 197 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100122/5e70afe5/attachment-0001.sig>
