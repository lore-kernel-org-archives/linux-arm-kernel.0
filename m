From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Wed, 17 Apr 2013 00:43:56 +0200
Subject: [PATCH v6 2/6] ARM: s3c64xx: Skip legacy EINT setup if
 pinctrl-s3c64xx driver is present
In-Reply-To: <20130416162642.GN26958@opensource.wolfsonmicro.com>
References: <1366060483-20342-1-git-send-email-tomasz.figa@gmail.com>
 <1366060483-20342-3-git-send-email-tomasz.figa@gmail.com>
 <20130416162642.GN26958@opensource.wolfsonmicro.com>
Message-ID: <5007310.KGcYpvCKGp@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The new pinctrl-s3c64xx is responsible for EINT handling on DT-enabled
platforms.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 arch/arm/mach-s3c64xx/common.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-s3c64xx/common.c b/arch/arm/mach-s3c64xx/common.c
index e79ca92..5053879 100644
--- a/arch/arm/mach-s3c64xx/common.c
+++ b/arch/arm/mach-s3c64xx/common.c
@@ -366,6 +366,10 @@ static int __init s3c64xx_init_irq_eint(void)
 {
 	int irq;
 
+	/* On DT-enabled systems EINTs are handled by pinctrl-s3c64xx driver. */
+	if (of_have_populated_dt())
+		return -ENODEV;
+
 	for (irq = IRQ_EINT(0); irq <= IRQ_EINT(27); irq++) {
 		irq_set_chip_and_handler(irq, &s3c_irq_eint, handle_level_irq);
 		irq_set_chip_data(irq, (void *)eint_irq_to_bit(irq));
-- 
1.8.1.5
