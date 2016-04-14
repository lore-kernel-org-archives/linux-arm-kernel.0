From: stuart.yoder@nxp.com (Stuart Yoder)
Date: Thu, 14 Apr 2016 09:21:25 -0500
Subject: [RFC PATCH] arm64: defconfig: add config fragment for Freescale SoCs
Message-ID: <1460643685-13670-1-git-send-email-stuart.yoder@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a config fragment enabling a reasonably useful set of
devices and options for Freescale ARM v8 SoCs.

I realize that we are trying to avoid the defconfig hell in arch/arm with 100+
defconfigs, but the single defconfig in arch/arm64 has some problems too.
I think what we want with arch/arm64/config are some reasonable in-kernel
defconfigs/fragments with built-in drivers for convenience.

The proposal is to allow a chip vendor 1 vendor-specific kconfig fragment
to cover all their chips, allowing them to _override_ the default config
options in defconfig.  One specific issue we have is that due to the ls2080a
physical address map, the combination of 4KB pages and 39-bit VA does not
allow us to see all our DDR.  And, thus we need CONFIG_ARM64_VA_BITS_48=y.
(which I presume no one else wants).

Allowing us to have a freescale.config gives us the flexibility of
adding Freescale specific options without having to keep this in
some other external repo.  It also keeps vendor specific clutter
out of the base defconfig.  With the number of new armv8 chips 
coming out the single defconfig is going to produce increasingly
large kernels, since all drivers are built-in.

We want people to be able to clone the kernel.org kernel, merge the
freescale.config fragment with defconfig, and get a decent kernel.

Signed-off-by: Stuart Yoder <stuart.yoder@nxp.com>
---
 arch/arm64/configs/freescale.config | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 arch/arm64/configs/freescale.config

diff --git a/arch/arm64/configs/freescale.config b/arch/arm64/configs/freescale.config
new file mode 100644
index 0000000..5f5bd7e
--- /dev/null
+++ b/arch/arm64/configs/freescale.config
@@ -0,0 +1,19 @@
+# general options
+CONFIG_ARM64_VA_BITS_48=y
+# dpaa2
+CONFIG_STAGING=y
+CONFIG_FSL_MC_BUS=y
+# clock driver
+CONFIG_CLK_QORIQ=y
+# ahci/sata
+CONFIG_AHCI_QORIQ=y
+# esdhc
+CONFIG_MMC_SDHCI_OF_ESDHC=y
+# I2C
+CONFIG_I2C_MUX=y
+CONFIG_I2C_MUX_PCA954x=y
+CONFIG_I2C_IMX=y
+CONFIG_HWMON=y
+CONFIG_SENSORS_LM90=y
+CONFIG_SENSORS_INA2XX=y
+CONFIG_RTC_DRV_DS3232=y
-- 
1.9.0
