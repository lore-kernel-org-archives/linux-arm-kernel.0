From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 16 Feb 2014 21:10:36 +0800
Subject: [PATCH v3] bus: imx-weim: support CS GPR config for imx6q-weim
In-Reply-To: <1392548881.675863030@f320.i.mail.ru>
References: <1392539924-23583-1-git-send-email-shawn.guo@linaro.org>
 <20140216105636.GE2946@S2101-09.ap.freescale.net>
 <1392548881.675863030@f320.i.mail.ru>
Message-ID: <20140216131034.GF2946@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 16, 2014 at 03:08:01PM +0400, Alexander Shiyan wrote:
> ???????????, 16 ??????? 2014, 18:56 +08:00 ?? Shawn Guo <shawn.guo@linaro.org>:
> > On Sun, Feb 16, 2014 at 04:38:44PM +0800, Shawn Guo wrote:
> > > @@ -56,6 +59,55 @@ static const struct of_device_id weim_id_table[] = {
> > >  };
> > >  MODULE_DEVICE_TABLE(of, weim_id_table);
> > >  
> > > +static int __init imx6q_weim_gpr_setup(struct platform_device *pdev)
> > > +{
> > > +	struct device_node *np = pdev->dev.of_node;
> > > +	struct property *prop;
> > > +	const __be32 *p;
> > > +	struct regmap *gpr;
> > > +	u32 gprvals[4] = {
> > > +		05,	/* CS0(128M) CS1(0M)  CS2(0M)  CS3(0M) */
> > > +		033,	/* CS0(64M)  CS1(64M) CS2(0M)  CS3(0M) */
> > > +		0113,	/* CS0(64M)  CS1(32M) CS2(32M) CS3(0M) */
> > > +		01111,	/* CS0(64M)  CS1(32M) CS2(32M) CS3(0M) */
> > > +	};
> > > +	u32 gprval = 0;
> > > +	u32 val;
> > > +	int cs = 0;
> > > +	int i = 0;
> > > +
> > > +	gpr = syscon_regmap_lookup_by_compatible("fsl,imx6q-iomuxc-gpr");
> > 
> > When trying to improve the bindings doc imx-weim.txt, I checked hardware
> > manuals and found that SoCs imx50, imx53, imx6q, imx6dl and imx6sl all
> > need the same CS GPR setup.  It's inappropriate to look up by hard-coded
> > compatible "fsl,imx6q-iomuxc-gpr" then.  So I'm going to add the
> > property fsl,weim-cs-gpr back, and update bindings doc accordingly.
> 
> You can add additional call into struct imx_weim_devtype for handle
> soc-specific stuff.

Yes, imx_weim_devtype is the place to code soc-specific stuff.  But for
this particular case, an additional DT property is more flexible.

Shawn
