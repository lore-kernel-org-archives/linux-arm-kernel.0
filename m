From: josephl@nvidia.com (Joseph Lo)
Date: Tue, 8 Oct 2013 12:50:07 +0800
Subject: [PATCH V2 5/6] HACK: arm: tegra: reuse the Tegra114 clock driver for
 Tegra124
In-Reply-To: <1381207808-14734-1-git-send-email-josephl@nvidia.com>
References: <1381207808-14734-1-git-send-email-josephl@nvidia.com>
Message-ID: <1381207808-14734-6-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is only a hack for Tegra124 bring up testing. Please don't
merge this. The same function can be replaced by Tegra124 clock driver.

* re-use UART-A in DT
* add a temp PMC compatible value

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
V2:
* add a temp PMC compatible value fot Tegra124
---
 arch/arm/boot/dts/tegra124.dtsi  | 8 ++++++++
 drivers/clk/tegra/clk-tegra114.c | 1 +
 2 files changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
index 905f148..7734d8d 100644
--- a/arch/arm/boot/dts/tegra124.dtsi
+++ b/arch/arm/boot/dts/tegra124.dtsi
@@ -1,3 +1,4 @@
+#include <dt-bindings/clock/tegra114-car.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
 #include "skeleton.dtsi"
@@ -29,6 +30,12 @@
 			     <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
+	tegra_car: clock {
+		compatible = "nvidia,tegra114-car";
+		reg = <0x60006000 0x1000>;
+		#clock-cells = <1>;
+	};
+
 	/*
 	 * There are two serial driver i.e. 8250 based simple serial
 	 * driver and APB DMA based serial driver for higher baudrate
@@ -43,6 +50,7 @@
 		reg-shift = <2>;
 		interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
 		status = "disabled";
+		clocks = <&tegra_car TEGRA114_CLK_UARTA>;
 	};
 
 	serial at 70006040 {
diff --git a/drivers/clk/tegra/clk-tegra114.c b/drivers/clk/tegra/clk-tegra114.c
index 9467da7..9a847f3 100644
--- a/drivers/clk/tegra/clk-tegra114.c
+++ b/drivers/clk/tegra/clk-tegra114.c
@@ -2198,6 +2198,7 @@ static struct tegra_cpu_car_ops tegra114_cpu_car_ops = {
 };
 
 static const struct of_device_id pmc_match[] __initconst = {
+	{ .compatible = "nvidia,tegra124-pmc" },
 	{ .compatible = "nvidia,tegra114-pmc" },
 	{},
 };
-- 
1.8.4
