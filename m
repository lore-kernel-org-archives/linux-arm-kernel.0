From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 10 Dec 2012 08:55:50 +0000
Subject: [PATCH 01/12] regulator: gpio-regulator: Demote GPIO Regulator driver
 to start later
In-Reply-To: <1355129761-8088-1-git-send-email-lee.jones@linaro.org>
References: <1355129761-8088-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1355129761-8088-2-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have quite a complicated hurdle we need to over-come, and this
patch aims to rectify it the best way possible. We're attempting
to move some MMC related voltage level-shifters out of platform
code and over to the new GPIO Regulator framework. The aim of this
change is to void the requirement for two separate call-backs; one
from the TC35892 GPIO controller which sets up MMC level-shifter
GPIOs and another from the MMCI driver to toggle the lines at the
appropriate times.

The issues come from device bring-up order during boot, and
-EPROBE_DEFER cannot help for this particular use-case. In its
current configuration the GPIO Regulator starts first. It parses
the Device Tree for 'enable' and 'voltage_select' GPIOs, then
requests them. However, the TC35892 GPIO controller isn't up yet
so it defers probe(). By the time it re-probes, the MMCI driver
has finished its probe and should have toggled the 'enable' and
'voltage_select' lines a few times already by now.

The normal course of action would be to defer the MMCI driver too,
but these IOS level-shifter regulators aren't present on all
platforms, so deferring until one is found would be incorrect.

So the best solution is to demote the GPIO Regulator driver, so
it starts later than the TC35892 GPIO controller, which is also
configured to start at subsys_initcall() time, but before deferred
probing time, which starts at late_initcall(), after many of the
drivers requiring these regulators would have already started.

Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/regulator/gpio-regulator.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/gpio-regulator.c b/drivers/regulator/gpio-regulator.c
index 3ee79c8..1a71be2 100644
--- a/drivers/regulator/gpio-regulator.c
+++ b/drivers/regulator/gpio-regulator.c
@@ -383,7 +383,7 @@ static int __init gpio_regulator_init(void)
 {
 	return platform_driver_register(&gpio_regulator_driver);
 }
-subsys_initcall(gpio_regulator_init);
+fs_initcall(gpio_regulator_init);
 
 static void __exit gpio_regulator_exit(void)
 {
-- 
1.7.9.5
