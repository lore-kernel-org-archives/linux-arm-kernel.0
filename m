From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 16 Aug 2012 23:34:46 +0100
Subject: imx6q restart is broken
In-Reply-To: <20120816023109.GH2258@S2101-09.ap.freescale.net>
References: <20120808101817.GA14718@S2101-09.ap.freescale.net>
 <50224547.9020000@de.bosch.com> <50232C17.9000700@gmail.com>
 <20120809092021.GQ18957@n2100.arm.linux.org.uk> <502BBB43.5010403@gmail.com>
 <20120815214412.GC32560@n2100.arm.linux.org.uk>
 <20120816023109.GH2258@S2101-09.ap.freescale.net>
Message-ID: <20120816223446.GB15883@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 16, 2012 at 10:31:11AM +0800, Shawn Guo wrote:
> On Wed, Aug 15, 2012 at 10:44:12PM +0100, Russell King - ARM Linux wrote:
> > On Wed, Aug 15, 2012 at 10:07:47AM -0500, Rob Herring wrote:
> > > I think I am seeing a similar problem on highbank with a v7 only build.
> > > 
> > > >From what I've debugged, restart hangs for me on the L2x0 spinlock
> > > during a writel. Changing the writel to writel_relaxed in the restart
> > > hook fixes the problem. This skips barriers in the writel and for the
> > > spinlock. However, I'm still puzzled as cpu_relax on the secondary cores
> > > should not be doing a dmb in my case on a v7 only build.
> > 
> > Well, I had the idea of only doing a dmb() once every N loops, but I don't
> > think we can sensibly introduce such a change into the mainline kernel.
> > (How would cpu_relax() know it's being used in a loop?)
> > 
> > Remember that the dmb() is in cpu_relax() as a work-around for the lack
> > of temporal flushing of pending stores, and is needed to make various bits
> > of the kernel work.
> > 
> The cpu_relax() will do dmb() only #if __LINUX_ARM_ARCH__ == 6 ||
> defined(CONFIG_ARM_ERRATA_754327).  Otherwise, it's just a barrier()
> call.  I guess Rob's puzzle is since the cpu_relax on the stopped
> cores does not do dmb, why a wmb/mb call on the running cpu would hang
> it.
> 
> One thing I note is that mb() will do a outer_sync() call.  Since the
> issue is around L2x0 operation, not sure if they are related ...

This doesn't get around the problem that userspace can still effectively
issue a DoS against the system by just running a dmb in a tight loop.
Or maybe this would have a much more dramatic effect:

	while (1) {
		asm("dmb");
		asm("dmb");
		asm("dmb");
		asm("dmb");
		asm("dmb");
		asm("dmb");
		asm("dmb");
		asm("dmb");
		asm("dmb");
		asm("dmb");
		asm("dmb");
		asm("dmb");
		asm("dmb");
		asm("dmb");
		asm("dmb");
		asm("dmb");
		asm("dmb");
		asm("dmb");
		asm("dmb");
		asm("dmb");
		asm("dmb");
		asm("dmb");
		asm("dmb");
		asm("dmb");
		asm("dmb");
		asm("dmb");
		asm("dmb");
	}

and make that 3 seconds to get a ps listing turn into something much
longer?

> > So at the moment, there is no solution for this - and as I've pointed out
> > it can be trivially exploited in userspace on the affected CPUs.  So
> > really a kernel work-around isn't going to sort it.
> 
> So, Sascha, it seems we get another good reason to split
> imx_v6_v7_defconfig into imx_v6_defconfig and imx_v7_defconfig?
> I have seen Matt Sealey and Hui Wang suggested doing this already.

The last thing we need are more defconfigs.

I think what needs to happen here (while we wait) is someone _with_ the
problem needs to experiment, and find out how many nops are needed for
the DMB not to have much effect in cpu_relax().  If it turns out we just
need to put one nop in, then that's not _too_ bad.
