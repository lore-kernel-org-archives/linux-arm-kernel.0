From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 6 Jul 2011 22:01:06 +0100
Subject: [PATCH] ARM: poison initmem when it is freed
In-Reply-To: <4E14CBDA.8@codeaurora.org>
References: <20110705184254.GH8286@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1107051509490.14596@xanadu.home>
	<20110705192656.GJ8286@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1107051540550.14596@xanadu.home>
	<4E139F8F.7060809@codeaurora.org>
	<20110706203427.GU8286@n2100.arm.linux.org.uk>
	<4E14CBDA.8@codeaurora.org>
Message-ID: <20110706210106.GX8286@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 06, 2011 at 01:55:54PM -0700, Stephen Boyd wrote:
> Should it include the initrd too? At least x86 poisons that memory but I
> don't know who would be using that incorrectly.

It could do - I don't see any harm in not doing so.  The only issue
is that people may want to disable this stuff if they're after
squeezing every last ms out of the boot time.

> How about a free_init_area() function which calls free_area() after
> poisoning the memory?

I need to go back and look at the Integrator etc situation with regard
to reorganizing the vmlinux layout - it may be that the omission of
freeing .init memory can now be removed (it was there to stop the
memory being used as the first K of memory wasn't DMA-able.)

Assuming it has to stay though, we still should arrange for the initrd
memory to be poisoned even if it isn't freed.
