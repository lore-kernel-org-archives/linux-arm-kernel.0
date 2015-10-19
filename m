From: geoff@infradead.org (Geoff Levand)
Date: Mon, 19 Oct 2015 23:38:54 +0000
Subject: [PATCH 16/16] arm64: kdump: relax BUG_ON() if more than one cpus are
 still active
In-Reply-To: <cover.1445297709.git.geoff@infradead.org>
References: <cover.1445297709.git.geoff@infradead.org>
Message-ID: <4cf0c03d6cd1cb4826bb5df679fbcdaf80be0b1c.1445297709.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: AKASHI Takahiro <takahiro.akashi@linaro.org>

We should try best in case of kdump.
So even if not all secondary cpus have shut down, we do kdump anyway.
---
 arch/arm64/kernel/machine_kexec.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index f315ee4..157c29b 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -139,7 +139,12 @@ void machine_kexec(struct kimage *image)
 	phys_addr_t reboot_code_buffer_phys;
 	void *reboot_code_buffer;
 
-	BUG_ON(num_online_cpus() > 1);
+	if (num_online_cpus() > 1) {
+		if (in_crash_kexec)
+			pr_warn("*\n* kdump might fail because %d cpus are still online\n*\n", num_online_cpus());
+		else
+			BUG();
+	}
 
 	kimage_head = image->head;
 
-- 
2.5.0
