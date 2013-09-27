From: khilman@linaro.org (Kevin Hilman)
Date: Fri, 27 Sep 2013 08:10:32 -0700
Subject: [PATCH V5 5/9] USB: OHCI: make ohci-at91 a separate driver
In-Reply-To: <1379761727-10656-6-git-send-email-manjunath.goudar@linaro.org>
 (Manjunath Goudar's message of "Sat, 21 Sep 2013 16:38:42 +0530")
References: <1370585013-12809-1-git-send-email-manjunath.goudar@linaro.org>
 <1379761727-10656-1-git-send-email-manjunath.goudar@linaro.org>
 <1379761727-10656-6-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <877ge2l2qf.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Manjunath,

Manjunath Goudar <manjunath.goudar@linaro.org> writes:

> Separate the  TI OHCI Atmel host controller driver from ohci-hcd
> host code so that it can be built as a separate driver module.
> This work is part of enabling multi-platform kernels on ARM.

This broke booting on atmel sama5 boards (and likely others with the
same conversion)...

[...]

> +static int __init ohci_at91_init(void)
> +{
> +	if (usb_disabled())
> +		return -ENODEV;
> +
> +	pr_info("%s: " DRIVER_DESC "\n", hcd_name);
> +	ohci_init_driver(&ohci_at91_hc_driver, NULL);

ohci_init_driver() doesn't have any sanity checks for NULL overrides, so
it blindly dereferences and faults.

Some of the other conversions have this same problem (at least omap3).
Did anyone test this series on hardware?

I'm not too familiar with OHCI, but something like the patch below is
probably needed along with this series.

Kevin


>From a3b5cc90e74038a6449fbd25e0d720ea02884f30 Mon Sep 17 00:00:00 2001
From: Kevin Hilman <khilman@linaro.org>
Date: Fri, 27 Sep 2013 08:07:19 -0700
Subject: [PATCH] USB: OHCI: ohci_init_driver(): sanity check overrides

Check for non-NULL overrides before dereferencing since platforms may
pass in NULL overrides.

Signed-off-by: Kevin Hilman <khilman@linaro.org>
---
 drivers/usb/host/ohci-hcd.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
index 21d937a..8ada13f 100644
--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -1161,10 +1161,12 @@ void ohci_init_driver(struct hc_driver *drv,
 	/* Copy the generic table to drv and then apply the overrides */
 	*drv = ohci_hc_driver;
 
-	drv->product_desc = over->product_desc;
-	drv->hcd_priv_size += over->extra_priv_size;
-	if (over->reset)
-		drv->reset = over->reset;
+	if (over) {
+		drv->product_desc = over->product_desc;
+		drv->hcd_priv_size += over->extra_priv_size;
+		if (over->reset)
+			drv->reset = over->reset;
+	}
 }
 EXPORT_SYMBOL_GPL(ohci_init_driver);
 
-- 
1.8.3
