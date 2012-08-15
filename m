From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 15 Aug 2012 22:44:12 +0100
Subject: imx6q restart is broken
In-Reply-To: <502BBB43.5010403@gmail.com>
References: <20120808101817.GA14718@S2101-09.ap.freescale.net>
 <50224547.9020000@de.bosch.com> <50232C17.9000700@gmail.com>
 <20120809092021.GQ18957@n2100.arm.linux.org.uk> <502BBB43.5010403@gmail.com>
Message-ID: <20120815214412.GC32560@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 15, 2012 at 10:07:47AM -0500, Rob Herring wrote:
> I think I am seeing a similar problem on highbank with a v7 only build.
> 
> >From what I've debugged, restart hangs for me on the L2x0 spinlock
> during a writel. Changing the writel to writel_relaxed in the restart
> hook fixes the problem. This skips barriers in the writel and for the
> spinlock. However, I'm still puzzled as cpu_relax on the secondary cores
> should not be doing a dmb in my case on a v7 only build.

Well, I had the idea of only doing a dmb() once every N loops, but I don't
think we can sensibly introduce such a change into the mainline kernel.
(How would cpu_relax() know it's being used in a loop?)

Remember that the dmb() is in cpu_relax() as a work-around for the lack
of temporal flushing of pending stores, and is needed to make various bits
of the kernel work.

So at the moment, there is no solution for this - and as I've pointed out
it can be trivially exploited in userspace on the affected CPUs.  So
really a kernel work-around isn't going to sort it.
