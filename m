From: aalonso@freescale.com (Alonso Adrian)
Date: Wed, 15 Jul 2015 15:55:59 +0000
Subject: [PATCH][v3] ARM: imx: pinctrl-imx: imx7d: add support for iomuxc
 lpsr
In-Reply-To: <20150715072307.GM4119@tiger>
References: <1436295725-19011-1-git-send-email-aalonso@freescale.com>
 <20150715072307.GM4119@tiger>
Message-ID: <BN3PR03MB1509DFB6A1513A23C48476CFA89A0@BN3PR03MB1509.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

Comments inline, thanks for reviewing :)

Regards
Adrian

-----Original Message-----
From: Shawn Guo [mailto:shawnguo at kernel.org] 
Sent: Wednesday, July 15, 2015 2:23 AM
To: Alonso Lazcano Adrian-B38018
Cc: linux-arm-kernel at lists.infradead.org; shawn.guo at linaro.org; linus.walleij at linaro.org; lznuaa at gmail.com; devicetree at vger.kernel.org; Li Frank-B20596; Garg Nitin-B37173; Huang Yongcai-B20788; linux-gpio at vger.kernel.org; robh+dt at kernel.org; Gong Yibin-B38343
Subject: Re: [PATCH][v3] ARM: imx: pinctrl-imx: imx7d: add support for iomuxc lpsr

On Tue, Jul 07, 2015 at 02:02:05PM -0500, Adrian Alonso wrote:
> * Extend pinctrl-imx driver to support iomux lpsr conntroller,
> * iMX7D has two iomuxc controllers, iomuxc controller similar as
>   previous iMX SoC generation and iomuxc-lpsr which provides
>   low power state rentetion capabilities on gpios that are part of
>   iomuxc-lpsr (GPIO1_IO7..GPIO1_IO0).
> * Use IOMUXC_LPSR_SUPPORT and iput_val most significant bits to
>   properly configure iomuxc/iomuxc-lpsr settings.
> 
> Signed-off-by: Adrian Alonso <aalonso@freescale.com>

It took me quite some time to understand what the patch does.  Before I gave specific comments on your implementation, I would discuss if there is a better solution, as I do not like the idea of encoding these artificial pin id of LPSR pads in the input_val.

Ideally, the LPSR controller should be implemented as a second instance of IOMUXC.  But the problem seems to be the select input register is shared between these two instances.  Is my understanding correct?

[Adrian] Yes that's the case SELECT_INPUT register is shared between IOMUXC and IOMUXC-LPSR controllers.

How select input register is shared?  With different bits in a single register which is only laid on normal IOMUXC controller?

[Adrian] IOMUXC and IOMUXC-LPSR are in different base address; each controller provides SW_PAD_CTL  (CONF_REG) and SW_MUX_CTL (MUX_REG) but only IOMUXC provides SELECT_INPUT registers for pad daisy chain configuration, so pads from IOMUXC-LPSR that need daisy chain settings need to access the IOMUXC register space address to access SELECT_INPUT.

[Adrian] One disadvantage that we found if we created two driver instances for IOMUXC and IOMUXC-LPSR controllers is that in the device tree machine files "end-users" could be creating pinctrl nodes mixing pads from different IOMUXC controllers resulting that pad that doesn't belong to that domain controller it will not be configured properly.

For example a valid pad configuration for I2C1 could use pads as shown below: 
&iomuxc {
	pinctrl_i2c1_1: i2c1grp-1 {
		fsl,pins = <
			MX7D_PAD_GPIO1_IO04__I2C1_SCL  	/* IOMUXC-LPSR domain */
			MX7D_PAD_I2C1_SDA__I2C1_SDA   	/* IOMUXC domain */
		>;
	};
};

By extending pinctrl-imx to support both controllers the above configuration is supported,
Otherwise using two driver instances "end-users" will need to do something like:

&iomuxc {
	pinctrl_i2c1_1: i2c1grp-1 {
		fsl,pins = <
			MX7D_PAD_I2C1_SDA__I2C1_SDA   	/* IOMUXC domain */
		>;
	};
};

&iomuxc_lpsr {
	pinctrl_i2c1_1: i2c1grp-1 {
		fsl,pins = <
			MX7D_PAD_GPIO1_IO04__I2C1_SCL  	/* IOMUXC-LPSR domain */
		>;
	};
};

And this is something that we will like to avoid so "end-user" don't have to worry about and configure pads as they are used to.

[Adrian] For the artificial encoding of pad group id's for IOMUXC-LPSR, I think there is no other way to do it (limited imagination here :P);
Pad group id's are extracted from MUX_REG offset address (pad_id = mux_reg / 4) but when combining both IOMUXC and IOMUXC-LPSR
Pad group ID's overlap so end up encoding the pad_id for IOMUXC-LPSR to resolve the proper pad group ID.

I need more details to understand the problem.

Shawn
