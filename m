From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 2 Feb 2011 22:47:45 +0000
Subject: [PATCH v2] ARM: kexec: selective MMU identity mapping
In-Reply-To: <alpine.LFD.2.00.1102021723330.8212@xanadu.home>
References: <1296657809-1589-1-git-send-email-per.xx.fransson@stericsson.com>
	<20110202210925.GD31043@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1102021704580.8212@xanadu.home>
	<20110202221937.GI31043@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1102021723330.8212@xanadu.home>
Message-ID: <20110202224745.GK31043@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 02, 2011 at 05:27:40PM -0500, Nicolas Pitre wrote:
> On Wed, 2 Feb 2011, Russell King - ARM Linux wrote:
> 
> > It's known to work on Assabet.  It works on SA1100 because the kernel
> > mapping is already a 1:1 mapping.
> D'oh.
> 
> > What setup_mm_for_reboot() is doing on Assabet though is making the
> > flash available for cpu_reset(0) to be able to call, not making the
> > kernel code for cpu_reset() available for calling.
> 
> Right.  So if RAM is located at 0xd0000000 instead then this won't work 
> as intended.

It'll work as intended for cpu resetting, except for v6 and v7 as they
don't have the necessary code in their cpu_reset() function to work,
and secondly perversely, v6 and v7 CPUs stall the pipeline when turning
the MMU off, while previous CPUs didn't.  Meanwhile, many other
instructions which did stall the pipeline no longer do.

> And overwriting the entire user space is not the best thing to do for
> kexec anyway.

Probably not.  As I see it, having RAM located above PAGE_OFFSET in phys
address space, but not being a 1:1 mapping, will always be a problem.
What if it ends up overwriting the L2 cache controller mapping?
