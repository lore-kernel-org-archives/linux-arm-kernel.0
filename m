From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 11 May 2011 22:13:46 +0200
Subject: [PATCH] mmci: sync DATAEND irq with dma transfer done
In-Reply-To: <BANLkTikAZjUw5q6FnbwaD_HzTG8BYp9TRQ@mail.gmail.com>
References: <1303203754-1731-1-git-send-email-linus.walleij@stericsson.com>
	<20110419092049.GC22799@n2100.arm.linux.org.uk>
	<BANLkTik4mmJzYsOit-5vNzchtHVUyEL+jg@mail.gmail.com>
	<20110419120344.GG22799@n2100.arm.linux.org.uk>
	<BANLkTimrsn1MxY+L7_yt0b1LXmaXxpMHPg@mail.gmail.com>
	<20110428170342.GA17290@n2100.arm.linux.org.uk>
	<BANLkTikAZjUw5q6FnbwaD_HzTG8BYp9TRQ@mail.gmail.com>
Message-ID: <BANLkTinTwieS6Nng3vc+KnusAFdpczUoWw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/4/29 Martin Furmanski <martin.furmanski@gmail.com>:

[About waiting for the DMA engine to complete]

> Even this would be no guarantee. The callback is hopefully a guarantee
> that the clr has been asserted, but for the peripheral's state machine
> there is still an uncertain time left, so the callback is a guess as good as
> any other, although the reference point has been shifted forwards. Since the
> time is uncertain, might just add a suitable delay. Preferably based on VHDL
> analysis and as a function of peripheral clock.

The proper thing is to get the VHDL up in the testbench (synopsys)
analyze it by running it and measure the number of cycles until idle.
Then we can calculate the necessary delay from
udelay(DIV_ROUND_UP(clockrate * cycles, 1000000));

Now I need to figure out if I can pull that off :-/

> At the very least the last data element should be out of the FIFO when
> RxDataAvlbl deasserts

Yes, but which FIFO?

> and a read of status should not arrive any
> sooner than that element to the DMAC.

As far as I can see there is no guarantee for that in the PL180 controller.
IIRC the FIFO toward the card is a separate state machine, and it's the
status of that state machine you're reading out in RxDataAvlbl.

It hands the read tokens to the MMCI DMA state machine with a simple
handshake, and from that point on the position of the data in the system
is the matter of the DMA statemachine, which in turn talks to the DMA
controller. The state of the DMA statemachine (like when it goes idle) is
not visible on the outside of the MMCI block in any flag register or so.

So when the MMCI DMA state machine takes over the last tokens,
the DMA engine can for example stop handshaking for an indefinate
amount of time, while there are still tokens in the DMA part of MMCI.
And in that time the driver may choose to initialize the MMCI for the
next transfer, which screws everything up.

So getting the callback from the DMA engine is what gives us the
certainty that CLR has been asserted.

Actually you probably need both: wait for the DMA ACK *and*
a few cycles more determined by analysis for the state machine
to settle, to be absolutely sure.

But waiting for the DMA engine to complete the transfer is necessary
as far as I can tell. Then you know there are no tokens stuck
anywhere in the pipeline...

> If this is true, then the read
> of status itself implies that the DMAC has asserted clr (or in some
> very pessimistic scenario within a few cycles?),

As said, the status comes from the FIFO toward the card, the
token queue in the DMA part of MMCI is something else.

Or am I getting things backwards? If you like we can have a
look at the hardware code together sometime and see if we can
figure it out...

Thanks,
Linus Walleij
