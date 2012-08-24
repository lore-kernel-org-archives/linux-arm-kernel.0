From: b29396@freescale.com (Dong Aisheng)
Date: Fri, 24 Aug 2012 10:37:50 +0800
Subject: [PATCH 4/7] regulator: anatop-regulator: convert to use
 imx-syscon to access anatop register
In-Reply-To: <50366EEA.2070200@wwwdotorg.org>
References: <1345619928-15446-1-git-send-email-b29396@freescale.com>
 <1345619928-15446-5-git-send-email-b29396@freescale.com>
 <5035BDBF.9020602@wwwdotorg.org>
 <20120823061202.GM4011@b20223-02.ap.freescale.net>
 <50366EEA.2070200@wwwdotorg.org>
Message-ID: <20120824023749.GC5822@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 24, 2012 at 01:56:58AM +0800, Stephen Warren wrote:
> On 08/23/2012 12:12 AM, Richard Zhao wrote:
> > On Wed, Aug 22, 2012 at 11:21:03PM -0600, Stephen Warren wrote:
> >> On 08/22/2012 01:18 AM, Dong Aisheng wrote:
> >>> Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
> >>
> >>> diff --git a/drivers/regulator/anatop-regulator.c b/drivers/regulator/anatop-regulator.c
> >>
> >>> @@ -109,7 +110,11 @@ static int __devinit anatop_regulator_probe(struct platform_device *pdev)
> >>>  	rdesc->ops = &anatop_rops;
> >>>  	rdesc->type = REGULATOR_VOLTAGE;
> >>>  	rdesc->owner = THIS_MODULE;
> >>> -	sreg->mfd = anatopmfd;
> >>> +
> >>> +	sreg->anatop = of_parse_phandle(np, "fsl,anatop", 0);
> >>> +	if (!sreg->anatop)
> >>> +		return -ENODEV;
> >>
> >> In fact, that imx_syscon_lookup function I proposed could even do the
> >> of_parse_phandle() internally, so perhaps:
> >>
> >> foo->syscon_dev = imx_syscon_lookup(np, "fsl,anatop", 0);
> >> if (IS_ERR(foo->syscon_dev))
> >>     return PTR_ERR(foo->syscon_dev);
> >>
> >> with imx_syscon_lookup() internally knowing when to return EPROBE_DEFER
> >> rather than any other permanent error code (e.g. for missing property,
> >> bad phandle, etc.)
> >
> > In some case that we access register in machine code, we don't have any
> > phandle. The node is got by find compatible or by path.
> 
> That sounds a little odd; why not just use a phandle consistently
> everywhere?
Maybe for some places we do not have that device node, e.g:
arch/arm/mach-imx/mach-imx6q.c

> 
> Either way though, I could imagine still putting all the lookup code
> into the syscon driver; just have different functions for the different
> lookup methods:
> 
> imx_syscon_lookup_by_phandle(np, char *property_name)
Probably we do not need the left two lookup, below seems also ok if needed:
np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-anatop");
regmap = imx_syscon_lookup_by_phandle(np, property_name)
Then we do not need to handle how to find the compatible node.

> imx_syscon_lookup_by_compatible(char *compatible
> imx_syscon_lookup_by_path(char *node_path)

Regards
Dong Aisheng
