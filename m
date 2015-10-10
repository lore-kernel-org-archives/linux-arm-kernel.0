From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 10 Oct 2015 16:33:36 +0100
Subject: [PATCH] sched_clock: add data pointer argument to read callback
In-Reply-To: <yw1xzizrh7ug.fsf@unicorn.mansr.com>
References: <1444427858-576-1-git-send-email-mans@mansr.com>
 <20151009232015.GC32536@n2100.arm.linux.org.uk>
 <yw1x4mhzioxl.fsf@unicorn.mansr.com>
 <20151009235441.GD32536@n2100.arm.linux.org.uk>
 <yw1xzizrh7ug.fsf@unicorn.mansr.com>
Message-ID: <20151010153336.GE32536@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 10, 2015 at 01:42:47AM +0100, M?ns Rullg?rd wrote:
> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
> 
> > On Sat, Oct 10, 2015 at 12:48:22AM +0100, M?ns Rullg?rd wrote:
> >> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
> >> 
> >> > On Fri, Oct 09, 2015 at 10:57:35PM +0100, Mans Rullgard wrote:
> >> >> This passes a data pointer specified in the sched_clock_register()
> >> >> call to the read callback allowing simpler implementations thereof.
> >> >> 
> >> >> In this patch, existing uses of this interface are simply updated
> >> >> with a null pointer.
> >> >
> >> > This is a bad description.  It tells us what the patch is doing,
> >> > (which we can see by reading the patch) but not _why_.  Please include
> >> > information on why the change is necessary - describe what you are
> >> > trying to achieve.
> >> 
> >> Currently most of the callbacks use a global variable to store the
> >> address of a counter register.  This has several downsides:
> >> 
> >> - Loading the address of a global variable can be more expensive than
> >>   keeping a pointer next to the function pointer.
> >> 
> >> - It makes it impossible to have multiple instances of a driver call
> >>   sched_clock_register() since the caller can't know which clock will
> >>   win in the end.
> >> 
> >> - Many of the existing callbacks are practically identical and could be
> >>   replaced with a common generic function if it had a pointer argument.
> >> 
> >> If I've missed something that makes this a stupid idea, please tell.
> >
> > So my next question is whether you intend to pass an iomem pointer
> > through this, or a some kind of structure, or both.  It matters,
> > because iomem pointers have a __iomem attribute to keep sparse
> > happy.  Having to force that attribute on and off pointers is frowned
> > upon, as it defeats the purpose of the sparse static checker.
> 
> So this is an instance where tools like sparse get in the way of doing
> the simplest, most efficient, and obviously correct thing.  Who wins in
> such cases?

In that case, NAK on the patch.  I don't have time for your stupid games.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
