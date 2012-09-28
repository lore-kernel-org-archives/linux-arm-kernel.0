From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 28 Sep 2012 23:36:09 +0200
Subject: [PATCH 04/12] video: exynos: warnings in exynos_dp_core.c
In-Reply-To: <1348868177-21205-1-git-send-email-arnd@arndb.de>
References: <1348868177-21205-1-git-send-email-arnd@arndb.de>
Message-ID: <1348868177-21205-5-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Something is wrong with the exynos_dp_core logic, and gcc
emits a warning about this. An array is declared in
exynos_dp_process_equalizer_training with length '2',
and exynos_dp_channel_eq_ok tries to access the third
element of it.

This patch is certainly not correct, but hopefully helps
highlight the actual problem. The problem apparently was
introduced by d5c0eed01 "video: exynos_dp: adjust voltage
swing and pre-emphasis during Link Training".

This is what we get in exynos_defconfig:
drivers/video/exynos/exynos_dp_core.c: In function 'exynos_dp_process_equalizer_training':
drivers/video/exynos/exynos_dp_core.c:341:13: warning: array subscript is above array bounds [-Warray-bounds]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Jingoo Han <jg1.han@samsung.com>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
---
 drivers/video/exynos/exynos_dp_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/exynos/exynos_dp_core.c b/drivers/video/exynos/exynos_dp_core.c
index cdc1398..358b595 100644
--- a/drivers/video/exynos/exynos_dp_core.c
+++ b/drivers/video/exynos/exynos_dp_core.c
@@ -542,7 +542,7 @@ reduce_link_rate:
 
 static int exynos_dp_process_equalizer_training(struct exynos_dp_device *dp)
 {
-	u8 link_status[2];
+	u8 link_status[3];
 	u8 link_align[3];
 	int lane;
 	int lane_count;
-- 
1.7.10
