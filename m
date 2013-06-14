From: ming.lei@canonical.com (Ming Lei)
Date: Fri, 14 Jun 2013 09:53:52 +0800
Subject: [RFC PATCH 0/4] USB: HCD/EHCI: giveback of URB in tasklet context
In-Reply-To: <20130614003503.GA31029@kroah.com>
References: <20130613184703.GA5701@kroah.com>
 <Pine.LNX.4.44L0.1306131526500.1561-100000@iolanthe.rowland.org>
 <20130614003503.GA31029@kroah.com>
Message-ID: <CACVXFVNKm5CUuyjZV-UrtmsrE76PEHYbcoBXembngt62VNR2+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 14, 2013 at 8:35 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Thu, Jun 13, 2013 at 03:41:17PM -0400, Alan Stern wrote:
>> On Thu, 13 Jun 2013, Greg Kroah-Hartman wrote:
>>
>> > On Thu, Jun 13, 2013 at 10:54:13AM -0400, Alan Stern wrote:
>> > > On Thu, 13 Jun 2013, Ming Lei wrote:
>> > >
>> > > > - using interrupt threaded handler(default)
>> > > >         33.440 MB/sec
>> > > >
>> > > > - using tasklet(#undef USB_HCD_THREADED_IRQ)
>> > > >         34.29 MB/sec
>> > > >
>> > > > - using hard interrupt handler(by removing HCD_BH in ehci-hcd.c )
>> > > >         34.260 MB/s
>> > > >
>> > > >
>> > > > So looks usb mass storage performance loss can be observed with
>> > > > interrupt threaded handler because one mass storage read/write sectors
>> > > > requires at least 3 interrupts which wake up usb-storage thread 3 times
>> > > > (each interrupt wakeup the usb-storage each time), introducing irq threaded
>> > > > handler will make 2 threads to be waken up about 6 times for one read/write.
>> > > >
>> > > > I think usb mass storage transfer handler need to be rewritten, otherwise
>> > > > it may become worsen after using irq threaded handler in USB 3.0.(the
>> > > > above device can reach >120MB/sec with hardware handler or tasklet handler,
>> > > > which means about ~3K interrupts/sec, so ~6K contexts switch in case of
>> > > > using irq threaded handler)
>> > > >
>> > > > So how about supporting tasklet first, then convert to interrupt
>> > > > threaded handler
>> > > > after usb mass storage transfer is rewritten without performance loss?
>> > > > (rewriting
>> > > > usb mass storage transfer handler may need some time and work since storage
>> > > > stability/correctness is extremely important, :-)
>> > >
>> > > Maybe we should simply copy what the networking people do.  They are
>> > > very concerned about performance and latency; whatever technique they
>> > > use should be good for USB too.
>> >
>> > Yes, but for "old-style" usb-storage, is this really a big deal?  We are
>> > still easily hitting the "line-speed" of USB for usb-storage with simple
>> > machines, the bottlenecks that I'm seeing are in the devices themselves,
>> > and then in the USB wire speed.
>>
>> What about with USB-3 storage devices?  Many of them still use the
>> bulk-only transport instead of UAS.  They may push the limits up.
>
> Are they really?  Have we seen that happen yet?  With the number's I've

Yes, the device I am testing is bulk-only, no uas support , and it is very
popular in market.

> seen published, we are easily serving up enough data to keep the pipe
> full, but that all depends on your CPU / host controller.
>
>> > Once hardware comes out that uses USB streams, and we get device support
>> > for the UAS protocol, then we might have a need to change things, but at
>> > this point in time, for the "old" driver, I think we are fine.
>> >
>> > Unless someone has a workload / benchmark that shows otherwise?
>>
>> The test results above show a 2.4% degradation for threaded interrupts
>> as compared to tasklets.  That's in addition to the bottlenecks caused
>> by the device; no doubt it would be worse for a faster device.  This
>> result calls into question the benefits of threaded interrupts.
>>
>> The main reason for moving away from the current scheme is to reduce
>> latency for other interrupt handlers.  Ming gave two examples of slow
>> USB code that runs in hardirq context now; with his change they would
>> run in softirq context and therefore wouldn't delay other interrupts so
>> much.  (Interrupt latency is hard to measure, however.)
>
> Yes, I know that people keep wanting to worry about latency issues, and
> the best answer for them has always been, "don't use USB." :)

I think we can do it better, why don't do it? :-)

> You suffer throughput issues with predicitable latency dependancies, so

This patchset don't cause throughout degradation but decrease latency much,
also has other advantages.

> we need to be careful we don't slow down the 99% of the systems out
> there that do not care about this at all.

Considered great amount of ARM devices in market, I think we need to
consider the problem on these devices, :-)

Thanks,
--
Ming Lei
