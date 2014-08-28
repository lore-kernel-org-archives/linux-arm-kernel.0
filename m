From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 28 Aug 2014 14:14:16 +0100
Subject: [PATCH 10/11] mfd: twl4030-irq: Check return value from
 twl_i2c_write() - warn() on failure
In-Reply-To: <1409231657-18294-1-git-send-email-lee.jones@linaro.org>
References: <1409231657-18294-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1409231657-18294-10-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the original code a return value variable was provided, but it
was never checked and the user was never informed of failure.  Now
it is and they are.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/twl4030-irq.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/twl4030-irq.c b/drivers/mfd/twl4030-irq.c
index b1dabba..1b772ef 100644
--- a/drivers/mfd/twl4030-irq.c
+++ b/drivers/mfd/twl4030-irq.c
@@ -396,13 +396,17 @@ static int twl4030_init_sih_modules(unsigned line)
 			status = twl_i2c_read(sih->module, rxbuf,
 				sih->mask[line].isr_offset, sih->bytes_ixr);
 			if (status < 0)
-				pr_err("twl4030: err %d initializing %s %s\n",
+				pr_warn("twl4030: err %d initializing %s %s\n",
 					status, sih->name, "ISR");
 
-			if (!sih->set_cor)
+			if (!sih->set_cor) {
 				status = twl_i2c_write(sih->module, buf,
 					sih->mask[line].isr_offset,
 					sih->bytes_ixr);
+				if (status < 0)
+					pr_warn("twl4030: write failed: %d\n",
+						status);
+			}
 			/*
 			 * else COR=1 means read sufficed.
 			 * (for most SIH modules...)
-- 
1.9.1
