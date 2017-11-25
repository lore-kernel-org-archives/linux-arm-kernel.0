From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Sat, 25 Nov 2017 11:33:02 +0000
Subject: [PATCH 0/2] Fix ftracetest issues
Message-ID: <20171125113302.GY31757@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ftracetest provokes the kernel to try and return to userspace addresses
in kernel mode.  These two patches prevent that.

The first patch, which I intend merging with Linus tonight, ensures that
we catch the condition before we hit userspace, meaning that there is no
possibility of executing user code while in kernel mode.

The second patch fixes the ftracetest issue itself by ensuring that it
is not possible to set a kprobe on any of the "special" assembler code.
Such code includes:
- the kernel primary/secondary CPU startup code
- exception entry code
- idmap code

This is because the conditions under which this code is executed does
not meet the kprobes requirements, which is basically that the
"function" is C-like - it does something and then returns to the parent,
and has a stack.  This is just not universally true of the above code.

This patch is larger than one may desire as we re-organise the sections
that some code ends up in, the way the unwinder works, and how we print
stack frames.

 arch/arm/include/asm/assembler.h | 18 ++++++++++++++++++
 arch/arm/include/asm/exception.h |  3 +--
 arch/arm/include/asm/sections.h  | 21 +++++++++++++++++++++
 arch/arm/include/asm/traps.h     | 12 ------------
 arch/arm/kernel/entry-armv.S     |  6 +-----
 arch/arm/kernel/entry-common.S   |  1 +
 arch/arm/kernel/entry-header.S   |  6 ++++++
 arch/arm/kernel/stacktrace.c     | 14 ++------------
 arch/arm/kernel/traps.c          |  4 ++--
 arch/arm/kernel/vmlinux.lds.S    |  6 +++---
 arch/arm/mm/fault.c              |  5 ++---
 arch/arm/probes/kprobes/core.c   | 14 +++++++++++---
 12 files changed, 68 insertions(+), 42 deletions(-)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
