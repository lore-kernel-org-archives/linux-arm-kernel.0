From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 14 Jun 2017 11:10:42 +0200
Subject: [PATCH 1/2] clocksource/drivers/arm_arch_timer: Fix read and iounmap
 of incorrect variable
In-Reply-To: <20170614091021.GG2261@mai>
References: <20170614091021.GG2261@mai>
Message-ID: <1497431443-14634-1-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Frank Rowand <frank.rowand@sony.com>

Fix boot warning 'Trying to vfree() nonexistent vm area'
from arch_timer_mem_of_init().

Refactored code attempts to read and iounmap using address frame
instead of address ioremap(frame->cntbase).

Fixes: c389d701dfb70 ("clocksource: arm_arch_timer: split MMIO timer probing.")

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
Reviewed-by: Fu Wei <fu.wei@linaro.org>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/arm_arch_timer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 4bed671..8b5c300 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -1209,9 +1209,9 @@ arch_timer_mem_frame_get_cntfrq(struct arch_timer_mem_frame *frame)
 		return 0;
 	}
 
-	rate = readl_relaxed(frame + CNTFRQ);
+	rate = readl_relaxed(base + CNTFRQ);
 
-	iounmap(frame);
+	iounmap(base);
 
 	return rate;
 }
-- 
2.7.4
