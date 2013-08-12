From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 12 Aug 2013 17:43:54 +0100
Subject: =?utf-8?B?562U5aSNOiBbUEFUQw==?=
 =?utf-8?Q?H?= v3 2/2] i2c: imx: Add Vybrid VF610 I2C controller
 support
In-Reply-To: <B56CDBE15CE27145A4B77D2D24263E851FE7AC@039-SN1MPN1-004.039d.mgd.msft.net>
References: <1375418648-22760-1-git-send-email-b35083@freescale.com>
 <1375418648-22760-2-git-send-email-b35083@freescale.com>
 <20130810140827.GC18085@e106331-lin.cambridge.arm.com>
 <B56CDBE15CE27145A4B77D2D24263E851FE7AC@039-SN1MPN1-004.039d.mgd.msft.net>
Message-ID: <20130812164354.GF27165@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Adding other devicetree maintainers to Cc]

On Mon, Aug 12, 2013 at 01:56:07PM +0100, Lu Jingchang-B35083 wrote:
> 
> ________________________________________
> >???: Mark Rutland [mark.rutland at arm.com]
> >????: 2013?8?10? 22:08
> >???: Lu Jingchang-B35083
> >??: wsa at the-dreams.de; Estevam Fabio-R49496; Li Xiaochun-B41219; s.hauer at pengutronix.de; linux-i2c at vger.kernel.org; Jin Zhengxiong-R64188; shawn.guo at linaro.org; linux-arm-kernel at lists.infradead.org
> >??: Re: [PATCH v3 2/2] i2c: imx: Add Vybrid VF610 I2C controller support
> 
> >On Fri, Aug 02, 2013 at 05:44:08AM +0100, Jingchang Lu wrote:
> >>   Add Freescale Vybrid VF610 I2C controller support to
> >> imx I2C driver framework.
> >>   Some operation is different from imx I2C controller.
> >> The register offset, the i2c clock divider value table,
> >> the module enabling(I2CR_IEN) which is just invert with imx,
> >> and the interrupt flag(I2SR) clearing opcode is w1c on VF610
> >> but w0c on imx.
> >>
> >> Signed-off-by: Jason Jin <Jason.jin@freescale.com>
> >> Signed-off-by: Xiaochun Li <b41219@freescale.com>
> >> Signed-off-by: Jingchang Lu <b35083@freescale.com>
> >> ---
> >> changes in v3:
> >>   Using struct naming the i2c clock {div, regval} pair.
> >>  Using address shift handling registers address difference.
> >>
> >> changes in v2:
> >>   Fix building section mismatch(es) warning.
> >>
> >>  drivers/i2c/busses/i2c-imx.c | 146 ++++++++++++++++++++++++++++++++++++-------
> >>  1 file changed, 122 insertions(+), 24 deletions(-)
> 
> >[...]
> 
> >> @@ -145,6 +233,7 @@ MODULE_DEVICE_TABLE(platform, imx_i2c_devtype);
> >>  static const struct of_device_id i2c_imx_dt_ids[] = {
> >>         { .compatible = "fsl,imx1-i2c", .data = &imx_i2c_devtype[IMX1_I2C], },
> >>         { .compatible = "fsl,imx21-i2c", .data = &imx_i2c_devtype[IMX21_I2C], },
> >> +       { .compatible = "fsl,vf610-i2c", .data = &imx_i2c_devtype[VF610_I2C], },
> >>         { /* sentinel */ }
> >>  };
> 
> 
> >That string doesn't seem to be documented anywhere (from a quick grep of
> >Documentation/devicetree), and there's no binding update included
> >here. It would be nice for that to be fixed :)
> [Lu Jingchang]
> The binding string for i2c-imx driver in Documentation/devicetree/bindings/i2c/i2c-imx.txt use a wildcard format
> of "- compatible : Should be "fsl,<chip>-i2c" " for device using this driver. Neither fsl,imx1-i2c nor fsl,imx21-i2c
> is described in the binding document. So I just leave the vf610 i2c compatible with this. 

I'm not a big fan on wildcards in bindings, as it leaves people free to
put anything in and claim it's a documented binding, and makes it far
harder for an os to actually implement drivers for said binding, as
there's no canonical reference for the set of valid variations.

Obviously there is some precedent, but I'm not sure it's something we
want to stick with, and we can prevent it my updating the documentation
now.

Does anyone else have an opinion?

Mark.
