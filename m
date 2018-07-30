From: dave.kleikamp@oracle.com (Dave Kleikamp)
Date: Mon, 30 Jul 2018 10:29:21 -0500
Subject: [PATCH 1/1] arm64: kexec: machine_kexec should call
 __flush_icache_range
In-Reply-To: <faf6c7cb-d9da-9a9c-cc0f-43c95e864ca2@oracle.com>
References: <faf6c7cb-d9da-9a9c-cc0f-43c95e864ca2@oracle.com>
Message-ID: <e07fc674-2a71-29ae-2212-46ee5f79593d@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

machine_kexec flushes the reboot_code_buffer from the icache
after stopping the other cpus.

Commit 3b8c9f1cdfc5 ("arm64: IPI each CPU after invalidating the I-cache
for kernel mappings") added an IPI call to flush_icache_range, which
causes a hang here, so replace the call with __flush_icache_range

Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/machine_kexec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index f62effc..e8c0283 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -184,7 +184,7 @@ void machine_kexec(struct kimage *kimage)
 
 	/* Flush the reboot_code_buffer in preparation for its execution. */
 	__flush_dcache_area(reboot_code_buffer, arm64_relocate_new_kernel_size);
-	flush_icache_range((uintptr_t)reboot_code_buffer,
+	__flush_icache_range((uintptr_t)reboot_code_buffer,
 		arm64_relocate_new_kernel_size);
 
 	/* Flush the kimage list and its buffers. */
-- 
1.8.3.1
