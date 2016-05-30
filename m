From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 30 May 2016 22:35:29 +0100
Subject: Possible race between PTRACE_SETVFPREGS and PTRACE_CONT on ARM?
In-Reply-To: <574C7CDB.7050103@ericsson.com>
References: <574C7CDB.7050103@ericsson.com>
Message-ID: <20160530213529.GS19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 30, 2016 at 01:48:11PM -0400, Simon Marchi wrote:
> Hello knowledgeable ARM people!
> 
> (Background: https://sourceware.org/ml/gdb/2016-05/msg00020.html )
> 
> Debugging a flaky GDB test case on ARM lead me to think there might
> be race between PTRACE_SETVFPREGS and PTRACE_CONT on ARM
> (PTRACE_SETVFPREGS is ARM-specific anyway).  The test case (and the
> reproducer below) changes the value of a VFP register (let's say d0)
> using PTRACE_SETVFPREGS and resumes the thread with PTRACE_CONT.  It
> happens intermittently that the thread resumes execution with the
> old value in d0 instead of the new one.

So, I thought I'd look into this, and what I see here on my systems
(whether it be Marvell Dove or iMX6) is that the program always exits
with a return code of 1.

Investigation on the Marvell Dove platform leads me to conclude that
Ubuntu 14.04 gdb (7.7.1-0ubuntu5~14.04.2) is built without support for
VFP - if I add an "info float" into the gdb script, I get:

Breakpoint 1, break_here () at test.S:8
8             vmrs APSR_nzcv, fpscr
No floating-point info available for this processor.

which is incredibly annoying, because it means that your "p $d0 = 4.0"
line has no effect on the VFP state - hence why its always exiting with
1.

However, if we look closer, we see that gdb has decided to put the
breakpoint _after_ the comparison instruction, as confirmed by the
disassembly after the breakpoint is hit:

   0x00008108 <+0>:     vcmp.f64        d0, d1
=> 0x0000810c <+4>:     vmrs    APSR_nzcv, fpscr
   0x00008110 <+8>:     moveq   r0, #1

On iMX6, where I have Ubuntu 12.04 gdb (7.4-2012.04-0ubuntu2.1), "info
float" works as one expects, but we still end up with the program
exiting with a code of 1 - every time - because again, the breakpoint
is misplaced.

So, the gdb verisons I have here seem to be particularly poor - but with
some modifications, I can test out on iMX6 by forcing gdb to do the right
thing - by inserting a couple of "mov r0, r0" instructions after the
"break_here" label.

With that, on a single CPU, it seems to work correctly every time, but
if I bring up a secondary CPU I start seeing the same problems you've
reported - which seems to need the following patch to solve.  Please can
you check whether this resolves your problem?

Thanks.

 arch/arm/kernel/ptrace.c | 2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index ef9119f7462e..4d9375814b53 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -733,8 +733,8 @@ static int vfp_set(struct task_struct *target,
 	if (ret)
 		return ret;
 
-	vfp_flush_hwstate(thread);
 	thread->vfpstate.hard = new_vfp;
+	vfp_flush_hwstate(thread);
 
 	return 0;
 }


-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
