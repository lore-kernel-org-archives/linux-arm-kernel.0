From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 02 Jan 2010 11:21:54 +0000
Subject: [PATCH 18/18] ARM: PNX4008: use msecs_to_jiffies() rather than
	open-coding it
In-Reply-To: <20100102111849.GA2529@n2100.arm.linux.org.uk>
References: <20100102111849.GA2529@n2100.arm.linux.org.uk>
Message-ID: <0c787ed0ccd862c192d9b1541e6ea10d75c7c5e0.1262431163.git.rmk+kernel@arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/i2c/busses/i2c-pnx.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pnx.c b/drivers/i2c/busses/i2c-pnx.c
index 34c5994..e480fa0 100644
--- a/drivers/i2c/busses/i2c-pnx.c
+++ b/drivers/i2c/busses/i2c-pnx.c
@@ -53,14 +53,14 @@ static inline int wait_reset(long timeout, struct i2c_pnx_algo_data *data)
 static inline void i2c_pnx_arm_timer(struct i2c_pnx_algo_data *alg_data)
 {
 	struct timer_list *timer = &alg_data->mif.timer;
-	int expires = I2C_PNX_TIMEOUT / (1000 / HZ);
+	unsigned long expires = msecs_to_jiffies(I2C_PNX_TIMEOUT);
 
 	if (expires <= 1)
 		expires = 2;
 
 	del_timer_sync(timer);
 
-	dev_dbg(&alg_data->adapter.dev, "Timer armed at %lu plus %u jiffies.\n",
+	dev_dbg(&alg_data->adapter.dev, "Timer armed at %lu plus %lu jiffies.\n",
 		jiffies, expires);
 
 	timer->expires = jiffies + expires;
-- 
1.6.2.5
