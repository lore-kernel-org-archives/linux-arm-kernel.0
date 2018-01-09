From: l.stach@pengutronix.de (Lucas Stach)
Date: Tue, 09 Jan 2018 10:28:18 +0100
Subject: [PATCH] soc: imx: gpc: de-register power domains only if
 initialized
In-Reply-To: <ca2d65f7b79df62f59942deca74e40d3@agner.ch>
References: <20180107134905.15624-1-stefan@agner.ch>
 <20180108102855.GA32635@b29396-OptiPlex-7040>
 <1515408692.12538.10.camel@pengutronix.de>
 <ca2d65f7b79df62f59942deca74e40d3@agner.ch>
Message-ID: <1515490098.12538.25.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, den 08.01.2018, 22:17 +0100 schrieb Stefan Agner:
> On 2018-01-08 11:51, Lucas Stach wrote:
> > Am Montag, den 08.01.2018, 18:28 +0800 schrieb Dong Aisheng:
> > > On Sun, Jan 07, 2018 at 02:49:05PM +0100, Stefan Agner wrote:
> > > > If power domain information are missing in the device tree, no
> > > > power domains get initialized. However, imx_gpc_remove tries to
> > > > remove power domains always in the old DT binding case. Only
> > > > remove power domains when imx_gpc_probe initialized them in
> > > > first place.
> > > > 
> > > > Fixes: 721cabf6c660 ("soc: imx: move PGC handling to a new GPC
> > > > driver")
> > > > > > > > Cc: Lucas Stach <l.stach@pengutronix.de>
> > > > > > > > Signed-off-by: Stefan Agner <stefan@agner.ch>
> > > > ---
> > > > ?drivers/soc/imx/gpc.c | 10 +++++++++-
> > > > ?1 file changed, 9 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/soc/imx/gpc.c b/drivers/soc/imx/gpc.c
> > > > index 53f7275d6cbd..62bb724726d9 100644
> > > > --- a/drivers/soc/imx/gpc.c
> > > > +++ b/drivers/soc/imx/gpc.c
> > > > @@ -470,13 +470,21 @@ static int imx_gpc_probe(struct
> > > > platform_device *pdev)
> > > > ?
> > > > ?static int imx_gpc_remove(struct platform_device *pdev)
> > > > ?{
> > > 
> > > What's the original purpose of imx_gpc_remove?
> > > ARM power domain can't be removed.
> > 
> > Why? As long as it stays powered on there is not reason why we wouldn't
> > be able to remove the driver.
> > 
> 
> Is it really safe to make assumptions of the hardware state when drivers
> get removed? At least some drivers disable the hardware on remove (e.g.
> i.MX SPI driver).

You are completely right that we should do something more sensible on
remove. Like making sure the domain is powered on or (preferably for
the non ARM domains) unbinding the consumers.
 
> > > And why current imx_gpc_remove only remove domains for old DT but not
> > > for new ones?
> > 
> > With the new binding the power domains will be removed by the sub-
> > drivers for the domains.
> > 
> > > How about make it un-removable?
> > > e.g.
> > 
> > I don't see why this would be a good idea. Once more device-dependency
> > handling is in place we might need to unbind the power domains when the
> > regulator driver for the domain is unbound. Do you intend to make them
> > non-removable, too?
> 
> I think it would be preferable to keep the ability to remote the driver.
> 
> However, I noticed that even with this fix, with device trees which do
> use the power domains capabilities (e.g. i.MX6DL) it leads to a stack
> trace when using DEBUG_TEST_DRIVER_REMOVE=y, see:
> https://marc.info/?l=linux-arm-kernel&m=151544599904423&w=4

Urgh. Yes, we should fix this. This is really missing a device
dependency between the core GPC driver and the PM domain drivers. With
this dependency in place we can make sure to unbind the domain driver
before the core driver goes away.

Regards,
Lucas
