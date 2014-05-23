From: pebolle@tiscali.nl (Paul Bolle)
Date: Fri, 23 May 2014 13:50:14 +0200
Subject: [PATCH v2] ARM: at91: #if 0 out ISI code for AT91SAM9263
In-Reply-To: <F4C251BF-666E-4E89-A6F7-3D96A669A8D8@jcrosoft.com>
References: <1400142868.20469.12.camel@x220>
 <F4C251BF-666E-4E89-A6F7-3D96A669A8D8@jcrosoft.com>
Message-ID: <1400845814.31526.29.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In v2.6.25 code was added for an Image Sensor Interface (ISI) for
AT91SAM9263. That code depended on the Kconfig macro
CONFIG_VIDEO_AT91_ISI and its MODULE variant. The related Kconfig symbol
has never been added to the tree. The net effect of this was that
at91_add_device_isi() was a NOP. No one noticed because no callers of
that function were added to the tree at that time.

The first caller of a function with that name was added in v3.4. But
that caller apparently only called the function defined for AT91SAM9G45.
(that function was also added in v3.4). So even then AT91SAM9263's NOP
version of at91_add_device_isi() remained unused.

This means that the ISI code for AT91SAM9263 could be removed. But,
since it can be useful for future reference, let's "#if 0" it instead.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
v2: Jean-Christophe would like to keep the information currently hidden
behind "#if defined(CONFIG_VIDEO_AT91_ISI) [...]". I'd like the
reference to that Kconfig macro dropped. Using "#if 0" will do both, so
that makes for a nice compromise, I'd say.

Josh verified that this definition of at91_add_device_isi() never will
be called. Thanks!

Still untested!

 arch/arm/mach-at91/at91sam9263_devices.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/arm/mach-at91/at91sam9263_devices.c b/arch/arm/mach-at91/at91sam9263_devices.c
index 43d53d6156dd..30af3048ade5 100644
--- a/arch/arm/mach-at91/at91sam9263_devices.c
+++ b/arch/arm/mach-at91/at91sam9263_devices.c
@@ -900,8 +900,7 @@ void __init at91_add_device_lcdc(struct atmel_lcdfb_pdata *data) {}
  *  Image Sensor Interface
  * -------------------------------------------------------------------- */
 
-#if defined(CONFIG_VIDEO_AT91_ISI) || defined(CONFIG_VIDEO_AT91_ISI_MODULE)
-
+#if 0 /* keep for future reference */
 struct resource isi_resources[] = {
 	[0] = {
 		.start	= AT91SAM9263_BASE_ISI,
@@ -947,9 +946,6 @@ void __init at91_add_device_isi(struct isi_platform_data *data,
 		/* TODO: register the PCK for ISI_MCK and set its parent */
 	}
 }
-#else
-void __init at91_add_device_isi(struct isi_platform_data *data,
-		bool use_pck_as_mck) {}
 #endif
 
 
-- 
1.9.0
