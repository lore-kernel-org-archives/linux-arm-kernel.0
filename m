From: jy0922.shim@samsung.com (Joonyoung Shim)
Date: Tue, 17 Jan 2017 13:54:36 +0900
Subject: [PATCH] clocksource: exynos_mct: clear irq at stop local mct to fix
 suspend
References: <CGME20170117045403epcas1p1c64f1563c31947059430e0fbf370ee75@epcas1p1.samsung.com>
Message-ID: <1484628876-22065-1-git-send-email-jy0922.shim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds clear interrupt to exynos4_mct_dying_cpu(). Without
clearing, after turning on non boot cpu at wakeup from suspend to
ram, not cleared tick interrupt occurs and it causes following null
deference for MCT_INT_SPI type mct.

[   51.251378] Unable to handle kernel NULL pointer dereference at virtual address 00000040
[   51.257980] pgd = c0004000
[   51.260666] [00000040] *pgd=00000000
[   51.264222] Internal error: Oops: 5 [#1] PREEMPT SMP ARM
[   51.269503] Modules linked in:
[   51.272541] CPU: 7 PID: 53 Comm: ksoftirqd/7 Tainted: G        W 4.9.0-rc7-next-20161201-00007-g74076859ec44 #140
[   51.283282] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[   51.289348] task: ee942d00 task.stack: ee960000
[   51.293861] PC is at tick_periodic+0x38/0xb0
[   51.298102] LR is at tick_handle_periodic+0x1c/0x90
[   51.302956] pc : [<c0183358>]    lr : [<c01833ec>]    psr: 20000093
[   51.302956] sp : ee961e18  ip : f0806000  fp : 00000100
[   51.314391] r10: c0c0ef6a  r9 : 0000000b  r8 : eebcf080
[   51.319591] r7 : ee961e7c  r6 : 00000000  r5 : 00000007  r4 : ef013ec0
[   51.326090] r3 : 00000000  r2 : 2e4ac000  r1 : c09ae9a8  r0 : 00000007
[   51.332591] Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM Segment none
[   51.339781] Control: 10c5387d  Table: 4000406a  DAC: 00000051
[   51.345501] Process ksoftirqd/7 (pid: 53, stack limit = 0xee960210)
[   51.351740] Stack: (0xee961e18 to 0xee962000)
[   51.356073] 1e00: ef014db0 c0c03dac
[   51.364222] 1e20: 00000000 ef013ec0 ee854100 00000000 ee961e7c 00000039 ee854100 c0c0ef6a
[   51.372367] 1e40: 00000100 c055bd44 ee852840 c0164a18 00000000 00000001 ee854100 ee854100
[   51.380512] 1e60: c0c03f24 c0b6324c c0c02080 c0c02080 40000006 c0164ac4 00000000 00000000
[   51.388658] 1e80: 00000100 ee854100 ee854160 c0164b38 ee854100 ee854160 c0c03f24 c0167e9c
[   51.396804] 1ea0: 00000039 c0c0cbac c0c0cbac c0b6324c c0c02080 c01675e0 c0c0cc5c c0c0cc60
[   51.404949] 1ec0: 00000000 c011fd3c 00000000 00000006 c0c02098 ee960000 c0c02080 c011ff6c
[   51.413095] 1ee0: ee961f0c c06fb4a4 ee961ee0 c0c47f80 0000000a ffff9ed5 c0c03900 04208040
[   51.421240] 1f00: c0c0a174 ee960000 ee867b00 00000007 00000001 c0c0a174 00000002 00000000
[   51.429385] 1f20: 00000000 c01200b8 ee960000 c013a50c 00000000 ee867b80 ee867b00 c013a3b0
[   51.437530] 1f40: 00000000 00000000 00000000 c0136cbc ffffffff 00000001 00000007 ee867b00
[   51.445676] 1f60: 00000000 00270027 dead4ead ffffffff ffffffff ee961f74 ee961f74 00000000
[   51.453822] 1f80: 00000000 dead4ead ffffffff ffffffff ee961f90 ee961f90 ee961fac ee867b80
[   51.461967] 1fa0: c0136be0 00000000 00000000 c0107a78 00000000 00000000 00000000 00000000
[   51.470112] 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[   51.478258] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000 ffffffff ffffffff
[   51.486409] [<c0183358>] (tick_periodic) from [<ef013ec0>] (0xef013ec0)
[   51.492990] Code: ee1d2f90 e34c30b6 e8bd4070 e7923003 (e5933040)
[   51.499057] ---[ end trace 995703fe1bede0b4 ]---

Fixes: 56a94f13919c ("clocksource: exynos_mct: Avoid blocking calls in the cpu hotplug notifier")
Cc: stable at vger.kernel.org #v4.2+ #v4.1.4+ #3.18.18+ #v3.16.18+ #v3.12.46+
Reported-by: Seung-Woo Kim <sw0312.kim@samsung.com>
Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
Signed-off-by: Seung-Woo Kim <sw0312.kim@samsung.com>
---
 drivers/clocksource/exynos_mct.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index 4da1dc2..670ff0f 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -495,6 +495,7 @@ static int exynos4_mct_dying_cpu(unsigned int cpu)
 	if (mct_int_type == MCT_INT_SPI) {
 		if (evt->irq != -1)
 			disable_irq_nosync(evt->irq);
+		exynos4_mct_write(0x1, mevt->base + MCT_L_INT_CSTAT_OFFSET);
 	} else {
 		disable_percpu_irq(mct_irqs[MCT_L0_IRQ]);
 	}
-- 
1.9.1
