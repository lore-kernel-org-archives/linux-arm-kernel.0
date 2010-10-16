From: awg@embtoolkit.org (Abdoulaye Walsimou Gaye)
Date: Sat, 16 Oct 2010 13:55:52 +0200
Subject: [PATCH RESEND 2/2] ARM: s3c2440: fix boot failure introduced by
	recent changes in gpiolib
In-Reply-To: <1287230152-5544-1-git-send-email-awg@embtoolkit.org>
References: <1287230152-5544-1-git-send-email-awg@embtoolkit.org>
Message-ID: <1287230152-5544-2-git-send-email-awg@embtoolkit.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Recent changes in s3c gpio break mini2440 board and may be others.
The problem is that mach-mini2440.c: mini2440_init()
(where we call s3c_gpio_setpull()) is called before s3c2440.c: s3c2440_init()
(where we initialize s3c24xx_gpiocfg_default.set_pull function pointer).
This causes dereferencing of NULL pointer at boot time and a kernel panic.

Signed-off-by: Abdoulaye Walsimou Gaye <awg@embtoolkit.org>

Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-samsung-soc at vger.kernel.org
---

Issue reported 4 months ago[1] and since prevents boards to boot
[1]: http://www.spinics.net/lists/arm-kernel/msg90151.html

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
