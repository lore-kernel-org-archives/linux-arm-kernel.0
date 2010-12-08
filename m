From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 8 Dec 2010 20:20:43 +0000
Subject: [RFC] Fixing CPU Hotplug for RealView Platforms
In-Reply-To: <007501cb9636$c0a54c90$41efe5b0$@deacon@arm.com>
References: <007401cb962d$d53d2500$7fb76f00$@deacon@arm.com>
	<20101207171810.GA25839@n2100.arm.linux.org.uk>
	<007501cb9636$c0a54c90$41efe5b0$@deacon@arm.com>
Message-ID: <20101208202043.GR9777@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 07, 2010 at 05:47:00PM -0000, Will Deacon wrote:
> Hi Russell,
> > What if we fixed the cpu_reset functions for v6 and v7, and when a CPU
> > is taken offline, we actually go through a proper shutdown of that CPU
> > and call the reset vector, re-entering the boot loader?
> 
> This will certainly solve our problem, but people might complain that it's
> too heavyweight :)

Our current hot plug-in code already re-runs most of the secondary CPU
initialization in the kernel - we reset the stack and jump back to
secondary_start_kernel().

What we'll be adding to that is the overheads in the boot loader (which
would happen at the point we go offline) and getting back to the kernel
code.  From that point, the additional things are looking up the CPU
type, calling its setup function, and enabling the MMU.

Everything from that point on would be identical to what already happens
on the hot plug-in path.
