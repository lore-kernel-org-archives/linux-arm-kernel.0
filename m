From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 22 Jun 2015 08:35:38 +0200
Subject: [PATCH v5] Mediatek SCPSYS power domain support
Message-ID: <1434954942-30179-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for the MediaTek SCPSYS unit.

The SCPSYS unit handles several power management related tasks such
as thermal measurement, DVFS, interrupt filter and low level sleep
control.

The initial support only contains the generic power domain handling.
This is needed to turn on power to the different power domains.

The driver is quite straight forward now. Due to the lack of a better
place I have put it to drivers/soc/mediatek. As the SCPSYS unit has
several other tasks that also do not fit into some specific subsystem
this probably is a good place for this driver.

Please review, any input welcome.

Sascha

Changes since v4:
- move Kconfig dependency "select PM_GENERIC_DOMAINS if PM" from arch/arm64
  next to the driver which needs this dependency
- drop unnecessary clk[] array from struct scp and make the array local to
  the function which needs it.
- Disable clock when enabling the domain fails
- Drop error message when devm_clk_get fails. The core already issues a
  similar warning
- Add clocks/clock-names description to the binding doc

Changes since v3:
- Drop unnecessary MODULE_* macros for builtin code
- introduce scpsys_domain_is_on() function instead of open coding this
  twice
- Drop unnecessary initialisation of power_o[ff|n]_latencies. The kernel
  updates them with the measured values anyway.

changes since v2:
- Add missing include/linux/soc/mediatek/infracfg.h file
- rename VDE -> VDEC, VEN -> VENC, DIS -> DISP and VEN2 -> VENC_LT
  to make the abbreviatons more clear
- make of_device_id const
- remove double loop
- fix hunk in wrong patch
- Fix order of domains. Some domains depend on other domains. Reorder
  the domains so that all domains can be turned on in order when
  CONFIG_PM is disabled. Also fixes earlier mixups in the domain array
- Do not allow compilation as modules. pm_domains cannot be removed, so
  compilation as module is not that useful
- reorder Kconfig items alphabetically
- reorder #includes alphabetically
- select MTK_INFRACFG instead of depending on it
- Use only two clocks as dependencies for the domains. The previously
  used 5 clocks are not necessary as confirmed by the hardware designers
- use 'genpd' as variable name for struct generic_pm_domain like done in
  other pm code

changes since v1:
- make MFG_ASYNC a subdomain of MFG_2D and MFG_2D a subdomain of MFG
- Add (now hopefully properly) infracfg register handling again
- Add clock handling
- Fix on/off mixup in error message
- Make readonly data const
- Fix MODULE_LICENSE to GPL v2

changes since RFC:

- add a commit log to driver patch
- drop manipulating infracfg registers for now, can be added (properly)
  later
- Add warning messages when errors occur
- add NULL pointer check for kmalloc
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABCAAGBQJVdqbqAAoJEPFlmONMx+ezvloP/jpQ1JBTkYvivy4oB+t8GuxU
J6xLeo5k4uBKHNbTVm/2YbpROwwxA8Q+B/S4iG5mKNSydW6pf9jfA05XFpto0yKr
CXkbSoWWS2emP3HlnObnW5DYf6ggSq349E5Sopl5G4nW+tOBc1GceND4k9HoRNSu
MRRlZE0YK+QZ0Mz2x+RVNBnfiI8EU4gXcNdPq/aMEXIj+gSHtMeg2s7Zlg7zzyTQ
x4ambA2DiGSumqYMWscJUGxJT1GLH7cMmfe5pKDFu9P0z11Og/8A7ix00x0UTdto
DKqxOyGE4qdQ3Ma8Fb7j15VZ56Y21e7EKkSrv1FK5qSKcfzXnoOWu1xmBL2q0Jht
X/kfEShfoeU8AMDf89zwxmUTqNx3nPuhsPpQeuVEIiO70cWvJ0dchL4Kp0t8a+xs
nTmnS6S6Mm8MEUfhYmkJJ7p8WR4roQ+b+W5yeVFPWL9ft81CuioLrAEr/57GeIdR
bhd4MgWlatNprBRvv/I6aBhFklWoSY87ERKJC9w9vvogZ7of/TEv1lMOI91qKMNL
eg9y4Pw/FWkZyK0bIysykGHwQcNGLxqlKX52QLbefAM0jzdaljtbyHr3u7SnvpZS
AikPoSJ+RC3jbP15Fx7IuD/XUCFt3fuSmUbyODpZJZM9MNo6xgmfsqmtwGUoTsbP
DAFexU9wsU/2Xny1Ygjk
=UL1E
-----END PGP SIGNATURE-----

