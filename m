From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Sat, 18 Nov 2017 00:45:32 +0530
Subject: [PATCH 10/10] Input: palmas-pwrbutton: Handle return value of
 platform_get_irq
In-Reply-To: <1510946132-13554-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1510946132-13554-1-git-send-email-arvind.yadav.cs@gmail.com>
Message-ID: <1510946132-13554-11-git-send-email-arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

platform_get_irq() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/input/misc/palmas-pwrbutton.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/input/misc/palmas-pwrbutton.c b/drivers/input/misc/palmas-pwrbutton.c
index 1e1baed..f9b05cf 100644
--- a/drivers/input/misc/palmas-pwrbutton.c
+++ b/drivers/input/misc/palmas-pwrbutton.c
@@ -210,6 +210,11 @@ static int palmas_pwron_probe(struct platform_device *pdev)
 	INIT_DELAYED_WORK(&pwron->input_work, palmas_power_button_work);
 
 	pwron->irq = platform_get_irq(pdev, 0);
+	if (pwron->irq < 0) {
+		error = pwron->irq;
+		goto err_free_input;
+	}
+
 	error = request_threaded_irq(pwron->irq, NULL, pwron_irq,
 				     IRQF_TRIGGER_HIGH |
 					IRQF_TRIGGER_LOW |
-- 
2.7.4
