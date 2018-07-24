From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Tue, 24 Jul 2018 15:57:48 +0900
Subject: [PATCH v12 05/16] kexec_file: kexec_walk_memblock() only walks a
 dedicated region at kdump
In-Reply-To: <20180724065759.19186-1-takahiro.akashi@linaro.org>
References: <20180724065759.19186-1-takahiro.akashi@linaro.org>
Message-ID: <20180724065759.19186-6-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In kdump case, there exists only one dedicated memblock region as usable
memory (crashk_res). With this patch, kexec_walk_memblock() runs a given
callback function on this region.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Dave Young <dyoung@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
---
 kernel/kexec_file.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 2f0691b0f8ad..bb23f9280a7a 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -511,6 +511,9 @@ static int kexec_walk_memblock(struct kexec_buf *kbuf,
 	phys_addr_t mstart, mend;
 	struct resource res = { };
 
+	if (kbuf->image->type == KEXEC_TYPE_CRASH)
+		return func(&crashk_res, kbuf);
+
 	if (kbuf->top_down) {
 		for_each_free_mem_range_reverse(i, NUMA_NO_NODE, 0,
 						&mstart, &mend, NULL) {
-- 
2.18.0
