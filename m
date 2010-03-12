From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 12 Mar 2010 21:16:14 +0000
Subject: [PATCH 03/11] Thumb-2: Implementation of the unified start-up
	and exceptions code
In-Reply-To: <4B9A7A3C.9000304@users.sourceforge.net>
References: <20090602130549.12732.15147.stgit@pc1117.cambridge.arm.com>
	<4B9A7A3C.9000304@users.sourceforge.net>
Message-ID: <20100312211614.GC1146@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 12, 2010 at 06:30:36PM +0100, Anders Grafstr?m wrote:
> This commit seems to have broken things for ARM720T and it looks like
> the removal of the "mov r0, r0" instruction in restore_user_regs is
> what caused it.
> 
> The patch below makes it work again but why?

Because the 'add' instruction will end up touching the _userspace_
stack pointer, not the SVC stack pointer.

It's a question of timing in the core - the ldmdb instruction accesses
the user sp+lr, which is still in progress when the following instruction
is executed.  So, referencing 'sp' in the following instruction ends up
hitting the user mode stack pointer.

I'm surprised this hasn't caused more problems - there is a stipulated
requirement that banked registers are _NOT_ accessed by the instruction
following a ldm { }^ instruction - this requirement goes all the way up
to V5T as defined by DDI0100I and below:

  In ARM architecture versions earlier than ARMv6, this form of LDM must
  not be followed by an instruction that accesses banked registers. A
  following NOP is a good way to ensure this.

So yes, your patch is absolutely required - all ARMv5 and below are
facing a hazard as the kernel stands.  It might explain some of the
weird behaviours people have been reporting as well.

Please cleanup the description and submit to the patch system.
