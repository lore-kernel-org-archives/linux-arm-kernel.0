From: abelvesa@linux.com (Abel Vesa)
Date: Tue,  6 Dec 2016 17:06:00 +0000
Subject: [PATCH 0/7] arm: Add livepatch support
Message-ID: <1481043967-15602-1-git-send-email-abelvesa@linux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is just an idea I've been trying out for a while now. 

Just in case somebody wants to play with it, this applies to linux-arm/for-next.

Also please note that this was only tested in qemu, but I will do some testing 
on some real hardware in the following days.

FWICT, on this arch the compiler always generates a function prologue somewhere
between these lines:

e1a0c00d        mov     ip, sp
e92ddff0        push    {r4-r9, sl, fp, ip, lr, pc}
e24cb004        sub     fp, ip, #4
e24dd064        sub     sp, sp, #100    ; 0x64 <--- local variables
e52de004        push    {lr}            ; (str lr, [sp, #-4]!)
ebf9c2c9        bl      80110364 <__gnu_mcount_nc>
....

Every function that follows this pattern (the number of registers pushed and the
sp subtraction for the local variables being the only acceptable exception) can
be patched with this mechanism. IIRC, only the inline functions and notrace 
functions do not follow this pattern.

Considering that the function is livepatchable, when the time comes to call
ftrace_call, the ftrace_regs_caller is called instead.

Because this arch didn't have a ftrace with regs implementation, the
ftrace_regs_caller was added.

This new function adds the regs saving/restoring part, plus the part necessary
for the livepatch mechanism to work. After the regs are saved and the r3 is set
to contain the sp's value, we're keeping the old pc into r10 in order to be
checked later against the new pc.

Next, the r1 and r0 are set for the ftrace_func, then, the ftrace_stub is called
and the klp_ftrace_handler overwrites the old pc with the new one.

Here comes the tricky part. We're checking if the pc is still the old one, if it
is we jump the whole livepatching and go ahead with restoring the saved regs.

If the pc is modified, it means we're livepatching current function and we need
to pop all regs from r1 through r12, jump over the next two regs saved on stack
(we're not interested in those since we're trying to get the same regs context
as it was at the point the function-to-be-patched was called) and put the new pc
into r11.

Since r12 contains the sp from when the function just got branched to, we need
to set the sp back to that.

Then we need to put the new pc on stack so that when we're popping r11 through 
pc, we will actually jump to the first instruction from the new function.

We don't need to worry about the returning phase since the epilogue of the new
function will take care of that and from there on everything goes back to 
normal.

The whole advantage of this over adding compiler support is that we're not
introducing nops at the beginning of the function. As a matter of fact, we're
not changing anything between an image with livepatch and an image without it
(except the ftrace_regs_call addition and the livepatch necessary code).

As for the implementation of the ftrace_regs_caller, I still think there might
be some unsafe stack handling since I'm getting some build warnings. Those are
due to pushing/popping of a list of regs in which the sp resides. I'll try to 
get around those in a next iteration (if necessary), but first I would like to
hear some opinions about this work and if it's worth going forward.

Everything else should be pretty straightforward, so I'll skip explaining that.

Abel Vesa (7):
  arm: Add livepatch arch specific code
  arm: ftrace: Add call modify mechanism
  arm: module: Add apply_relocate_add
  arm: Add ftrace with regs support
  arm: ftrace: Add ARCH_SUPPORTS_FTRACE_OPS for ftrace with regs
  arm: Add livepatch to build if CONFIG_LIVEPATCH
  arm: Add livepatch necessary arch selects into Kconfig

 MAINTAINERS                      |  3 +++
 arch/arm/Kconfig                 |  4 ++++
 arch/arm/include/asm/ftrace.h    |  4 ++++
 arch/arm/include/asm/livepatch.h | 46 +++++++++++++++++++++++++++++++++++++
 arch/arm/kernel/Makefile         |  1 +
 arch/arm/kernel/entry-ftrace.S   | 49 ++++++++++++++++++++++++++++++++++++++++
 arch/arm/kernel/ftrace.c         | 21 +++++++++++++++++
 arch/arm/kernel/livepatch.c      | 43 +++++++++++++++++++++++++++++++++++
 arch/arm/kernel/module.c         |  9 ++++++++
 9 files changed, 180 insertions(+)
 create mode 100644 arch/arm/include/asm/livepatch.h
 create mode 100644 arch/arm/kernel/livepatch.c

-- 
2.7.4
