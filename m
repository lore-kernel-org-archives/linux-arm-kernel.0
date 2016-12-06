From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  6 Dec 2016 15:27:42 +0000
Subject: [PATCH v2 0/2] arm64: Fix fallout of asm/opcodes.h removal
Message-ID: <1481038065-32153-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As part of the asm/opcodes.h removal, the SET_PSTATE_{PAN,UAO} macros
have been switch to using the .inst directive instead of .long (as
this has the advantage of providing a correct disassembly). This
had the side effect of bringing back an ugly gas bug that shows up
when .inst is used within alternative sequences.

This series works around the problem by:
- adding detection code for the broken binutils,
- work around the issue by falling back to .long when using a buggy
  assembler.

This has been tested with both binutils 2.25 (broken) and 2.27
(fixed), with both LE and BE builds.

Marc Zyngier (2):
  arm64: Add detection code for broken .inst support in binutils
  arm64: Work around broken .inst when defective gas is detected

 arch/arm64/Makefile             | 10 ++++++++--
 arch/arm64/include/asm/sysreg.h | 29 +++++++++++++++++++++++++----
 2 files changed, 33 insertions(+), 6 deletions(-)

-- 
2.1.4
