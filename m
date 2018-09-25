From: weiyongjun1@huawei.com (Wei Yongjun)
Date: Tue, 25 Sep 2018 14:23:21 +0000
Subject: [PATCH -next] serial: uartps: Fix missing unlock on error in
 cdns_get_id()
Message-ID: <1537885401-18605-1-git-send-email-weiyongjun1@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the missing unlock before return from function cdns_get_id()
in the error handling case.

Fixes: ae1cca3fa347 ("serial: uartps: Change uart ID port allocation")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/tty/serial/xilinx_uartps.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index f77200a..0e3dae4 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1394,8 +1394,10 @@ static int cdns_get_id(struct platform_device *pdev)
 	if (!alias_bitmap_initialized) {
 		ret = of_alias_get_alias_list(cdns_uart_of_match, "serial",
 					      alias_bitmap, MAX_UART_INSTANCES);
-		if (ret)
+		if (ret) {
+			mutex_unlock(&bitmap_lock);
 			return ret;
+		}
 
 		alias_bitmap_initialized++;
 	}
