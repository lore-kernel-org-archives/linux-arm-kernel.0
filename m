From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Tue,  6 Mar 2018 19:23:00 +0900
Subject: [PATCH v2 4/7] x86: kexec_file: remove X86_64 dependency from
 prepare_elf64_headers()
In-Reply-To: <20180306102303.9063-1-takahiro.akashi@linaro.org>
References: <20180306102303.9063-1-takahiro.akashi@linaro.org>
Message-ID: <20180306102303.9063-5-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The code guarded by CONFIG_X86_64 is necessary on some architectures
which have a dedicated kernel mapping outside of linear memory mapping.
(arm64 is among those.)

In this patch, an additional argument, kernel_map, is added to enable/
disable the code removing #ifdef.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Dave Young <dyoung@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
---
 arch/x86/kernel/crash.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 2123fa0efc17..b328153cee65 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -347,7 +347,7 @@ static int prepare_elf64_ram_headers_callback(struct resource *res, void *arg)
 	return 0;
 }
 
-static int prepare_elf64_headers(struct crash_elf_data *ced,
+static int prepare_elf64_headers(struct crash_elf_data *ced, bool kernel_map,
 		void **addr, unsigned long *sz)
 {
 	Elf64_Ehdr *ehdr;
@@ -414,17 +414,17 @@ static int prepare_elf64_headers(struct crash_elf_data *ced,
 	phdr->p_filesz = phdr->p_memsz = VMCOREINFO_NOTE_SIZE;
 	(ehdr->e_phnum)++;
 
-#ifdef CONFIG_X86_64
 	/* Prepare PT_LOAD type program header for kernel text region */
-	phdr = (Elf64_Phdr *)bufp;
-	bufp += sizeof(Elf64_Phdr);
-	phdr->p_type = PT_LOAD;
-	phdr->p_flags = PF_R|PF_W|PF_X;
-	phdr->p_vaddr = (Elf64_Addr)_text;
-	phdr->p_filesz = phdr->p_memsz = _end - _text;
-	phdr->p_offset = phdr->p_paddr = __pa_symbol(_text);
-	(ehdr->e_phnum)++;
-#endif
+	if (kernel_map) {
+		phdr = (Elf64_Phdr *)bufp;
+		bufp += sizeof(Elf64_Phdr);
+		phdr->p_type = PT_LOAD;
+		phdr->p_flags = PF_R|PF_W|PF_X;
+		phdr->p_vaddr = (Elf64_Addr)_text;
+		phdr->p_filesz = phdr->p_memsz = _end - _text;
+		phdr->p_offset = phdr->p_paddr = __pa_symbol(_text);
+		(ehdr->e_phnum)++;
+	}
 
 	/* Go through all the ranges in cmem->ranges[] and prepare phdr */
 	for (i = 0; i < cmem->nr_ranges; i++) {
@@ -477,7 +477,7 @@ static int prepare_elf_headers(struct kimage *image, void **addr,
 		goto out;
 
 	/* By default prepare 64bit headers */
-	ret =  prepare_elf64_headers(ced, addr, sz);
+	ret =  prepare_elf64_headers(ced, IS_ENABLED(CONFIG_X86_64), addr, sz);
 	if (ret)
 		goto out;
 
-- 
2.16.2
