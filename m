From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 06 Aug 2011 09:40:23 +0100
Subject: [PATCH] ARM: Fix build error for SMP=n builds
Message-ID: <E1QpcQh-00013p-N1@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Unfortunately, the module fixups cause the kernel to fail to build
when SMP is not enabled.  Fix this by removing the reference to
fixup_smp on non-SMP fixup kernels, but ensuring that if we do have
the SMP fixup section, we refuse to load the module.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/module.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
index 05b3776..cc2020c 100644
--- a/arch/arm/kernel/module.c
+++ b/arch/arm/kernel/module.c
@@ -323,7 +323,11 @@ int module_finalize(const Elf32_Ehdr *hdr, const Elf_Shdr *sechdrs,
 #endif
 	s = find_mod_section(hdr, sechdrs, ".alt.smp.init");
 	if (s && !is_smp())
+#ifdef CONFIG_SMP_ON_UP
 		fixup_smp((void *)s->sh_addr, s->sh_size);
+#else
+		return -EINVAL;
+#endif
 	return 0;
 }
 
-- 
1.7.4.4
