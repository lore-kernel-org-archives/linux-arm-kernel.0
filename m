From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 25 Nov 2015 13:51:02 -0800
Subject: [PATCH v2 0/2] ARM: Use udiv/sdiv for __aeabi_{u}idiv library
 functions
Message-ID: <1448488264-23400-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a respin of a patch series from about a year ago[1]. I realized
that we already had most of the code in recordmcount to figure out
where we make calls to particular functions, so recording where
we make calls to the integer division functions should be easy enough
to add support for using the same design. Looking back on the thread
it seems like Mans was thinking along the same lines, although it wasn't
obvious to me back then or even over the last few days when I wrote this.

This series copies and reworks recordmcount to record the locations of the
calls to the library integer division functions on ARM builds, and puts those
locations into a table that we use to patch instructions at boot. The first
patch adds the recorduidiv program, and the second patch implements the
runtime patching for modules and kernel code. The module part hooks into
the relocation patching code we already have.

The discussion surrounding adding ARMv7VE so that this patchset isn't
as necessary is still on going, so I'm just sending out these patches for
now. Assuming we can come to a conclusion on how to implement ARMv7VE
I'll finish up those patches.

Comments/feedback appreciated.

Changes from v1:
 * Add suport for PJ4 udiv/sdiv mrc opcodes
 * Create a new program for recording uidiv instead of modifying recordmcount

[1] http://lkml.kernel.org/r/1383951632-6090-1-git-send-email-sboyd at codeaurora.org

Cc: Nicolas Pitre <nico@fluxnic.net>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: M?ns Rullg?rd <mans@mansr.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Michal Marek <mmarek@suse.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>

Stephen Boyd (2):
  scripts: Add a recorduidiv program
  ARM: Replace calls to __aeabi_{u}idiv with udiv/sdiv instructions

 arch/arm/Kconfig               |  14 +
 arch/arm/include/asm/cputype.h |   8 +-
 arch/arm/include/asm/setup.h   |   3 +
 arch/arm/kernel/module.c       |  40 +++
 arch/arm/kernel/setup.c        |  68 ++++
 arch/arm/kernel/vmlinux.lds.S  |  13 +
 scripts/Makefile               |   1 +
 scripts/Makefile.build         |  17 +-
 scripts/recorduidiv.c          | 745 +++++++++++++++++++++++++++++++++++++++++
 9 files changed, 906 insertions(+), 3 deletions(-)
 create mode 100644 scripts/recorduidiv.c

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
