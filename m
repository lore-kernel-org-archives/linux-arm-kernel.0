From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Tue, 13 Dec 2016 15:33:30 +0100
Subject: [PATCH v9 1/3] ARM: sunxi_defconfig: Add CONFIG_THERMAL_OF
In-Reply-To: <20161213143332.24988-1-quentin.schulz@free-electrons.com>
References: <20161213143332.24988-1-quentin.schulz@free-electrons.com>
Message-ID: <20161213143332.24988-2-quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables CONFIG_THERMAL_OF by default for sunxi_defconfig. It is
required to get Allwinner SoCs' temperature from the GPADC driver.

The Allwinner SoCs all have an ADC that can also act as a touchscreen
controller and a thermal sensor. The first four channels can be used
either for the ADC or the touchscreen and the fifth channel is used for
the thermal sensor.

The thermal sensor requires the IP to be in touchscreen mode to return
correct values. Therefore, if the user is continuously reading the ADC
channel(s), the thermal framework in which the thermal sensor is
registered will switch the IP in touchscreen mode to get a temperature
value and requires a delay of 100ms (because of the mode switching),
then the ADC will switch back to ADC mode and requires also a delay of
100ms. If the ADC readings are critical to user and the SoC temperature
is not, the GPADC driver is capable of not registering the thermal
sensor in the thermal framework and thus, "quicken" the ADC readings. In
most use cases, the SoC temperature is more critical (for cpu throttling
for example or activating cooling devices) than ADC readings, thus it is
now enabled by default.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---

v8:
 - more explanatory commit log,

added in v7

 arch/arm/configs/sunxi_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_defconfig
index 714da33..8aaeae3 100644
--- a/arch/arm/configs/sunxi_defconfig
+++ b/arch/arm/configs/sunxi_defconfig
@@ -83,6 +83,7 @@ CONFIG_GPIO_SYSFS=y
 CONFIG_POWER_SUPPLY=y
 CONFIG_AXP20X_POWER=y
 CONFIG_THERMAL=y
+CONFIG_THERMAL_OF=y
 CONFIG_CPU_THERMAL=y
 CONFIG_WATCHDOG=y
 CONFIG_SUNXI_WATCHDOG=y
-- 
2.9.3
