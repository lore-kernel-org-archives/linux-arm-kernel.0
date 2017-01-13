From: chris.packham@alliedtelesis.co.nz (Chris Packham)
Date: Fri, 13 Jan 2017 22:12:18 +1300
Subject: [PATCHv4 3/5] pinctrl: mvebu: pinctrl driver for 98DX3236 SoC
In-Reply-To: <20170113091222.7132-1-chris.packham@alliedtelesis.co.nz>
References: <20170113091222.7132-1-chris.packham@alliedtelesis.co.nz>
Message-ID: <20170113091222.7132-4-chris.packham@alliedtelesis.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kalyan Kinthada <kalyan.kinthada@alliedtelesis.co.nz>

This pinctrl driver supports the 98DX3236, 98DX3336 and 98DX4251 SoCs
from Marvell.

Signed-off-by: Kalyan Kinthada <kalyan.kinthada@alliedtelesis.co.nz>
Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---

Notes:
    Changes in v2:
    - include sdio support for the 98DX4251
    Changes in v3:
    - None
    Changes in v4:
    - Correct some discrepencies between binding and driver.
    - Collect acks from Rob and Sebastian

 .../pinctrl/marvell,armada-98dx3236-pinctrl.txt    |  46 ++++++
 drivers/pinctrl/mvebu/pinctrl-armada-xp.c          | 156 +++++++++++++++++++++
 2 files changed, 202 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/marvell,armada-98dx3236-pinctrl.txt

diff --git a/Documentation/devicetree/bindings/pinctrl/marvell,armada-98dx3236-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/marvell,armada-98dx3236-pinctrl.txt
new file mode 100644
index 000000000000..b5bd23992fdf
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/marvell,armada-98dx3236-pinctrl.txt
@@ -0,0 +1,46 @@
+* Marvell 98dx3236 pinctrl driver for mpp
+
+Please refer to marvell,mvebu-pinctrl.txt in this directory for common binding
+part and usage
+
+Required properties:
+- compatible: "marvell,98dx3236-pinctrl" or "marvell,98dx4251-pinctrl"
+- reg: register specifier of MPP registers
+
+This driver supports all 98dx3236, 98dx3336 and 98dx4251 variants
+
+name          pins     functions
+================================================================================
+mpp0          0        gpio, spi0(mosi), dev(ad8)
+mpp1          1        gpio, spi0(miso), dev(ad9)
+mpp2          2        gpio, spi0(sck), dev(ad10)
+mpp3          3        gpio, spi0(cs0), dev(ad11)
+mpp4          4        gpio, spi0(cs1), smi(mdc), dev(cs0)
+mpp5          5        gpio, pex(rsto), sd0(cmd), dev(bootcs)
+mpp6          6        gpio, sd0(clk), dev(a2)
+mpp7          7        gpio, sd0(d0), dev(ale0)
+mpp8          8        gpio, sd0(d1), dev(ale1)
+mpp9          9        gpio, sd0(d2), dev(ready0)
+mpp10         10       gpio, sd0(d3), dev(ad12)
+mpp11         11       gpio, uart1(rxd), uart0(cts), dev(ad13)
+mpp12         12       gpio, uart1(txd), uart0(rts), dev(ad14)
+mpp13         13       gpio, intr(out), dev(ad15)
+mpp14         14       gpio, i2c0(sck)
+mpp15         15       gpio, i2c0(sda)
+mpp16         16       gpio, dev(oe)
+mpp17         17       gpio, dev(clkout)
+mpp18         18       gpio, uart1(txd)
+mpp19         19       gpio, uart1(rxd), dev(rb)
+mpp20         20       gpio, dev(we0)
+mpp21         21       gpio, dev(ad0)
+mpp22         22       gpio, dev(ad1)
+mpp23         23       gpio, dev(ad2)
+mpp24         24       gpio, dev(ad3)
+mpp25         25       gpio, dev(ad4)
+mpp26         26       gpio, dev(ad5)
+mpp27         27       gpio, dev(ad6)
+mpp28         28       gpio, dev(ad7)
+mpp29         29       gpio, dev(a0)
+mpp30         30       gpio, dev(a1)
+mpp31         31       gpio, slv_smi(mdc), smi(mdc), dev(we1)
+mpp32         32       gpio, slv_smi(mdio), smi(mdio), dev(cs1)
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-xp.c b/drivers/pinctrl/mvebu/pinctrl-armada-xp.c
index e4ea71a9d985..9601d662c7f5 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-xp.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-xp.c
@@ -49,6 +49,10 @@ enum armada_xp_variant {
 	V_MV78460	= BIT(2),
 	V_MV78230_PLUS	= (V_MV78230 | V_MV78260 | V_MV78460),
 	V_MV78260_PLUS	= (V_MV78260 | V_MV78460),
+	V_98DX3236	= BIT(3),
+	V_98DX3336	= BIT(4),
+	V_98DX4251	= BIT(5),
+	V_98DX3236_PLUS	= (V_98DX3236 | V_98DX3336 | V_98DX4251),
 };
 
 static struct mvebu_mpp_mode armada_xp_mpp_modes[] = {
@@ -360,6 +364,131 @@ static struct mvebu_mpp_mode armada_xp_mpp_modes[] = {
 		 MPP_VAR_FUNCTION(0x1, "dev", "ad31",       V_MV78260_PLUS)),
 };
 
