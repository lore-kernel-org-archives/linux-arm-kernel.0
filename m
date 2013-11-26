From: Peter.Chen@freescale.com (Peter Chen)
Date: Tue, 26 Nov 2013 12:08:03 +0000
Subject: [PATCH 2/4 V2] ARM: mx28: Add USB PHY overcurrent pinmux
In-Reply-To: <20131125134248.GA28906@pengutronix.de>
References: <1345852300-2213-1-git-send-email-marex@denx.de>
 <1345852300-2213-2-git-send-email-marex@denx.de>
 <20131122154947.GE24508@pengutronix.de> <201311250058.32881.marex@denx.de>
 <20131125134248.GA28906@pengutronix.de>
Message-ID: <F281D0F91ED19E4D8E63A7504E8A64980411F14C@039-SN2MPN1-021.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



 
> 
> The GPIO is working for this pin. But also the DIGCTL register bits
> helped here.  Now the OC event triggers if the pin gets pulled to 3V3.
> 
> I am currently looking for a good place to enable the DIGCTL bits.
> I suggest to enable them per default.  As we don't have USBMISC registers
> in MX28, the bits should be toggled in ci_hdrc_imx.c if the of property
> "disable-overcurrent" is not found.  I will use the syscon interface to
> reach them with the regmap interface.
> 

Hi Michael,

usbmisc register doesn't stand for the register needs to be in usb controller.
Any registers which are related to USB function can be considered as usbmisc
registers. You will see FSL-style SoC, the over-current or other related setting
are at controller base + 0x800 (0x600), but Sigmatel-style SoC (mx28/mx23), the usb
register are not at controller register region.

My suggestion is: create usbmisc node for mx28, and put oc setting at there, it can
keep ci_hdrc_imx.c clean.
Besides, you may need two dts user setting for oc enable and oc polarity.

Peter
