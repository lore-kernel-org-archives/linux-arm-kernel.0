From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 25 Feb 2015 17:01:14 +0100
Subject: [PATCH V6 00/12] Tegra xHCI support
In-Reply-To: <1416874644-12070-1-git-send-email-abrestic@chromium.org>
References: <1416874644-12070-1-git-send-email-abrestic@chromium.org>
Message-ID: <20150225160110.GA26610@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 24, 2014 at 04:17:12PM -0800, Andrew Bresticker wrote:
> This series adds support for xHCI on NVIDIA Tegra SoCs.  This includes:
>  - patches 1, 2, and 3: minor cleanups for mailbox framework and xHCI,
>  - patches 4 and 5: adding a driver for the mailbox used to communicate
>    with the xHCI controller's firmware,
>  - patches 6 and 7: extending the XUSB pad controller driver to support
>    the USB PHY types (UTMI, HSIC, and USB3),
>  - patches 8 and 9: adding a xHCI host-controller driver, and
>  - patches 10, 11, and 12: updating the relevant DT files.
> 
> The mailbox driver (patch 5) has a compile-time dependency on patch 2 and
> a run-time dependency on patch 3.  Both the PHY (patch 7) and host (patch 9)
> drivers have compile-time dependencies on the mailbox driver.  The host
> driver also has a run-time dependency on patch 1.  Because of this, this
> entire series should probably go through the Tegra tree.  Patches 11 and 12
> should probably not be merged until the controller firmware [0] lands in
> linux-firmware since they disable the EHCI controllers.
> 
> Tested on Venice2, Jetson TK1, and Big with a variety of USB2.0 and
> USB3.0 memory sticks and ethernet dongles.  This has also been tested,
> with additional out-of-tree patches, on a Tegra132-based board.
> 
> Based on v3.18-rc6.  A branch with the entire series is available at:
>   https://github.com/abrestic/linux/tree/tegra-xhci-v6
> 
> Notes:
>  - HSIC support is mostly untested and I think there are still some issues
>    to work out there.  I do have a Tegra124 board with a HSIC hub so I'll
>    try to sort those out later.
>  - The XUSB padctl driver doesn't play nice with the existing Tegra USB2.0
>    PHY driver, so all ports should be assigned to the XHCI controller.
> 
> Based on work by:
>   a lot of people, but from what I can tell from the L4T tree [1], the
>   original authors of the Tegra xHCI driver are:
>     Ajay Gupta <ajayg@nvidia.com>
>     Bharath Yadav <byadav@nvidia.com>
> 
> [0] https://patchwork.ozlabs.org/patch/400110/
> [1] git://nv-tegra.nvidia.com/linux-3.10.git
> 
> Changes from v5:
>  - Addressed review comments from Jassi and Felipe.
> 
> Changes from v4:
>  - Made USB support optional in padctl driver.
>  - Made usb3-port a pinconfig property again.
>  - Cleaned up mbox_request_channel() error handling and allowed it to defer
>    probing (patch 3).
>  - Minor xHCI (patch 1) and mailbox framework (patch 2) cleanups suggested
>    by Thierry.
>  - Addressed Thierry's review comments.
> 
> Changes from v3:
>  - Fixed USB2.0 flakiness on Jetson-TK1.
>  - Switched to 32-bit DMA mask for host.
>  - Addressed Stephen's review comments.
> 
> Chagnes from v2:
>  - Dropped mailbox channel specifier.  The mailbox driver allocates virtual
>    channels backed by the single physical channel.
>  - Added support for HS_CURR_LEVEL adjustment pinconfig property, which
>    will be required for the Blaze board.
>  - Addressed Stephen's review comments.
> 
> Changes from v1:
>  - Converted mailbox driver to use the common mailbox framework.
>  - Fixed up host driver so that it can now be built and used as a module.
>  - Addressed Stephen's review comments.
>  - Misc. cleanups.
> 
> Andrew Bresticker (11):
>   xhci: Set shared HCD's hcd_priv in xhci_gen_setup
>   mailbox: Make struct mbox_controller's ops field const
>   of: Add NVIDIA Tegra XUSB mailbox binding
>   mailbox: Add NVIDIA Tegra XUSB mailbox driver
>   of: Update Tegra XUSB pad controller binding for USB
>   pinctrl: tegra-xusb: Add USB PHY support
>   of: Add NVIDIA Tegra xHCI controller binding
>   usb: xhci: Add NVIDIA Tegra xHCI host-controller driver
>   ARM: tegra: jetson-tk1: Add xHCI support
>   ARM: tegra: Add Tegra124 XUSB mailbox and xHCI controller
>   ARM: tegra: venice2: Add xHCI support
> 
> Benson Leung (1):
>   mailbox: Fix up error handling in mbox_request_channel()
> 
>  .../bindings/mailbox/nvidia,tegra124-xusb-mbox.txt |   32 +
>  .../pinctrl/nvidia,tegra124-xusb-padctl.txt        |   63 +-
>  .../bindings/usb/nvidia,tegra124-xhci.txt          |  104 ++
>  arch/arm/boot/dts/tegra124-jetson-tk1.dts          |   46 +-
>  arch/arm/boot/dts/tegra124-venice2.dts             |   79 +-
>  arch/arm/boot/dts/tegra124.dtsi                    |   41 +
>  drivers/mailbox/Kconfig                            |    3 +
>  drivers/mailbox/Makefile                           |    2 +
>  drivers/mailbox/mailbox.c                          |   11 +-
>  drivers/mailbox/tegra-xusb-mailbox.c               |  278 +++++
>  drivers/pinctrl/Kconfig                            |    1 +
>  drivers/pinctrl/pinctrl-tegra-xusb.c               | 1262 +++++++++++++++++++-
>  drivers/usb/host/Kconfig                           |   10 +
>  drivers/usb/host/Makefile                          |    1 +
>  drivers/usb/host/xhci-pci.c                        |    5 -
>  drivers/usb/host/xhci-plat.c                       |    5 -
>  drivers/usb/host/xhci-tegra.c                      |  931 +++++++++++++++
>  drivers/usb/host/xhci.c                            |    6 +-
>  include/dt-bindings/pinctrl/pinctrl-tegra-xusb.h   |    7 +
>  include/linux/mailbox_controller.h                 |    2 +-
>  include/soc/tegra/xusb.h                           |   50 +
>  21 files changed, 2852 insertions(+), 87 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/nvidia,tegra124-xusb-mbox.txt
>  create mode 100644 Documentation/devicetree/bindings/usb/nvidia,tegra124-xhci.txt
>  create mode 100644 drivers/mailbox/tegra-xusb-mailbox.c
>  create mode 100644 drivers/usb/host/xhci-tegra.c
>  create mode 100644 include/soc/tegra/xusb.h

