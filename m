From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 19 Sep 2010 14:04:38 +0100
Subject: [PATCH] ARM: make app read out process num even not use SMP
In-Reply-To: <20100919122920.GB9098@n2100.arm.linux.org.uk>
References: <1284866536-21431-1-git-send-email-leiwen@marvell.com>
	<20100919122920.GB9098@n2100.arm.linux.org.uk>
Message-ID: <20100919130438.GC9098@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 19, 2010 at 01:29:20PM +0100, Russell King - ARM Linux wrote:
> On Sun, Sep 19, 2010 at 11:22:16AM +0800, Lei Wen wrote:
> > Some app like trace-cmd need to know the process number, but not
> 
> That'll be "processor number".
> 
> > all arm board is enabled with the SMP. Add this fix up to let those
> > app works happy.
> 
> We have historically never given the "processor: 0" line on uniprocessor
> systems - and many other architectures do not provide this line either.
> 
> I'd suggest trace-cmd is fixed so that it doesn't assume presence of this
> line.

Ah, trace-cmd is using it to get the number of CPUs in the system.
This is silly, and it's unreliable to use /proc/cpuinfo as noted in
the glibc source code.

There's a better way.  sysconf with _SC_NPROCESSORS_CONF for the number
of configured processors, or _SC_NPROCESSORS_ONLN for the number of
online processors.  Standard interfaces are always better than home-made
interfaces.
