From: geoff@infradead.org (Geoff Levand)
Date: Fri, 15 Jan 2016 19:18:38 +0000
Subject: [PATCH 19/19] arm64: kdump: relax BUG_ON() if more than one cpus are
 still active
In-Reply-To: <cover.1452884156.git.geoff@infradead.org>
References: <cover.1452884156.git.geoff@infradead.org>
Message-ID: <e52b39c76d2a967bdecc376daee07d6edd47b01a.1452884156.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: AKASHI Takahiro <takahiro.akashi@linaro.org>

We should try best in case of kdump.
So even if not all secondary cpus have shut down, we do kdump anyway.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm64/kernel/machine_kexec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index 0ba2ae4..3230551 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -157,7 +157,7 @@ void machine_kexec(struct kimage *kimage)
 	phys_addr_t reboot_code_buffer_phys;
 	void *reboot_code_buffer;
 
-	BUG_ON(num_online_cpus() > 1);
+	BUG_ON((num_online_cpus() > 1) && !WARN_ON(in_crash_kexec));
 
 	reboot_code_buffer_phys = page_to_phys(kimage->control_code_page);
 	reboot_code_buffer = kmap(kimage->control_code_page);
-- 
2.5.0
