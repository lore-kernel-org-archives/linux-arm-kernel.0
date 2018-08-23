From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Thu, 23 Aug 2018 09:51:15 +0200
Subject: [PATCH 4.17 009/324] clocksource/drivers/stm32: Fix error return code
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
Message-ID: <20180823074956.401371103@linuxfoundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Julia Lawall <Julia.Lawall@lip6.fr>

[ Upstream commit a26ed66c20f080c510fcf5bd448bce204f2c19d7 ]

Return an error code on failure.

Problem found using Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: kernel-janitors at vger.kernel.org
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Cc: linux-arm-kernel at lists.infradead.org
Link: https://lkml.kernel.org/r1528640655-18948-3-git-send-email-Julia.Lawall at lip6.fr
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clocksource/timer-stm32.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/clocksource/timer-stm32.c
+++ b/drivers/clocksource/timer-stm32.c
@@ -304,8 +304,10 @@ static int __init stm32_timer_init(struc
 
 	to->private_data = kzalloc(sizeof(struct stm32_timer_private),
 				   GFP_KERNEL);
-	if (!to->private_data)
+	if (!to->private_data) {
+		ret = -ENOMEM;
 		goto deinit;
+	}
 
 	rstc = of_reset_control_get(node, NULL);
 	if (!IS_ERR(rstc)) {
