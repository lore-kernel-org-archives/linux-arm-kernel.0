From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Nov 2017 16:57:56 +0000
Subject: [PATCH] arm: ensure dump_instr() checks addr_limit
In-Reply-To: <20171102163452.7652-1-mark.rutland@arm.com>
References: <20171102163452.7652-1-mark.rutland@arm.com>
Message-ID: <20171102165755.GG9463@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 02, 2017 at 04:34:52PM +0000, Mark Rutland wrote:
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> 
> When CONFIG_DEBUG_USER is enabled, it's possible for a user to
> deliberately trigger dump_instr() with a chosen kernel address.

Hi Mark,

Please show how userspace could trigger that, as I don't think it's
possible.  Firstly, you need to set PC to a kernel address, which
will trigger an abort.

When that happens, we'll get a section permission fault, and head
to do_sect_fault().  This will call do_bad_area(), which will detect
that it's a userspace fault (because of the CPSR value).

This calls show_pte() and show_regs().  show_pte() shows the page
table values only.  show_regs() shows the register values, and then
dumps the kernel stack via show_stack().  Nothing in this path calls
dump_instr().

The places where dump_instr() is called from are:

	die()
	do_undefinstr()
	bad_syscall()
	arm_syscall()
	baddataabort() (only for late v4 faulting architectures)

The last four all need the CPU to have read and attempted to execute
the instruction, so the permission checks must have passed.  Userspace
can't achieve that by setting the PC to a kernel address.

die() is called when we enter an exception in an invalid mode, or we
have a kernel mode fault (CPSR in kernel mode) that we can't handle,
we have fault handling disabled (never the case when running user
code), or we have no mm (kernel thread).

So, I don't see how the kernel could be provoked to dump instructions
from kernel space by the user.

Please show a working example.

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
