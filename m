From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri,  3 Apr 2015 14:41:59 +0200
Subject: [PATCH/RFC 2/6] staging: board: Initialize staging board code earlier
In-Reply-To: <1428064923-24950-1-git-send-email-geert+renesas@glider.be>
References: <1428064923-24950-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1428064923-24950-3-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the staging board code is initialized from a late_initcall().
However, unused PM domains are also disabled from a late_initcall(),
which happens before due to link order.

Change the initialization of staging board code from using
late_initcall() to device_initcall() to fix this.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/staging/board/board.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/board/board.h b/drivers/staging/board/board.h
index 2390ed6c31a42f2f..e9c914985d4acb36 100644
--- a/drivers/staging/board/board.h
+++ b/drivers/staging/board/board.h
@@ -15,6 +15,6 @@ static int __init runtime_board_check(void)	\
 	return 0;				\
 }						\
 						\
-late_initcall(runtime_board_check)
+device_initcall(runtime_board_check)
 
 #endif /* __BOARD_H__ */
-- 
1.9.1
