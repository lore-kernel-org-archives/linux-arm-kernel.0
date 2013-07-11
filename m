From: peter.chen@freescale.com (Peter Chen)
Date: Thu, 11 Jul 2013 14:55:38 +0800
Subject: [PATCH v12 02/13] usb: chipidea: imx: remove vbus regulator
 operation
In-Reply-To: <20130711063719.GE14452@pengutronix.de>
References: <1373524041-10482-1-git-send-email-peter.chen@freescale.com>
 <1373524041-10482-3-git-send-email-peter.chen@freescale.com>
 <20130711063719.GE14452@pengutronix.de>
Message-ID: <20130711065537.GA10551@nchen-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 11, 2013 at 08:37:19AM +0200, Sascha Hauer wrote:
> >  
> > -	/* we only support host now, so enable vbus here */
> > -	data->reg_vbus = devm_regulator_get(&pdev->dev, "vbus");
> > -	if (!IS_ERR(data->reg_vbus)) {
> > -		ret = regulator_enable(data->reg_vbus);
> > -		if (ret) {
> > -			dev_err(&pdev->dev,
> > -				"Failed to enable vbus regulator, err=%d\n",
> > -				ret);
> > -			goto err_clk;
> > -		}
> > -	} else {
> > -		data->reg_vbus = NULL;
> > -	}
> > -
> >  	pdata.phy = data->phy;
> >  
> > +	/* Get the vbus regulator */
> > +	pdata.reg_vbus = devm_regulator_get(&pdev->dev, "vbus");
> > +	if (IS_ERR(pdata.reg_vbus))
> > +		pdata.reg_vbus = NULL;
> 
> I think you should bail out at least in the -EPROBE_DEFER case.
> 

Oh, correct. I will add another patch behind this for fix.
In fact, I met this problem at FSL mx6-auto board which uses
gpio-expendor chip max7310 as regulator-gpio for enable vbus
output.

-- 

Best Regards,
Peter Chen
