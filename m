From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 08 Jan 2013 18:23:20 +0100
Subject: [PATCH 7/7] ARM i.MX51 babbage: Add display support
In-Reply-To: <201301081809.38537.marex@denx.de>
References: <1352733809-27230-1-git-send-email-s.hauer@pengutronix.de>
 <CAOMZO5BnFZs+s-WFahtqyzCi15P9RBzKDzwdZNCJ4PmnQrFY1g@mail.gmail.com>
 <CAOMZO5AkRmhdB-JWQ5DFuQUJHibV7GGvvDeK7-cg7m8OnbHA_Q@mail.gmail.com>
 <201301081809.38537.marex@denx.de>
Message-ID: <1357665800.2527.17.camel@pizza.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, den 08.01.2013, 18:09 +0100 schrieb Marek Vasut:
> Dear Fabio Estevam,
> 
> > On Tue, Jan 8, 2013 at 2:41 PM, Fabio Estevam <festevam@gmail.com> wrote:
> > > Hi Sascha,
> > > 
> > > On Mon, Nov 12, 2012 at 1:23 PM, Sascha Hauer <s.hauer@pengutronix.de> 
> wrote:
> > >> The babbage board has a DVI-I output which allows to output analog
> > >> and digital signals simultaneously. This patch adds support for it
> > >> to the devicetree. The DDC signals are not wired up on the board, so
> > >> DRM will fall back on default VESA modes.
> > >> 
> > >> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > > 
> > > I am running linux-next 20130108, which has this patch applied and I
> > 
> > > get the following on my mx51babbage:
> > Ok, good news. I see a nice penguin on my monitor now.
> > 
> > Discussed with Marek and he proposed a quick workaround:
> > 
> > --- a/drivers/staging/imx-drm/ipuv3-crtc.c
> > +++ b/drivers/staging/imx-drm/ipuv3-crtc.c
> > @@ -343,6 +343,11 @@ static irqreturn_t ipu_irq_handler(int irq, void
> > *dev_id) {
> >         struct ipu_crtc *ipu_crtc = dev_id;
> > 
> > +       if (!ipu_crtc->imx_crtc) {
> > +               pr_err("Spurious IPU IRQ\n");
> > +               return IRQ_HANDLED;
> > +       }
> > +
> >         imx_drm_handle_vblank(ipu_crtc->imx_crtc);
> > 
> >         if (ipu_crtc->newfb) {
> > 
> > It seems that this issue happened because bootloader leaves the IPU turned
> > on.
> 
> To elaborate more on this stuff:
> 
> 491         ipu_crtc->irq = ipu_idmac_channel_irq(ipu, ipu_crtc->ipu_ch,
> 492                         IPU_IRQ_EOF);
> 493         ret = devm_request_irq(ipu_crtc->dev, ipu_crtc->irq, 
> ipu_irq_handler, 0,
> 494                         "imx_drm", ipu_crtc);
> 495         if (ret < 0) {
> 496                 dev_err(ipu_crtc->dev, "irq request failed with %d.\n", 
> ret);
> 497                 goto err_out;
> 498         }
> 499 
> 500         disable_irq(ipu_crtc->irq);
> 
> This code in drivers/staging/imx-drm/ipuv3-crtc.c is broken. If the IPU is on, 
> it produces an interrupt before the driver is fully set up. I didn't produce a 
> patch yet, I think I might offload this to someone else. Volunteers?

Reordering the ipu_get_resources and imx_drm_add_crtc calls should resolve this:

From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH] staging: imx/drm: add crtc before registering interrupt
 handler

If the bootloader already enabled the display, the interrupt handler
will be called as soon as it is registered. If the CRTC is not already
added at this time, the call to imx_drm_handle_vblank will result in
a NULL pointer dereference.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/staging/imx-drm/ipuv3-crtc.c |   21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/imx-drm/ipuv3-crtc.c b/drivers/staging/imx-drm/ipuv3-crtc.c
index 4b3a019..3d04abb 100644
--- a/drivers/staging/imx-drm/ipuv3-crtc.c
+++ b/drivers/staging/imx-drm/ipuv3-crtc.c
@@ -506,28 +506,23 @@ static int ipu_crtc_init(struct ipu_crtc *ipu_crtc,
 {
 	int ret;
 
-	ret = ipu_get_resources(ipu_crtc, pdata);
-	if (ret) {
-		dev_err(ipu_crtc->dev, "getting resources failed with %d.\n",
-				ret);
-		return ret;
-	}
-
 	ret = imx_drm_add_crtc(&ipu_crtc->base,
 			&ipu_crtc->imx_crtc,
 			&ipu_crtc_helper_funcs, THIS_MODULE,
 			ipu_crtc->dev->parent->of_node, pdata->di);
 	if (ret) {
 		dev_err(ipu_crtc->dev, "adding crtc failed with %d.\n", ret);
-		goto err_put_resources;
+		return ret;
 	}
 
-	return 0;
-
-err_put_resources:
-	ipu_put_resources(ipu_crtc);
+	ret = ipu_get_resources(ipu_crtc, pdata);
+	if (ret) {
+		dev_err(ipu_crtc->dev, "getting resources failed with %d.\n",
+				ret);
+		return ret;
+	}
 
-	return ret;
+	return 0;
 }
 
 static int ipu_drm_probe(struct platform_device *pdev)
-- 
1.7.10.4
