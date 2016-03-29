From: leo.yan@linaro.org (Leo Yan)
Date: Tue, 29 Mar 2016 19:27:13 +0800
Subject: [PATCH v3 2/4] thermal: hisilicon: fix IRQ imbalance enabling
In-Reply-To: <1459250835-25561-1-git-send-email-leo.yan@linaro.org>
References: <1459250835-25561-1-git-send-email-leo.yan@linaro.org>
Message-ID: <1459250835-25561-3-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When register sensors into thermal zone during initialization phase, it
reports error for IRQ imbalance enabling:

[    2.040713] WARNING: at kernel/irq/manage.c:513
[    2.040719] Modules linked in:
[    2.040721]
[    2.040729] CPU: 1 PID: 804 Comm: irq/33-hisi_the Not tainted 4.5.0-rc4+ #505
[    2.040732] Hardware name: HiKey Development Board (DT)
[    2.040736] task: ffffffc03ae82580 ti: ffffffc0379c8000 task.ti: ffffffc0379c8000
[    2.040745] PC is at __enable_irq+0x74/0x84
[    2.040749] LR is at __enable_irq+0x74/0x84

This warning is for IRQ imbalance enabling, which is caused by
enable_irq() twice. During sensor's initialization it tries to enable
IRQ, the driver will call thermal_zone_of_sensor_register() to bind
sensors and read sensor's temperature. But at this moment the flag
"data->irq_enabled" has been not initialized as correct state, so it
finally introduces the function enabled_irq() to be called twice. In
essentially this is caused by the flag "data->irq_enabled" is
inconsistent with real hardware IRQ enabling state.

So this patch is to fix this issue, firstly init "irq_enabled" flag
before binding sensors to thermal zone. Also change to use the function
irq_get_irqchip_state() to read back real interrupt line state.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/thermal/hisi_thermal.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index 0fed5cf..4fef1b3 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -343,6 +343,10 @@ static int hisi_thermal_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	hisi_thermal_enable_bind_irq_sensor(data);
+	irq_get_irqchip_state(data->irq, IRQCHIP_STATE_MASKED,
+			      &data->irq_enabled);
+
 	for (i = 0; i < HISI_MAX_SENSORS; ++i) {
 		ret = hisi_thermal_register_sensor(pdev, data,
 						   &data->sensors[i], i);
@@ -353,9 +357,6 @@ static int hisi_thermal_probe(struct platform_device *pdev)
 			hisi_thermal_toggle_sensor(&data->sensors[i], true);
 	}
 
-	hisi_thermal_enable_bind_irq_sensor(data);
-	data->irq_enabled = true;
-
 	return 0;
 }
 
-- 
1.9.1
