From: robh@kernel.org (Rob Herring)
Date: Thu, 17 Mar 2016 12:01:01 -0500
Subject: [v6, 5/5] mmc: sdhci-of-esdhc: fix host version for
 T4240-R1.0-R2.0
In-Reply-To: <DB5PR0401MB19286B2D23D07F5C60DB799D91880@DB5PR0401MB1928.eurprd04.prod.outlook.com>
References: <1457518131-11339-1-git-send-email-yangbo.lu@nxp.com>
 <1457518131-11339-6-git-send-email-yangbo.lu@nxp.com>
 <4947024.WeMycs2fID@wuerfel>
 <HE1PR04MB0889CE4742B92461A925B9C4F8880@HE1PR04MB0889.eurprd04.prod.outlook.com>
 <DB5PR0401MB19286B2D23D07F5C60DB799D91880@DB5PR0401MB1928.eurprd04.prod.outlook.com>
Message-ID: <20160317170101.GA21009@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 14, 2016 at 05:45:43PM +0000, Scott Wood wrote:
> On 03/14/2016 02:29 AM, Yangbo Lu wrote:
> >> -----Original Message-----
> >> From: Arnd Bergmann [mailto:arnd at arndb.de]
> >> Sent: Monday, March 14, 2016 6:26 AM
> >> To: linuxppc-dev at lists.ozlabs.org
> >> Cc: Yangbo Lu; devicetree at vger.kernel.org; linux-arm-
> >> kernel at lists.infradead.org; linux-kernel at vger.kernel.org; linux-
> >> clk at vger.kernel.org; linux-i2c at vger.kernel.org; iommu at lists.linux-
> >> foundation.org; netdev at vger.kernel.org; linux-mmc at vger.kernel.org;
> >> ulf.hansson at linaro.org; Zhao Qiang; Russell King; Bhupesh Sharma; Joerg
> >> Roedel; Santosh Shilimkar; Scott Wood; Rob Herring; Claudiu Manoil; Kumar
> >> Gala; Yang-Leo Li; Xiaobo Xie
> >> Subject: Re: [v6, 5/5] mmc: sdhci-of-esdhc: fix host version for T4240-
> >> R1.0-R2.0
> >>
> >> On Wednesday 09 March 2016 18:08:51 Yangbo Lu wrote:
> >>> @@ -567,10 +580,20 @@ static void esdhc_init(struct platform_device
> >> *pdev, struct sdhci_host *host)
> >>>         struct sdhci_pltfm_host *pltfm_host;
> >>>         struct sdhci_esdhc *esdhc;
> >>>         u16 host_ver;
> >>> +       u32 svr;
> >>>
> >>>         pltfm_host = sdhci_priv(host);
> >>>         esdhc = sdhci_pltfm_priv(pltfm_host);
> >>>
> >>> +       fsl_guts_init();
> >>> +       svr = fsl_guts_get_svr();
> >>> +       if (svr) {
> >>> +               esdhc->soc_ver = SVR_SOC_VER(svr);
> >>> +               esdhc->soc_rev = SVR_REV(svr);
> >>> +       } else {
> >>> +               dev_err(&pdev->dev, "Failed to get SVR value!\n");
> >>> +       }
> >>> +
> >>
> >> This makes the driver non-portable. Better identify the specific
> >> workarounds based on the compatible string for this device, or add a
> >> boolean DT property for the quirk.
> >>
> >> 	Arnd
> > 
> > [Lu Yangbo-B47093] Hi Arnd, we did have a discussion about using DTS in v1 before.
> > https://patchwork.kernel.org/patch/6834221/
> > 
> > We don?t have a separate DTS file for each revision of an SOC and if we did, we'd constantly have people using the wrong one.
> > In addition, the device tree is stable ABI and errata are often discovered after device tree are deployed.
> > See the link for details.
> > 
> > So we decide to read SVR from the device-config/guts MMIO block other than using DTS.
> > Thanks.
> 
> Also note that this driver is already only for fsl-specific hardware,
> and it will still work even if fsl_guts doesn't find anything to bind to
> -- it just wouldn't be able to detect errata based on SVR in that case.

IIRC, it is the same IP block as i.MX and Arnd's point is this won't 
even compile on !PPC. It is things like this that prevent sharing the 
driver. Dealing with Si revs is a common problem. We should have a 
common solution. There is soc_device for this purpose.

OTOH, the integration differences may be enough that trying to have a 
common driver with i.MX would not be worth it.

Rob
