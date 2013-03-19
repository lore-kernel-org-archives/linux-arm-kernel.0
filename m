From: jon-hunter@ti.com (Jon Hunter)
Date: Tue, 19 Mar 2013 12:38:16 -0500
Subject: [PATCH 2/5] ARM: OMAP: Force dmtimer restore if context loss is not
 detectable
In-Reply-To: <1363714699-29622-1-git-send-email-jon-hunter@ti.com>
References: <1363714699-29622-1-git-send-email-jon-hunter@ti.com>
Message-ID: <1363714699-29622-3-git-send-email-jon-hunter@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When booting with device-tree the function pointer for detecting context
loss is not populated. Ideally, the pm_runtime framework should be
enhanced to allow a means for reporting context/state loss and we could
avoid populating such function pointers altogether. In the interim until
a generic non-device specific solution is in place, force a restore of
the dmtimer when enabling the timer.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/plat-omap/dmtimer.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 5cae1dd..725d972 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -326,6 +326,8 @@ void omap_dm_timer_enable(struct omap_dm_timer *timer)
 				omap_timer_restore_context(timer);
 				timer->ctx_loss_count = c;
 			}
+		} else {
+			omap_timer_restore_context(timer);
 		}
 	}
 }
-- 
1.7.10.4
