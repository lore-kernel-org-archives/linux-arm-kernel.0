From: rmk@arm.linux.org.uk (Russell King)
Date: Tue, 03 May 2016 11:21:49 +0100
Subject: [PATCH kexec-tools 09/32] kexec: phys_to_virt() must take unsigned
 long long
In-Reply-To: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
References: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
Message-ID: <E1axXSf-0004hl-PC@e0050434b2927.dyn.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

crashdump-elf.c passes unsigned long long addresses into phys_to_virt()
so make phys_to_virt() accept such addresses without truncating them.
This is important for ARM LPAE systems.

Signed-off-by: Russell King <rmk@arm.linux.org.uk>
---
 kexec/arch/arm/phys_to_virt.c | 2 +-
 kexec/crashdump.h             | 2 +-
 kexec/phys_to_virt.c          | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kexec/arch/arm/phys_to_virt.c b/kexec/arch/arm/phys_to_virt.c
index bcced52..c2fe2ea 100644
--- a/kexec/arch/arm/phys_to_virt.c
+++ b/kexec/arch/arm/phys_to_virt.c
@@ -14,7 +14,7 @@
  * http://lists.arm.linux.org.uk/lurker/message/20010723.185051.94ce743c.en.html
  */
 unsigned long
-phys_to_virt(struct crash_elf_info *elf_info, unsigned long paddr)
+phys_to_virt(struct crash_elf_info *elf_info, unsigned long long paddr)
 {
 	return paddr + elf_info->page_offset - phys_offset;
 }
diff --git a/kexec/crashdump.h b/kexec/crashdump.h
index 95f1f0c..96219a8 100644
--- a/kexec/crashdump.h
+++ b/kexec/crashdump.h
@@ -55,7 +55,7 @@ int crash_create_elf64_headers(struct kexec_info *info,
 unsigned long crash_architecture(struct crash_elf_info *elf_info);
 
 unsigned long phys_to_virt(struct crash_elf_info *elf_info,
-			   unsigned long paddr);
+			   unsigned long long paddr);
 
 unsigned long xen_architecture(struct crash_elf_info *elf_info);
 int xen_get_nr_phys_cpus(void);
diff --git a/kexec/phys_to_virt.c b/kexec/phys_to_virt.c
index 91b6d01..5e8c4e3 100644
--- a/kexec/phys_to_virt.c
+++ b/kexec/phys_to_virt.c
@@ -10,7 +10,7 @@
  * their own implementation.
  */
 unsigned long
-phys_to_virt(struct crash_elf_info *elf_info, unsigned long paddr)
+phys_to_virt(struct crash_elf_info *elf_info, unsigned long long paddr)
 {
 	return paddr + elf_info->page_offset;
 }
-- 
1.9.1