+static struct mvebu_mpp_mode mv98dx3236_mpp_modes[] = {
+	MPP_MODE(0,
+		 MPP_VAR_FUNCTION(0x0, "gpo", NULL,          V_98DX3236_PLUS),
+		 MPP_VAR_FUNCTION(0x2, "spi0", "mosi",       V_98DX3236_PLUS),
+		 MPP_VAR_FUNCTION(0x4, "dev", "ad8",         V_98DX3236_PLUS)),
+	MPP_MODE(1,
+		 MPP_VAR_FUNCTION(0x0, "gpio", NULL,         V_98DX3236_PLUS),
+		 MPP_VAR_FUNCTION(0x2, "spi0", "miso",       V_98DX3236_PLUS),
+		 MPP_VAR_FUNCTION(0x4, "dev", "ad9",         V_98DX3236_PLUS)),
+	MPP_MODE(2,
+		 MPP_VAR_FUNCTION(0x0, "gpo", NULL,          V_98DX3236_PLUS),
+		 MPP_VAR_FUNCTION(0x2, "spi0", "sck",        V_98DX3236_PLUS),
+		 MPP_VAR_FUNCTION(0x4, "dev", "ad10",        V_98DX3236_PLUS)),
+	MPP_MODE(3,
+		 MPP_VAR_FUNCTION(0x0, "gpio", NULL,         V_98DX3236_PLUS),
+		 MPP_VAR_FUNCTION(0x2, "spi0", "cs0",        V_98DX3236_PLUS),
+		 MPP_VAR_FUNCTION(0x4, "dev", "ad11",        V_98DX3236_PLUS)),
+	MPP_MODE(4,
+		 MPP_VAR_FUNCTION(0x0, "gpio", NULL,         V_98DX3236_PLUS),
+		 MPP_VAR_FUNCTION(0x2, "spi0", "cs1",        V_98DX3236_PLUS),
+		 MPP_VAR_FUNCTION(0x3, "smi", "mdc",         V_98DX3236_PLUS),
+		 MPP_VAR_FUNCTION(0x4, "dev", "cs0",         V_98DX3236_PLUS)),
+	MPP_MODE(5,
+		 MPP_VAR_FUNCTION(0x0, "gpio", NULL,         V_98DX3236_PLUS),
+		 MPP_VAR_FUNCTION(0x1, "pex", "rsto",        V_98DX3236_PLUS),
+		 MPP_VAR_FUNCTION(0x2, "sd0", "cmd",         V_98DX4251),
+		 MPP_VAR_FUNCTION(0x4, "dev", "bootcs",      V_98DX3236_PLUS)),
+	MPP_MODE(6,
+		 MPP_VAR_FUNCTION(0x0, "gpo", NULL,          V_98DX3236_PLUS),
+		 MPP_VAR_FUNCTION(0x2, "sd0", "clk",         V_98DX4251),
+		 MPP_VAR_FUNCTION(0x4, "dev", "a2",          V_98DX3236_PLUS)),
+	MPP_MODE(7,
+		 MPP_VAR_FUNCTION(0x0, "gpio", NULL,         V_98DX3236_PLUS),
+		 MPP_VAR_FUNCTION(0x2, "sd0", "d0",          V_98DX4251),
+		 MPP_VAR_FUNCTION(0x4, "dev", "ale0",        V_98DX3236_PLUS)),
+	MPP_MODE(8,
+		 MPP_VAR_FUNCTION(0x0, "gpio", NULL,         V_98DX3236_PLUS),
+		 MPP_VAR_FUNCTION(0x2, "sd0", "d1",          V_98DX4251),
+		 MPP_VAR_FUNCTION(0x4, "dev", "ale1",        V_98DX3236_PLUS)),
+	MPP_MODE(9,
+		 MPP_VAR_FUNCTION(0x0, "gpio", NULL,         V_98DX3236_PLUS),
+		 MPP_VAR_FUNCTION(0x2, "sd0", "d2",          V_98DX4251),
+		 MPP_VAR_FUNCTION(0x4, "dev", "ready0",      V_98DX3236_PLUS)),
+	MPP_MODE(10,
+		 MPP_VAR_FUNCTION(0x0, "gpio", NULL,         V_98DX3236_PLUS),
+		 MPP_VAR_FUNCTION(0x2, "sd0", "d3",          V_98DX4251),
+		 MPP_VAR_FUNCTION(0x4, "dev", "ad12",        V_98DX3236_PLUS)),
+	MPP_MODE(11,
+		 MPP_VAR_FUNCTION(0x0, "gpio", NULL,         V_98DX3236_PLUS),
+		 MPP_VAR_FUNCTION(0x2, "uart1", "rxd",       V_98DX3236_PLUS),
+		 MPP_VAR_FUNCTION(0x3, "uart0", "cts",       V_98DX3236_PLUS),
+		 MPP_VAR_FUNCTION(0x4, "dev", "ad13",        V_98DX3236_PLUS)),
+	MPP_MODE(12,
+		 MPP_VAR_FUNCTION(0x0, "gpo", NULL,          V_98DX3236_PLUS),
+		 MPP_VAR_FUNCTION(0x2, "uart1", "txd",       V_98DX3236_PLUS),
+		 MPP_VAR_FUNCTION(0x3, "uart0", "rts",       V_98DX3236_PLUS),
+		 MPP_VAR_FUNCTION(0x4, "dev", "ad14",        V_98DX3236_PLUS)),
+	MPP_MODE(13,
+		 MPP_VAR_FUNCTION(0x0, "gpio", NULL,         V_98DX3236_PLUS),
+		 MPP_VAR_FUNCTION(0x1, "intr", "out",        V_98DX3236_PLUS),
+		 MPP_VAR_FUNCTION(0x4, "dev", "ad15",        V_98DX3236_PLUS)),
+	MPP_MODE(14,
+		 MPP_VAR_FUNCTION(0x0, "gpio", NULL,         V_98DX3236_PLUS),
+		 MPP_VAR_FUNCTION(0x1, "i2c0", "sck",        V_98DX3236_PLUS)),
+	MPP_MODE(15,
+		 MPP_VAR_FUNCTION(0x0, "gpio", NULL,         V_98DX3236_PLUS),
+		 MPP_VAR_FUNCTION(0x4, "i2c0", "sda",        V_98DX3236_PLUS)),
+	MPP_MODE(16,
+		 MPP_VAR_FUNCTION(0x0, "gpo", NULL,          V_98DX3236_PLUS),
+		 MPP_VAR_FUNCTION(0x4, "dev", "oe",          V_98DX3236_PLUS)),
+	MPP_MODE(17,
+		 MPP_VAR_FUNCTION(0x0, "gpo", NULL,          V_98DX3236_PLUS),
+		 MPP_VAR_FUNCTION(0x4, "dev", "clkout",      V_98DX3236_PLUS)),
+	MPP_MODE(18,
+		 MPP_VAR_FUNCTION(0x0, "gpio", NULL,         V_98DX3236_PLUS),
+		 MPP_VAR_FUNCTION(0x3, "uart1", "txd",       V_98DX3236_PLUS)),
+	MPP_MODE(19,
+		 MPP_VAR_FUNCTION(0x0, "gpio", NULL,         V_98DX3236_PLUS),
+		 MPP_VAR_FUNCTION(0x3, "uart1", "rxd",       V_98DX3236_PLUS),
+		 MPP_VAR_FUNCTION(0x4, "dev", "rb",          V_98DX3236_PLUS)),
+	MPP_MODE(20,
+		 MPP_VAR_FUNCTION(0x0, "gpo", NULL,          V_98DX3236_PLUS),
+		 MPP_VAR_FUNCTION(0x4, "dev", "we0",         V_98DX3236_PLUS)),
+	MPP_MODE(21,
+		 MPP_VAR_FUNCTION(0x0, "gpo", NULL,          V_98DX3236_PLUS),
+		 MPP_VAR_FUNCTION(0x1, "dev", "ad0",         V_98DX3236_PLUS)),
+	MPP_MODE(22,
+		 MPP_VAR_FUNCTION(0x0, "gpo", NULL,          V_98DX3236_PLUS),
+		 MPP_VAR_FUNCTION(0x1, "dev", "ad1",         V_98DX3236_PLUS)),
+	MPP_MODE(23,
+		 MPP_VAR_FUNCTION(0x0, "gpo", NULL,          V_98DX3236_PLUS),
+		 MPP_VAR_FUNCTION(0x1, "dev", "ad2",         V_98DX3236_PLUS)),
+	MPP_MODE(24,
+		 MPP_VAR_FUNCTION(0x0, "gpo", NULL,          V_98DX3236_PLUS),
+		 MPP_VAR_FUNCTION(0x1, "dev", "ad3",         V_98DX3236_PLUS)),
+	MPP_MODE(25,
+		 MPP_VAR_FUNCTION(0x0, "gpo", NULL,          V_98DX3236_PLUS),
+		 MPP_VAR_FUNCTION(0x1, "dev", "ad4",         V_98DX3236_PLUS)),
+	MPP_MODE(26,
+		 MPP_VAR_FUNCTION(0x0, "gpo", NULL,          V_98DX3236_PLUS),
+		 MPP_VAR_FUNCTION(0x1, "dev", "ad5",         V_98DX3236_PLUS)),
+	MPP_MODE(27,
+		 MPP_VAR_FUNCTION(0x0, "gpo", NULL,          V_98DX3236_PLUS),
+		 MPP_VAR_FUNCTION(0x1, "dev", "ad6",         V_98DX3236_PLUS)),
+	MPP_MODE(28,
+		 MPP_VAR_FUNCTION(0x0, "gpo", NULL,          V_98DX3236_PLUS),
+		 MPP_VAR_FUNCTION(0x1, "dev", "ad7",         V_98DX3236_PLUS)),
+	MPP_MODE(29,
+		 MPP_VAR_FUNCTION(0x0, "gpo", NULL,          V_98DX3236_PLUS),
+		 MPP_VAR_FUNCTION(0x1, "dev", "a0",          V_98DX3236_PLUS)),
+	MPP_MODE(30,
+		 MPP_VAR_FUNCTION(0x0, "gpo", NULL,          V_98DX3236_PLUS),
+		 MPP_VAR_FUNCTION(0x1, "dev", "a1",          V_98DX3236_PLUS)),
+	MPP_MODE(31,
+		 MPP_VAR_FUNCTION(0x0, "gpio", NULL,         V_98DX3236_PLUS),
+		 MPP_VAR_FUNCTION(0x1, "slv_smi", "mdc",     V_98DX3236_PLUS),
+		 MPP_VAR_FUNCTION(0x3, "smi", "mdc",         V_98DX3236_PLUS),
+		 MPP_VAR_FUNCTION(0x4, "dev", "we1",         V_98DX3236_PLUS)),
+	MPP_MODE(32,
+		 MPP_VAR_FUNCTION(0x0, "gpio", NULL,         V_98DX3236_PLUS),
+		 MPP_VAR_FUNCTION(0x1, "slv_smi", "mdio",    V_98DX3236_PLUS),
+		 MPP_VAR_FUNCTION(0x3, "smi", "mdio",        V_98DX3236_PLUS),
+		 MPP_VAR_FUNCTION(0x4, "dev", "cs1",         V_98DX3236_PLUS)),
+};
+
 static struct mvebu_pinctrl_soc_info armada_xp_pinctrl_info;
 
 static const struct of_device_id armada_xp_pinctrl_of_match[] = {
@@ -375,6 +504,14 @@ static const struct of_device_id armada_xp_pinctrl_of_match[] = {
 		.compatible = "marvell,mv78460-pinctrl",
 		.data       = (void *) V_MV78460,
 	},
+	{
+		.compatible = "marvell,98dx3236-pinctrl",
+		.data       = (void *) V_98DX3236,
+	},
+	{
+		.compatible = "marvell,98dx4251-pinctrl",
+		.data       = (void *) V_98DX4251,
+	},
 	{ },
 };
 
