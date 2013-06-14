From: ming.lei@canonical.com (Ming Lei)
Date: Fri, 14 Jun 2013 09:37:15 +0800
Subject: [RFC PATCH 0/4] USB: HCD/EHCI: giveback of URB in tasklet context
In-Reply-To: <Pine.LNX.4.44L0.1306131526500.1561-100000@iolanthe.rowland.org>
References: <20130613184703.GA5701@kroah.com>
 <Pine.LNX.4.44L0.1306131526500.1561-100000@iolanthe.rowland.org>
Message-ID: <CACVXFVOPTVYMdbuFkauqVEf_WMq_w1GguHRZMVoGz=OYdcAcog@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 14, 2013 at 3:41 AM, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Thu, 13 Jun 2013, Greg Kroah-Hartman wrote:
>
>> On Thu, Jun 13, 2013 at 10:54:13AM -0400, Alan Stern wrote:
>> > On Thu, 13 Jun 2013, Ming Lei wrote:
>> >
>> > > - using interrupt threaded handler(default)
>> > >         33.440 MB/sec
>> > >
>> > > - using tasklet(#undef USB_HCD_THREADED_IRQ)
>> > >         34.29 MB/sec
>> > >
>> > > - using hard interrupt handler(by removing HCD_BH in ehci-hcd.c )
>> > >         34.260 MB/s
>> > >
>> > >
>> > > So looks usb mass storage performance loss can be observed with
>> > > interrupt threaded handler because one mass storage read/write sectors
>> > > requires at least 3 interrupts which wake up usb-storage thread 3 times
>> > > (each interrupt wakeup the usb-storage each time), introducing irq threaded
>> > > handler will make 2 threads to be waken up about 6 times for one read/write.
>> > >
>> > > I think usb mass storage transfer handler need to be rewritten, otherwise
>> > > it may become worsen after using irq threaded handler in USB 3.0.(the
>> > > above device can reach >120MB/sec with hardware handler or tasklet handler,
>> > > which means about ~3K interrupts/sec, so ~6K contexts switch in case of
>> > > using irq threaded handler)
>> > >
>> > > So how about supporting tasklet first, then convert to interrupt
>> > > threaded handler
>> > > after usb mass storage transfer is rewritten without performance loss?
>> > > (rewriting
>> > > usb mass storage transfer handler may need some time and work since storage
>> > > stability/correctness is extremely important, :-)
>> >
>> > Maybe we should simply copy what the networking people do.  They are
>> > very concerned about performance and latency; whatever technique they
>> > use should be good for USB too.
>>
>> Yes, but for "old-style" usb-storage, is this really a big deal?  We are
>> still easily hitting the "line-speed" of USB for usb-storage with simple
>> machines, the bottlenecks that I'm seeing are in the devices themselves,
>> and then in the USB wire speed.
>
> What about with USB-3 storage devices?  Many of them still use the
> bulk-only transport instead of UAS.  They may push the limits up.

Exactly, my test device(sandisk extreme USB 3.0 16G, 0781:5580) is very
popular, which is faster than most USB 3.0 pendrive in market, but the device
is bulk-only, and no UAS support, so I guess most of the USB 3.0 pendrive in
market still may not support UAS.

>
>> Once hardware comes out that uses USB streams, and we get device support
>> for the UAS protocol, then we might have a need to change things, but at
>> this point in time, for the "old" driver, I think we are fine.
>>
>> Unless someone has a workload / benchmark that shows otherwise?
>
> The test results above show a 2.4% degradation for threaded interrupts
> as compared to tasklets.  That's in addition to the bottlenecks caused
> by the device; no doubt it would be worse for a faster device.  This
> result calls into question the benefits of threaded interrupts.

If I enable HCD_BH in xhci driver and enable requst_threaded_irq in xhci driver,
the degradation becomes >10%, see below test on the same device connected to
xhci-hcd:

[tom at board]$ps -ax | grep xhci
Warning: bad ps syntax, perhaps a bogus '-'? See http://procps.sf.net/faq.html
 4896 pts/1    S+     0:00 grep --color=auto xhci
[tom at board]$sudo ./ds-msg /dev/sdb 400M 1 4
No. 0, time 121 MB
No. 1, time 122 MB
No. 2, time 124 MB
No. 3, time 122 MB
count=4, total=489 ms, average=122.250 MB
[tom at board]$
[tom at board]$ps -ax | grep xhci
Warning: bad ps syntax, perhaps a bogus '-'? See http://procps.sf.net/faq.html
 6037 ?        S      0:00 [irq/42-xhci_hcd]
 6038 ?        S      0:00 [irq/43-xhci_hcd]
 6039 ?        S      0:00 [irq/44-xhci_hcd]
 6040 ?        S      0:00 [irq/45-xhci_hcd]
 6041 ?        S      0:00 [irq/46-xhci_hcd]
 6304 pts/1    S+     0:00 grep --color=auto xhci
[tom at board]$
[tom at board]$
[tom at board]$sudo ./ds-msg /dev/sdb 400M 1 4
No. 0, time 107 MB
No. 1, time 108 MB
No. 2, time 108 MB
No. 3, time 109 MB
count=4, total=432 ms, average=108.000 MB

Thanks,
--
Ming Lei
