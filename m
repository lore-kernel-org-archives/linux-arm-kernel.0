From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Mon, 11 Nov 2013 22:23:50 +0800
Subject: [PATCH -next] tree-wide: add missing clk_disable_unprepare() on error
 in wmt_i2c_reset_hardware()
Message-ID: <CAPgLHd-j19gkcuBEVUm5EkUkqXbqZBZ9i74p1WXth89rEaDpJw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Add the missing clk_disable_unprepare() before return
from wmt_i2c_reset_hardware() in the error handling case.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/i2c/busses/i2c-wmt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-wmt.c b/drivers/i2c/busses/i2c-wmt.c
index 31395fa..2c8a3e4 100644
--- a/drivers/i2c/busses/i2c-wmt.c
+++ b/drivers/i2c/busses/i2c-wmt.c
@@ -349,6 +349,7 @@ static int wmt_i2c_reset_hardware(struct wmt_i2c_dev *i2c_dev)
 	err = clk_set_rate(i2c_dev->clk, 20000000);
 	if (err) {
 		dev_err(i2c_dev->dev, "failed to set clock = 20Mhz\n");
+		clk_disable_unprepare(i2c_dev->clk);
 		return err;
 	}
 
