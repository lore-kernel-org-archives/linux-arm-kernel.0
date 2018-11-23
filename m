From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Fri, 23 Nov 2018 09:30:38 +0100
Subject: [PATCH 2/6] phy: add A3700 COMPHY support
In-Reply-To: <20181122210420.14861-3-miquel.raynal@bootlin.com>
References: <20181122210420.14861-1-miquel.raynal@bootlin.com>
 <20181122210420.14861-3-miquel.raynal@bootlin.com>
Message-ID: <20181123093038.20278133@xps13>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

+ Adding people concerned by this driver that I forgot when initially
  sending the driver, will update the Cc: list if there is a v2.

One question below.

Miquel Raynal <miquel.raynal@bootlin.com> wrote on Thu, 22 Nov 2018
22:04:16 +0100:

> Add a driver to support COMPHY, a hardware block providing shared
> serdes PHYs on Marvell Armada 3700. This driver uses SMC calls and
> rely on having an up-to-date firmware.
> 
> SATA, PCie and USB3 host mode have been tested successfully with an
> ESPRESSObin. SGMII mode cannot be tested with this platform.
> 
> Co-Developed-by: Evan Wang <xswang@marvell.com>
> Signed-off-by: Evan Wang <xswang@marvell.com>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/phy/marvell/Kconfig                  |  10 +
>  drivers/phy/marvell/Makefile                 |   1 +
>  drivers/phy/marvell/phy-mvebu-a3700-comphy.c | 276 +++++++++++++++++++
>  3 files changed, 287 insertions(+)
>  create mode 100644 drivers/phy/marvell/phy-mvebu-a3700-comphy.c

[...]

> +
> +static int mvebu_a3700_comphy_power_on(struct phy *phy)
> +{
> +	struct mvebu_a3700_comphy_lane *lane = phy_get_drvdata(phy);
> +	u32 fw_param;
> +	int fw_mode;
> +
> +	fw_mode = mvebu_a3700_comphy_get_fw_mode(lane->id, lane->port,
> +						 lane->mode);
> +	if (fw_mode < 0) {
> +		dev_err(lane->dev, "invalid COMPHY mode\n");
> +		return fw_mode;
> +	}
> +
> +	switch (lane->mode) {
> +	case PHY_MODE_USB_HOST_SS:
> +		dev_dbg(lane->dev, "set lane %d to USB3 host mode\n", lane->id);
> +		fw_param = COMPHY_FW_MODE(fw_mode);
> +		break;
> +	case PHY_MODE_SATA:
> +		dev_dbg(lane->dev, "set lane %d to SATA mode\n", lane->id);
> +		fw_param = COMPHY_FW_MODE(fw_mode);
> +		break;
> +	case PHY_MODE_SGMII:
> +		dev_dbg(lane->dev, "set lane %d to SGMII mode\n", lane->id);
> +		fw_param = COMPHY_FW_NET(fw_mode, lane->port,
> +					 COMPHY_FW_SPEED_1_25G);
> +		break;
> +	case PHY_MODE_PCIE:
> +		dev_dbg(lane->dev, "set lane %d to PCIe mode\n", lane->id);
> +		fw_param = COMPHY_FW_PCIE(fw_mode, lane->port,
> +					  COMPHY_FW_SPEED_5G,
> +					  phy->attrs.bus_width);
> +		break;
> +	default:
> +		dev_err(lane->dev, "unsupported PHY mode (%d)\n", lane->mode);
> +		return -ENOTSUPP;
> +	}
> +
> +	return mvebu_a3700_comphy_smc(COMPHY_SIP_POWER_ON, lane->id, fw_param);

This call might fail because the firmware is not up-to-date. In this
case, I wonder what is the appropriate behavior. Here I just return the
error; this means drivers may fail to probe when enabling their PHY.

Shall I ignore a "not supported by the firmware" code and return 0 to
the caller (with a printed warning) so it will continue probing? Doing
so is lying as the PHY might not be configured as expected and S2RAM
will always fail in this case. 

Thanks,
Miqu?l
