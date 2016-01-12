From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 12 Jan 2016 02:19:04 +0100
Subject: I/O issues with writing to mtdblock devices on kirkwood
In-Reply-To: <20160112004749.GT6588@sirena.org.uk>
References: <1440159857.19360.50.camel@debian.org>
 <20150905210846.GF6040@lunn.ch>
 <CAKzmTe0Bq8itvKoOTwZ+ZjY5pTqFYWt0-ihO4jn0qew_NYGhFg@mail.gmail.com>
 <20151011153548.GA9808@lunn.ch>
 <20160111230059.GA12286@jirafa.cyrius.com>
 <20160111232231.GS6588@sirena.org.uk>
 <20160112000721.GB12286@jirafa.cyrius.com>
 <20160112004749.GT6588@sirena.org.uk>
Message-ID: <20160112011904.GC7690@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Oh, right.  This sounds like everything is working fine with SPI - that
> commit was supposed to improve throughput with single threaded workloads
> by avoiding pointless context switches and it seems it is in fact doing
> that.  Most likely you are using a bitbanging SPI controller driver and
> that's causing lots of I/O wait states which is upsetting the scheduler
> but it's hard to be sure.

drivers/spi/spi-orion.c

Not bitbanging, but it is polled IO, not DMA.
 
> Possibly whatever SPI driver this system uses is doing something really
> rude (perhaps limited by the hardware), possibly it isn't using DMA when
> it should be, or possibly the scheduler just isn't doing a good job with
> the workload you're giving it.

When i played with this, i added a reschedule point at the end of the
drivers transfer_one_message() function, to see if that would help. It
did not, which is why i made a guess it has something to do with a
lock.

	Andrew