Hi Andrew,

Sorry for taking so awfully long to look at this. I've spent some time
looking at various pieces of documentation and I concluded that
representing the port assignment as muxing options doesn't seem right
after all. Instead I've come up with an alternate proposal (attached).
Could you take a look and see if that sounds reasonable to you?

Thierry
-------------- next part --------------
diff --git a/Documentation/devicetree/bindings/pinctrl/nvidia,tegra124-xusb-padctl.txt b/Documentation/devicetree/bindings/pinctrl/nvidia,tegra124-xusb-padctl.txt
index 4af09d6235c1..9ca9ca5f85c6 100644
--- a/Documentation/devicetree/bindings/pinctrl/nvidia,tegra124-xusb-padctl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/nvidia,tegra124-xusb-padctl.txt
@@ -29,10 +29,26 @@ Required properties:
   - xusb
 
 Optional properties:
--------------------
-- vbus-{0,1,2}-supply: VBUS regulator for the corresponding UTMI pad.
+--------------------
 - vddio-hsic-supply: VDDIO regulator for the HSIC pads.
 
+PHY nodes:
+----------
+
+An optional child node named "phys" can contain nodes describing additional
+properties of each PHY. Only USB3 and UTMI PHYs can be complemented in this
+way, in which case the name of each node must match one of the following:
+
+  usb3-0, usb3-1, utmi-0, utmi-1, utmi-2
+
+Required properties for USB3 PHYs:
+- nvidia,lanes: specifies the name of the lane that this USB3 PHY uses
+- nvidia,port: specifies the number of the USB2 port that is used for this
+  USB3 PHY
+
+Optional properties for UTMI PHYs:
+- vbus-supply: regulator providing the VBUS voltage for the UTMI pad
+
 Lane muxing:
 ------------
 
@@ -98,9 +114,7 @@ divided into four groups:
 
     Valid functions for this group are: "pcie", "usb3", "sata", "rsvd".
 
-    Only the nvidia,iddq, nvidia,usb2-port, and nvidia,usb3-port properties
-    apply. The nvidia,usb2-port and nvidia,usb3-port properties are required
-    when the function is usb3.
+    Only the nvidia,iddq property applies.
 
 Example:
 ========
@@ -148,7 +162,24 @@ Board file extract:
 		pinctrl-0 = <&padctl_default>;
 		pinctrl-names = "default";
 
