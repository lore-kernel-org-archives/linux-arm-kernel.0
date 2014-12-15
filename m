From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 15 Dec 2014 08:55:45 -0500
Subject: [PATCHv0 5/5] dt-bindings: fix isl vs isil prefix issue for
 Intersil
In-Reply-To: <b2c34bea6fc7bd42d636c9cadfe1b7e5ec523aeb.1418519430.git.arno@natisbad.org>
References: <cover.1418519430.git.arno@natisbad.org>
 <b2c34bea6fc7bd42d636c9cadfe1b7e5ec523aeb.1418519430.git.arno@natisbad.org>
Message-ID: <20141215135545.GC967@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 14, 2014 at 02:43:15AM +0100, Arnaud Ebalard wrote:
> 
> When Intersil ISL12057 driver was introduced by commit 70e123373c05
> ("rtc: Add support for Intersil ISL12057 I2C RTC chip"), the vendor
> prefix 'isl' was used instead of the expected 'isil' (Intersil
> NASDAQ symbol) and documented in vendor-prefixes.txt.
> 
> Recently, a patch from Philip Zabel (7a6540ca856a, "ARM: mvebu:
> Change vendor prefix for Intersil Corporation to isil") fixed that
> prefix in ReadyNAS devices .dts files (AFAICT, the only users of
> the driver).
> 
> Then, commits 7c75c1d5e72b ("dt-bindings: Document deprecated device
> vendor name to fix related warning") and b2ea3f82e798 (dt-bindings:
> Document correct and deprecated vendor-prefix with device isl29028)
> decided to go the other way and deprecate isil in vendor-prefixes.txt
> and in isl29028.c staging driver.
> 
> While trying and merge a fix I wrote for ISL12057 drivers to finish
> Philip's work, it conflicted with the two recently introduced commits,
> and revealed the issue: at the moment, there are various compatible
> strings in drivers and .dts files for Intersil products which use
> either isl or isil:
> 
> $ grep -R "isil," .
> ./Documentation/devicetree/bindings/i2c/trivial-devices.txt:isil,isl29028           (deprecated, use isl)
> ./drivers/staging/iio/light/isl29028.c:   { .compatible = "isil,isl29028", },/* deprecated, don't use */
> ./drivers/staging/iio/light/isl29018.c:   { .compatible = "isil,isl29018", },
> ./drivers/staging/iio/light/isl29018.c:   { .compatible = "isil,isl29023", },
> ./drivers/staging/iio/light/isl29018.c:   { .compatible = "isil,isl29035", },
> ./arch/powerpc/boot/dts/p1022rdk.dts:        compatible = "isil,zl6100";
> ./arch/powerpc/boot/dts/p1022rdk.dts:        compatible = "isil,zl6100";
> ./arch/powerpc/boot/dts/p1022rdk.dts:        compatible = "isil,zl6100";
> ./arch/powerpc/boot/dts/p1022rdk.dts:        compatible = "isil,zl6100";
> ./arch/arm/boot/dts/exynos5800-peach-pi.dts: compatible = "isil,isl29018";
> ./arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi: compatible = "isil,isl1208";
> ./arch/arm/boot/dts/tegra20-ventana.dts:     compatible = "isil,isl29018";
> ./arch/arm/boot/dts/tegra20-seaboard.dts:    compatible = "isil,isl29018";
> ./arch/arm/boot/dts/armada-xp-netgear-rn2120.dts: compatible = "isil,isl12057";
> ./arch/arm/boot/dts/armada-370-netgear-rn104.dts: compatible = "isil,isl12057";
> ./arch/arm/boot/dts/exynos5420-peach-pit.dts:     compatible = "isil,isl29018";
> ./arch/arm/boot/dts/armada-370-netgear-rn102.dts: compatible = "isil,isl12057";
> 
> $ grep -R "isl," .
> ./Documentation/devicetree/bindings/regulator/isl9305.txt:- compatible: "isl,isl9305" or "isl,isl9305h"
> ./Documentation/devicetree/bindings/regulator/isl9305.txt:              compatible = "isl,isl9305";
> ./Documentation/devicetree/bindings/i2c/trivial-devices.txt:isl,isl12057      Intersil ISL12057 I2C RTC Chip
> ./Documentation/devicetree/bindings/i2c/trivial-devices.txt:isl,isl29028      Intersil ISL29028 Ambient Light ....
> ./drivers/regulator/isl9305.c:          { .compatible = "isl,isl9305" },
> ./drivers/regulator/isl9305.c:          { .compatible = "isl,isl9305h" },
> ./drivers/staging/iio/light/isl29028.c: { .compatible = "isl,isl29028", },
> ./drivers/rtc/rtc-isl12057.c:           { .compatible = "isl,isl12057" },
> ./drivers/rtc/rtc-isl12022.c:           { .compatible = "isl,isl12022" },
> ./arch/arm/boot/dts/tegra30-cardhu.dtsi:   compatible = "isl,isl29028";
> ./arch/arm/boot/dts/zynq-parallella.dts:   compatible = "isl,isl9305";
> 
> AFAICT, it seems it makes sense to *definitively* settle for isil as the
> vendor prefix for Intersil, as Philip did in 7a6540ca856a: it's the NASDAQ
> symbol and this choice requires less changes than opting for isl.
> 
> So, this patch changes compatible strings in .dts files to use isil where
> isl was found before, and modify drivers w/ compatible strings using isl
> to add one using isil. In those cases, a comment is made that the old
> compatible string is kept for backward compatibility (w/ out-fo-tree users
> of those drivers). Additionally, it leaves only isil as prefix in
> vendor-prefixes.txt. Those changes should prevent any new inclusion of
> isl compatible strings for Intersil devices due to copy-and-paste.
> 
> Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
> ---
>  Documentation/devicetree/bindings/i2c/trivial-devices.txt | 5 ++---
>  Documentation/devicetree/bindings/regulator/isl9305.txt   | 4 ++--
>  Documentation/devicetree/bindings/vendor-prefixes.txt     | 3 +--

>  arch/arm/boot/dts/tegra30-cardhu.dtsi                     | 2 +-
>  arch/arm/boot/dts/zynq-parallella.dts                     | 2 +-

>  drivers/regulator/isl9305.c                               | 6 ++++--
>  drivers/rtc/rtc-isl12022.c                                | 3 ++-
>  drivers/rtc/rtc-isl12057.c                                | 3 ++-
>  drivers/staging/iio/light/isl29028.c                      | 4 ++--
>  9 files changed, 17 insertions(+), 15 deletions(-)

Please split the dts{i} changes out into a separate patch.  The
different maintainers under drivers/ may want separate patches as well.

thx,

Jason.
