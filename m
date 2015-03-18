From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 18 Mar 2015 11:27:28 +0100
Subject: [PATCH] spi: trigger trace event for message-done before
 mesg->complete
Message-ID: <1426674448-8246-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With spidev the mesg->complete callback points to spidev_complete.
Calling this unblocks spidev_sync and so spidev_sync_write finishes. As
the struct spi_message just read is a local variable in
spidev_sync_write and recording the trace event accesses this message
the recording is better done first. The same can happen for
spidev_sync_read.

This fixes an oops observed on a 3.14-rt system with spidev activity
after

	echo 1 > /sys/kernel/debug/tracing/events/spi/enable

.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/spi/spi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 6d3b9b76c80b..df577518b770 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -994,13 +994,14 @@ void spi_finalize_current_message(struct spi_master *master)
 				"failed to unprepare message: %d\n", ret);
 		}
 	}
+
+	trace_spi_message_done(mesg);
+
 	master->cur_msg_prepared = false;
 
 	mesg->state = NULL;
 	if (mesg->complete)
 		mesg->complete(mesg->context);
-
-	trace_spi_message_done(mesg);
 }
 EXPORT_SYMBOL_GPL(spi_finalize_current_message);
 
-- 
2.1.4
