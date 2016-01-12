From: broonie@kernel.org (Mark Brown)
Date: Tue, 12 Jan 2016 00:47:49 +0000
Subject: I/O issues with writing to mtdblock devices on kirkwood
In-Reply-To: <20160112000721.GB12286@jirafa.cyrius.com>
References: <1440159857.19360.50.camel@debian.org>
 <20150905210846.GF6040@lunn.ch>
 <CAKzmTe0Bq8itvKoOTwZ+ZjY5pTqFYWt0-ihO4jn0qew_NYGhFg@mail.gmail.com>
 <20151011153548.GA9808@lunn.ch>
 <20160111230059.GA12286@jirafa.cyrius.com>
 <20160111232231.GS6588@sirena.org.uk>
 <20160112000721.GB12286@jirafa.cyrius.com>
Message-ID: <20160112004749.GT6588@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 11, 2016 at 04:07:21PM -0800, Martin Michlmayr wrote:
> * Mark Brown <broonie@debian.org> [2016-01-11 23:22]:

I've just noticed that you're asking about the kernel SPI subsystem on
the Debian ARM list, please don't do things like this - please include
the kernel community, you'll be able to get more help that way.

> > >      spi: Pump transfers inside calling context for spi_sync()

> > Can you please clarify?  You're saying this causes SATA timeouts but
> > this is a change in the SPI subsystem and you're talking about MTD
> > devices.  You've also not said which kernel version this is with...

> Sorry for being unclear.  The problem is that other activities get
> blocked (most notably SATA) when writing a 9 MB file to an SPI flash
> chip.  The problem does not happen when writing a smaller (2 MB) file.
> It only happens when writing to mtdblock, not to mtd (maybe flashcp
> writes the file in smaller blocks?).

Oh, right.  This sounds like everything is working fine with SPI - that
commit was supposed to improve throughput with single threaded workloads
by avoiding pointless context switches and it seems it is in fact doing
that.  Most likely you are using a bitbanging SPI controller driver and
that's causing lots of I/O wait states which is upsetting the scheduler
but it's hard to be sure.

Possibly whatever SPI driver this system uses is doing something really
rude (perhaps limited by the hardware), possibly it isn't using DMA when
it should be, or possibly the scheduler just isn't doing a good job with
the workload you're giving it.

> > In any case, please provide traces from ftrace with all the SPI trace
> > enabled (via /sys/kernel/debug/trace/events/spi/enable).

> I've never used ftrace so I need to look into that (or maybe Andrew
> can help).

cat /sys/kernel/debug/tracing/trace
https://www.kernel.org/doc/Documentation/trace/ftrace.txt
http://www.sirena.org.uk/2011/01/22/tracing-asoc-with-trace-points/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160112/6a85d0fc/attachment.sig>
