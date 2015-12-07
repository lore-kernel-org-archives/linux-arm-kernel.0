From: lee.jones@linaro.org (Lee Jones)
Date: Mon,  7 Dec 2015 11:50:22 +0000
Subject: [PATCH 09/19] mfd: arizona-core: msleep() is unreliable for anything
 <20ms use usleep_range() instead
In-Reply-To: <1449489032-14374-1-git-send-email-lee.jones@linaro.org>
References: <1449489032-14374-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1449489032-14374-10-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

WARNING: msleep < 20ms can sleep for up to 20ms; see Documentation/timers/timers-howto.txt
+               msleep(1);

WARNING: msleep < 20ms can sleep for up to 20ms; see Documentation/timers/timers-howto.txt
+                       msleep(5);

WARNING: msleep < 20ms can sleep for up to 20ms; see Documentation/timers/timers-howto.txt
+               msleep(1);

WARNING: msleep < 20ms can sleep for up to 20ms; see Documentation/timers/timers-howto.txt
+               msleep(1);

total: 0 errors, 4 warnings, 1407 lines checked

Cc: patches at opensource.wolfsonmicro.com
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/arizona-core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/arizona-core.c b/drivers/mfd/arizona-core.c
index 44cfdbb..ceba17ca 100644
--- a/drivers/mfd/arizona-core.c
+++ b/drivers/mfd/arizona-core.c
@@ -239,7 +239,7 @@ static int arizona_poll_reg(struct arizona *arizona,
 		if ((val & mask) == target)
 			return 0;
 
-		msleep(1);
+		usleep_range(1000, 5000);
 	}
 
 	dev_err(arizona->dev, "Polling reg %u timed out: %x\n", reg, val);
@@ -280,14 +280,14 @@ static void arizona_disable_reset(struct arizona *arizona)
 		case WM5110:
 		case WM8280:
 			/* Meet requirements for minimum reset duration */
-			msleep(5);
+			usleep_range(5000, 10000);
 			break;
 		default:
 			break;
 		}
 
 		gpio_set_value_cansleep(arizona->pdata.reset, 1);
-		msleep(1);
+		usleep_range(1000, 5000);
 	}
 }
 
@@ -1045,7 +1045,7 @@ int arizona_dev_init(struct arizona *arizona)
 			goto err_reset;
 		}
 
-		msleep(1);
+		usleep_range(1000, 5000);
 	}
 
 	/* Ensure device startup is complete */
-- 
1.9.1
