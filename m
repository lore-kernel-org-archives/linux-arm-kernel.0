From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 26 Sep 2011 15:32:38 +0100
Subject: [RFC PATCH 0/3] ARM: mm: add L2 suspend/resume support
Message-ID: <1317047561-11020-1-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As a follow up to the last L2 resume patch on alkml:

http://www.spinics.net/lists/arm-kernel/msg141881.html

please have a look at this patchset and merge the required bits if needed,
in particular MMU off for L2 retention use case.

Description:

In order to support the deepest C-states on all ARM platforms, code to resume
L2 state could be added to the kernel to avoid reliance on bootloaders.

If L2 RAM is retained on power down, it is not cleaned on shutdown to preserve
its content and improve performance. Hence, L2 state should be restored before
the MMU is turned on, so that CPU resume code can search the data saved on
power down in the L2 cache.

This patch addresses this issue and extends outercache and l2x0 driver to
support L2 resume in a platform independent way, security issues 
notwithstanding that must be tackled separately.

Since the L2 should be enabled when the MMU is possibly off,
L2 physical address should be passed from platform code or retrieved from 
the device tree so that the code can be made generic and platform
independent. For that purpose, the signature of L2 init function has
to be upgraded.

The resume code should not use the stack and it must fetch data using 
program counter relative loads so that it does not matter if it is run 
in physical or virtual address space.

This patch depends on three patches:

ARM: 7090/1: CACHE-L2X0: filter start address can be 0 and is often 0
http://www.spinics.net/lists/arm-kernel/msg140126.html
available in rmk/for-next commit 2afda86d91b5f15a744182d7ddacf68f6a6054c9

ARM: 7080/1: l2x0: make sure I&D are not locked down on init
http://www.spinics.net/lists/arm-kernel/msg139119.html
available in rmk/for-next commit bac7e6ecf60933b68af910eb4c83a775a8b20b19

ARM: 7009/1: l2x0: Add OF based initialization
http://www.spinics.net/lists/arm-kernel/msg131123.htm
available in rmk/for-next commit 41c86ff5be44e26978282f86c20598181b999142

Platform code initializing L2 has not been patched (l2x0_init requires
a new parameter which is the physical base address) yet, waiting to
see if there are platforms that can take advantage of this code.

Tested on Samsung Origen within suspend and cpuidle code paths.
DT support compile tested.

Lorenzo Pieralisi (3):
  ARM: mm: add outercache resume hook
  ARM: mm: add l2x0 physical address parameter to init
  ARM: mm: add l2x0 suspend/resume support

 arch/arm/include/asm/hardware/cache-l2x0.h |   24 +++++-
 arch/arm/include/asm/outercache.h          |    7 ++
 arch/arm/kernel/asm-offsets.c              |   12 +++
 arch/arm/mm/Makefile                       |    3 +
 arch/arm/mm/cache-l2x0.c                   |   17 +++-
 arch/arm/mm/l2x0-sleep.S                   |  136 ++++++++++++++++++++++++++++
 6 files changed, 193 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm/mm/l2x0-sleep.S

-- 
1.7.4.4