-		vbus-2-supply = <&vdd_usb3_vbus>;
+		phys {
+			usb3-0 {
+				status = "okay";
+
+				nvidia,lanes = "pcie-0";
+				nvidia,port = <2>;
+			};
+
+			utmi-1 {
+				status = "okay";
+			};
+
+			utmi-2 {
+				status = "okay";
+
+				vbus-supply = <&vdd_usb3_vbus>;
+			};
+		};
 
 		padctl_default: pinmux {
 			otg {
@@ -160,8 +191,6 @@ Board file extract:
 				nvidia,lanes = "pcie-0";
 				nvidia,function = "usb3";
 				nvidia,iddq = <0>;
-				nvidia,usb2-port = <2>;
-				nvidia,usb3-port = <0>;
 			};
 
 			pcie {
diff --git a/arch/arm/boot/dts/tegra124-jetson-tk1.dts b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
index 526826b790f8..bd7af1073d4c 100644
--- a/arch/arm/boot/dts/tegra124-jetson-tk1.dts
+++ b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
@@ -1724,7 +1724,24 @@
 		pinctrl-0 = <&padctl_default>;
 		pinctrl-names = "default";
 
-		vbus-2-supply = <&vdd_usb3_vbus>;
+		phys {
+			usb3-0 {
+				status = "okay";
+
+				nvidia,lanes = "pcie-0";
+				nvidia,port = <2>;
+			};
+
+			utmi-1 {
+				status = "okay";
+			};
+
+			utmi-2 {
+				status = "okay";
+
+				vbus-supply = <&vdd_usb3_vbus>;
+			};
+		};
 
 		padctl_default: pinmux {
 			otg {
@@ -1736,8 +1753,6 @@
 				nvidia,lanes = "pcie-0";
 				nvidia,function = "usb3";
 				nvidia,iddq = <0>;
-				nvidia,usb2-port = <2>;
-				nvidia,usb3-port = <0>;
 			};
 
 			pcie {
diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
index c16c5e932a4c..31c3d0ee6305 100644
--- a/arch/arm/boot/dts/tegra124.dtsi
+++ b/arch/arm/boot/dts/tegra124.dtsi
@@ -685,6 +685,28 @@
 		mbox-names = "xusb";
 
 		#phy-cells = <1>;
+
+		phys {
+			usb3-0 {
+				status = "disabled";
+			};
+
+			usb3-1 {
+				status = "disabled";
+			};
+
+			utmi-0 {
+				status = "disabled";
+			};
+
+			utmi-1 {
+				status = "disabled";
+			};
+
+			utmi-2 {
+				status = "disabled";
+			};
+		};
 	};
 
 	sdhci at 0,700b0000 {
diff --git a/drivers/pinctrl/pinctrl-tegra-xusb.c b/drivers/pinctrl/pinctrl-tegra-xusb.c
index cfda6ad6457f..2c1ec538402d 100644
--- a/drivers/pinctrl/pinctrl-tegra-xusb.c
+++ b/drivers/pinctrl/pinctrl-tegra-xusb.c
@@ -254,13 +254,25 @@ struct tegra_xusb_fuse_calibration {
 	u32 hs_squelch_level;
 };
 
-struct tegra_xusb_usb3_port {
-	unsigned int lane;
+struct tegra_xusb_usb3_phy {
+	struct tegra_xusb_padctl *padctl;
 	bool context_saved;
-	u32 tap1_val;
-	u32 amp_val;
-	u32 ctle_z_val;
-	u32 ctle_g_val;
+	unsigned int index;
+	unsigned int lane;
+	unsigned int port;
+
+	u32 tap1;
+	u32 amp;
+	u32 ctle_z;
+	u32 ctle_g;
+};
+
+struct tegra_xusb_utmi_phy {
+	struct tegra_xusb_padctl *padctl;
+	unsigned int index;
+
+	unsigned int hs_curr_level_offset;
+	struct regulator *supply;
 };
 
 struct tegra_xusb_padctl {
@@ -284,10 +296,7 @@ struct tegra_xusb_padctl {
 	struct mbox_client mbox_client;
 	struct mbox_chan *mbox_chan;
 
-	struct tegra_xusb_usb3_port usb3_ports[TEGRA_XUSB_USB3_PHYS];
 	unsigned int utmi_enable;
-	unsigned int hs_curr_level_offset[TEGRA_XUSB_UTMI_PHYS];
-	struct regulator *vbus[TEGRA_XUSB_UTMI_PHYS];
 	struct regulator *vddio_hsic;
 };
 
@@ -337,19 +346,6 @@ static inline bool lane_is_pcie_or_sata(unsigned int lane)
 	return lane >= PIN_PCIE_0 && lane <= PIN_SATA_0;
 }
 
-static int lane_to_usb3_port(struct tegra_xusb_padctl *padctl,
-			     unsigned int lane)
-{
-	unsigned int i;
-
-	for (i = 0; i < TEGRA_XUSB_USB3_PHYS; i++) {
-		if (padctl->usb3_ports[i].lane == lane)
-			return i;
-	}
-
-	return -EINVAL;
-}
-
 static int tegra_xusb_padctl_get_groups_count(struct pinctrl_dev *pinctrl)
 {
 	struct tegra_xusb_padctl *padctl = pinctrl_dev_get_drvdata(pinctrl);
@@ -367,8 +363,6 @@ static const char *tegra_xusb_padctl_get_group_name(struct pinctrl_dev *pinctrl,
 
 enum tegra_xusb_padctl_param {
 	TEGRA_XUSB_PADCTL_IDDQ,
-	TEGRA_XUSB_PADCTL_USB3_PORT,
-	TEGRA_XUSB_PADCTL_USB2_PORT,
 	TEGRA_XUSB_PADCTL_HSIC_STROBE_TRIM,
 	TEGRA_XUSB_PADCTL_HSIC_RX_STROBE_TRIM,
 	TEGRA_XUSB_PADCTL_HSIC_RX_DATA_TRIM,
@@ -385,8 +379,6 @@ static const struct tegra_xusb_padctl_property {
 	enum tegra_xusb_padctl_param param;
 } properties[] = {
 	{ "nvidia,iddq", TEGRA_XUSB_PADCTL_IDDQ },
-	{ "nvidia,usb3-port", TEGRA_XUSB_PADCTL_USB3_PORT },
-	{ "nvidia,usb2-port", TEGRA_XUSB_PADCTL_USB2_PORT },
 	{ "nvidia,hsic-strobe-trim", TEGRA_XUSB_PADCTL_HSIC_STROBE_TRIM },
 	{ "nvidia,hsic-rx-strobe-trim", TEGRA_XUSB_PADCTL_HSIC_RX_STROBE_TRIM },
 	{ "nvidia,hsic-rx-data-trim", TEGRA_XUSB_PADCTL_HSIC_RX_DATA_TRIM },
@@ -604,28 +596,6 @@ static int tegra_xusb_padctl_pinconf_group_get(struct pinctrl_dev *pinctrl,
 			value = 1;
 		break;
 
-	case TEGRA_XUSB_PADCTL_USB3_PORT:
-		value = lane_to_usb3_port(padctl, group);
-		if (value < 0) {
-			dev_err(padctl->dev,
-				"Pin %d not mapped to USB3 port\n", group);
-			return -EINVAL;
-		}
-		break;
-
-	case TEGRA_XUSB_PADCTL_USB2_PORT:
-		port = lane_to_usb3_port(padctl, group);
-		if (port < 0) {
-			dev_err(padctl->dev,
-				"Pin %d not mapped to USB3 port\n", group);
-			return -EINVAL;
-		}
-
-		value = padctl_readl(padctl, XUSB_PADCTL_SS_PORT_MAP) >>
-			XUSB_PADCTL_SS_PORT_MAP_PORTX_SHIFT(port);
-		value &= XUSB_PADCTL_SS_PORT_MAP_PORT_MASK;
-		break;
-
 	case TEGRA_XUSB_PADCTL_HSIC_STROBE_TRIM:
 		if (!lane_is_hsic(group)) {
 			dev_err(padctl->dev, "Pin %d not an HSIC\n", group);
@@ -728,10 +698,15 @@ static int tegra_xusb_padctl_pinconf_group_get(struct pinctrl_dev *pinctrl,
 			dev_err(padctl->dev, "Pin %d is not an OTG pad\n",
 				group);
 			return -EINVAL;
-		}
+		} else {
+			unsigned int index = group - PIN_OTG_0;
+			struct tegra_xusb_utmi_phy *utmi;
+			struct phy *phy;
 
-		port = group - PIN_OTG_0;
-		value = padctl->hs_curr_level_offset[port];
+			phy = padctl->phys[TEGRA_XUSB_PADCTL_UTMI_P0 + index];
+			utmi = phy_get_drvdata(phy);
+			value = utmi->hs_curr_level_offset;
+		}
 		break;
 
 	default:
@@ -779,50 +754,6 @@ static int tegra_xusb_padctl_pinconf_group_set(struct pinctrl_dev *pinctrl,
 			padctl_writel(padctl, regval, lane->offset);
 			break;
 
-		case TEGRA_XUSB_PADCTL_USB3_PORT:
-			if (value >= TEGRA_XUSB_USB3_PHYS) {
-				dev_err(padctl->dev, "Invalid USB3 port: %lu\n",
-					value);
-				return -EINVAL;
-			}
-			if (!lane_is_pcie_or_sata(group)) {
-				dev_err(padctl->dev,
-					"USB3 port not applicable for pin %d\n",
-					group);
-				return -EINVAL;
-			}
-
-			padctl->usb3_ports[value].lane = group;
-			break;
-
-		case TEGRA_XUSB_PADCTL_USB2_PORT:
-			if (value >= TEGRA_XUSB_UTMI_PHYS) {
-				dev_err(padctl->dev, "Invalid USB2 port: %lu\n",
-					value);
-				return -EINVAL;
-			}
-			if (!lane_is_pcie_or_sata(group)) {
-				dev_err(padctl->dev,
-					"USB2 port not applicable for pin %d\n",
-					group);
-				return -EINVAL;
-			}
-			port = lane_to_usb3_port(padctl, group);
-			if (port < 0) {
-				dev_err(padctl->dev,
-					"Pin %d not mapped to USB3 port\n",
-					group);
-				return -EINVAL;
-			}
-
-			regval = padctl_readl(padctl, XUSB_PADCTL_SS_PORT_MAP);
-			regval &= ~(XUSB_PADCTL_SS_PORT_MAP_PORT_MASK <<
-				    XUSB_PADCTL_SS_PORT_MAP_PORTX_SHIFT(port));
-			regval |= value <<
-				XUSB_PADCTL_SS_PORT_MAP_PORTX_SHIFT(port);
-			padctl_writel(padctl, regval, XUSB_PADCTL_SS_PORT_MAP);
-			break;
-
 		case TEGRA_XUSB_PADCTL_HSIC_STROBE_TRIM:
 			if (!lane_is_hsic(group)) {
 				dev_err(padctl->dev, "Pin %d not an HSIC\n",
@@ -972,11 +903,17 @@ static int tegra_xusb_padctl_pinconf_group_set(struct pinctrl_dev *pinctrl,
 				dev_err(padctl->dev,
 					"Pin %d is not an OTG pad\n", group);
 				return -EINVAL;
-			}
+			} else {
+				unsigned int index = group - PIN_OTG_0;
+				struct tegra_xusb_utmi_phy *utmi;
+				struct phy *phy;
 
-			port = group - PIN_OTG_0;
-			value &= XUSB_PADCTL_USB2_OTG_PAD_CTL0_HS_CURR_LEVEL_MASK;
-			padctl->hs_curr_level_offset[port] = value;
+				phy = padctl->phys[TEGRA_XUSB_PADCTL_UTMI_P0 + index];
+				utmi = phy_get_drvdata(phy);
+
+				value &= XUSB_PADCTL_USB2_OTG_PAD_CTL0_HS_CURR_LEVEL_MASK;
+				utmi->hs_curr_level_offset = value;
+			}
 			break;
 
 		default:
@@ -1265,36 +1202,46 @@ static const struct phy_ops sata_phy_ops = {
 	.owner = THIS_MODULE,
 };
 
-static int usb3_phy_to_port(struct phy *phy)
+static int usb3_phy_init(struct phy *phy)
 {
-	struct tegra_xusb_padctl *padctl = phy_get_drvdata(phy);
-	unsigned int i;
+	struct tegra_xusb_usb3_phy *usb = phy_get_drvdata(phy);
+	struct tegra_xusb_padctl *padctl = usb->padctl;
+	u32 value;
+	int err;
 
-	for (i = 0; i < TEGRA_XUSB_USB3_PHYS; i++) {
-		if (phy == padctl->phys[TEGRA_XUSB_PADCTL_USB3_P0 + i])
-			return i;
-	}
-	WARN_ON(1);
+	err = tegra_xusb_padctl_enable(padctl);
+	if (err < 0)
+		return err;
 
-	return -EINVAL;
+	value = padctl_readl(padctl, XUSB_PADCTL_SS_PORT_MAP);
+	value &= ~(XUSB_PADCTL_SS_PORT_MAP_PORT_MASK <<
+		   XUSB_PADCTL_SS_PORT_MAP_PORTX_SHIFT(usb->index));
+	value |= usb->port <<
+		 XUSB_PADCTL_SS_PORT_MAP_PORTX_SHIFT(usb->index);
+	padctl_writel(padctl, value, XUSB_PADCTL_SS_PORT_MAP);
+
+	return 0;
 }
 
-static int usb3_phy_power_on(struct phy *phy)
+static int usb3_phy_exit(struct phy *phy)
 {
-	struct tegra_xusb_padctl *padctl = phy_get_drvdata(phy);
-	int port = usb3_phy_to_port(phy);
-	unsigned int lane;
-	u32 value, offset;
+	struct tegra_xusb_usb3_phy *usb = phy_get_drvdata(phy);
+	struct tegra_xusb_padctl *padctl = usb->padctl;
+	u32 value;
 
-	if (port < 0)
-		return port;
+	value = padctl_readl(padctl, XUSB_PADCTL_SS_PORT_MAP);
+	value |= 0x7 << XUSB_PADCTL_SS_PORT_MAP_PORTX_SHIFT(usb->index);
+	padctl_writel(padctl, value, XUSB_PADCTL_SS_PORT_MAP);
 
-	lane = padctl->usb3_ports[port].lane;
-	if (!lane_is_pcie_or_sata(lane)) {
-		dev_err(padctl->dev, "USB3 PHY %d mapped to invalid lane: %d\n",
-			port, lane);
-		return -EINVAL;
-	}
+	return tegra_xusb_padctl_disable(padctl);
+}
+
+static int usb3_phy_power_on(struct phy *phy)
+{
+	struct tegra_xusb_usb3_phy *usb = phy_get_drvdata(phy);
+	struct tegra_xusb_padctl *padctl = usb->padctl;
+	unsigned int port = usb->index;
+	u32 value, offset;
 
 	value = padctl_readl(padctl, XUSB_PADCTL_IOPHY_USB3_PADX_CTL2(port));
 	value &= ~((XUSB_PADCTL_IOPHY_USB3_PAD_CTL2_RX_WANDER_MASK <<
@@ -1309,34 +1256,34 @@ static int usb3_phy_power_on(struct phy *phy)
 		  XUSB_PADCTL_IOPHY_USB3_PAD_CTL2_CDR_CNTL_SHIFT) |
 		 (padctl->soc->rx_eq <<
 		  XUSB_PADCTL_IOPHY_USB3_PAD_CTL2_RX_EQ_SHIFT);
-	if (padctl->usb3_ports[port].context_saved) {
+	if (usb->context_saved) {
 		value &= ~((XUSB_PADCTL_IOPHY_USB3_PAD_CTL2_RX_EQ_G_MASK <<
 			    XUSB_PADCTL_IOPHY_USB3_PAD_CTL2_RX_EQ_G_SHIFT) |
 			   (XUSB_PADCTL_IOPHY_USB3_PAD_CTL2_RX_EQ_Z_MASK <<
 			    XUSB_PADCTL_IOPHY_USB3_PAD_CTL2_RX_EQ_Z_SHIFT));
-		value |= (padctl->usb3_ports[port].ctle_g_val <<
+		value |= (usb->ctle_g <<
 			  XUSB_PADCTL_IOPHY_USB3_PAD_CTL2_RX_EQ_G_SHIFT) |
-			 (padctl->usb3_ports[port].ctle_z_val <<
+			 (usb->ctle_z <<
 			  XUSB_PADCTL_IOPHY_USB3_PAD_CTL2_RX_EQ_Z_SHIFT);
 	}
 	padctl_writel(padctl, value, XUSB_PADCTL_IOPHY_USB3_PADX_CTL2(port));
 
 	value = padctl->soc->dfe_cntl;
-	if (padctl->usb3_ports[port].context_saved) {
+	if (usb->context_saved) {
 		value &= ~((XUSB_PADCTL_IOPHY_USB3_PAD_CTL4_DFE_CNTL_TAP_MASK <<
 			    XUSB_PADCTL_IOPHY_USB3_PAD_CTL4_DFE_CNTL_TAP_SHIFT) |
 			   (XUSB_PADCTL_IOPHY_USB3_PAD_CTL4_DFE_CNTL_AMP_MASK <<
 			    XUSB_PADCTL_IOPHY_USB3_PAD_CTL4_DFE_CNTL_AMP_SHIFT));
-		value |= (padctl->usb3_ports[port].tap1_val <<
+		value |= (usb->tap1 <<
 			  XUSB_PADCTL_IOPHY_USB3_PAD_CTL4_DFE_CNTL_TAP_SHIFT) |
-			 (padctl->usb3_ports[port].amp_val <<
+			 (usb->amp <<
 			  XUSB_PADCTL_IOPHY_USB3_PAD_CTL4_DFE_CNTL_AMP_SHIFT);
 	}
 	padctl_writel(padctl, value, XUSB_PADCTL_IOPHY_USB3_PADX_CTL4(port));
 
-	offset = (lane == PIN_SATA_0) ?
+	offset = (usb->lane == PIN_SATA_0) ?
 		XUSB_PADCTL_IOPHY_MISC_PAD_S0_CTL2 :
-		XUSB_PADCTL_IOPHY_MISC_PAD_PX_CTL2(lane - PIN_PCIE_0);
+		XUSB_PADCTL_IOPHY_MISC_PAD_PX_CTL2(usb->lane - PIN_PCIE_0);
 	value = padctl_readl(padctl, offset);
 	value &= ~(XUSB_PADCTL_IOPHY_MISC_PAD_CTL2_SPARE_IN_MASK <<
 		   XUSB_PADCTL_IOPHY_MISC_PAD_CTL2_SPARE_IN_SHIFT);
@@ -1344,15 +1291,15 @@ static int usb3_phy_power_on(struct phy *phy)
 		XUSB_PADCTL_IOPHY_MISC_PAD_CTL2_SPARE_IN_SHIFT;
 	padctl_writel(padctl, value, offset);
 
-	offset = (lane == PIN_SATA_0) ?
+	offset = (usb->lane == PIN_SATA_0) ?
 		XUSB_PADCTL_IOPHY_MISC_PAD_S0_CTL5 :
-		XUSB_PADCTL_IOPHY_MISC_PAD_PX_CTL5(lane - PIN_PCIE_0);
+		XUSB_PADCTL_IOPHY_MISC_PAD_PX_CTL5(usb->lane - PIN_PCIE_0);
 	value = padctl_readl(padctl, offset);
 	value |= XUSB_PADCTL_IOPHY_MISC_PAD_CTL5_RX_QEYE_EN;
 	padctl_writel(padctl, value, offset);
 
 	/* Enable SATA PHY when SATA lane is used */
-	if (lane == PIN_SATA_0) {
+	if (usb->lane == PIN_SATA_0) {
 		value = padctl_readl(padctl, XUSB_PADCTL_IOPHY_PLL_S0_CTL1);
 		value &= ~(XUSB_PADCTL_IOPHY_PLL_S0_CTL1_PLL0_REFCLK_NDIV_MASK <<
 			   XUSB_PADCTL_IOPHY_PLL_S0_CTL1_PLL0_REFCLK_NDIV_SHIFT);
@@ -1401,13 +1348,11 @@ static int usb3_phy_power_on(struct phy *phy)
 
 static int usb3_phy_power_off(struct phy *phy)
 {
-	struct tegra_xusb_padctl *padctl = phy_get_drvdata(phy);
-	int port = usb3_phy_to_port(phy);
+	struct tegra_xusb_usb3_phy *usb = phy_get_drvdata(phy);
+	struct tegra_xusb_padctl *padctl = usb->padctl;
+	unsigned int port = usb->index;
 	u32 value;
 
-	if (port < 0)
-		return port;
-
 	value = padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM);
 	value |= XUSB_PADCTL_ELPG_PROGRAM_SSPX_ELPG_CLAMP_EN_EARLY(port);
 	padctl_writel(padctl, value, XUSB_PADCTL_ELPG_PROGRAM);
@@ -1427,20 +1372,21 @@ static int usb3_phy_power_off(struct phy *phy)
 	return 0;
 }
 
-static int usb3_phy_save_context(struct tegra_xusb_padctl *padctl,
-				 unsigned int port)
+static int tegra_xusb_usb3_phy_save_context(struct tegra_xusb_padctl *padctl,
+					    unsigned int port)
 {
-	unsigned int lane = padctl->usb3_ports[port].lane;
+	struct tegra_xusb_usb3_phy *usb;
 	u32 value, offset;
 
 	if (port >= TEGRA_XUSB_USB3_PHYS)
 		return -EINVAL;
 
-	padctl->usb3_ports[port].context_saved = true;
+	usb = phy_get_drvdata(padctl->phys[TEGRA_XUSB_PADCTL_USB3_P0 + port]);
+	usb->context_saved = true;
 
-	offset = (lane == PIN_SATA_0) ?
+	offset = (usb->lane == PIN_SATA_0) ?
 		XUSB_PADCTL_IOPHY_MISC_PAD_S0_CTL6 :
-		XUSB_PADCTL_IOPHY_MISC_PAD_PX_CTL6(lane - PIN_PCIE_0);
+		XUSB_PADCTL_IOPHY_MISC_PAD_PX_CTL6(usb->lane - PIN_PCIE_0);
 
 	value = padctl_readl(padctl, offset);
 	value &= ~(XUSB_PADCTL_IOPHY_MISC_PAD_CTL6_MISC_OUT_SEL_MASK <<
@@ -1451,8 +1397,7 @@ static int usb3_phy_save_context(struct tegra_xusb_padctl *padctl,
 
 	value = padctl_readl(padctl, offset) >>
 		XUSB_PADCTL_IOPHY_MISC_PAD_CTL6_MISC_OUT_SHIFT;
-	padctl->usb3_ports[port].tap1_val = value &
-		XUSB_PADCTL_IOPHY_MISC_PAD_CTL6_MISC_OUT_TAP_MASK;
+	usb->tap1 = value & XUSB_PADCTL_IOPHY_MISC_PAD_CTL6_MISC_OUT_TAP_MASK;
 
 	value = padctl_readl(padctl, offset);
 	value &= ~(XUSB_PADCTL_IOPHY_MISC_PAD_CTL6_MISC_OUT_SEL_MASK <<
@@ -1463,17 +1408,16 @@ static int usb3_phy_save_context(struct tegra_xusb_padctl *padctl,
 
 	value = padctl_readl(padctl, offset) >>
 		XUSB_PADCTL_IOPHY_MISC_PAD_CTL6_MISC_OUT_SHIFT;
-	padctl->usb3_ports[port].amp_val = value &
-		XUSB_PADCTL_IOPHY_MISC_PAD_CTL6_MISC_OUT_AMP_MASK;
+	usb->amp = value & XUSB_PADCTL_IOPHY_MISC_PAD_CTL6_MISC_OUT_AMP_MASK;
 
 	value = padctl_readl(padctl, XUSB_PADCTL_IOPHY_USB3_PADX_CTL4(port));
 	value &= ~((XUSB_PADCTL_IOPHY_USB3_PAD_CTL4_DFE_CNTL_TAP_MASK <<
 		    XUSB_PADCTL_IOPHY_USB3_PAD_CTL4_DFE_CNTL_TAP_SHIFT) |
 		   (XUSB_PADCTL_IOPHY_USB3_PAD_CTL4_DFE_CNTL_AMP_MASK <<
 		    XUSB_PADCTL_IOPHY_USB3_PAD_CTL4_DFE_CNTL_AMP_SHIFT));
-	value |= (padctl->usb3_ports[port].tap1_val <<
+	value |= (usb->tap1 <<
 		  XUSB_PADCTL_IOPHY_USB3_PAD_CTL4_DFE_CNTL_TAP_SHIFT) |
-		 (padctl->usb3_ports[port].amp_val <<
+		 (usb->amp <<
 		  XUSB_PADCTL_IOPHY_USB3_PAD_CTL4_DFE_CNTL_AMP_SHIFT);
 	padctl_writel(padctl, value, XUSB_PADCTL_IOPHY_USB3_PADX_CTL4(port));
 
@@ -1493,7 +1437,7 @@ static int usb3_phy_save_context(struct tegra_xusb_padctl *padctl,
 
 	value = padctl_readl(padctl, offset) >>
 		XUSB_PADCTL_IOPHY_MISC_PAD_CTL6_MISC_OUT_SHIFT;
-	padctl->usb3_ports[port].ctle_g_val = value &
+	usb->ctle_g = value &
 		XUSB_PADCTL_IOPHY_MISC_PAD_CTL6_MISC_OUT_G_Z_MASK;
 
 	value = padctl_readl(padctl, offset);
@@ -1505,7 +1449,7 @@ static int usb3_phy_save_context(struct tegra_xusb_padctl *padctl,
 
 	value = padctl_readl(padctl, offset) >>
 		XUSB_PADCTL_IOPHY_MISC_PAD_CTL6_MISC_OUT_SHIFT;
-	padctl->usb3_ports[port].ctle_z_val = value &
+	usb->ctle_z = value &
 		XUSB_PADCTL_IOPHY_MISC_PAD_CTL6_MISC_OUT_G_Z_MASK;
 
 	value = padctl_readl(padctl, XUSB_PADCTL_IOPHY_USB3_PADX_CTL2(port));
@@ -1513,9 +1457,9 @@ static int usb3_phy_save_context(struct tegra_xusb_padctl *padctl,
 		    XUSB_PADCTL_IOPHY_USB3_PAD_CTL2_RX_EQ_G_SHIFT) |
 		   (XUSB_PADCTL_IOPHY_USB3_PAD_CTL2_RX_EQ_Z_MASK <<
 		    XUSB_PADCTL_IOPHY_USB3_PAD_CTL2_RX_EQ_Z_SHIFT));
-	value |= (padctl->usb3_ports[port].ctle_g_val <<
+	value |= (usb->ctle_g <<
 		  XUSB_PADCTL_IOPHY_USB3_PAD_CTL2_RX_EQ_G_SHIFT) |
-		 (padctl->usb3_ports[port].ctle_z_val <<
+		 (usb->ctle_z <<
 		  XUSB_PADCTL_IOPHY_USB3_PAD_CTL2_RX_EQ_Z_SHIFT);
 	padctl_writel(padctl, value, XUSB_PADCTL_IOPHY_USB3_PADX_CTL2(port));
 
@@ -1523,36 +1467,34 @@ static int usb3_phy_save_context(struct tegra_xusb_padctl *padctl,
 }
 
 static const struct phy_ops usb3_phy_ops = {
-	.init = tegra_xusb_phy_init,
-	.exit = tegra_xusb_phy_exit,
+	.init = usb3_phy_init,
+	.exit = usb3_phy_exit,
 	.power_on = usb3_phy_power_on,
 	.power_off = usb3_phy_power_off,
 	.owner = THIS_MODULE,
 };
 
-static int utmi_phy_to_port(struct phy *phy)
+static int utmi_phy_init(struct phy *phy)
 {
-	struct tegra_xusb_padctl *padctl = phy_get_drvdata(phy);
-	unsigned int i;
+	struct tegra_xusb_utmi_phy *utmi = phy_get_drvdata(phy);
 
-	for (i = 0; i < TEGRA_XUSB_UTMI_PHYS; i++) {
-		if (phy == padctl->phys[TEGRA_XUSB_PADCTL_UTMI_P0 + i])
-			return i;
-	}
-	WARN_ON(1);
+	return tegra_xusb_padctl_enable(utmi->padctl);
+}
 
-	return -EINVAL;
+static int utmi_phy_exit(struct phy *phy)
+{
+	struct tegra_xusb_utmi_phy *utmi = phy_get_drvdata(phy);
+
+	return tegra_xusb_padctl_disable(utmi->padctl);
 }
 
 static int utmi_phy_power_on(struct phy *phy)
 {
-	struct tegra_xusb_padctl *padctl = phy_get_drvdata(phy);
-	int port = utmi_phy_to_port(phy);
-	int err;
+	struct tegra_xusb_utmi_phy *utmi = phy_get_drvdata(phy);
+	struct tegra_xusb_padctl *padctl = utmi->padctl;
+	unsigned int port = utmi->index;
 	u32 value;
-
-	if (port < 0)
-		return port;
+	int err;
 
 	value = padctl_readl(padctl, XUSB_PADCTL_USB2_BIAS_PAD_CTL0);
 	value &= ~((XUSB_PADCTL_USB2_BIAS_PAD_CTL0_HS_SQUELCH_LEVEL_MASK <<
@@ -1583,7 +1525,7 @@ static int utmi_phy_power_on(struct phy *phy)
 		   XUSB_PADCTL_USB2_OTG_PAD_CTL0_PD2 |
 		   XUSB_PADCTL_USB2_OTG_PAD_CTL0_PD_ZI);
 	value |= (padctl->calib.hs_curr_level[port] +
-		  padctl->hs_curr_level_offset[port]) <<
+		  utmi->hs_curr_level_offset) <<
 		XUSB_PADCTL_USB2_OTG_PAD_CTL0_HS_CURR_LEVEL_SHIFT;
 	value |= padctl->soc->hs_slew <<
 		XUSB_PADCTL_USB2_OTG_PAD_CTL0_HS_SLEW_SHIFT;
@@ -1605,7 +1547,7 @@ static int utmi_phy_power_on(struct phy *phy)
 		  XUSB_PADCTL_USB2_OTG_PAD_CTL1_HS_IREF_CAP_SHIFT);
 	padctl_writel(padctl, value, XUSB_PADCTL_USB2_OTG_PADX_CTL1(port));
 
-	err = regulator_enable(padctl->vbus[port]);
+	err = regulator_enable(utmi->supply);
 	if (err)
 		return err;
 
@@ -1625,15 +1567,10 @@ out:
 
 static int utmi_phy_power_off(struct phy *phy)
 {
-	struct tegra_xusb_padctl *padctl = phy_get_drvdata(phy);
-	int port = utmi_phy_to_port(phy);
+	struct tegra_xusb_utmi_phy *utmi = phy_get_drvdata(phy);
+	struct tegra_xusb_padctl *padctl = utmi->padctl;
 	u32 value;
 
-	if (port < 0)
-		return port;
-
-	regulator_disable(padctl->vbus[port]);
-
 	mutex_lock(&padctl->lock);
 
 	if (WARN_ON(padctl->utmi_enable == 0))
@@ -1647,13 +1584,14 @@ static int utmi_phy_power_off(struct phy *phy)
 	padctl_writel(padctl, value, XUSB_PADCTL_USB2_BIAS_PAD_CTL0);
 
 out:
+	regulator_disable(utmi->supply);
 	mutex_unlock(&padctl->lock);
 	return 0;
 }
 
 static const struct phy_ops utmi_phy_ops = {
-	.init = tegra_xusb_phy_init,
-	.exit = tegra_xusb_phy_exit,
+	.init = utmi_phy_init,
+	.exit = utmi_phy_exit,
 	.power_on = utmi_phy_power_on,
 	.power_off = utmi_phy_power_off,
 	.owner = THIS_MODULE,
@@ -1757,7 +1695,7 @@ static void tegra_xusb_phy_mbox_work(struct work_struct *work)
 	switch (msg->cmd) {
 	case MBOX_CMD_SAVE_DFE_CTLE_CTX:
 		resp.data = msg->data;
-		if (usb3_phy_save_context(padctl, msg->data) < 0)
+		if (tegra_xusb_usb3_phy_save_context(padctl, msg->data) < 0)
 			resp.cmd = MBOX_CMD_NAK;
 		else
 			resp.cmd = MBOX_CMD_ACK;
@@ -2027,34 +1965,189 @@ static int tegra_xusb_read_fuse_calibration(struct tegra_xusb_padctl *padctl)
 	return 0;
 }
 
+static int tegra_xusb_padctl_find_pin_by_name(struct tegra_xusb_padctl *padctl,
+					      const char *name)
+{
+	unsigned int i;
+
+	for (i = 0; i < padctl->soc->num_pins; i++) {
+		const struct pinctrl_pin_desc *pin = &padctl->soc->pins[i];
+
+		if (strcmp(pin->name, name) == 0)
+			return pin->number;
+	}
+
+	return -ENODEV;
+}
+
+static struct device_node *
+tegra_xusb_padctl_find_phy_node(struct tegra_xusb_padctl *padctl,
+				const char *type, unsigned int index)
+{
+	struct device_node *np;
+
+	np = of_find_node_by_name(padctl->dev->of_node, "phys");
+	if (np) {
+		struct device_node *of_node;
+		char *name;
+
+		name = kasprintf(GFP_KERNEL, "%s-%u", type, index);
+		of_node = of_find_node_by_name(np, name);
+		kfree(name);
+
+		of_node_put(np);
+		np = of_node;
+	}
+
+	return np;
+}
+
+static int tegra_xusb_usb3_phy_parse_dt(struct phy *phy)
+{
+	struct tegra_xusb_usb3_phy *usb = phy_get_drvdata(phy);
+	struct device_node *np = phy->dev.of_node;
+	const char *lane = NULL;
+	u32 value;
+	int err;
+
+	if (!np)
+		return 0;
+
+	/* only a single lane can be mapped to each USB3 port */
+	err = of_property_count_strings(np, "nvidia,lanes");
+	if (err < 0 && err != -EINVAL) {
+		dev_err(&phy->dev, "failed to get number of lanes: %d\n", err);
+		return err;
+	}
+
+	if (err > 1)
+		dev_warn(&phy->dev, "found %d lanes, expected 1\n", err);
+
+	err = of_property_read_string(np, "nvidia,lanes", &lane);
+	if (err < 0) {
+		dev_err(&phy->dev, "failed to read lanes: %d\n", err);
+		return err;
+	}
+
+	if (lane) {
+		err = tegra_xusb_padctl_find_pin_by_name(usb->padctl, lane);
+		if (err < 0) {
+			dev_err(&phy->dev, "unknown pin: %s\n", lane);
+			return err;
+		}
+
+		if (!lane_is_pcie_or_sata(err)) {
+			dev_err(&phy->dev,
+				"USB3 PHY %u mapped to invalid lane %s\n",
+				usb->index, lane);
+			return -EINVAL;
+		}
+
+		usb->lane = err;
+	}
+
+	err = of_property_read_u32_index(np, "nvidia,port", 0, &value);
+	if (err < 0) {
+		dev_err(&phy->dev, "failed to read port: %d\n", err);
+		return err;
+	}
+
+	usb->port = value;
+
+	return 0;
+}
+
+static struct phy *tegra_xusb_usb3_phy_create(struct tegra_xusb_padctl *padctl,
+					      unsigned int index)
+{
+	struct tegra_xusb_usb3_phy *usb;
+	struct device_node *np;
+	struct phy *phy;
+	int err;
+
+	/*
+	 * If there is no supplemental configuration in the device tree the
+	 * PHY is unusable. But it is valid to configure only a single PHY,
+	 * hence return NULL instead of an error to mark the PHY as not in
+	 * use. Similarly if the PHY is marked as disabled, don't register
+	 * it.
+	 */
+	np = tegra_xusb_padctl_find_phy_node(padctl, "usb3", index);
+	if (!np || !of_device_is_available(np))
+		return NULL;
+
+	phy = devm_phy_create(padctl->dev, np, &usb3_phy_ops);
+	if (IS_ERR(phy))
+		return phy;
+
+	usb = devm_kzalloc(&phy->dev, sizeof(*usb), GFP_KERNEL);
+	if (!usb)
+		return ERR_PTR(-ENOMEM);
+
+	phy_set_drvdata(phy, usb);
+	usb->padctl = padctl;
+	usb->index = index;
+
+	err = tegra_xusb_usb3_phy_parse_dt(phy);
+	if (err < 0)
+		return ERR_PTR(err);
+
+	return phy;
+}
+
+static struct phy *tegra_xusb_utmi_phy_create(struct tegra_xusb_padctl *padctl,
+					      unsigned int index)
+{
+	struct tegra_xusb_utmi_phy *utmi;
+	struct device_node *np;
+	struct phy *phy;
+
+	/*
+	 * UTMI PHYs don't require additional properties, but if the PHY is
+	 * marked as disabled there is no reason to register it.
+	 */
+	np = tegra_xusb_padctl_find_phy_node(padctl, "utmi", index);
+	if (np && !of_device_is_available(np))
+		return NULL;
+
+	phy = devm_phy_create(padctl->dev, np, &utmi_phy_ops);
+	if (IS_ERR(phy))
+		return ERR_CAST(phy);
+
+	utmi = devm_kzalloc(&phy->dev, sizeof(*utmi), GFP_KERNEL);
+	if (!utmi)
+		return ERR_PTR(-ENOMEM);
+
+	phy_set_drvdata(phy, utmi);
+	utmi->padctl = padctl;
+	utmi->index = index;
+
+	utmi->supply = devm_regulator_get(&phy->dev, "vbus");
+	if (IS_ERR(utmi->supply))
+		return ERR_CAST(utmi->supply);
+
+	return phy;
+}
+
 static int tegra_xusb_setup_usb(struct tegra_xusb_padctl *padctl)
 {
 	struct phy *phy;
 	unsigned int i;
 
 	for (i = 0; i < TEGRA_XUSB_USB3_PHYS; i++) {
-		phy = devm_phy_create(padctl->dev, NULL, &usb3_phy_ops);
+		phy = tegra_xusb_usb3_phy_create(padctl, i);
 		if (IS_ERR(phy))
 			return PTR_ERR(phy);
 
 		padctl->phys[TEGRA_XUSB_PADCTL_USB3_P0 + i] = phy;
-		phy_set_drvdata(phy, padctl);
 	}
 
 	for (i = 0; i < TEGRA_XUSB_UTMI_PHYS; i++) {
-		char reg_name[sizeof("vbus-N")];
-
-		sprintf(reg_name, "vbus-%d", i);
-		padctl->vbus[i] = devm_regulator_get(padctl->dev, reg_name);
-		if (IS_ERR(padctl->vbus[i]))
-			return PTR_ERR(padctl->vbus[i]);
-
-		phy = devm_phy_create(padctl->dev, NULL, &utmi_phy_ops);
+		phy = tegra_xusb_utmi_phy_create(padctl, i);
 		if (IS_ERR(phy))
 			return PTR_ERR(phy);
 
 		padctl->phys[TEGRA_XUSB_PADCTL_UTMI_P0 + i] = phy;
-		phy_set_drvdata(phy, padctl);
 	}
 
 	padctl->vddio_hsic = devm_regulator_get(padctl->dev, "vddio-hsic");
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150225/4c002073/attachment-0001.sig>
