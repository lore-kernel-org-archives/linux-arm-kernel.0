From: balbi@ti.com (Felipe Balbi)
Date: Fri, 28 Mar 2014 09:42:45 -0500
Subject: [RFC/PATCH] base: platform: add generic clock handling for
 platform-bus
In-Reply-To: <2775124.TXohNNxBKa@avalon>
References: <1391191965-31102-1-git-send-email-balbi@ti.com>
 <2775124.TXohNNxBKa@avalon>
Message-ID: <20140328144245.GD17820@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Mar 12, 2014 at 04:37:19PM +0100, Laurent Pinchart wrote:
> Hi Felipe,
> 
> (CC'ing Geert Uytterhoeven as we happen to discuss runtime PM and clock 
> handling for the Renesas SoCs at the moment)
> 
> Thank you for the patch. This is a bit of a late reply, but that's better than 
> no reply I suppose. Please see below for a small comment.
> 
> On Friday 31 January 2014 12:12:45 Felipe Balbi wrote:
> > Still TODO a commit log. Not for merging!!!!!
> > 
> > NYET-Signed-off-by: Felipe Balbi <balbi@ti.com>
> > ---
> > 
> > This patch is an idea I've had recently in order to combine several
> > different PM implementations into the platform-bus.
> > 
> > This patch is bare minimum for platforms which need to handle functional and
> > interface clocks but the whole thing is made optional.
> > 
> > Note that this patch makes sure that by the time a platform_driver's probe
> > is called, we already have clocks enabled and pm_runtime_set_active() has
> > been called, thus making sure that a device driver's pm_runtime_get_sync()
> > will solely increase the pm usage counter.
> > 
> > I have *NOT* tested this anywhere *YET*, but I suppose it shouldn't cause
> > any issues since the clock API has ref counting too.
> > 
> > Would really like to get some review from several folks involved with ARM
> > SoC PM so that's the reason for the wide audience. If I have missed
> > anybody, please add them to Cc.
> > 
> > As mentioned above, this is *NOT* meant for merging, but serves as a
> > starting point for discussing some convergence of several PM domain
> > implementations on different arch/arm/mach-* directories.
> > 
> > For OMAP, this has the added benefit of removing clock handling from
> > omap_device/omap_hwmod and, thus, dropping the need for so many DT_CLK()
> > tables under drivers/clk/ti/
> > 
> >  drivers/base/platform.c         | 169 +++++++++++++++++++++++++++++++++++--
> >  include/linux/platform_device.h |   9 +++
> >  2 files changed, 173 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> > index 3a94b79..86aeb5b 100644
> > --- a/drivers/base/platform.c
> > +++ b/drivers/base/platform.c
> > @@ -484,6 +484,21 @@ static int platform_drv_probe(struct device *_dev)
> >  	if (ACPI_HANDLE(_dev))
> >  		acpi_dev_pm_attach(_dev, true);
> > 
> > +	dev->fck = devm_clk_get(_dev, "fck");
> > +	dev->ick = devm_clk_get(_dev, "ick");
> 
> My concern with this that some devices might want to handle their functional 
> and interface clocks manually if they have exotic requirements. They would 
> thus need a way to signal that the platform bus core should not try to perform 
> clock management on its own.
> 
> One possible way would be to name the clocks differently for those devices, 
> but we might then have a backward compatibility issue with DT.
> 
> Another concern is how to handle the DT backward compatibility for devices 
> that would benefit from core management of their functional and interface 
> clocks, but that currently don't name those clocks "fck" and "ick". Renaming 
> those clocks in DT wouldn't be a problem for the future, but backward 
> compatibility needs to be handled. Maybe platforms could provide aliases in 
> that case.

yeah, I guess alias would be the way to go. Another possible way would
be grab the clocks by phandle if of_node is a valid pointer. At the end
of the day, the name of the clock shouldn't matter.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140328/8dd4cbbd/attachment.sig>
