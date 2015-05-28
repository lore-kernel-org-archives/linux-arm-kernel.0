From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 28 May 2015 14:45:55 +0200
Subject: [PATCH] drm: atmel_hlcdc: Add support for get_timings
In-Reply-To: <1432811608.3228.43.camel@pengutronix.de>
References: <1432199216-1139-1-git-send-email-davidcdueck@googlemail.com>
 <20150526112853.688d26b7@bbrezillon>
 <1432811608.3228.43.camel@pengutronix.de>
Message-ID: <20150528144555.13cd755a@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philip,

On Thu, 28 May 2015 13:13:28 +0200
Philipp Zabel <p.zabel@pengutronix.de> wrote:

> Hi Boris,
> 
> Am Dienstag, den 26.05.2015, 11:28 +0200 schrieb Boris Brezillon:
> > Hi David,
> > 
> > On Thu, 21 May 2015 11:06:56 +0200
> > David Dueck <davidcdueck@googlemail.com> wrote:
> > 
> > > drm_panel supports querying timing ranges. If the supplied mode does
> > > not work with the hlcdc we query the panel and try to find a suitable
> > > mode.
> > 
> > This patch looks good to me.
> > 
> > Philip, Thierry, could you confirm this is the correct way of dealing
> > with timing ranges.
> 
> I wonder about two things:
> 
> This implementation minimizes the sum of absolute differences between
> chosen and typical values. I wonder if it would be better to try and
> minimize the difference between the chosen and nominal vertical refresh
> rate.

I'm not sure to understand what you mean.
Are you suggesting that we should try keeping the vtotal (and maybe the
htotal too) value unchanged by adapting the timing values ?
Something like that:

	vfront_porch = atmel_hlcdc_choose_parameter(1, 0x40,
						    timings->vfront_porch);
	
	adjusted_mode->vsync_start = adjusted_mode->vdisplay + vfront_porch;

	vsync_len = atmel_hlcdc_choose_parameter(1, 0x40,
						 adjusted_mode->vsync_end -
						 adjusted_mode->vsync_start);
	adjusted_mode->vsync_end = adjusted_mode->vsync_start + vsync_len;
	vback_porch = atmel_hlcdc_choose_parameter(0, 0x40,
						   timings->vtotal -
						   adjusted_mode->vsync_end);
	adjusted_mode->vtotal = adjusted_mode->vsync_end + vback_porch;
	/* ... */

If that's the case, then I definitely agree.

> 
> Is this something that should be done earlier, in create_panel_output,
> so that the connector's modes already contain the corrected settings?

You mean creating our own drm_display modes (and taking the timing
constraints when creating those modes) instead of calling drm_panel's
->get_modes().
That sounds reasonable. David, what's your opinion.

Best Regards,

Boris


-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
