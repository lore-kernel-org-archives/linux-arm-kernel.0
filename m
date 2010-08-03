From: seth.forshee@gmail.com (Seth Forshee)
Date: Tue, 3 Aug 2010 14:58:16 -0500
Subject: READ_IMPLIES_EXEC set when no GNU_STACK header present
Message-ID: <20100803195816.GB31111@ubuntu-workstation>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We recently noticed that all of our applications had the execute
permission set for any mappings with read permission on an ARMv6
platform. This is happening because the ELF images do not have a
GNU_STACK program header, causing executable_stack=EXSTACK_DEFAULT to be
passed to arm_elf_read_implies_exec(), and it immediately returns 1.

Is this intentional or just an oversight? The patch below removes
READ_IMPLIES_EXEC when GNU_STACK is not present; if this is the desired
behavior I can submit it to the patch system.



commit 6e6d10ae2b5967ce9e9ebe9ebcc6df26a6b57854
Author: Seth Forshee <seth.forshee@gmail.com>
Date:   Tue Aug 3 13:50:41 2010 -0500

    [ARM] enable NX support by default
    
    arm_elf_read_implies_exec() currently returns 1 unless non-
    executable stacks are explicitly requested. This results in
    READ_IMPLIES_EXEC being set for elf images without a GNU_STACK
    program header, even though executable stacks aren't actually
    being requested. This function should default to enabling NX when
    the architecture supports it for better security.
    
    Signed-off-by: Seth Forshee <seth.forshee@gmail.com>

diff --git a/arch/arm/kernel/elf.c b/arch/arm/kernel/elf.c
index d4a0da1..a2eaa6d 100644
--- a/arch/arm/kernel/elf.c
+++ b/arch/arm/kernel/elf.c
@@ -74,7 +74,7 @@ EXPORT_SYMBOL(elf_set_personality);
  */
 int arm_elf_read_implies_exec(const struct elf32_hdr *x, int executable_stack)
 {
-	if (executable_stack != EXSTACK_DISABLE_X)
+	if (executable_stack == EXSTACK_ENABLE_X)
 		return 1;
 	if (cpu_architecture() < CPU_ARCH_ARMv6)
 		return 1;
