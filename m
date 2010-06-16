From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 16 Jun 2010 16:33:19 -0400
Subject: [PATCH 1/5] [ARM] implement arch_randomize_brk()
In-Reply-To: <1276720403-27918-1-git-send-email-nico@fluxnic.net>
References: <1276720403-27918-1-git-send-email-nico@fluxnic.net>
Message-ID: <1276720403-27918-2-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For this feature to take effect, CONFIG_COMPAT_BRK must be turned
off.  This can safely be turned off for any EABI user space versions.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/include/asm/elf.h |    3 +++
 arch/arm/kernel/process.c  |    7 +++++++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/elf.h b/arch/arm/include/asm/elf.h
index 51662fe..0a96e8c 100644
--- a/arch/arm/include/asm/elf.h
+++ b/arch/arm/include/asm/elf.h
@@ -121,4 +121,7 @@ int dump_task_regs(struct task_struct *t, elf_gregset_t *elfregs);
 extern void elf_set_personality(const struct elf32_hdr *);
 #define SET_PERSONALITY(ex)	elf_set_personality(&(ex))
 
+extern unsigned long arch_randomize_brk(struct mm_struct *mm);
+#define arch_randomize_brk arch_randomize_brk
+
 #endif
diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index acf5e6f..1c6eb7e 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -28,6 +28,7 @@
 #include <linux/tick.h>
 #include <linux/utsname.h>
 #include <linux/uaccess.h>
+#include <linux/random.h>
 
 #include <asm/leds.h>
 #include <asm/processor.h>
@@ -421,3 +422,9 @@ unsigned long get_wchan(struct task_struct *p)
 	} while (count ++ < 16);
 	return 0;
 }
+
+unsigned long arch_randomize_brk(struct mm_struct *mm)
+{
+	unsigned long range_end = mm->brk + 0x02000000;
+	return randomize_range(mm->brk, range_end, 0) ? : mm->brk;
+}
-- 
1.7.1.337.gbd0bc
