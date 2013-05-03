From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 3 May 2013 16:35:36 +0800
Subject: [PATCH 2/2] pinctrl/imx: add zero register offset valid for
 Vybrid platform
In-Reply-To: <20130502182759.GQ32299@pengutronix.de>
References: <1367480932-22318-1-git-send-email-b35083@freescale.com>
 <1367480932-22318-2-git-send-email-b35083@freescale.com>
 <20130502182759.GQ32299@pengutronix.de>
Message-ID: <20130503083534.GC31873@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 02, 2013 at 08:27:59PM +0200, Sascha Hauer wrote:
> > @@ -221,10 +221,14 @@ static int imx_pmx_enable(struct pinctrl_dev *pctldev, unsigned selector,
> >  		pin_id = pins[i];
> >  		pin_reg = &info->pin_regs[pin_id];
> >  
> > -		if (!pin_reg->mux_reg) {
> > -			dev_err(ipctl->dev, "Pin(%s) does not support mux function\n",
> > -				info->pins[pin_id].name);
> > -			return -EINVAL;
> > +		/* mux_reg offset maybe zero on some platform such as Vybrid */
> > +		if (!of_machine_is_compatible("fsl,mvf600")) {
> > +			if (!pin_reg->mux_reg) {
> 
> Please add a zero_offset_valid flag to the drivers private structure
> instead of using a rather expensive function in a frequently used path.
> Also the && operator can be used to test for two conditions being true.

Agreed.  I would suggest that we add a flag member into struct
imx_pinctrl_soc_info telling the mvf case, and handle the following mvf
specialties by checking the flag.

* FSL_PIN_SIZE is 20 on mvf, as PIN_FUNC_ID consists of 4 u32 there.
* Assign mux_reg to conf_reg in imx_pinctrl_parse_groups() for mvf case.
* In imx_pmx_enable(), write mux_reg[22:20] bit field rather than the
  whole register for mvf case.
* In imx_pinconf_set(), write conf_reg[15:0] bit field rather than the
  whole register for mvf case.

Doing above will ease the defining of the pin function ID in
mvf600-pinfunc.h.

Shawn
