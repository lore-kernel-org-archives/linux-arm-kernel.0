From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu,  2 Sep 2010 17:13:35 +0200
Subject: (Patch #6347) ARM: nomadik: move nmk_gpio_probe to .devinit.text
In-Reply-To: <AANLkTinU=E0aek4CA73wLTfb1yArpE4u=YpHQTpvS+rg@mail.gmail.com>
References: <AANLkTinU=E0aek4CA73wLTfb1yArpE4u=YpHQTpvS+rg@mail.gmail.com>
Message-ID: <1283440415-21990-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes a section mismatch reported by modpost:

	WARNING: arch/arm/plat-nomadik/built-in.o(.data+0x100): Section mismatch in reference from the variable nmk_gpio_driver to the function .init.text:nmk_gpio_probe()
	The variable nmk_gpio_driver references
	the function __init nmk_gpio_probe()
	If the reference is valid then annotate the
	variable with __init* or __refdata (see linux/init.h) or name the variable:
	*_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console,

According to Rabin VINCENT the alternative to use platform_driver_probe
won't work because the "platform devices are not yet registered when
nmk_gpio_init() is called."

Acked-by: Rabin Vincent <rabin.vincent@stericsson.com>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
KernelVersion: 2.6.36-rc3

 arch/arm/plat-nomadik/gpio.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-nomadik/gpio.c b/arch/arm/plat-nomadik/gpio.c
index 977c8f9..7c7c1f1 100644
--- a/arch/arm/plat-nomadik/gpio.c
+++ b/arch/arm/plat-nomadik/gpio.c
@@ -534,7 +534,7 @@ static struct gpio_chip nmk_gpio_template = {
 	.can_sleep		= 0,
 };
 
-static int __init nmk_gpio_probe(struct platform_device *dev)
+static int __devinit nmk_gpio_probe(struct platform_device *dev)
 {
 	struct nmk_gpio_platform_data *pdata = dev->dev.platform_data;
 	struct nmk_gpio_chip *nmk_chip;
-- 
1.7.1
