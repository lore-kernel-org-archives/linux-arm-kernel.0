From: yooyoo.yoo@samsung.com (YoungHyun Yoo)
Date: Thu, 11 Aug 2016 02:08:52 +0900
Subject: [PATCH] ARM: kexec: use kmap to get control_code_page addr
Message-ID: <20160810170852.29728-1-yooyoo.yoo@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the kexec-tools preload the crash_kernel via kexec_load
system call, it uses the kmap. If the preserved physical memory
address is located not in ZONE_NORMAL, tool will use highmem.
When it does use highmem, in the machine_kexec(), the function
tries to map physical memory address by using page_address,
which return NULL and make OOPS.

This patch fix the problem the above problem by using kmap instead
of using page_address function for mapping physical memory address.

Signed-off-by: YoungHyun Yoo <yooyoo.yoo@samsung.com>
---
 arch/arm/kernel/machine_kexec.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
index 59fd0e2..f187c20 100644
--- a/arch/arm/kernel/machine_kexec.c
+++ b/arch/arm/kernel/machine_kexec.c
@@ -157,7 +157,7 @@ void machine_kexec(struct kimage *image)
 
 	page_list = image->head & PAGE_MASK;
 
-	reboot_code_buffer = page_address(image->control_code_page);
+	reboot_code_buffer = kmap(image->control_code_page);
 
 	/* Prepare parameters for reboot_code_buffer*/
 	set_kernel_text_rw();
@@ -175,6 +175,8 @@ void machine_kexec(struct kimage *image)
 	/* get the identity mapping physical address for the reboot code */
 	reboot_entry_phys = virt_to_idmap(reboot_entry);
 
+	kunmap(image->control_code_page);
+
 	pr_info("Bye!\n");
 
 	if (kexec_reinit)
-- 
2.9.0.GIT
