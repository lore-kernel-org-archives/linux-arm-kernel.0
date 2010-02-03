From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 3 Feb 2010 14:40:22 +0000
Subject: 32-bit Thumb-2 breakpoints
In-Reply-To: <20100203135914.GF4277@wear.picochip.com>
References: <20100203005038.GA16356@caradoc.them.org>
	<1265197942.1970.34.camel@pc1117.cambridge.arm.com>
	<20100203132824.GA27048@n2100.arm.linux.org.uk>
	<20100203135914.GF4277@wear.picochip.com>
Message-ID: <20100203144022.GG22275@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 03, 2010 at 01:59:14PM +0000, Jamie Iles wrote:
> Well it looks like the hardware breakpoint layer is on top of the perf_events
> subsystem and the breakpoint becomes a perf event. In this case the breakpoint
> should be scheduled in and out by perf on context switches if targetting a
> specific PID or could be left in the whole time if desired.

Unfortunately, we're drifting from the original topic...

This starts worrying me more.  Is execution stopped (as in actually
stopped, not just switched away from leaving the thread runnable) in
the target thread when one of these 'perf' breakpoints is hit?  If
not, it's completely unsuitable for debuggers to use, and raises the
question of why it's being interfaced with the ptrace code.

Yes, x86 seems to use this method, but it doesn't send signals in the
counter overflow function, so things must be working differently there.
