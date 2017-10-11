From: radoslaw.pietrzyk@gmail.com (Radoslaw Pietrzyk)
Date: Wed, 11 Oct 2017 13:53:08 +0200
Subject: [PATCH] i2c: stm32: Fixes multibyte transfer for STM32F4 I2C
 controller
Message-ID: <1507722788-31224-1-git-send-email-radoslaw.pietrzyk@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	Do not read data on RXNE but on BTF only due to HW
	synchronisation problems and NACKing read data too early.
	It was found during testing of stmpe811 touchscreen driver.

Signed-off-by: Radoslaw Pietrzyk <radoslaw.pietrzyk@gmail.com>
---
 drivers/i2c/busses/i2c-stm32f4.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/i2c/busses/i2c-stm32f4.c b/drivers/i2c/busses/i2c-stm32f4.c
index 4ec1084..86bcf4c 100644
--- a/drivers/i2c/busses/i2c-stm32f4.c
+++ b/drivers/i2c/busses/i2c-stm32f4.c
@@ -409,16 +409,9 @@ static void stm32f4_i2c_handle_read(struct stm32f4_i2c_dev *i2c_dev)
 	 * So, here we just disable buffer interrupt in order to avoid another
 	 * system preemption due to RX not empty event.
 	 */
-	case 2:
-	case 3:
+	default:
 		stm32f4_i2c_clr_bits(reg, STM32F4_I2C_CR2_ITBUFEN);
 		break;
-	/*
-	 * For N byte reception with N > 3 we directly read data register
-	 * until N-2 data.
-	 */
-	default:
-		stm32f4_i2c_read_msg(i2c_dev);
 	}
 }
 
@@ -470,8 +463,6 @@ static void stm32f4_i2c_handle_rx_done(struct stm32f4_i2c_dev *i2c_dev)
 		 */
 		reg = i2c_dev->base + STM32F4_I2C_CR1;
 		stm32f4_i2c_clr_bits(reg, STM32F4_I2C_CR1_ACK);
-		stm32f4_i2c_read_msg(i2c_dev);
-		break;
 	default:
 		stm32f4_i2c_read_msg(i2c_dev);
 	}
-- 
1.9.1
