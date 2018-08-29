From: aisheng.dong@nxp.com (A.s. Dong)
Date: Wed, 29 Aug 2018 13:15:50 +0000
Subject: [PATCH V4 4/4] video: simplefb: switch to use clk_bulk API to
 simplify clock operations
In-Reply-To: <66eb6870-3674-0fdb-f5fb-4915a76191f6@redhat.com>
References: <1535547100-25634-1-git-send-email-aisheng.dong@nxp.com>
 <1535547100-25634-5-git-send-email-aisheng.dong@nxp.com>
 <66eb6870-3674-0fdb-f5fb-4915a76191f6@redhat.com>
Message-ID: <AM0PR04MB4211E934272EE1A212711FAE80090@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Hans de Goede [mailto:hdegoede at redhat.com]
> Sent: Wednesday, August 29, 2018 9:01 PM

[...]

> > @@ -252,39 +228,21 @@ static int simplefb_clocks_get(struct simplefb_par
> *par,
> >   static void simplefb_clocks_enable(struct simplefb_par *par,
> >   				   struct platform_device *pdev)
> >   {
> > -	int i, ret;
> > +	int ret;
> > +
> > +	ret = clk_bulk_prepare_enable(par->clk_count, par->clks);
> > +	if (ret)
> > +		dev_warn(&pdev->dev, "failed to enable clocks\n");
> 
> If clk_bulk_prepare_enable() fails, it leaves all clocks disabled, so you should
> not set par->clks_enabled = true; then.
> 

Thanks for spotting this.
The original code wanted to keep the behavior as before.
But a bit more thinking that unlike the exist code, clk_bulk_prepare_enable will
automatically do reverse clean up once it fails.
So no need to set par->clks_enabled = true anymore.

Will fix it and resend.

Regards
Dong Aisheng

> Otherwise this patch looks good.
> 
> Regards,
> 
> Hans
