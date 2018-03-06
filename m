From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Tue,  6 Mar 2018 19:23:02 +0900
Subject: [PATCH v2 6/7] x86: kexec_file: clean up prepare_elf64_headers()
In-Reply-To: <20180306102303.9063-1-takahiro.akashi@linaro.org>
References: <20180306102303.9063-1-takahiro.akashi@linaro.org>
Message-ID: <20180306102303.9063-7-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

removing bufp variable in prepare_elf64_headers() makes the code simpler
and more understandable.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Dave Young <dyoung@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
---
 arch/x86/kernel/crash.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 0f20a6330bd6..24de3f13f40c 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -336,7 +336,7 @@ static int prepare_elf64_headers(struct crash_mem *cmem, bool kernel_map,
 	Elf64_Ehdr *ehdr;
 	Elf64_Phdr *phdr;
 	unsigned long nr_cpus = num_possible_cpus(), nr_phdr, elf_sz;
-	unsigned char *buf, *bufp;
+	unsigned char *buf;
 	unsigned int cpu, i;
 	unsigned long long notes_addr;
 	unsigned long mstart, mend;
@@ -361,9 +361,8 @@ static int prepare_elf64_headers(struct crash_mem *cmem, bool kernel_map,
 	if (!buf)
 		return -ENOMEM;
 
-	bufp = buf;
-	ehdr = (Elf64_Ehdr *)bufp;
-	bufp += sizeof(Elf64_Ehdr);
+	ehdr = (Elf64_Ehdr *)buf;
+	phdr = (Elf64_Phdr *)(ehdr + 1);
 	memcpy(ehdr->e_ident, ELFMAG, SELFMAG);
 	ehdr->e_ident[EI_CLASS] = ELFCLASS64;
 	ehdr->e_ident[EI_DATA] = ELFDATA2LSB;
@@ -379,33 +378,30 @@ static int prepare_elf64_headers(struct crash_mem *cmem, bool kernel_map,
 
 	/* Prepare one phdr of type PT_NOTE for each present cpu */
 	for_each_present_cpu(cpu) {
-		phdr = (Elf64_Phdr *)bufp;
-		bufp += sizeof(Elf64_Phdr);
 		phdr->p_type = PT_NOTE;
 		notes_addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpu));
 		phdr->p_offset = phdr->p_paddr = notes_addr;
 		phdr->p_filesz = phdr->p_memsz = sizeof(note_buf_t);
 		(ehdr->e_phnum)++;
+		phdr++;
 	}
 
 	/* Prepare one PT_NOTE header for vmcoreinfo */
-	phdr = (Elf64_Phdr *)bufp;
-	bufp += sizeof(Elf64_Phdr);
 	phdr->p_type = PT_NOTE;
 	phdr->p_offset = phdr->p_paddr = paddr_vmcoreinfo_note();
 	phdr->p_filesz = phdr->p_memsz = VMCOREINFO_NOTE_SIZE;
 	(ehdr->e_phnum)++;
+	phdr++;
 
 	/* Prepare PT_LOAD type program header for kernel text region */
 	if (kernel_map) {
-		phdr = (Elf64_Phdr *)bufp;
-		bufp += sizeof(Elf64_Phdr);
 		phdr->p_type = PT_LOAD;
 		phdr->p_flags = PF_R|PF_W|PF_X;
 		phdr->p_vaddr = (Elf64_Addr)_text;
 		phdr->p_filesz = phdr->p_memsz = _end - _text;
 		phdr->p_offset = phdr->p_paddr = __pa_symbol(_text);
-		(ehdr->e_phnum)++;
+		ehdr->e_phnum++;
+		phdr++;
 	}
 
 	/* Go through all the ranges in cmem->ranges[] and prepare phdr */
-- 
2.16.2
