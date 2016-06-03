From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 3 Jun 2016 15:15:48 +0100
Subject: [PATCH] drm: convert DT component matching to
 component_match_add_release()
In-Reply-To: <57516268.3020401@arm.com>
References: <E1b8jze-00046l-K5@rmk-PC.armlinux.org.uk>
 <57516268.3020401@arm.com>
Message-ID: <20160603141548.GC1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 03, 2016 at 11:56:40AM +0100, Robin Murphy wrote:
> Hi Russell,
> 
> On 03/06/16 08:58, Russell King wrote:
> >Convert DT component matching to use component_match_add_release().
> >
> >Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> >---
> >  drivers/gpu/drm/arm/hdlcd_drv.c             | 10 ++++++++--
> >  drivers/gpu/drm/armada/armada_drv.c         |  9 +++++++--
> >  drivers/gpu/drm/drm_of.c                    | 13 +++++++++----
> >  drivers/gpu/drm/msm/msm_drv.c               |  8 +++++++-
> >  drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 13 ++++++++++---
> >  drivers/gpu/drm/sti/sti_drv.c               |  9 +++++++--
> >  drivers/gpu/drm/tilcdc/tilcdc_external.c    |  9 +++++++--
> >  7 files changed, 55 insertions(+), 16 deletions(-)
> >
> >diff --git a/drivers/gpu/drm/arm/hdlcd_drv.c b/drivers/gpu/drm/arm/hdlcd_drv.c
> >index b987c63ba8d6..bbde48c4f550 100644
> >--- a/drivers/gpu/drm/arm/hdlcd_drv.c
> >+++ b/drivers/gpu/drm/arm/hdlcd_drv.c
> >@@ -443,11 +443,16 @@ static const struct component_master_ops hdlcd_master_ops = {
> >  	.unbind		= hdlcd_drm_unbind,
> >  };
> >
> >-static int compare_dev(struct device *dev, void *data)
> >+static int compare_of(struct device *dev, void *data)
> >  {
> >  	return dev->of_node == data;
> >  }
> >
> >+static void release_of(struct device *dev, void *data)
> >+{
> >+	of_node_put(data);
> >+}
> 
> Considering that there's 7 identical copies of this function in this patch
> alone, perhaps there's some mileage in defining it commonly as a static
> __maybe_unused default_release_of() in component.h or drm_of.h (and maybe
> default_compare_of() similarly)?
> 
> (Apologies if there's already been some strong argument against that which
> I've not seen, but it seems like a reasonable thing to do.)

What we could do is extract out the common bits of OF-component matching
into drivers/of/of_component.c and make the whole thing a tad better.
I'll send a v2 series threaded to this message.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
