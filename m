From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 07 Apr 2011 22:52:53 -0400 (EDT)
Subject: [PATCH 2/2] ARM: fix personality flag propagation across an exec
Message-ID: <alpine.LFD.2.00.1104072251390.28032@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Our SET_PERSONALITY() implementation was overwriting all existing
personality flags, including ADDR_NO_RANDOMIZE, making them unavailable
to processes being exec'd after a call to personality() in user space.
This prevents the gdb test suite from running successfully.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/kernel/elf.c |   19 +++++++++++++------
 1 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/arm/kernel/elf.c b/arch/arm/kernel/elf.c
index d4a0da1..8524d09 100644
--- a/arch/arm/kernel/elf.c
+++ b/arch/arm/kernel/elf.c
@@ -40,16 +40,23 @@ EXPORT_SYMBOL(elf_check_arch);
 void elf_set_personality(const struct elf32_hdr *x)
 {
 	unsigned int eflags = x->e_flags;
-	unsigned int personality = PER_LINUX_32BIT;
+	unsigned int personality = current->personality;
 
 	/*
+	 * Inherit most personality flags from parent, except for those
+	 * we're about to choose.  Beware: PER_LINUX_32BIT carries flag bits
+	 * outside of PER_MASK.
+	 */
+	personality &= ~(PER_MASK | PER_LINUX | PER_LINUX_32BIT);
+		
+	/*
 	 * APCS-26 is only valid for OABI executables
 	 */
-	if ((eflags & EF_ARM_EABI_MASK) == EF_ARM_EABI_UNKNOWN) {
-		if (eflags & EF_ARM_APCS_26)
-			personality = PER_LINUX;
-	}
-
+	if ((eflags & EF_ARM_EABI_MASK) == EF_ARM_EABI_UNKNOWN &&
+	    (eflags & EF_ARM_APCS_26))
+		personality |= PER_LINUX;
+	else
+		personality |= PER_LINUX_32BIT;
 	set_personality(personality);
 
 	/*
-- 
1.7.4
