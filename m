From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 24 Apr 2012 07:12:28 +0800
Subject: [PATCH 1/2] pinctrl: add pinctrl-mxs support
In-Reply-To: <4F95A3BB.3000004@wwwdotorg.org>
References: <1334823125-24159-1-git-send-email-shawn.guo@linaro.org>
 <4F91969C.2010201@wwwdotorg.org>
 <20120421015052.GA6808@S2101-09.ap.freescale.net>
 <4F95A3BB.3000004@wwwdotorg.org>
Message-ID: <20120423231227.GW26306@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 23, 2012 at 12:47:23PM -0600, Stephen Warren wrote:
> Don't the pin numbers from DT get converted into the "real" pin numbers
> in the pinctrl mapping tables though (i.e. the "mux" field stripped
> out)?

This is the case.

> If so, then it seems that people have to be aware of the
> separation between pin number and mux setting anyway, so it may as well
> be represented directly in DT.

People have no interests to know that.  They are only interesting in
knowing what pinmux-id value they should put in the device tree if
they want pin "MX28_PAD_GPMI_D00" functional in mux selection "GPMI_D0".
They do not even care about the pin number and mux value, not mention
the separation between these two.

> > This is basically what Dong's imx patch does.  It ends up with something
> > like "fsl,mux = <0 0 1 1 1 1 1 1 1 1>;" for a group of pins specified
> > in "fsl,pins".  Sascha does not like it, because it makes the pinctrl
> > migration hard, and every time we touch "fsl,mux", we need to look at
> > hardware manual to find the meaning of these mux numbers.
> 
> Well, it's even worse if the pin numbers include both pin numbers and
> mux selection. You have to do all the exact same lookups in the manual,
> except that first you have to remember which bits of the pin ID really
> mean mux function and not pin ID.

Eh, I do not follow that.

That long list of valid pinmux-id is generated from the database with
a script.

MX28_PAD_GPMI_D00__GPMI_D0                      0x0000
MX28_PAD_GPMI_D01__GPMI_D1                      0x0010
MX28_PAD_GPMI_D02__GPMI_D2                      0x0020
MX28_PAD_GPMI_D03__GPMI_D3                      0x0030
MX28_PAD_GPMI_D04__GPMI_D4                      0x0040
MX28_PAD_GPMI_D05__GPMI_D5                      0x0050
MX28_PAD_GPMI_D06__GPMI_D6                      0x0060
MX28_PAD_GPMI_D07__GPMI_D7                      0x0070

If people want pin MX28_PAD_GPMI_D00 functional in GPMI_D0 mode, all
he needs to do if search "MX28_PAD_GPMI_D00__GPMI_D0" in the list and
then put value "0x0000" in the device tree.  Why do they need to look
up the manual?

-- 
Regards,
Shawn
