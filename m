From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 23 Nov 2018 10:41:51 +0100
Subject: [PATCH v3 1/2] bpf: add __weak hook for allocating executable memory
In-Reply-To: <20181123094152.21368-1-ard.biesheuvel@linaro.org>
References: <20181123094152.21368-1-ard.biesheuvel@linaro.org>
Message-ID: <20181123094152.21368-2-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

By default, BPF uses module_alloc() to allocate executable memory,
but this is not necessary on all arches and potentially undesirable
on some of them.

So break out the module_alloc() and module_memfree() calls into __weak
functions to allow them to be overridden in arch code.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 kernel/bpf/core.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 1a796e0799ec..572dd74c26e3 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -609,6 +609,16 @@ static void bpf_jit_uncharge_modmem(u32 pages)
 	atomic_long_sub(pages, &bpf_jit_current);
 }
 
+void *__weak bpf_jit_alloc_exec(unsigned long size)
+{
+	return module_alloc(size);
+}
+
+void __weak bpf_jit_free_exec(const void *addr)
+{
+	module_memfree(addr);
+}
+
 struct bpf_binary_header *
 bpf_jit_binary_alloc(unsigned int proglen, u8 **image_ptr,
 		     unsigned int alignment,
@@ -626,7 +636,7 @@ bpf_jit_binary_alloc(unsigned int proglen, u8 **image_ptr,
 
 	if (bpf_jit_charge_modmem(pages))
 		return NULL;
-	hdr = module_alloc(size);
+	hdr = bpf_jit_alloc_exec(size);
 	if (!hdr) {
 		bpf_jit_uncharge_modmem(pages);
 		return NULL;
@@ -650,7 +660,7 @@ void bpf_jit_binary_free(struct bpf_binary_header *hdr)
 {
 	u32 pages = hdr->pages;
 
-	module_memfree(hdr);
+	bpf_jit_free_exec(hdr);
 	bpf_jit_uncharge_modmem(pages);
 }
 
-- 
2.17.1
