From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 27 Aug 2015 09:54:13 +0100
Subject: [PATCH 04/12] gpu: imx: fix support for interlaced modes
In-Reply-To: <1440664752.3233.36.camel@pengutronix.de>
References: <20150808160251.GM7557@n2100.arm.linux.org.uk>
 <E1ZO6ay-0002qh-6E@rmk-PC.arm.linux.org.uk>
 <1440664752.3233.36.camel@pengutronix.de>
Message-ID: <20150827085411.GE21084@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 27, 2015 at 10:39:12AM +0200, Philipp Zabel wrote:
> Hi Russell,
> 
> Am Samstag, den 08.08.2015, 17:03 +0100 schrieb Russell King:
> > The support for interlaced video modes seems to be broken; we don't use
> > anything other than the vtotal/htotal from the timing information to
> > define the various sync counters.
> 
> I finally made time to test this series:
> 
> Tested-by: Philipp Zabel <p.zabel@pengutronix.de>
> on i.MX6 GK802 via HDMI connected to a TV (1080p60, 1080i60).
> 
> Unfortunately these timings are completely different from what Freescale
> came up with for the TV Encoder on i.MX5, but the code we have currently
> in mainline doesn't work for that either. I suppose I'll follow up with
> a patch that adds yet another sync counter setup for the i.MX5/TVE case.
> 
> I'd like to take the two ipu-v3 patches, making a few small changes on
> this one:

Please don't split the series up.  The reason it's a series is because
there's interdependencies between the patches.

> > Freescale patches for interlaced video support contain an alternative
> > sync counter setup, which we include here.  This setup produces the
> > hsync and vsync via the normal counter 2 and 3, but moves the display
> > enable signal from counter 5 to counter 6.  Therefore, we need to
> > change the display controller setup as well.
> > 
> > The corresponding Freescale patches for this change are:
> >   iMX6-HDMI-support-interlaced-display-mode.patch
> >   IPU-fine-tuning-the-interlace-display-timing-for-CEA.patch
> > 
> > This produces a working interlace format output from the IPU.
> 
> ... on i.MX6 via HDMI.

It should also be correct for any other source which wants interlaced
output.

> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > ---
> >  drivers/gpu/ipu-v3/ipu-dc.c | 18 ++++++++---
> >  drivers/gpu/ipu-v3/ipu-di.c | 79 +++++++++++++++++++++------------------------
> >  2 files changed, 51 insertions(+), 46 deletions(-)
> > 
> > diff --git a/drivers/gpu/ipu-v3/ipu-dc.c b/drivers/gpu/ipu-v3/ipu-dc.c
> > index 9ef2e1f54ca4..aa560855c1dc 100644
> > --- a/drivers/gpu/ipu-v3/ipu-dc.c
> > +++ b/drivers/gpu/ipu-v3/ipu-dc.c
> > @@ -183,12 +183,22 @@ int ipu_dc_init_sync(struct ipu_dc *dc, struct ipu_di *di, bool interlaced,
> >  	}
> >  
> >  	if (interlaced) {
> > -		dc_link_event(dc, DC_EVT_NL, 0, 3);
> > -		dc_link_event(dc, DC_EVT_EOL, 0, 2);
> > -		dc_link_event(dc, DC_EVT_NEW_DATA, 0, 1);
> > +		int word, addr;
> > +
> > +		if (dc->di) {
> > +			addr = 1;
> > +			word = 1;
> 
> These two are really one and the same. The address written to the link
> register for the given event has to point to the address of the
> microcode instruction written to the template memory that should be
> executed on this event.
> 
> I'd like to drop the word variable and use addr for both.

Ok.  As I said in the commit message, this code comes from Freescale's
patches which I pointed to above.

> > +		} else {
> > +			addr = 0;
> > +			word = 0;
> > +		}
> > +
> > +		dc_link_event(dc, DC_EVT_NL, addr, 3);
> > +		dc_link_event(dc, DC_EVT_EOL, addr, 2);
> > +		dc_link_event(dc, DC_EVT_NEW_DATA, addr, 1);
> >  
> >  		/* Init template microcode */
> > -		dc_write_tmpl(dc, 0, WROD(0), 0, map, SYNC_WAVE, 0, 8, 1);
> > +		dc_write_tmpl(dc, word, WROD(0), 0, map, SYNC_WAVE, 0, 6, 1);
> >  	} else {
> >  		if (dc->di) {
> >  			dc_link_event(dc, DC_EVT_NL, 2, 3);
> > diff --git a/drivers/gpu/ipu-v3/ipu-di.c b/drivers/gpu/ipu-v3/ipu-di.c
> > index a96991c5c15f..359268e3a166 100644
> > --- a/drivers/gpu/ipu-v3/ipu-di.c
> > +++ b/drivers/gpu/ipu-v3/ipu-di.c
> > @@ -71,6 +71,10 @@ enum di_sync_wave {
> >  	DI_SYNC_HSYNC = 3,
> >  	DI_SYNC_VSYNC = 4,
> >  	DI_SYNC_DE = 6,
> > +
> > +	DI_SYNC_CNT1 = 2,	/* counter >= 2 only */
> > +	DI_SYNC_CNT4 = 5,	/* counter >= 5 only */
> > +	DI_SYNC_CNT5 = 6,	/* counter >= 6 only */
> >  };
> >  
> >  #define SYNC_WAVE 0
> > @@ -211,66 +215,59 @@ static void ipu_di_sync_config_interlaced(struct ipu_di *di,
> >  		sig->mode.hback_porch + sig->mode.hfront_porch;
> >  	u32 v_total = sig->mode.vactive + sig->mode.vsync_len +
> >  		sig->mode.vback_porch + sig->mode.vfront_porch;
> > -	u32 reg;
> >  	struct di_sync_config cfg[] = {
> >  		{
> > -			.run_count = h_total / 2 - 1,
> > -			.run_src = DI_SYNC_CLK,
> > +			/* 1: internal VSYNC for each frame */
> > +			.run_count = v_total * 2 - 1,
> > +			.run_src = 3,			/* == counter 7 */
> 
> Do you know why this works? The Reference Manual v2 lists that value as
> "NA" in the DI counter #1 Run Resolution field.

Yes, I noticed that Freescale were using values for the source fields
which were marked as NA in the manual.  As it works, I can only assume
that the engineer who came up with this setup has more knowledge than
is public.

> >  		}, {
> > -			.run_count = h_total - 11,
> > +			/* PIN2: HSYNC waveform */
> > +			.run_count = h_total - 1,
> >  			.run_src = DI_SYNC_CLK,
> > -			.cnt_down = 4,
> > +			.cnt_polarity_gen_en = 1,
> > +			.cnt_polarity_trigger_src = DI_SYNC_CLK,
> > +			.cnt_down = sig->mode.hsync_len * 2,
> >  		}, {
> > -			.run_count = v_total * 2 - 1,
> > -			.run_src = DI_SYNC_INT_HSYNC,
> > -			.offset_count = 1,
> > -			.offset_src = DI_SYNC_INT_HSYNC,
> > -			.cnt_down = 4,
> > +			/* PIN3: VSYNC waveform */
> > +			.run_count = v_total - 1,
> > +			.run_src = 4,			/* == counter 7 */
> 
> Same here, ...
> 
> > +			.cnt_polarity_gen_en = 1,
> > +			.cnt_polarity_trigger_src = 4,	/* == counter 7 */
> 
> ... and same here, the DI counter #3 polarity Clear select field lists
> the value 4 as "Reserved".
> 
> > +			.cnt_down = sig->mode.vsync_len * 2,
> > +			.cnt_clr_src = DI_SYNC_CNT1,
> >  		}, {
> [...]
> >  		}
> >  	};
> >  
> >  	ipu_di_sync_config(di, cfg, 0, ARRAY_SIZE(cfg));
> >  
> > -	/* set gentime select and tag sel */
> > -	reg = ipu_di_read(di, DI_SW_GEN1(9));
> > -	reg &= 0x1FFFFFFF;
> > -	reg |= (3 - 1) << 29 | 0x00008000;
> > -	ipu_di_write(di, reg, DI_SW_GEN1(9));
> 
> As far as I understood, attaching counter #9 to counter #3 is needed to
> generate the second vsync on i.MX5. Since this doesn't currently work,
> I'm fine with removing it for now.

I went through the counter setup to understand how it works, and it
seems correct provided you accept that the various source values do
work as the code claims, which includes creating the vsync at the
appropriate half-scanline position without needing this hack.

It's not easy to work back from the counter setup to get a mental
picture of what's going on, but it is possible to do so.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
