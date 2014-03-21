From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 21 Mar 2014 16:48:50 +0100
Subject: [PATCH 04/62] ARM: at91: fix broken "if () else" statement
In-Reply-To: <1446105B-3033-4799-A697-C70748DC90C5@jcrosoft.com>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
 <1395257399-359545-5-git-send-email-arnd@arndb.de>
 <1446105B-3033-4799-A697-C70748DC90C5@jcrosoft.com>
Message-ID: <201403211648.51206.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 20 March 2014, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On Mar 20, 2014, at 3:29 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > -	if (data->flags & AT91_CF_TRUE_IDE)
> > #if defined(CONFIG_PATA_AT91) || defined(CONFIG_PATA_AT91_MODULE)
> > +	if (data->flags & AT91_CF_TRUE_IDE)
> I prefer if (IS_ENABLED())
> > 		pdev->name = "pata_at91";
> > +	else
> > #else
> > #warning "board requires AT91_CF_TRUE_IDE: enable pata_at91?
> but this means drop this warning
> > #endif

Good idea, thanks!

	Arnd

>From ce916f429091f98cc53ee9cf11e6e02b4dc3dc25 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 13 Mar 2014 17:47:23 +0100
Subject: [PATCH] ARM: at91: fix broken "if () else" statement

If CONFIG_PATA_AT91 is disabled, the code in at91_add_device_cf
is turned into invalid C statements due to the lack of an
expression before the 'else' clause.

This moves the first half of the condition inside of the #ifdef,
which seems to be what the author intended.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Andrew Victor <linux@maxim.org.za>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>

diff --git a/arch/arm/mach-at91/at91sam9260_devices.c b/arch/arm/mach-at91/at91sam9260_devices.c
index 2ae7715..33fa98d 100644
--- a/arch/arm/mach-at91/at91sam9260_devices.c
+++ b/arch/arm/mach-at91/at91sam9260_devices.c
@@ -1263,12 +1263,8 @@ void __init at91_add_device_cf(struct at91_cf_data *data)
 	at91_set_A_periph(AT91_PIN_PC10, 0);    /* CFRNW */
 	at91_set_A_periph(AT91_PIN_PC15, 1);    /* NWAIT */
 
-	if (data->flags & AT91_CF_TRUE_IDE)
-#if defined(CONFIG_PATA_AT91) || defined(CONFIG_PATA_AT91_MODULE)
+	if (IS_ENABLED(CONFIG_PATA_AT91) && (data->flags & AT91_CF_TRUE_IDE)
 		pdev->name = "pata_at91";
-#else
-#warning "board requires AT91_CF_TRUE_IDE: enable pata_at91"
-#endif
 	else
 		pdev->name = "at91_cf";
 
