From: jbe@pengutronix.de (=?iso-8859-1?q?J=FCrgen_Beisert?=)
Date: Mon, 16 Sep 2013 11:37:31 +0200
Subject: [PATCH 5/6] Staging/iio/adc/touchscreen/MXS: add interrupt driven
 touch detection
In-Reply-To: <201309161010.22151.jbe@pengutronix.de>
References: <1378887511-24530-1-git-send-email-jbe@pengutronix.de>
 <52359259.8010202@kernel.org> <201309161010.22151.jbe@pengutronix.de>
Message-ID: <201309161137.31411.jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jonathan,

On Monday 16 September 2013 10:10:22 J?rgen Beisert wrote:
> [...]
> > While this driver is placed in IIO within staging at the moment, these
> > changes are definitely input related.  Hence I have cc'd Dmitry and the
> > input list.
> >
> > I am personaly a little uncomfortable that we have such a complex bit of
> > input code sat within an IIO driver but such is life.
>
> Maybe an MFD for this ADC unit would be a better way to go? Currently I
> have a different problem with this driver, because the ADC unit monitors
> the battery as well. And the charging driver from the power subsystem needs
> these values to charge the battery in a correct manner.

I would suggest:

diff --git a/drivers/staging/iio/TODO b/drivers/staging/iio/TODO
index 04c2326..c22a0ed 100644
--- a/drivers/staging/iio/TODO
+++ b/drivers/staging/iio/TODO
@@ -13,6 +13,17 @@ Would be nice
 3) Expand device set. Lots of other maxim adc's have very
    similar interfaces.
 
+MXS LRADC driver:
+This is a classic MFD device as it combines the following subdevices
+ - touchscreen controller (input subsystem related device)
+ - general purpose ADC channels
+ - battery voltage monitor (power subsystem related device)
+ - die temperature monitor (thermal management)
+
+At least the battery voltage and die temperature feature is required in-kernel
+by a driver of the SoC's battery charging unit to avoid any damage to the
+silicon and the battery.
+
 TSL2561
 Would be nice
 1) Open question of userspace vs kernel space balance when

Regards,
Juergen

-- 
Pengutronix e.K. ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?| Juergen Beisert ? ? ? ? ? ? |
Linux Solutions for Science and Industry ? ? ?| http://www.pengutronix.de/  |
