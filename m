From: geoff@infradead.org (Geoff Levand)
Date: Tue, 24 Nov 2015 22:25:34 +0000
Subject: [PATCH v12 16/16] arm64: kdump: relax BUG_ON() if more than one cpus
 are still active
In-Reply-To: <cover.1448403503.git.geoff@infradead.org>
References: <cover.1448403503.git.geoff@infradead.org>
Message-ID: <83db66df70fc1f7cd4da8b580d264b9320991cf0.1448403503.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: AKASHI Takahiro <takahiro.akashi@linaro.org>

We should try best in case of kdump.
So even if not all secondary cpus have shut down, we do kdump anyway.
---
 arch/arm64/kernel/machine_kexec.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index d2d7e90..482aae7 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -148,7 +148,13 @@ void machine_kexec(struct kimage *kimage)
 	phys_addr_t reboot_code_buffer_phys;
 	void *reboot_code_buffer;
 
-	BUG_ON(num_online_cpus() > 1);
+	if (num_online_cpus() > 1) {
+		if (in_crash_kexec)
+			pr_warn("kdump might fail because %d cpus are still online\n",
+					num_online_cpus());
+		else
+			BUG();
+	}
 
 	reboot_code_buffer_phys = page_to_phys(kimage->control_code_page);
 	reboot_code_buffer = phys_to_virt(reboot_code_buffer_phys);
-- 
2.5.0
