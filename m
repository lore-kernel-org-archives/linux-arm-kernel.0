From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 24 Feb 2014 18:03:58 +0100
Subject: [RFC PATCH v3 1/9] staging: imx-drm-core: don't request probe
 deferral in imx_drm_encoder_parse_of
In-Reply-To: <1393260998.3091.63.camel@pizza.hi.pengutronix.de>
References: <1392723370-4772-1-git-send-email-p.zabel@pengutronix.de>
 <1392723370-4772-2-git-send-email-p.zabel@pengutronix.de>
 <20140224154919.GL21483@n2100.arm.linux.org.uk>
 <1393260998.3091.63.camel@pizza.hi.pengutronix.de>
Message-ID: <1393261438.3091.67.camel@pizza.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, den 24.02.2014, 17:56 +0100 schrieb Philipp Zabel:
> Am Montag, den 24.02.2014, 15:49 +0000 schrieb Russell King - ARM Linux:
> > On Tue, Feb 18, 2014 at 12:36:02PM +0100, Philipp Zabel wrote:
> > > From: Lucas Stach <l.stach@pengutronix.de>
> > > 
> > > Since imx_drm_encoder_parse_of is called from the encoder bind callbacks,
> > > it is too late to request probe deferral. Rather the core should make sure
> > > that the crtcs are bound before the encoders, after all needed components
> > > are probed.
> > 
> > Why is it too late?  -EPROBE_DEFER from this point will cause the driver
> > initialisation to correctly unwind and return -EPROBE_DEFER to the
> > last-to-be-added component.
> 
> Hmm, you are right. I have conflated two separate issues here. I'll back
> that out.
> 
> > > This fixes probe failure when using the LDB on i.MX6.
> > 
> > More details please.
> 
> One issue was that the DT parsing code would try to add the imx-ldb
> component right after the first crtc, and then its bind would fail
> in imx_drm_encoder_parse_of because the three remaining crtcs were
> not yet registered. This is already fixed by adding the crtc
> components first.

On second thought, now that the crtcs are all bound before the encoders,
we'll never even reach this point until all crtcs are available.

regards
Philipp
