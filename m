From: will.deacon@arm.com (Will Deacon)
Date: Tue,  8 Nov 2011 15:52:55 +0000
Subject: [PATCH v5 0/8] kexec fixes and soft restart code
Message-ID: <1320767583-21162-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This is version 5 of the patches originally posted here:

v1: http://lists.infradead.org/pipermail/linux-arm-kernel/2011-June/052157.html
v2: http://lists.infradead.org/pipermail/linux-arm-kernel/2011-June/052559.html
v3: http://lists.infradead.org/pipermail/linux-arm-kernel/2011-June/053252.html
v4: http://lists.infradead.org/pipermail/linux-arm-kernel/2011-August/062305.html

This time around, the patches are based on top of Russell's reset branch,
where soft restart on ARMv6 onwards is starting to look like a reality.

Notable changes from previous versions of this code are:
	- The identity map pgd is now populated at init time and is
	  static to idmap.c
	- The reserved stack page is no more
	- The temporary restart stack is simply a static array

The reserved stack page disappeared after feedback from Nicolas suggesting
that using a known physical location for the secondary CPU pen is ripe for
bootloader abuse. Although I can think of ways around this, having to maintain
this in future kernels could become tricky so I got rid of the idea.
Furthermore, talks at the ARM workshop in Prague revealed that most SMP SoCs
have hardware for controlling SMP boot anyway, so a purely software solution
is not usually needed (the exception being boards from ARM Ltd.).

The removal of the stack page means that we need to use a static array for
the stack prior to turning off the MMU. It looks to me like we currently only
need 6 stack slots [__soft_restart (-4), setup_mm_for_reboot (-2)] so I've
allocated 32 to be safe. Is there a way GCC can help us here?

The first patch (revert) is present in Russell's fixes branch but I'm
including it here for completeness. The fourth and fifth patches may
also need to be combined as it doesn't make sense to apply one without
the other.

As per usual, all feedback is welcome.

Cheers,

Will


Will Deacon (8):
  Revert "ARM: 7098/1: kdump: copy kernel relocation code at the kexec
    prepare stage"
  ARM: lib: add call_with_stack function for safely changing stack
  ARM: idmap: populate identity map pgd at init time
  ARM: reset: allow kernelspace mappings to be flat mapped during reset
  ARM: reset: implement soft_restart for jumping to a physical address
  ARM: soft_restart: disable the outer L2 when the last CPU is going
    down
  ARM: stop: execute platform callback from cpu_stop code
  ARM: kexec: use soft_restart for branching to the reboot buffer

 arch/arm/Kconfig                |    2 +-
 arch/arm/kernel/machine_kexec.c |   50 ++++++++++++++---------------------
 arch/arm/kernel/process.c       |   55 ++++++++++++++++++++++++++++++--------
 arch/arm/kernel/smp.c           |    4 +++
 arch/arm/lib/Makefile           |    3 +-
 arch/arm/lib/call_with_stack.S  |   44 +++++++++++++++++++++++++++++++
 arch/arm/mm/idmap.c             |   37 ++++++++++++++++++++------
 7 files changed, 142 insertions(+), 53 deletions(-)
 create mode 100644 arch/arm/lib/call_with_stack.S

-- 
1.7.4.1
