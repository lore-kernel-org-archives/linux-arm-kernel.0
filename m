From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Thu, 13 Jun 2013 11:47:03 -0700
Subject: [RFC PATCH 0/4] USB: HCD/EHCI: giveback of URB in tasklet context
In-Reply-To: <Pine.LNX.4.44L0.1306131035080.1561-100000@iolanthe.rowland.org>
References: <CACVXFVP__N9o3xRMd5+sk5T0zeGcrSk41rxY6Tzi1AM-mHL81Q@mail.gmail.com>
 <Pine.LNX.4.44L0.1306131035080.1561-100000@iolanthe.rowland.org>
Message-ID: <20130613184703.GA5701@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 13, 2013 at 10:54:13AM -0400, Alan Stern wrote:
> On Thu, 13 Jun 2013, Ming Lei wrote:
> 
> > - using interrupt threaded handler(default)
> >         33.440 MB/sec
> > 
> > - using tasklet(#undef USB_HCD_THREADED_IRQ)
> >         34.29 MB/sec
> > 
> > - using hard interrupt handler(by removing HCD_BH in ehci-hcd.c )
> >         34.260 MB/s
> > 
> > 
> > So looks usb mass storage performance loss can be observed with
> > interrupt threaded handler because one mass storage read/write sectors
> > requires at least 3 interrupts which wake up usb-storage thread 3 times
> > (each interrupt wakeup the usb-storage each time), introducing irq threaded
> > handler will make 2 threads to be waken up about 6 times for one read/write.
> > 
> > I think usb mass storage transfer handler need to be rewritten, otherwise
> > it may become worsen after using irq threaded handler in USB 3.0.(the
> > above device can reach >120MB/sec with hardware handler or tasklet handler,
> > which means about ~3K interrupts/sec, so ~6K contexts switch in case of
> > using irq threaded handler)
> > 
> > So how about supporting tasklet first, then convert to interrupt
> > threaded handler
> > after usb mass storage transfer is rewritten without performance loss?
> > (rewriting
> > usb mass storage transfer handler may need some time and work since storage
> > stability/correctness is extremely important, :-)
> 
> Maybe we should simply copy what the networking people do.  They are 
> very concerned about performance and latency; whatever technique they 
> use should be good for USB too.

Yes, but for "old-style" usb-storage, is this really a big deal?  We are
still easily hitting the "line-speed" of USB for usb-storage with simple
machines, the bottlenecks that I'm seeing are in the devices themselves,
and then in the USB wire speed.

Once hardware comes out that uses USB streams, and we get device support
for the UAS protocol, then we might have a need to change things, but at
this point in time, for the "old" driver, I think we are fine.

Unless someone has a workload / benchmark that shows otherwise?

thanks,

greg k-h
