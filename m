From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 17 Feb 2014 17:22:47 +0800
Subject: [PATCH v4] bus: imx-weim: support CS GPR configuration
In-Reply-To: <20140217085221.GB23095@frolo.macqel>
References: <1392559381-30842-1-git-send-email-shawn.guo@linaro.org>
 <1392560564.725313659@f356.i.mail.ru>
 <20140216143114.GH2946@S2101-09.ap.freescale.net>
 <20140217085221.GB23095@frolo.macqel>
Message-ID: <20140217092243.GB10731@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 17, 2014 at 09:52:21AM +0100, Philippe De Muyter wrote:
> On Sun, Feb 16, 2014 at 10:31:16PM +0800, Shawn Guo wrote:
> > On Sun, Feb 16, 2014 at 06:22:44PM +0400, Alexander Shiyan wrote:
> > > ???????????, 16 ??????? 2014, 22:03 +08:00 ?? Shawn Guo <shawn.guo@linaro.org>:
> > > > For imx50-weim and imx6q-weim type of devices, there might a WEIM CS
> > > > space configuration register in General Purpose Register controller,
> > > > e.g. IOMUXC_GPR1 on i.MX6Q.
> > > ...
> > > > +static int __init imx_weim_gpr_setup(struct platform_device *pdev)
> > > > +{
> > > > +	struct device_node *np = pdev->dev.of_node;
> > > > +	struct property *prop;
> > > > +	const __be32 *p;
> > > > +	struct regmap *gpr;
> > > > +	u32 gprvals[4] = {
> > > > +		05,	/* CS0(128M) CS1(0M)  CS2(0M)  CS3(0M) */
> > > > +		033,	/* CS0(64M)  CS1(64M) CS2(0M)  CS3(0M) */
> > > > +		0113,	/* CS0(64M)  CS1(32M) CS2(32M) CS3(0M) */
> > > > +		01111,	/* CS0(64M)  CS1(32M) CS2(32M) CS3(0M) */
> > > > +	};
> > > > +	u32 gprval = 0;
> > > > +	u32 val;
> > > > +	int cs = 0;
> > > > +	int i = 0;
> > > > +
> > > > +	gpr = syscon_regmap_lookup_by_phandle(np, "fsl,weim-cs-gpr");
> > > > +	if (IS_ERR(gpr)) {
> > > > +		dev_dbg(&pdev->dev, "failed to find weim-cs-gpr\n");
> > > > +		return 0;
> > > 
> > > Only one comment:
> > > You do not use these error codes in the probe(),
> > > so let's declare this function as void.
> > 
> > Oh, yes.  I should check return of imx_weim_gpr_setup() in probe().
> > Will add in the next version.
> 
> Well, as all the error cases are already covered by error messages, there is
> no added value in testing that again in probe().  As Alexander wrote, you can
> declare imx_weim_gpr_setup() as 'void'.

Hmm, shouldn't we stop probing when running into the error of invalid
ranges configuration?

Shawn
