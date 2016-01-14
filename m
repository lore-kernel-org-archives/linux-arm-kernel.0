From: sre@kernel.org (Sebastian Reichel)
Date: Thu, 14 Jan 2016 23:40:25 +0100
Subject: [PATCH] mmc: host: omap_hsmmc: add a verbose print to enable
 CONFIG_REGULATOR_PBIAS
In-Reply-To: <20160114172549.GC5783@n2100.arm.linux.org.uk>
References: <1452762920-2588-1-git-send-email-kishon@ti.com>
 <20160114120706.GA12774@earth>
 <20160114172549.GC5783@n2100.arm.linux.org.uk>
Message-ID: <20160114224025.GA26988@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jan 14, 2016 at 05:25:49PM +0000, Russell King - ARM Linux wrote:
> On Thu, Jan 14, 2016 at 01:07:06PM +0100, Sebastian Reichel wrote:
> > On Thu, Jan 14, 2016 at 02:45:20PM +0530, Kishon Vijay Abraham I wrote:
> > > Since v4.3+, CONFIG_REGULATOR_PBIAS should be enabled (for platforms that
> > > have PBIAS regulator) in order for MMC1 to work.
> > > 
> > > Add a more verbose print to help enable CONFIG_REGULATOR_PBIAS for users
> > > using a olddefconfig or a custom .config.
> > > 
> > > Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> > > ---
> > >  drivers/mmc/host/omap_hsmmc.c |    5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> > > index 7fb0753..7086bd6 100644
> > > --- a/drivers/mmc/host/omap_hsmmc.c
> > > +++ b/drivers/mmc/host/omap_hsmmc.c
> > > @@ -503,8 +503,11 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
> > >  	host->pbias = devm_regulator_get_optional(host->dev, "pbias");
> > >  	if (IS_ERR(host->pbias)) {
> > >  		ret = PTR_ERR(host->pbias);
> > > -		if ((ret != -ENODEV) && host->dev->of_node)
> > > +		if ((ret != -ENODEV) && host->dev->of_node) {
> > > +			dev_err(host->dev,
> > > +			"SD card detect fail? enable CONFIG_REGULATOR_PBIAS\n");
> > >  			return ret;
> > > +		}
> > >  		dev_dbg(host->dev, "unable to get pbias regulator %ld\n",
> > >  			PTR_ERR(host->pbias));
> > >  		host->pbias = NULL;
> > 
> > 
> > Is there a good reason against adding "depends on REGULATOR_PBIAS"
> > to MMC_OMAP_HS?
> 
> There are very good reasons not to do this: that will result in
> configurations where MMC_OMAP_HS was set but without REGULATOR_PBIAS
> ending up with MMC_OMAP_HS being disabled.  That doesn't help the
> root problem, which is "why has the kernel boot regressed for my
> previous working configuration?"
> 
> The solution proposed here adds a message to the boot which points
> out fair and square what needs to be done to rectify the boot
> failure.  Adding a dependency just brings up the question "where
> has my MMC driver gone?"

The best thing would be to have no regression. Just printing a
message means I have to build another kernel. But more importantly
the message may not be visible by the user - e.g. if the display has
not yet been initialized.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160114/f85226fa/attachment.sig>
