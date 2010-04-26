From: ext-mika.1.westerberg@nokia.com (Mika Westerberg)
Date: Mon, 26 Apr 2010 12:03:30 +0300
Subject: [PATCH 1/2] kexec: add phys_offset field
In-Reply-To: <cover.1272271391.git.ext-mika.1.westerberg@nokia.com>
References: <cover.1272271391.git.ext-mika.1.westerberg@nokia.com>
Message-ID: <e376969c3d29696ce11488af59605ada56fdccff.1272271391.git.ext-mika.1.westerberg@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add new field 'phys_offset' to struct elf_info. This field is used to calculate
virtual address of PT_LOAD segment on architectures where physical memory
doesn't always start at address 0 (namely ARM).

Signed-off-by: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
---
 kexec/crashdump-elf.c |    9 ++++++++-
 kexec/crashdump.h     |    1 +
 2 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/kexec/crashdump-elf.c b/kexec/crashdump-elf.c
index 6bcef8d..1291174 100644
--- a/kexec/crashdump-elf.c
+++ b/kexec/crashdump-elf.c
@@ -236,7 +236,14 @@ int FUNC(struct kexec_info *info,
 		 * memory region.
 		 */
 		phdr->p_paddr = mstart;
-		phdr->p_vaddr = mstart + elf_info->page_offset;
+		/*
+		 * In some architectures (namely ARM), physical memory doesn't
+		 * always start at 0 so we need to calculate virtual address
+		 * based on elf_info->phys_offset like:
+		 *     virt = phys + page_offset - phys_offset
+		 */
+		phdr->p_vaddr = mstart + elf_info->page_offset -
+				elf_info->phys_offset;
 		phdr->p_filesz	= phdr->p_memsz	= mend - mstart + 1;
 		/* Do we need any alignment of segments? */
 		phdr->p_align	= 0;
diff --git a/kexec/crashdump.h b/kexec/crashdump.h
index 30d6f29..8c0ccda 100644
--- a/kexec/crashdump.h
+++ b/kexec/crashdump.h
@@ -27,6 +27,7 @@ struct crash_elf_info {
 	unsigned long backup_src_end;
 
 	unsigned long long page_offset;
+	unsigned long long phys_offset;
 	unsigned long lowmem_limit;
 
 	int (*get_note_info)(int cpu, uint64_t *addr, uint64_t *len);
-- 
1.5.6.5
