From: john@metanate.com (John Keeping)
Date: Mon, 23 Jan 2017 12:49:25 +0000
Subject: [PATCH v2 19/26] drm/rockchip: dw-mipi-dsi: improve PLL
 configuration
In-Reply-To: <58855EAE.2010704@rock-chips.com>
References: <20170121163128.22240-1-john@metanate.com>
 <20170121163128.22240-20-john@metanate.com>
 <58855EAE.2010704@rock-chips.com>
Message-ID: <20170123124925.4fa10fc2.john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris,

On Mon, 23 Jan 2017 09:38:54 +0800, Chris Zhong wrote:
> On 01/22/2017 12:31 AM, John Keeping wrote:
> > The multiplication ratio for the PLL is required to be even due to the
> > use of a "by 2 pre-scaler".  Currently we are likely to end up with an
> > odd multiplier even though there is an equivalent set of parameters with
> > an even multiplier.
> >
> > For example, using the 324MHz bit rate with a reference clock of 24MHz
> > we end up with M = 27, N = 2 whereas the example in the PHY databook
> > gives M = 54, N = 4 for this bit rate and reference clock.
> >
> > By walking down through the available multiplier instead of up we are
> > more likely to hit an even multiplier.  With the above example we do now
> > get M = 54, N = 4 as given by the databook.
> >
> > While doing this, change the loop limits to encode the actual limits on
> > the divisor, which are:
> >
> > 	40MHz >= (pllref / N) >= 5MHz  
> 
> This formula is limit for N, but we still can not guarantee to get an 
> even M.
> Do you think we should do a check for M.
> such as:
> if (m % 2)
>      continue;
> ...
>      for (i = pllref / 5; i > (pllref / 40); i--) {
>          pre = pllref / i;
>          if ((tmp > (target_mbps % pre)) && (target_mbps / pre < 512)) {
>              tmp = target_mbps % pre;
>              n = i;
>              m = target_mbps / pre;
>              if (m % 2)
>                  continue;
>          }
>          if (tmp == 0)
>              break;
>      }
> 
> if (m % 2)
>      m++;
> 
>      dsi->lane_mbps = pllref / n * m;
>      dsi->input_div = n;
>      dsi->feedback_div = m;

Yes, I agree that there should be a check for M, but I'm not sure if
the version above is sufficient.  The "m % 2" check inside the loop
means that we don't break immediately when tmp=0 but then we are
guaranteed to break next time without having modified n, m because now
tmp=0 so "tmp > (target_mbps % pre)" is always false and we just hit the
"if (tmp == 0) break" case next time.

Given that the descending loop already means that if we can hit "tmp"
exactly we are more likely to do so with a bigger N and even M, I think
it might be better to just fix M after the loop like:

	if (m % 2) {
		if (m < 256 && (n * 2) <= (pllref / 5)) {
			n *= 2;
			m *= 2;
		} else {
			m++;
		}
	}

but I haven't thought about this too carefully.

For this series, I'd rather either keep this patch as it is or drop it
in favour of a more comprehensive solution.  I don't want to block the
other fixes waiting for a perfect fix here and we can always improve
this further with a follow-up patch.

> > Signed-off-by: John Keeping <john@metanate.com>
> > ---
> > Unchanged in v2
> > ---
> >   drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
> > index 12432e41971b..f2320cf1366c 100644
> > --- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
> > +++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
> > @@ -519,7 +519,7 @@ static int dw_mipi_dsi_get_lane_bps(struct dw_mipi_dsi *dsi,
> >   	pllref = DIV_ROUND_UP(clk_get_rate(dsi->pllref_clk), USEC_PER_SEC);
> >   	tmp = pllref;
> >   
> > -	for (i = 1; i < 6; i++) {
> > +	for (i = pllref / 5; i > (pllref / 40); i--) {
> >   		pre = pllref / i;
> >   		if ((tmp > (target_mbps % pre)) && (target_mbps / pre < 512)) {
> >   			tmp = target_mbps % pre;  
> 
> 
