From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu, 15 Nov 2018 14:52:44 +0900
Subject: [PATCH v16 05/16] kexec_file: kexec_walk_memblock() only walks a
 dedicated region at kdump
In-Reply-To: <20181115055254.2812-1-takahiro.akashi@linaro.org>
References: <20181115055254.2812-1-takahiro.akashi@linaro.org>
Message-ID: <20181115055254.2812-6-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In kdump case, there exists only one dedicated memblock region as usable
memory (crashk_res). With this patch, kexec_walk_memblock() runs a given
callback function on this region.

Cosmetic change: 0 to MEMBLOCK_NONE at for_each_free_mem_range*()

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Acked-by: Dave Young <dyoung@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
---
 kernel/kexec_file.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index d03195a8cb6e..f1d0e00a3971 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -515,8 +515,11 @@ static int kexec_walk_memblock(struct kexec_buf *kbuf,
 	phys_addr_t mstart, mend;
 	struct resource res = { };
 
+	if (kbuf->image->type == KEXEC_TYPE_CRASH)
+		return func(&crashk_res, kbuf);
+
 	if (kbuf->top_down) {
-		for_each_free_mem_range_reverse(i, NUMA_NO_NODE, 0,
+		for_each_free_mem_range_reverse(i, NUMA_NO_NODE, MEMBLOCK_NONE,
 						&mstart, &mend, NULL) {
 			/*
 			 * In memblock, end points to the first byte after the
@@ -530,8 +533,8 @@ static int kexec_walk_memblock(struct kexec_buf *kbuf,
 				break;
 		}
 	} else {
-		for_each_free_mem_range(i, NUMA_NO_NODE, 0, &mstart, &mend,
-					NULL) {
+		for_each_free_mem_range(i, NUMA_NO_NODE, MEMBLOCK_NONE,
+					&mstart, &mend, NULL) {
 			/*
 			 * In memblock, end points to the first byte after the
 			 * range while in kexec, end points to the last byte
-- 
2.19.0
