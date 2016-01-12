From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 12 Jan 2016 17:29:40 +0100
Subject: I/O issues with writing to mtdblock devices on kirkwood
In-Reply-To: <20160112011904.GC7690@lunn.ch>
References: <1440159857.19360.50.camel@debian.org>
 <20160112004749.GT6588@sirena.org.uk> <20160112011904.GC7690@lunn.ch>
Message-ID: <4004455.tVDpSpUXxo@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 12 January 2016 02:19:04 Andrew Lunn wrote:
> > Oh, right.  This sounds like everything is working fine with SPI - that
> > commit was supposed to improve throughput with single threaded workloads
> > by avoiding pointless context switches and it seems it is in fact doing
> > that.  Most likely you are using a bitbanging SPI controller driver and
> > that's causing lots of I/O wait states which is upsetting the scheduler
> > but it's hard to be sure.
> 
> drivers/spi/spi-orion.c
> 
> Not bitbanging, but it is polled IO, not DMA.
>  
> > Possibly whatever SPI driver this system uses is doing something really
> > rude (perhaps limited by the hardware), possibly it isn't using DMA when
> > it should be, or possibly the scheduler just isn't doing a good job with
> > the workload you're giving it.
> 
> When i played with this, i added a reschedule point at the end of the
> drivers transfer_one_message() function, to see if that would help. It
> did not, which is why i made a guess it has something to do with a
> lock.

Can you try using usleep_range() instead of udelay()? It might also
be worth trying what the actual delay is for each byte to see if a
longer sleep time would help, but I guess that time is highly
device specific.

	Arnd
