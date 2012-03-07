From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 7 Mar 2012 11:17:55 -0300
Subject: I.MX35 PDK
In-Reply-To: <4875438356E7CA4A8F2145FCD3E61C0B2CBD5D890F@MEP-EXCH.meprolight.com>
References: <4875438356E7CA4A8F2145FCD3E61C0B2CBD666A26@MEP-EXCH.meprolight.com>
 <4F562C90.6090103@freescale.com>
 <CAOMZO5CyGazr1=kLF51W7S7ZpEy2Mg4k2n_ZHnGimSyu2oVcrA@mail.gmail.com>
 <4875438356E7CA4A8F2145FCD3E61C0B2CBD5D890F@MEP-EXCH.meprolight.com>
Message-ID: <CAOMZO5DnP7+zupy9vwBPS0+2XtKM1+nLbwCqBzuCqEG5OWbZRQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/7/12, Alex Gershgorin <alexg@meprolight.com> wrote:

> in spite of this I get from ov2640 driver error
> Here Linux Kernel boot message:
>
> "Linux video capture interface: v2.00
> soc-camera-pdrv soc-camera-pdrv.0: Probing soc-camera-pdrv.0
> mx3-camera mx3-camera.0: MX3 Camera driver attached to camera 0
> ov2640 0-0030: Product ID error fb:fb"
>
> I cannot understand what the problem is, if someone tested this?

Looks like a I2C issue.

Check the I2C1 pad settings in the mainline kernel.

On FSL kernel we have:

#define PAD_CONFIG (PAD_CTL_HYS_SCHMITZ | PAD_CTL_PKE_ENABLE |
PAD_CTL_PUE_PUD | PAD_CTL_ODE_OpenDrain)

	switch (i2c_num) {
	case 0:
		mxc_request_iomux(MX35_PIN_I2C1_CLK, MUX_CONFIG_SION);
		mxc_request_iomux(MX35_PIN_I2C1_DAT, MUX_CONFIG_SION);

		mxc_iomux_set_pad(MX35_PIN_I2C1_CLK, PAD_CONFIG);
		mxc_iomux_set_pad(MX35_PIN_I2C1_DAT, PAD_CONFIG);

Also check if you are getting the proper voltage levels at the I2C1 lines.

Good luck!
