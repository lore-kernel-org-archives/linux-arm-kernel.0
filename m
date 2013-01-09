From: marex@denx.de (Marek Vasut)
Date: Wed, 9 Jan 2013 11:25:32 +0100
Subject: [PATCH 7/7] ARM i.MX51 babbage: Add display support
In-Reply-To: <1357724786.2538.20.camel@pizza.hi.pengutronix.de>
References: <1352733809-27230-1-git-send-email-s.hauer@pengutronix.de>
 <201301091026.36838.marex@denx.de>
 <1357724786.2538.20.camel@pizza.hi.pengutronix.de>
Message-ID: <201301091125.32468.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Philipp Zabel,

> Am Mittwoch, den 09.01.2013, 10:26 +0100 schrieb Marek Vasut:
> > Dear Philipp Zabel,
> > 
> > > Hi Marek,
> > > 
> > > Am Dienstag, den 08.01.2013, 18:29 +0100 schrieb Marek Vasut:
> > > > Dear Philipp Zabel,
> > > > 
> > > > > Am Dienstag, den 08.01.2013, 18:09 +0100 schrieb Marek Vasut:
> > > > > > Dear Fabio Estevam,
> > > > > > 
> > > > > > > On Tue, Jan 8, 2013 at 2:41 PM, Fabio Estevam
> > > > > > > <festevam@gmail.com>
> > 
> > wrote:
> > > > > > > > Hi Sascha,
> > > > > > > > 
> > > > > > > > On Mon, Nov 12, 2012 at 1:23 PM, Sascha Hauer
> > > > > > > > <s.hauer@pengutronix.de>
> > > > > > 
> > > > > > wrote:
> > > > > > > >> The babbage board has a DVI-I output which allows to output
> > > > > > > >> analog and digital signals simultaneously. This patch adds
> > > > > > > >> support for it to the devicetree. The DDC signals are not
> > > > > > > >> wired up on the board, so DRM will fall back on default
> > > > > > > >> VESA modes.
> > > > > > > >> 
> > > > > > > >> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > > > > > > > 
> > > > > > > > I am running linux-next 20130108, which has this patch
> > > > > > > > applied and I
> > > > > > > 
> > > > > > > > get the following on my mx51babbage:
> > > > > > > Ok, good news. I see a nice penguin on my monitor now.
> > > > > > > 
> > > > > > > Discussed with Marek and he proposed a quick workaround:
> > > > > > > 
> > > > > > > --- a/drivers/staging/imx-drm/ipuv3-crtc.c
> > > > > > > +++ b/drivers/staging/imx-drm/ipuv3-crtc.c
> > > > > > > @@ -343,6 +343,11 @@ static irqreturn_t ipu_irq_handler(int
> > > > > > > irq, void *dev_id) {
> > > > > > > 
> > > > > > >         struct ipu_crtc *ipu_crtc = dev_id;
> > > > > > > 
> > > > > > > +       if (!ipu_crtc->imx_crtc) {
> > > > > > > +               pr_err("Spurious IPU IRQ\n");
> > > > > > > +               return IRQ_HANDLED;
> > > > > > > +       }
> > > > > > > +
> > > > > > > 
> > > > > > >         imx_drm_handle_vblank(ipu_crtc->imx_crtc);
> > > > > > >         
> > > > > > >         if (ipu_crtc->newfb) {
> > > > > > > 
> > > > > > > It seems that this issue happened because bootloader leaves the
> > > > > > > IPU turned on.
> > > > > > 
> > > > > > To elaborate more on this stuff:
> > > > > > 
> > > > > > 491         ipu_crtc->irq = ipu_idmac_channel_irq(ipu,
> > > > > > ipu_crtc->ipu_ch, 492                         IPU_IRQ_EOF);
> > > > > > 493         ret = devm_request_irq(ipu_crtc->dev, ipu_crtc->irq,
> > > > > > ipu_irq_handler, 0,
> > > > > > 494                         "imx_drm", ipu_crtc);
> > > > > > 495         if (ret < 0) {
> > > > > > 496                 dev_err(ipu_crtc->dev, "irq request failed
> > > > > > with %d.\n", ret);
> > > > > > 497                 goto err_out;
> > > > > > 498         }
> > > > > > 499
> > > > > > 500         disable_irq(ipu_crtc->irq);
> > > > > > 
> > > > > > This code in drivers/staging/imx-drm/ipuv3-crtc.c is broken. If
> > > > > > the IPU is on, it produces an interrupt before the driver is
> > > > > > fully set up. I didn't produce a patch yet, I think I might
> > > > > > offload this to someone else. Volunteers?
> > > > > 
> > > > > Reordering the ipu_get_resources and imx_drm_add_crtc calls should
> > > > > resolve this:
> > > > > 
> > > > > From: Philipp Zabel <p.zabel@pengutronix.de>
> > > > > Subject: [PATCH] staging: imx/drm: add crtc before registering
> > > > > interrupt
> > > > > 
> > > > >  handler
> > > > > 
> > > > > If the bootloader already enabled the display, the interrupt
> > > > > handler will be called as soon as it is registered. If the CRTC is
> > > > > not already added at this time, the call to imx_drm_handle_vblank
> > > > > will result in a NULL pointer dereference.
> > > > 
> > > > I ain't no IPU expert, but isn't adding the component before having
> > > > it fully inited even worse?
> > > 
> > > Good point, how about just moving the irq request out of
> > > ipu_get_resources into ipu_crtc_init, after adding the crtc:
> > > 
> > > From: Philipp Zabel <p.zabel@pengutronix.de>
> > > Subject: [PATCH] staging: imx/drm: request irq only after adding the
> > > crtc
> > > 
> > > If the bootloader already enabled the display, the interrupt handler
> > > will be called as soon as it is registered. If the CRTC is not already
> > > added at this time, the call to imx_drm_handle_vblank will result in
> > > a NULL pointer dereference.
> > 
> > Can we not just flush (and make sure it's disabled) the IRQ before
> > requesting it ? That'd be probably the most sane way
> 
> Probably, but that still would be no excuse for the interrupt handler to
> be registered before it can actually handle interrupts.

Yep, fully agreed.

Ok, can you check if the IRQ can be somehow flushed/disabled and then apply your 
last patch (the one that pulls the IRQ registration past imx_drm_add_crtc() )? 
That'd sound to me like a reasonable solution, what do you say? Apparently 
imx_drm_add_crtc() doesn't use the IRQ, so it should be cool too.
