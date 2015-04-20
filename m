From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Mon, 20 Apr 2015 09:57:28 +0100
Subject: [PATCH] ARM: mm: add imprecise abort non-deadly handler
In-Reply-To: <20150418090845.GH12732@n2100.arm.linux.org.uk>
References: <1429316083.8341.76.camel@xylophone.i.decadent.org.uk>
 <20150418090845.GH12732@n2100.arm.linux.org.uk>
Message-ID: <1429520248.8341.82.camel@xylophone.i.decadent.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2015-04-18 at 10:08 +0100, Russell King - ARM Linux wrote:
> On Sat, Apr 18, 2015 at 01:14:43AM +0100, Ben Hutchings wrote:
> > From: Ben Dooks <ben.dooks@codethink.co.uk>
> > 
> > Given that imprecise aborts may be delivered after the action that
> > caused them (or even for non-cpu related activities such as bridge
> > faults from a bus-master) it is possible that the wrong process is
> > terminated as a result.
> > 
> > Add a handler to take and print imprecise aborts and allow the process
> > to continue. This should ensure that the abort is shown but not kill
> > the process that was running on the cpu core at the time.
> 
> I'm not happy with this.
> 
> On older CPUs, you generally get the "imprecise" (aka external) aborts
> within a few cycles of the faulting instruction, which is good enough
> to ensure that the appropriate process gets terminated.

Right.

> Yes, this is not true of ARMv7, where such faults can happen a longer
> time after the access which caused them.

Not only that, but they can apparently be caused by DMA masters.  I
think Ben ran into a problem like that a while back and this patch dates
from then, but I don't know the details.

If there was a way to tell whose memory access caused it...

> However, I would argue that merely printing a message to the kernel
> log is insufficient - especially as the kernel networking layer can
> spam the log so that such messages yet rotated out of the ring buffer.
> 
> An imprecise abort is a serious condition, one which _ought_ to be very
> noticable, on the level of panic()ing the kernel.  It's a data loss
> condition, one which _can_ result in corruption of user data or even
> filesystems.

Would it make sense to treat this similarly to an x86 Machine Check
Error, and have a kernel parameter to choose between panic and log?  It
seems like that would be useful when debugging a driver that is
triggering this.

Ben.
