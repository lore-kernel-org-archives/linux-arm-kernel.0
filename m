From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 18 Jul 2018 10:49:24 +0100
Subject: [PATCH v3 3/4] PCI: mediatek: Add system pm support for MT2712
 and MT7622
In-Reply-To: <1531893761.31406.15.camel@mhfsdcap03>
References: <1530518264-6125-1-git-send-email-honghui.zhang@mediatek.com>
 <1530518264-6125-4-git-send-email-honghui.zhang@mediatek.com>
 <20180717171543.GA20991@red-moon>
 <1531893761.31406.15.camel@mhfsdcap03>
Message-ID: <20180718094924.GA21463@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 18, 2018 at 02:02:41PM +0800, Honghui Zhang wrote:

<snip>

> > > +static int __maybe_unused mtk_pcie_resume_noirq(struct device *dev)
> > > +{
> > > +	struct mtk_pcie *pcie = dev_get_drvdata(dev);
> > > +	const struct mtk_pcie_soc *soc = pcie->soc;
> > > +	struct mtk_pcie_port *port, *tmp;
> > > +
> > > +	if (!soc->pm_support)
> > > +		return 0;
> > > +
> > > +	if (list_empty(&pcie->ports))
> > > +		return 0;
> > > +
> > > +	if (dev->pm_domain) {
> > > +		pm_runtime_enable(dev);
> > > +		pm_runtime_get_sync(dev);
> > > +	}
> > 
> > Are these runtime PM calls needed/abused here ?
> > 
> > Mind explaining the logic ?
> > 
> > There is certainly an asymmetry with the suspend callback which made me
> > suspicious, I am pretty certain Rafael/Kevin/Ulf can help me clarify so
> > that we can make progress with this patch.
> > 
> > Lorenzo
> > 
> Hi Lorenzo, thanks for your comments.
> Sorry I don't get you.
> I believe that in suspend callbacks the pm_runtime_put_sync and
> pm_runtime_disable should be called to gated the CMOS for this module,
> while the pm_rumtime_enable and pm_rumtime_get_sync should be called
> in resume callback.

That's why I CC'ed Rafael, Kevin and Ulf, to answer this question
thoroughly, I am not sure it is needed and that's the right way
of doing it in system suspend callbacks.

> That's exactly this patch doing.
> But the pm_rumtime_put_sync and pm_runtime_disable functions was wrapped
> in the mtk_pcie_subsys_powerdown.

Ah, sorry, I missed that.

> I did not call mtk_pcie_subsys_powerup since it does not just wrapped
> pm_rumtime related functions but also do the platform_resource_get,
> devm_ioremap, and free_ck clock get which I do not needed in resume
> callback.
> 
> Do you think it will be much clear if I abstract the
> platform_resource_get, devm_ioremap functions from
> mtk_pcie_subsys_powerup and put it to a new functions like
> mtk_pcie_subsys_resource_get, and then we may call the
> mtk_pcie_subsys_powerup in the resume function?

I think so but let's wait first for feedback on whether those
runtime PM calls are needed in the first place.

Lorenzo
