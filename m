From: joe@perches.com (Joe Perches)
Date: Tue, 20 Sep 2016 13:02:24 -0700
Subject: iomux-mx3.h: possible macro precedence issue
Message-ID: <1474401744.1954.55.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Julia Lawall wrote a script

Link:?http://lkml.kernel.org/r/alpine.DEB.2.10.1609201503260.2914 at hadrien

that found a possible issue with macro argument precedence.


diff -u -p a/arch/arm/mach-imx/iomux-mx3.h b/arch/arm/mach-imx/iomux-mx3.h
--- a/arch/arm/mach-imx/iomux-mx3.h
+++ b/arch/arm/mach-imx/iomux-mx3.h
@@ -529,7 +529,7 @@ enum iomux_pins {
 #define MX31_PIN_DCD_DTE1__DCD_DTE2	IOMUX_MODE(MX31_PIN_DCD_DTE1, IOMUX_CONFIG_ALT1)
 #define MX31_PIN_RI_DTE1__RI_DTE2	IOMUX_MODE(MX31_PIN_RI_DTE1, IOMUX_CONFIG_ALT1)
 #define MX31_PIN_DSR_DTE1__DSR_DTE2	IOMUX_MODE(MX31_PIN_DSR_DTE1, IOMUX_CONFIG_ALT1)
-#define MX31_PIN_DTR_DTE1__DTR_DTE2	IOMUX_MODE(MX31_PIN_DTR_DTE1, IOMUX_OCONFIG_ALT3 | IOMUX_ICONFIG_NONE)
+#define MX31_PIN_DTR_DTE1__DTR_DTE2	IOMUX_MODE(MX31_PIN_DTR_DTE1, (IOMUX_OCONFIG_ALT3 | IOMUX_ICONFIG_NONE))
 #define MX31_PIN_PC_RST__CTS5		IOMUX_MODE(MX31_PIN_PC_RST, IOMUX_CONFIG_ALT2)
 #define MX31_PIN_PC_VS2__RTS5		IOMUX_MODE(MX31_PIN_PC_VS2, IOMUX_CONFIG_ALT2)
 #define MX31_PIN_PC_BVD2__TXD5		IOMUX_MODE(MX31_PIN_PC_BVD2, IOMUX_CONFIG_ALT2)

this may be intentional, but perhaps a solution
would be to use parentheses in the #define IOMUX_MODE 

---

diff --git a/arch/arm/mach-imx/iomux-mx3.h b/arch/arm/mach-imx/iomux-mx3.h
index 368667b..3f9ede2 100644
--- a/arch/arm/mach-imx/iomux-mx3.h
+++ b/arch/arm/mach-imx/iomux-mx3.h
@@ -156,7 +156,7 @@ void mxc_iomux_mode(unsigned int pin_mode);
 	(((gpionum << IOMUX_GPIONUM_SHIFT) & IOMUX_GPIONUM_MASK) | \
 	 (padnum & IOMUX_PADNUM_MASK))
 
-#define IOMUX_MODE(pin, mode) (pin | mode << IOMUX_MODE_SHIFT)
+#define IOMUX_MODE(pin, mode) ((pin) | ((mode) << IOMUX_MODE_SHIFT))
 
 #define IOMUX_TO_GPIO(iomux_pin) \
 	((iomux_pin & IOMUX_GPIONUM_MASK) >> IOMUX_GPIONUM_SHIFT)
