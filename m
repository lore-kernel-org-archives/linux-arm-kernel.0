From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 7 Apr 2013 10:53:33 -0300
Subject: [PATCH v2 0/3] Get rid of big array from imx pinctrl driver
In-Reply-To: <20130407071028.GD11898@S2101-09.ap.freescale.net>
References: <1361533888-18073-1-git-send-email-shawn.guo@linaro.org>
 <CAOMZO5D1+baoM0vMdPW9bAd4DX8C82BF9H87igFNo78+8D_N3Q@mail.gmail.com>
 <20130407071028.GD11898@S2101-09.ap.freescale.net>
Message-ID: <CAOMZO5Bxfj9ZGrVOcNirsVHFLWaHWBdkFpKSiVQ9iS4paT0Y6g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 7, 2013 at 4:10 AM, Shawn Guo <shawn.guo@linaro.org> wrote:

> Thanks for spotting it, Fabio.
>
> There is indeed a bug with the patch.  The select input register should
> not be defined in imx_pin_reg, because the same pad may have multiple
> select input registers for different mux setting values.  So it should
> be something defined with pin group.  The following code change should
> fix the problem.
>
> I just rebuilt imx/dt branch with the problem fixed and also had the
> branch based on Stephen Warren's for-3.10/dtc-cpp-chroot-std-headers
> branch so avoid all those dts files renaming.

With this change the audmux input registers are set and I can get
audio functional again.

I still see a different issue though:

In 3.6-rc5 we get:

imx6q-pinctrl 20e0000.iomuxc: maps: function i2c1 group i2c1grp-1 num 3
imx6q-pinctrl 20e0000.iomuxc: enable function i2c1 group i2c1grp-1
imx6q-pinctrl 20e0000.iomuxc: write: offset 0xa4 val 0x16
imx6q-pinctrl 20e0000.iomuxc: ==>select_input: offset 0x898 val 0x0
imx6q-pinctrl 20e0000.iomuxc: write: offset 0xc4 val 0x11
imx6q-pinctrl 20e0000.iomuxc: ==>select_input: offset 0x89c val 0x0
imx6q-pinctrl 20e0000.iomuxc: pinconf set pin MX6Q_PAD_EIM_D21
imx6q-pinctrl 20e0000.iomuxc: write: offset 0x3b8 val 0x1b8b1
imx6q-pinctrl 20e0000.iomuxc: pinconf set pin MX6Q_PAD_EIM_D28
imx6q-pinctrl 20e0000.iomuxc: write: offset 0x3d8 val 0x1b8b1

,but we get the following on your branch:

imx6q-pinctrl 20e0000.iomuxc: maps: function i2c1 group i2c1grp-1 num 3
imx6q-pinctrl 20e0000.iomuxc: enable function i2c1 group i2c1grp-1
imx6q-pinctrl 20e0000.iomuxc: write: offset 0xa4 val 0x16
imx6q-pinctrl 20e0000.iomuxc: ==>select_input: offset 0x898 val 0x0
imx6q-pinctrl 20e0000.iomuxc: write: offset 0xc4 val 0x11
imx6q-pinctrl 20e0000.iomuxc: ==>select_input: offset 0x89c val 0x0
imx6q-pinctrl 20e0000.iomuxc: pinconf set pin MX6Q_PAD_EIM_A17
imx6q-pinctrl 20e0000.iomuxc: write: offset 0x3b8 val 0x1b8b1
imx6q-pinctrl 20e0000.iomuxc: pinconf set pin MX6Q_PAD_EIM_EB1
imx6q-pinctrl 20e0000.iomuxc: write: offset 0x3d8 val 0x1b8b1

The pin name passed in the 'pinconf set pin' line is wrong.

On 3.6-rc5 MX6Q_PAD_EIM_D21 is number 22 and MX6Q_PAD_EIM_A17 is 41.

On your branch: MX6Q_PAD_EIM_D21 is 41 and MX6Q_PAD_EIM_A17 is 60

So this offset of 19 is causing troubles and I can see that you added
this offset  in the enum:

enum imx6q_pads {
	MX6Q_PAD_SD2_DAT1 = 19,
	MX6Q_PAD_SD2_DAT2 = 20,
	MX6Q_PAD_SD2_DAT0 = 21,
	MX6Q_PAD_RGMII_TXC = 22,
	MX6Q_PAD_RGMII_TD0 = 23,
	MX6Q_PAD_RGMII_TD1 = 24,
	MX6Q_PAD_RGMII_TD2 = 25,
