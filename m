From: awg@embtoolkit.org (awg at embtoolkit.org)
Date: Sun, 15 Aug 2010 22:07:48 +0200
Subject: [PATCH] ARM: s3c2440: fix boot failure introduced by recent changes
	in gpiolib
Message-ID: <1281902868-11711-1-git-send-email-awg@embtoolkit.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Abdoulaye Walsimou Gaye <awg@embtoolkit.org>

Recent changes in s3c gpio break mini2440 board and may be others.
The problem is that mach-mini2440.c: mini2440_init()
(where we call s3c_gpio_setpull()) is called before s3c2440.c: s3c2440_init()
(where we initialize s3c24xx_gpiocfg_default.set_pull function pointer).
This causes dereferencing of NULL pointer at boot time and a kernel panic.

Signed-off-by: Abdoulaye Walsimou Gaye <awg@embtoolkit.org>
---
 arch/arm/plat-s3c24xx/gpiolib.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-s3c24xx/gpiolib.c b/arch/arm/plat-s3c24xx/gpiolib.c
index 4c0896f..ae9d3c2 100644
--- a/arch/arm/plat-s3c24xx/gpiolib.c
+++ b/arch/arm/plat-s3c24xx/gpiolib.c
@@ -87,6 +87,8 @@ static struct s3c_gpio_cfg s3c24xx_gpiocfg_banka = {
 struct s3c_gpio_cfg s3c24xx_gpiocfg_default = {
 	.set_config	= s3c_gpio_setcfg_s3c24xx,
 	.get_config	= s3c_gpio_getcfg_s3c24xx,
+	.set_pull	= s3c_gpio_setpull_1up,
+	.get_pull	= s3c_gpio_getpull_1up,
 };
 
 struct s3c_gpio_chip s3c24xx_gpios[] = {
-- 
1.7.0.4