@@ -407,6 +544,14 @@ static struct pinctrl_gpio_range mv78460_mpp_gpio_ranges[] = {
 	MPP_GPIO_RANGE(2,  64, 64,  3),
 };
 
+static struct mvebu_mpp_ctrl mv98dx3236_mpp_controls[] = {
+	MPP_FUNC_CTRL(0, 32, NULL, armada_xp_mpp_ctrl),
+};
+
+static struct pinctrl_gpio_range mv98dx3236_mpp_gpio_ranges[] = {
+	MPP_GPIO_RANGE(0, 0, 0, 32),
+};
+
 static int armada_xp_pinctrl_suspend(struct platform_device *pdev,
 				     pm_message_t state)
 {
@@ -488,6 +633,17 @@ static int armada_xp_pinctrl_probe(struct platform_device *pdev)
 		soc->gpioranges = mv78460_mpp_gpio_ranges;
 		soc->ngpioranges = ARRAY_SIZE(mv78460_mpp_gpio_ranges);
 		break;
+	case V_98DX3236:
+	case V_98DX3336:
+	case V_98DX4251:
+		/* fall-through */
+		soc->controls = mv98dx3236_mpp_controls;
+		soc->ncontrols = ARRAY_SIZE(mv98dx3236_mpp_controls);
+		soc->modes = mv98dx3236_mpp_modes;
+		soc->nmodes = mv98dx3236_mpp_controls[0].npins;
+		soc->gpioranges = mv98dx3236_mpp_gpio_ranges;
+		soc->ngpioranges = ARRAY_SIZE(mv98dx3236_mpp_gpio_ranges);
+		break;
 	}
 
 	nregs = DIV_ROUND_UP(soc->nmodes, MVEBU_MPPS_PER_REG);
-- 
2.11.0.24.ge6920cf
