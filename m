From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 5 Aug 2013 11:53:22 +0200
Subject: [PATCH v3 2/2] i2c: imx: Add Vybrid VF610 I2C controller support
In-Reply-To: <B56CDBE15CE27145A4B77D2D24263E851FC075@039-SN1MPN1-004.039d.mgd.msft.net>
References: <1375418648-22760-1-git-send-email-b35083@freescale.com>
 <1375418648-22760-2-git-send-email-b35083@freescale.com>
 <20130805083050.GN26614@pengutronix.de>
 <B56CDBE15CE27145A4B77D2D24263E851FC075@039-SN1MPN1-004.039d.mgd.msft.net>
Message-ID: <20130805095322.GP26614@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 05, 2013 at 09:32:11AM +0000, Lu Jingchang-B35083 wrote:
> > Subject: Re: [PATCH v3 2/2] i2c: imx: Add Vybrid VF610 I2C controller
> > > +struct imx_i2c_clk_pair {
> > > +	u16	div;
> > > +	u16	regval;
> > > +}i;
> > 
> > Converting this to a struct should be a separate patch. This is an
> > obvious cleanup which makes maintainers happy and more willing to take
> > the features you are adding later.
> > 
> [Lu Jingchang-B35083] 
> Do you mean all changes to i.MX common should be a separate patch including the clk div pair, and 
> the struct imx_i2c_hwdata, struct imx_i2c_drvdata and other things changed to be easier to
> use adding other SoCs support later. Thanks.

I mean that each patch should only contain a single logical change.

Converting the two dimensional array into an array of struct is such a
logical change and thus should be a separate patch.

The smaller a patch is the easier it is for people to review it.

> > >
> > > +#define IMX_I2C_IADR	(0x00 << i2c_imx->i2c_hwdata->regshift)
> > > +#define IMX_I2C_IFDR	(0x01 << i2c_imx->i2c_hwdata->regshift)
> > > +#define IMX_I2C_I2CR	(0x02 << i2c_imx->i2c_hwdata->regshift)
> > > +#define IMX_I2C_I2SR	(0x03 << i2c_imx->i2c_hwdata->regshift)
> > > +#define IMX_I2C_I2DR	(0x04 << i2c_imx->i2c_hwdata->regshift)
> > 
> > Macros should not assume there is a i2c_imx variable present in a
> > function. Instead, add static inline accessor functions.
> [Lu Jingchang-B35083] 
> Ok, I will add inline functions instead. Thanks.
> > 
> > 
> > > +	[VF610_I2C] = {
> > > +		.devtype = VF610_I2C,
> > > +		.hwdata = &vf610_i2c_hwdata
> > > +	},
> > >  };
> > 
> > Why add this array?
> > You should reference imx_i2c_hwdata/vf610_i2c_hwdata directly here.
> [Lu Jingchang-B35083] 
> The "is_imx1_i2c()"function need the devtype variable the test the arch, so the devtype is out of the
> imx_i2c_hwdata struct to let all other i.MX i2c device can sharing the same imx_i2c_hwdata setting. Thanks.

Then add the devtype variable to struct imx_i2c_hwdata and split
imx_i2c_hwdata into imx1_i2c_hwdata and imx21_i2c_hwdata.

> > 
> > >
> > >  	if (of_id)
> > >  		pdev->id_entry = of_id->data;
> > 
> > This is wrong in the original driver code. This field should be changed
> > in a driver.
> [Lu Jingchang-B35083] 
> Could you please give some more comments on this? Thanks.

It's not the drivers business of changing pdev->id_entry. This should
only be modified by the driver core.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
