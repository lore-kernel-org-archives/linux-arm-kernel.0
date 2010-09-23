From: jacob.keller@gmail.com (Jacob Keller)
Date: Thu, 23 Sep 2010 11:21:55 -0700
Subject: [PATCH v6 0/8] ptp: IEEE 1588 hardware clock support
In-Reply-To: <alpine.DEB.2.00.1009231238170.2962@router.home>
References: <cover.1285261533.git.richard.cochran@omicron.at>
	<alpine.DEB.2.00.1009231238170.2962@router.home>
Message-ID: <AANLkTim0JqVTyvrvjLRp1Cg423MdrwmyZG2uN6uSyeLb@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>
> >     In contrast to the standard Linux system clock, a PHC is
> >     adjustable in hardware, for example using frequency compensation
> >     registers or a VCO. The ability to directly tune the PHC is
> >     essential to reap the benefit of hardware timestamping.
>
> There is a reason for not being able to shift posix clocks: The system has
> one time base. The various clocks are contributing to maintaining that
> sytem wide time.
>
> Adjusting clocks is absolutely essential for proper functioning of the PTP
protocol. The slave obtains and calculates the offset from master and uses
that in order to adjust the clock properly, The problem is that the
timestamps are done via the hardware. We need a method to expose that
hardware so that the ptp software can properly adjust those clocks.


> I do not understand why you want to maintain different clocks running at
> different speeds. Certainly interesting for some uses I guess that I
> do not have the energy to imagine right now. But can we get the PTP killer
> feature of synchronized accurate system time first?
>

The problem is maintaining a hardware clock at the correct speed/frequency
and time. The timestamping is done via hardware, and that hardware clock
needs to be accurate. We need to be able to modify that clock. Yes, having
the system time be the same value would be nice, but the problem comes
because we don't want to jump through hoops to keep that hardware clock
accurate to the ptp protocol running on the network.



>
> >    Instead, the patch set provides a way to offer a Pulse Per Second
> >    (PPS) event from the PHC to the Linux PPS subsystem. A user space
> >    application can read the PPS events and tune the system clock, just
> >    like when using other external time sources like radio clocks or
> >    GPS.
>
> User space is subject to various latencies created by the OS etc. I would
> that in order to have fine grained (read microsecond) accurary we would
> have to run the portions that are relevant to obtaining the desired
> accuracy in the kernel.
>

All of the necessary features for microsecond or better accuracy are done
via the hardware. You can get accuracy to within <10 mircoseconds while only
sending sync packets and such once per second. The reason is because the
hardware timestamps are very accurate. But if we can't properly adjust the
clocks time and frequency, we cannot maintain the accuracy of the
timestamps.

>
>
 --
> To unsubscribe from this list: send the line "unsubscribe netdev" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100923/b689e292/attachment-0001.html>