commit 5e33965ca0b265401349229773ee7a3732a63388
Author: Sascha Hauer <s.hauer@pengutronix.de>
Date:   Mon Mar 9 08:41:36 2015 +0100

    ARM64: MediaTek MT8173: Add SCPSYS device node

    This adds the SCPSYS device node to the MT8173 dtsi file.

    Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 924fdb6..12430f0 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -125,6 +125,16 @@
 						<GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;
 		};

+		scpsys: scpsys at 10006000 {
+			compatible = "mediatek,mt8173-scpsys";
+			#power-domain-cells = <1>;
+			reg = <0 0x10006000 0 0x1000>;
+			clocks = <&clk26m>,
+				 <&topckgen CLK_TOP_MM_SEL>;
+			clock-names = "mfg", "mm";
+			infracfg = <&infracfg>;
+		};
+
 		sysirq: intpol-controller at 10200620 {
 			compatible = "mediatek,mt8173-sysirq",
 					"mediatek,mt6577-sysirq";
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABCAAGBQJVh6xeAAoJEPFlmONMx+ezuAQP/3OsxylPoreCDqeqJ/JMToPw
WUp9Yrxu9BJPg7zV56nZAf+3gKNXgMkV5wyb6WpCYT0rRRabX6iALs0taPysYoRY
IUkq57w8bl+oWS0rJwagXx6BclH2uzjlBor9DTLU7PKjRRmPBvfiLwqJjiGABxf3
yz4AFptnKkaj6IAudQDl1d2xJevmnzDDL3dMYhZy/VddaC8Gi/CmP86Pxnmr1Vt/
dTzwDsw3NSF0Hhuy601OFnwRiLDH+8C8xwg+j68kYfWbftrhHrTJZLCeJ+WvCSPL
aCyrM0MZN+RkBzBgg1ZcdMAJPkjnxie4jERofafiEusLNEmiNln47bIPECMs7/7U
IVVyCTLFuHljnVC/7Kf5t6RStlohzSgs3FdOs0raV9ObbnEb9Tg9mwSLHJIk6wmr
xO6X5gqIURHkAODBvmi6MDWTTKmVv0Ep/N6c/HqLaEJEkeS5bP/gge3/l6O7LN9t
1ZGAjvGQwELszivh0YcFXsN+g1iDjIFSzwvXCCbeCmE1pZoa4JQsKCgLxQWJw3d/
dtWGtVt4IEX9qAb2UCIwU3HREP6JPn3Zd9QfOOXV2A9Lt0gfFqO7tiKrG4T4QBcx
4f9h48W4MmygCkNu87jG/3QLpn2p40MzNtvK3ffvP5acaoUtuQL1z1bCoEktDQ58
MIZ0jg9h66cFyJumlwbm
=ZIEi
-----END PGP SIGNATURE-----

commit 4aa48202b3f22a71685f66d66beff0f040781bfd
Author: Sascha Hauer <s.hauer@pengutronix.de>
Date:   Mon Mar 9 08:41:36 2015 +0100

    ARM64: MediaTek MT8173: Add SCPSYS device node
    
    This adds the SCPSYS device node to the MT8173 dtsi file.
    
    Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 924fdb6..12430f0 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -125,6 +125,16 @@
 						<GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		scpsys: scpsys at 10006000 {
+			compatible = "mediatek,mt8173-scpsys";
+			#power-domain-cells = <1>;
+			reg = <0 0x10006000 0 0x1000>;
+			clocks = <&clk26m>,
+				 <&topckgen CLK_TOP_MM_SEL>;
+			clock-names = "mfg", "mm";
+			infracfg = <&infracfg>;
+		};
+
 		sysirq: intpol-controller at 10200620 {
 			compatible = "mediatek,mt8173-sysirq",
 					"mediatek,mt6577-sysirq";
