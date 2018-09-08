From: olof@lixom.net (Olof Johansson)
Date: Sat, 8 Sep 2018 10:15:34 -0700
Subject: [GIT PULL] ARM: SoC fixes
Message-ID: <20180908171534.umap5fj6bkyvhki2@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

The following changes since commit a72b44a871c218e2a0580e68affa1d3528c0587a:

  Merge tag 'omap-for-v4.19/fixes-v2-signed' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap into fixes (2018-09-01 18:22:19 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-fixes

for you to fetch changes up to a132bb90414bfad4f8ee23cb45fe6946a89b167d:

  Merge tag 'sunxi-fixes-for-4.19' of https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux into fixes (2018-09-08 10:04:37 -0700)

----------------------------------------------------------------
ARM: SoC fixes

A few more fixes who have trickled in:
 - MMC bus width fixup for some Allwinner platforms
 - Fix for NULL deref in ti-aemif when no platform data is passed in
 - Fix div by 0 in SCMI code
 - Add a missing module alias in a new RPi driver

----------------------------------------------------------------
Bartosz Golaszewski (1):
      memory: ti-aemif: fix a potential NULL-pointer dereference

Icenowy Zheng (1):
      arm64: allwinner: dts: h6: fix Pine H64 MMC bus width

Olof Johansson (2):
      Merge tag 'arm-soc/for-4.19/drivers-fixes' of https://github.com/Broadcom/stblinux into fixes
      Merge tag 'sunxi-fixes-for-4.19' of https://git.kernel.org/.../sunxi/linux into fixes

Peter Robinson (1):
      hwmon: rpi: add module alias to raspberrypi-hwmon

Sudeep Holla (1):
      firmware: arm_scmi: fix divide by zero when sustained_perf_level is zero

 arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts | 2 ++
 drivers/firmware/arm_scmi/perf.c                     | 8 +++++++-
 drivers/hwmon/raspberrypi-hwmon.c                    | 1 +
 drivers/memory/ti-aemif.c                            | 2 +-
 4 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
index ceffc40810ee..48daec7f78ba 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
@@ -46,6 +46,7 @@
 	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&reg_cldo1>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;
+	bus-width = <4>;
 	status = "okay";
 };
 
@@ -56,6 +57,7 @@
 	vqmmc-supply = <&reg_bldo2>;
 	non-removable;
 	cap-mmc-hw-reset;
+	bus-width = <8>;
 	status = "okay";
 };
 
diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index 721e6c57beae..64342944d917 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -166,7 +166,13 @@ scmi_perf_domain_attributes_get(const struct scmi_handle *handle, u32 domain,
 					le32_to_cpu(attr->sustained_freq_khz);
 		dom_info->sustained_perf_level =
 					le32_to_cpu(attr->sustained_perf_level);
-		dom_info->mult_factor =	(dom_info->sustained_freq_khz * 1000) /
+		if (!dom_info->sustained_freq_khz ||
+		    !dom_info->sustained_perf_level)
+			/* CPUFreq converts to kHz, hence default 1000 */
+			dom_info->mult_factor =	1000;
+		else
+			dom_info->mult_factor =
+					(dom_info->sustained_freq_khz * 1000) /
 					dom_info->sustained_perf_level;
 		memcpy(dom_info->name, attr->name, SCMI_MAX_STR_SIZE);
 	}
diff --git a/drivers/hwmon/raspberrypi-hwmon.c b/drivers/hwmon/raspberrypi-hwmon.c
index fb4e4a6bb1f6..be5ba4690895 100644
--- a/drivers/hwmon/raspberrypi-hwmon.c
+++ b/drivers/hwmon/raspberrypi-hwmon.c
@@ -164,3 +164,4 @@ module_platform_driver(rpi_hwmon_driver);
 MODULE_AUTHOR("Stefan Wahren <stefan.wahren@i2se.com>");
 MODULE_DESCRIPTION("Raspberry Pi voltage sensor driver");
 MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:raspberrypi-hwmon");
diff --git a/drivers/memory/ti-aemif.c b/drivers/memory/ti-aemif.c
index 31112f622b88..475e5b3790ed 100644
--- a/drivers/memory/ti-aemif.c
+++ b/drivers/memory/ti-aemif.c
@@ -411,7 +411,7 @@ static int aemif_probe(struct platform_device *pdev)
 			if (ret < 0)
 				goto error;
 		}
-	} else {
+	} else if (pdata) {
 		for (i = 0; i < pdata->num_sub_devices; i++) {
 			pdata->sub_devices[i].dev.parent = dev;
 			ret = platform_device_register(&pdata->sub_devices[i]);
