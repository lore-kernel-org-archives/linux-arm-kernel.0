From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu,  1 Dec 2016 10:44:32 +0000
Subject: [PATCH 0/2] Make arm64 headers self-contained
Message-ID: <1480589074-809-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wookey recently reported that the arm64 headers are not
self-contained, making it impossible to build external kernel modules
using DKMS and a distribution kernel-headers package. I do not condone
the use of out of tree modules, but there is no reason to be more
awkward than strictly necessary, and having standalone headers seems
to be a reasonable requirement.

The offenders are asm/opcodes.h, which drags its 32bit counterpart
despite only requiring a handful of macros, and a bunch of Xen files
that directly include their 32bit equivalent.

This series solves the issue in two ways:

- asm/opcodes.h is killed, and the few required macros moved added at
  the required locations

- asm/xen/* are brutally copied oved. It'd be better if they were
  placed in a common location (include/xen/ ?), but at least that
  solves it for now

Patches on top of -rc6.

Marc Zyngier (2):
  arm64: Get rid of asm/opcodes.h
  arm64: xen: Split architecture-specific headers from 32bit ARM

 arch/arm64/include/asm/opcodes.h           |   5 --
 arch/arm64/include/asm/sysreg.h            |  16 ++--
 arch/arm64/include/asm/xen/hypercall.h     |  88 ++++++++++++++++++++-
 arch/arm64/include/asm/xen/hypervisor.h    |  40 +++++++++-
 arch/arm64/include/asm/xen/interface.h     |  86 +++++++++++++++++++-
 arch/arm64/include/asm/xen/page-coherent.h |  99 ++++++++++++++++++++++-
 arch/arm64/include/asm/xen/page.h          | 123 ++++++++++++++++++++++++++++-
 arch/arm64/kernel/armv8_deprecated.c       |   5 +-
 arch/arm64/kernel/insn.c                   |   1 -
 9 files changed, 445 insertions(+), 18 deletions(-)
 delete mode 100644 arch/arm64/include/asm/opcodes.h

-- 
2.1.4
