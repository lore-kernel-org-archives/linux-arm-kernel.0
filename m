From: shinya.kuribayashi@necel.com (Shinya Kuribayashi)
Date: Tue, 13 Oct 2009 11:53:56 +0900
Subject: [PATCH 15/16] i2c-designware: i2c_dw_xfer_msg: Mark as completed
	on an error
In-Reply-To: <4AD3E974.8080200@necel.com>
References: <4AD3E974.8080200@necel.com>
Message-ID: <4AD3EBC4.6030705@necel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As wait_for_completion_interruptible_timeout() will be invoked after
the first call to i2c_dw_xfer_msg() is made whether or not an error is
detected in it, we need to mark ->cmd_complete as completed to avoid a
needless HZ timeout.

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi@necel.com>
---

 Or we could change the i2c_dw_xfer_msg() prototype from "void" to
 "int".  Which is preffered?

 drivers/i2c/busses/i2c-designware.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware.c b/drivers/i2c/busses/i2c-designware.c
index f7ea032..6f85e28 100644
--- a/drivers/i2c/busses/i2c-designware.c
+++ b/drivers/i2c/busses/i2c-designware.c
@@ -376,6 +376,7 @@ i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
 			dev_err(dev->dev,
 				"%s: invalid message length\n", __func__);
 			dev->msg_err = -EINVAL;
+			complete(&dev->cmd_complete);
 			return;
 		}
 
-- 
1.6.5
