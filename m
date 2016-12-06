From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  6 Dec 2016 15:27:43 +0000
Subject: [PATCH v2 1/2] arm64: Add detection code for broken .inst support in
 binutils
In-Reply-To: <1481038065-32153-1-git-send-email-marc.zyngier@arm.com>
References: <1481038065-32153-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1481038065-32153-2-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Binutils version up to (and including) 2.25 have a pathological
behaviour when it comes to mixing .inst directive and arithmetic
involving labels. The assembler complains about non-constant
expressions and compilation stops pretty quickly.

In order to detect this and work around it, let's add a bit of
detection code that will set the CONFIG_BROKEN_GAS_INST option
should a broken gas be detected.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/Makefile | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 3635b86..b9a4a93 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -37,10 +37,16 @@ $(warning LSE atomics not supported by binutils)
   endif
 endif
 
-KBUILD_CFLAGS	+= -mgeneral-regs-only $(lseinstr)
+brokengasinst := $(call as-instr,1:\n.inst 0\n.rept . - 1b\n\nnop\n.endr\n,,-DCONFIG_BROKEN_GAS_INST=1)
+
+ifneq ($(brokengasinst),)
+$(warning Detected assembler with broken .inst; disassembly will be unreliable)
+endif
+
+KBUILD_CFLAGS	+= -mgeneral-regs-only $(lseinstr) $(brokengasinst)
 KBUILD_CFLAGS	+= -fno-asynchronous-unwind-tables
 KBUILD_CFLAGS	+= $(call cc-option, -mpc-relative-literal-loads)
-KBUILD_AFLAGS	+= $(lseinstr)
+KBUILD_AFLAGS	+= $(lseinstr) $(brokengasinst)
 
 ifeq ($(CONFIG_CPU_BIG_ENDIAN), y)
 KBUILD_CPPFLAGS	+= -mbig-endian
-- 
2.1.4
