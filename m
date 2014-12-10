From: akpm@linux-foundation.org (Andrew Morton)
Date: Wed, 10 Dec 2014 13:30:41 -0800
Subject: [rtc-linux] [PATCHv1 4/6] rtc: rtc-isl12057: fix isil vs isl
 naming for intersil
In-Reply-To: <3dde5b6adfc9c953e0c943b0b40ccd2177508030.1416006090.git.arno@natisbad.org>
References: <cover.1416006090.git.arno@natisbad.org>
 <3dde5b6adfc9c953e0c943b0b40ccd2177508030.1416006090.git.arno@natisbad.org>
Message-ID: <20141210133041.27c5cb53bbf29b611fa5c48a@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 15 Nov 2014 00:07:05 +0100 Arnaud Ebalard <arno@natisbad.org> wrote:

> 
> When Intersil ISL12057 driver was introduced by commit 70e123373c05
> ("rtc: Add support for Intersil ISL12057 I2C RTC chip"), the vendor
> prefix 'isl' was used instead of the expected 'isil' (Intersil
> NASDAQ symbol). Recently, a patch from Philip Zabel (7a6540ca856a,
> "ARM: mvebu: Change vendor prefix for Intersil Corporation to isil")
> fixed that prefix in ReadyNAS devices .dts files (AFAICT, the only
> users).
> 
> That patch completes that work to change the remaining values in:
> 
>  - Intersil ISL12057 driver (compatible string) and also associated
>    Documentation/devicetree/bindings/i2c/trivial-devices.txt file
>    to reflect the changes introduced by previous commit from Philip
>  - Documentation/devicetree/bindings/vendor-prefixes.txt files to
>    avoid future mistakes
> 
> ...
>
> diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> index fbde415078e6..edac97c0f756 100644
> --- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> +++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> @@ -55,7 +55,7 @@ fsl,sgtl5000		SGTL5000: Ultra Low-Power Audio Codec
>  gmt,g751		G751: Digital Temperature Sensor and Thermal Watchdog with Two-Wire Interface
>  infineon,slb9635tt	Infineon SLB9635 (Soft-) I2C TPM (old protocol, max 100khz)
>  infineon,slb9645tt	Infineon SLB9645 I2C TPM (new protocol, max 400khz)
> -isl,isl12057		Intersil ISL12057 I2C RTC Chip
> +isil,isl12057		Intersil ISL12057 I2C RTC Chip
>  maxim,ds1050		5 Bit Programmable, Pulse-Width Modulator
>  maxim,max1237		Low-Power, 4-/12-Channel, 2-Wire Serial, 12-Bit ADCs
>  maxim,max6625		9-Bit/12-Bit Temperature Sensors with I__C-Compatible Serial Interface
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 723999d73744..84193ecdc41c 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -77,7 +77,7 @@ innolux	Innolux Corporation
>  intel	Intel Corporation
>  intercontrol	Inter Control Group
>  isee	ISEE 2007 S.L.
> -isl	Intersil
> +isil	Intersil
>  karo	Ka-Ro electronics GmbH
>  keymile	Keymile GmbH
>  lacie	LaCie
> diff --git a/drivers/rtc/rtc-isl12057.c b/drivers/rtc/rtc-isl12057.c
> index fe562820a54a..31eaa6a9c2b2 100644
> --- a/drivers/rtc/rtc-isl12057.c
> +++ b/drivers/rtc/rtc-isl12057.c
> @@ -310,7 +310,8 @@ static int isl12057_probe(struct i2c_client *client,
>  
>  #ifdef CONFIG_OF
>  static const struct of_device_id isl12057_dt_match[] = {
> -	{ .compatible = "isl,isl12057" },
> +	{ .compatible = "isl,isl12057" },  /* obsolete */
> +	{ .compatible = "isil,isl12057" },
>  	{ },
>  };
>  #endif

Your patch conflicts both textually and materially with the two below
patches, which are now upstream.

I don't know what to do about this so I'll drop "rtc: rtc-isl12057: fix
isil vs isl naming for intersil".  Could you folks please sort this all
out?



commit 7c75c1d5e72be6736aa558efd33ca2b31d77e425
Author:     Darshana Padmadas <darshanapadmadas@gmail.com>
AuthorDate: Sat Nov 8 22:52:06 2014 +0530
Commit:     Arnd Bergmann <arnd@arndb.de>
CommitDate: Thu Nov 20 12:20:18 2014 +0100

    dt-bindings: Document deprecated device vendor name to fix related warning
    
    This patch documents deprecated vendor name "isil" to fix warning of
    undocumented string for device isl29028 as reported while running checkpatch.pl
    on drivers/staging/iio/light/isl29028.c. This is done to maintain compatibility
    with older kernels.
    
    Signed-off-by: Darshana Padmadas <darshanapadmadas@gmail.com>
    Acked-by: Arnd Bergmann <arnd@arndb.de>
    Acked-by: Mark Rutland <mark.rutland@arm.com>
    Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 723999d..bfbd93e 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -77,6 +77,7 @@ innolux	Innolux Corporation
 intel	Intel Corporation
 intercontrol	Inter Control Group
 isee	ISEE 2007 S.L.
+isil    Intersil (deprecated, use isl)
 isl	Intersil
 karo	Ka-Ro electronics GmbH
 keymile	Keymile GmbH


commit b2ea3f82e7984d855c5e61fef18746771d90c73c
Author:     Darshana Padmadas <darshanapadmadas@gmail.com>
AuthorDate: Sat Nov 8 22:52:05 2014 +0530
Commit:     Arnd Bergmann <arnd@arndb.de>
CommitDate: Thu Nov 20 12:19:59 2014 +0100

    dt-bindings: Document correct and deprecated vendor-prefix with device isl29028
    
    This patch documents the device isl29028 with its vendor-prefix. Undocumented deprecated vendor-prefix
    found by checkpatch also documented for compatibility reasons.
    
    Signed-off-by: Darshana Padmadas <darshanapadmadas@gmail.com>
    Acked-by: Arnd Bergmann <arnd@arndb.de>
    Acked-by: Mark Rutland <mark.rutland@arm.com>
    Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
index fbde415..605dcca 100644
--- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
+++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
@@ -56,6 +56,8 @@ gmt,g751		G751: Digital Temperature Sensor and Thermal Watchdog with Two-Wire In
 infineon,slb9635tt	Infineon SLB9635 (Soft-) I2C TPM (old protocol, max 100khz)
 infineon,slb9645tt	Infineon SLB9645 I2C TPM (new protocol, max 400khz)
 isl,isl12057		Intersil ISL12057 I2C RTC Chip
+isil,isl29028           (deprecated, use isl)
+isl,isl29028            Intersil ISL29028 Ambient Light and Proximity Sensor
 maxim,ds1050		5 Bit Programmable, Pulse-Width Modulator
 maxim,max1237		Low-Power, 4-/12-Channel, 2-Wire Serial, 12-Bit ADCs
 maxim,max6625		9-Bit/12-Bit Temperature Sensors with I?C-Compatible Serial Interface
