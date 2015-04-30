From: dianders@chromium.org (Doug Anderson)
Date: Thu, 30 Apr 2015 14:44:07 -0700
Subject: [PATCH] i2c: rk3x: Increase wait timeout to 1 second
Message-ID: <1430430247-9632-1-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While it's not sensible for an i2c command to _actually_ need more
than 200ms to complete, let's increase the timeout anyway.  Why?  It
turns out that if you've got a large number of printks going out to a
serial console, interrupts on a CPU can be disabled for hundreds of
milliseconds. That's not a great situation to be in to start with
(maybe we should put a cap in vprintk_emit()) but it's pretty annoying
to start seeing unexplained i2c timeouts.

A normal system shouldn't see i2c timeouts anyway, so increasing the
timeout should help people debugging without hurting other people
excessively.

Signed-off-by: Doug Anderson <dianders@chromium.org>
---
 drivers/i2c/busses/i2c-rk3x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
index 019d542..72e97e30 100644
--- a/drivers/i2c/busses/i2c-rk3x.c
+++ b/drivers/i2c/busses/i2c-rk3x.c
@@ -72,7 +72,7 @@ enum {
 #define REG_INT_ALL       0x7f
 
 /* Constants */
-#define WAIT_TIMEOUT      200 /* ms */
+#define WAIT_TIMEOUT      1000 /* ms */
 #define DEFAULT_SCL_RATE  (100 * 1000) /* Hz */
 
 enum rk3x_i2c_state {
-- 
2.2.0.rc0.207.ga3a616c
