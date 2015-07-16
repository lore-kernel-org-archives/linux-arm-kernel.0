From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 16 Jul 2015 23:50:34 +0800
Subject: [PATCH][v3] ARM: imx: pinctrl-imx: imx7d: add support for iomuxc
 lpsr
In-Reply-To: <BN3PR03MB1509DFB6A1513A23C48476CFA89A0@BN3PR03MB1509.namprd03.prod.outlook.com>
References: <1436295725-19011-1-git-send-email-aalonso@freescale.com>
 <20150715072307.GM4119@tiger>
 <BN3PR03MB1509DFB6A1513A23C48476CFA89A0@BN3PR03MB1509.namprd03.prod.outlook.com>
Message-ID: <20150716155034.GN4119@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adrian,

Please configure your email client to use bottom-posting rather than
top-posting.

On Wed, Jul 15, 2015 at 03:55:59PM +0000, Alonso Adrian wrote:
> [Adrian] IOMUXC and IOMUXC-LPSR are in different base address; each controller provides SW_PAD_CTL  (CONF_REG) and SW_MUX_CTL (MUX_REG) but only IOMUXC provides SELECT_INPUT registers for pad daisy chain configuration, so pads from IOMUXC-LPSR that need daisy chain settings need to access the IOMUXC register space address to access SELECT_INPUT.
> 

Thanks for the explanation.

> [Adrian] One disadvantage that we found if we created two driver instances for IOMUXC and IOMUXC-LPSR controllers is that in the device tree machine files "end-users" could be creating pinctrl nodes mixing pads from different IOMUXC controllers resulting that pad that doesn't belong to that domain controller it will not be configured properly.
> 
> For example a valid pad configuration for I2C1 could use pads as shown below: 
> &iomuxc {
> 	pinctrl_i2c1_1: i2c1grp-1 {
> 		fsl,pins = <
> 			MX7D_PAD_GPIO1_IO04__I2C1_SCL  	/* IOMUXC-LPSR domain */
> 			MX7D_PAD_I2C1_SDA__I2C1_SDA   	/* IOMUXC domain */
> 		>;
> 	};
> };
> 
> By extending pinctrl-imx to support both controllers the above configuration is supported,
> Otherwise using two driver instances "end-users" will need to do something like:
> 
> &iomuxc {
> 	pinctrl_i2c1_1: i2c1grp-1 {
> 		fsl,pins = <
> 			MX7D_PAD_I2C1_SDA__I2C1_SDA   	/* IOMUXC domain */
> 		>;
> 	};
> };
> 
> &iomuxc_lpsr {
> 	pinctrl_i2c1_1: i2c1grp-1 {
> 		fsl,pins = <
> 			MX7D_PAD_GPIO1_IO04__I2C1_SCL  	/* IOMUXC-LPSR domain */
> 		>;
> 	};
> };
> 
> And this is something that we will like to avoid so "end-user" don't have to worry about and configure pads as they are used to.
> 

This is exactly how hardware is designed, and having device tree
describe how hardware is laid out is the right thing to do.  In that
case, when people check the device tree source with a i.MX7D Reference
Manual on hands, they can easily understand how hardware is represented
in device tree.

Also, your example with pins for a single device across IOMUXC and
IOMUXC-LPSR should be the rare case except GPIO pins.  For your I2C1
example, a sane hardware design would chose one group among the
following instead of the one you put above.

  MX7D_PAD_I2C1_SCL__I2C1_SCL
  MX7D_PAD_I2C1_SDA__I2C1_SDA

  MX7D_PAD_UART1_RX_DATA__I2C1_SCL
  MX7D_PAD_UART1_TX_DATA__I2C1_SDA

  MX7D_PAD_GPIO1_IO04__I2C1_SCL
  MX7D_PAD_GPIO1_IO05__I2C1_SDA

So this is not really a problem for us to implement two IOMUXC instances.
The only problem we need to solve is the select input register access
for IOMUXC-LPSR driver.  I have some idea for that, i.e. honestly
represent how hardware is laid out.  I will give more details on that
tomorrow.

> [Adrian] For the artificial encoding of pad group id's for IOMUXC-LPSR, I think there is no other way to do it (limited imagination here :P);
> Pad group id's are extracted from MUX_REG offset address (pad_id = mux_reg / 4) but when combining both IOMUXC and IOMUXC-LPSR
> Pad group ID's overlap so end up encoding the pad_id for IOMUXC-LPSR to resolve the proper pad group ID.

One big missing piece from your patch is the update to bindings document
Documentation/devicetree/bindings/pinctrl/fsl,imx-pinctrl.txt.  Have you
thought about how you will document all these magics and hacks you have
done here?

Shawn
