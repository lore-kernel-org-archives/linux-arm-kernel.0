From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Wed, 23 Nov 2011 21:40:30 +0100
Subject: [alsa-devel] [PATCH 07/17] ASoC: Tegra DAS: Use devm_ APIs and
 module_platform_driver
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF174F08C6F3@HQMAIL01.nvidia.com>
References: <1322011285-4002-1-git-send-email-swarren@nvidia.com>
 <1322011285-4002-8-git-send-email-swarren@nvidia.com>
 <20111123065808.GB5255@avionic-0098.adnet.avionic-design.de>
 <74CDBE0F657A3D45AFBB94109FB122FF174F08C6F3@HQMAIL01.nvidia.com>
Message-ID: <20111123204030.GA7485@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Stephen Warren wrote:
> Thierry Reding wrote at Tuesday, November 22, 2011 11:58 PM:
> > * Stephen Warren wrote:
> > > module_platform_drive saves some boiler-plate code.
> > >
> > > The devm_ APIs remove the need to manually clean up allocations,
> > > thus removing some code.
> ...
> > >  static int __devexit tegra_das_remove(struct platform_device *pdev)
> > >  {
> > > -	struct resource *res;
> > > -
> > >  	if (!das)
> > >  		return -ENODEV;
> > >
> > > -	platform_set_drvdata(pdev, NULL);
> > > -
> > [...]
> > 
> > Setting the driver data to NULL may still be a good idea.
> 
> When Mark Brown reviewed the TrimSlice machine driver, he mentioned that
> clearing the drvdata was pointless; nothing should be using it when the
> device is not created.
> 
> As background, soon after that, I modified the tegra_wm8903.c machine
> driver along the same lines, but evidently didn't update tegra_das.c
> in a similar way, but would have if I'd been paying attention...

Thinking about this some more I have to agree. The only one using the driver
data would be the driver, which in turn shouldn't be doing anything with it
after remove is called.

I was just commenting on it because I've seen it done in a lot of drivers and
thought it was common (best) practice.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111123/21c11281/attachment-0001.sig>
