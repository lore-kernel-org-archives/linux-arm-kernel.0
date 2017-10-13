From: shankerd@codeaurora.org (Shanker Donthineni)
Date: Fri, 13 Oct 2017 10:16:47 -0500
Subject: [PATCH v2] irqchip/gic-v3-its: Fix the incorrect BUG_ON in
 its_init_vpe_domain()
Message-ID: <1507907807-10148-1-git-send-email-shankerd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver probe path hits 'BUG_ON(entries != vpe_proxy.dev->nr_ites)'
on systems where it has VLPI capability, doesn't support direct LPI
feature and boot with a single CPU.

Relax the BUG_ON() condition to fix the issue.

Crash log messages on QDF2400 when booting with a single core.

------------[ cut here ]------------
kernel BUG at /v4.14-rc2/kernel/drivers/irqchip/irq-gic-v3-its.c:2854!
Internal error: Oops - BUG: 0 [#1] SMP
0.000000] Modules linked in:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.14.0+ #5
[<ffff000008c2edd8>] its_init+0x310/0x370
[<ffff000008c2da94>] gic_init_bases+0x18c/0x29c
[<ffff000008c2de94>] gic_acpi_init+0x118/0x234
[<ffff000008c31f74>] acpi_match_madt+0x44/0x78
[<ffff000008c30a34>] acpi_table_parse_entries_array+0x11c/0x1e0
[<ffff000008c30b20>] acpi_table_parse_entries+0x28/0x30
[<ffff000008c30b4c>] acpi_table_parse_madt+0x24/0x2c
[<ffff000008c32234>] __acpi_probe_device_table+0x80/0xdc
[<ffff000008c2c760>] irqchip_init+0x30/0x38
[<ffff000008c123e8>] init_IRQ+0xb4/0xe8
[<ffff000008c10a10>] start_kernel+0x238/0x3a0
Code: 14000011 b9407802 6b15005f 54000040 (d4210000)
---[ end trace 4defdcd9ed65d530 ]---

Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
---
Changes since v1:
  -Added crash log messages to commit text.

 drivers/irqchip/irq-gic-v3-its.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 4b598b6..83220f7 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -2921,7 +2921,7 @@ static int its_init_vpe_domain(void)
 		return -ENOMEM;
 	}
 
-	BUG_ON(entries != vpe_proxy.dev->nr_ites);
+	BUG_ON(entries > vpe_proxy.dev->nr_ites);
 
 	raw_spin_lock_init(&vpe_proxy.lock);
 	vpe_proxy.next_victim = 0;
-- 
Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
