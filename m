From: w.sang@pengutronix.de (Wolfram Sang)
Date: Sun, 20 Mar 2011 20:24:52 +0100
Subject: [PATCH 2/2] ARM: mx5/mx53_evk: Remove unneeded gpio_set_value call
In-Reply-To: <Pine.LNX.4.64.1103201850250.27008@ask.diku.dk>
References: <1300126869-14587-1-git-send-email-fabio.estevam@freescale.com>
	<1300126869-14587-2-git-send-email-fabio.estevam@freescale.com>
	<20110315090656.GC13316@pengutronix.de>
	<Pine.LNX.4.64.1103151039030.11859@ask.diku.dk>
	<20110315094946.GD13316@pengutronix.de>
	<Pine.LNX.4.64.1103151113420.8560@pc-004.diku.dk>
	<20110316083326.GF13316@pengutronix.de>
	<Pine.LNX.4.64.1103201850250.27008@ask.diku.dk>
Message-ID: <20110320192451.GA19808@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Julia,

> What is the degree of interest in having gpio_request_one be used?  Right 
> now, it is very little used.  But there seem to be over 900 places where 
> it could be used.

I have a very high interest in getting it more known/used.

> One advantage of gpio_request_one is that it manages error handling.  

Yes, that's what I like about it; checks for two errors in one call
(especially the latter one is often forgotten in current code).

> However a number of current calls to gpio_request and 
> gpio_direction_input/output don't save or test the return value.  Are 
> there cases where these operations cannot fail?

It is a mixture of pragmatism and lazyness. For board setup code, mostly
CPU-internal GPIOs are used and one can assume that they are always there
because they are often set up in the same file. I wouldn't mind the error
checks to catch the 0.00001% chance of it failing for whatever reason (most
probably a careless update); still, the error checks have to be added by hand,
because you need to know something about the board to handle the error
correctly (igonre it? stop booting?).

For device drivers, the checks really should be made because one cannot assume
anything about the GPIOs passed by platform data. The problem here is that you
cannot use gpio_request_one yet because it is not available yet with !GPIOLIB.
I have sent a patch [1] to fix it, but Grant needs some more time to review. If
he accepts it, I wanted to clean up the drivers as a first step (with
coccinelle surely involved ;)).

Regards,

   Wolfram

[1] <1297530239-7429-1-git-send-email-w.sang@pengutronix.de>

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 197 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110320/dc5e6c2e/attachment.sig>
