From: festevam@gmail.com (Fabio Estevam)
Date: Sat,  4 Jun 2011 15:29:45 -0300
Subject: [PATCH v2 2/2] ARM: mx5/eukrea_mbimx51-baseboard: Fix build issue due
	to removed irq
In-Reply-To: <1307212185-18184-1-git-send-email-festevam@gmail.com>
References: <1307212185-18184-1-git-send-email-festevam@gmail.com>
Message-ID: <1307212185-18184-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit b50d28 (ARM i.MX: get rid of wrong MXC_INTERNAL_IRQ usage) broke eukrea_mbimx51-baseboard
build because it removed MBIMX51_TSC2007_IRQ and still referenced it in irq_set_irq_type.

Fix it by using gpio_to_irq with the correct GPIO parameter.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
No changes
 arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c b/arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c
index 592d172..b89d829 100644
--- a/arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c
+++ b/arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c
@@ -197,7 +197,8 @@ void __init eukrea_mbimx51_baseboard_init(void)
 
 	gpio_request(MBIMX51_TSC2007_GPIO, "tsc2007_irq");
 	gpio_direction_input(MBIMX51_TSC2007_GPIO);
-	irq_set_irq_type(MBIMX51_TSC2007_IRQ, IRQF_TRIGGER_FALLING);
+	irq_set_irq_type(gpio_to_irq(MBIMX51_TSC2007_GPIO),
+					IRQF_TRIGGER_FALLING);
 	i2c_register_board_info(1, mbimx51_i2c_devices,
 				ARRAY_SIZE(mbimx51_i2c_devices));
 
-- 
1.7.1
