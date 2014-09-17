From: frans.klaver@xsens.com (Frans Klaver)
Date: Wed, 17 Sep 2014 14:13:03 +0200
Subject: [PATCH 3/4] tty: omap-serial: use threaded interrupt handler
In-Reply-To: <54197804.3020302@hurleysoftware.com>
References: <1410789610-23059-1-git-send-email-frans.klaver@xsens.com>
 <1410789610-23059-4-git-send-email-frans.klaver@xsens.com>
 <54170823.7040801@hurleysoftware.com>
 <5417228C.5070503@hurleysoftware.com>
 <20140916085037.GI28458@ci00147.xsens-tech.local>
 <54197804.3020302@hurleysoftware.com>
Message-ID: <20140917121303.GB20438@ci00147.xsens-tech.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 17, 2014 at 08:01:08AM -0400, Peter Hurley wrote:
> On 09/16/2014 04:50 AM, Frans Klaver wrote:
> > On Mon, Sep 15, 2014 at 01:31:56PM -0400, Peter Hurley wrote:
> >> On 09/15/2014 11:39 AM, Peter Hurley wrote:
> >>> On 09/15/2014 10:00 AM, Frans Klaver wrote:
> >>>> At 3.6Mbaud, with slightly over 2Mbit/s data coming in, we see 1600 uart
> >>>> rx buffer overflows within 30 seconds. Threading the interrupt handling reduces
> >>>> this to about 170 overflows in 10 minutes.
> >>>
> >>> Why is the threadirqs kernel boot option not sufficient?
> >>> Or conversely, shouldn't this be selectable?
> >>
> > 
> > I wasn't aware of the threadirqs boot option. I also wouldn't know if
> > this should be selectable. What would be a reason to favor the
> > non-threaded irq over the threaded irq?
> 
> Not everyone cares enough about serial to dedicate kthreads to it :)

Fair enough. In that light, we might not care enough about other
subsystems to dedicate kthreads to it :). Selectable seems reasonable in
that case.


> >> Also, do you see the same performance differential when you implement this
> >> in the 8250 driver (that is, on top of Sebastian's omap->8250 conversion)?
> >>
> > 
> > I haven't gotten Sebastian's driver to work properly yet on the console.
> > There was no reason for me yet to throw my omap changes on top of
> > Sebastian's queue.
> > 
> >>> PS - To overflow the 64 byte RX FIFO at those data rates means interrupt
> >>> latency in excess of 250us?
> > 
> > At 3686400 baud it should take about 174 us to fill a 64 byte buffer. I
> > haven't done any measurements on the interrupt latency though. If you
> > consider that we're sending about 1kB of data, 240 times a second, we're
> > spending a lot of time reading data from the uart. I can imagine the
> > system has other work to do as well.
> 
> System work should not keep irqs from being serviced. Even 174us is a long
> time not to service an interrupt. Maybe console writes are keeping the isr
> from running?

That's quite possible. I'll have to redo the test setup I had for this to
give you a decent answer. I'll have to do that anyway as Sebastian's
8250 conversion improves.

Thanks for the comments,
Frans
