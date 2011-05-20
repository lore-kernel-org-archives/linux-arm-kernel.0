From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 20 May 2011 19:05:10 +0100
Subject: [RFC PATCH] ARM hibernation / suspend-to-disk support code
In-Reply-To: <20110520113758.GA3141@arm.com>
References: <3DCE2F529B282E4B8F53D4D8AA406A07014FFE@008-AM1MPN1-022.mgdnok.nokia.com>
	<alpine.DEB.2.00.1105181257370.2374@localhost6.localdomain6>
	<20110520113758.GA3141@arm.com>
Message-ID: <20110520180510.GE7445@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 20, 2011 at 12:37:58PM +0100, Dave Martin wrote:
> Where do we save/restore r8_FIQ..r13_FIQ, r13_IRQ, r13_UND and r13_ABT?
> (I'm assuming there's no reason to save/restore r14 or SPSR for any
> exception mode, since we presumably aren't going to suspend/resume
> from inside an exception handler (?))

There is absolutely no need to save r13 for _any_ of the abort modes.  As
we have to set them up at boot time to fixed values, we keep that code
around, and in the resume paths we re-execute that initialization code.
cpu_init().

Out of the list you mention above, the only thing which isn't saved are the
FIQ registers, and that's a problem for S2RAM too, and should be done by
arch/arm/kernel/fiq.c hooking into the suspend paths.
