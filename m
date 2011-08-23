From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 23 Aug 2011 16:14:21 +0100
Subject: ARM processor mode, kernel startup, Hyp / secure state
In-Reply-To: <20051.48809.945431.800543@mariner.uk.xensource.com>
References: <20051.48809.945431.800543@mariner.uk.xensource.com>
Message-ID: <20110823151421.GK19622@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 23, 2011 at 03:52:25PM +0100, Ian Jackson wrote:
> We're looking into porting Xen to the ARM A15 architecture.  In this
> context, it's necessary to arrange for the Xen hypervisor to be
> entered from the boot loader in an appropriate processor mode.
> 
> KVM needs to deal with the same problem, of course.  And any future
> Linux kernel feature which uses the Secure State does too.

We already have kernels which boot in both secure and non-secure mode
CPUs.  There's very little difference between the two from the core
ARM support code - except that we have expectations that appropriate
hardware work-arounds will have already been initialized by the
secure monitor (as there is no way for the kernel to be able to call
out to the secure monitor in a platform independent way.)

That's unfortunately one of the necessary evils of having the secure
stuff, which doesn't have any kind of defined API, getting in the way.

So, basically, which side of the secure division the kernel runs on
depends highly on the platform itself - and as the secure monitor APIs
are highly platform specific, there's no getting away from that.

If the kernel does not contain the appropriate platform specific secure
monitor API then it can't run in non-secure mode (or it can but the
functionality will be severely limited - no power management, and
in some cases buggy L2 cache.)  So you wouldn't _want_ to run such a
kernel if you value your data.

As far as I know, the kernel runs non-secure on all real silicon out in
the wild.  It's only ARMs evaluation boards and models where the kernel
runs on the secure side.

Given all that, there's not much point to publishing whether a kernel is
built for secure side or not.  It's tied extremely closely to the platform
itself, which is where most of the secure API calls already live.
