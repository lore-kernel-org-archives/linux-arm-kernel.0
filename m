From: ricardo.neri@ti.com (Ricardo Neri)
Date: Wed, 8 Aug 2012 17:12:58 -0500
Subject: [alsa-devel] [PATCH 07/11] ASoC: omap-mcbsp: Sidetone: Use SIDLE
 bits in SYSCONFIG register to select noidle mode
In-Reply-To: <1344417101-5015-8-git-send-email-peter.ujfalusi@ti.com>
References: <1344417101-5015-1-git-send-email-peter.ujfalusi@ti.com>
 <1344417101-5015-8-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <5022E46A.4010909@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/08/2012 04:11 AM, Peter Ujfalusi wrote:
> Instead of the callback (which modifies control module register) use the
> McBSP module's SYSCONFIG register to disable smart-idle mode when the
> sidetone is enabled.
> Store the original SIDLEMODE configuration and restore it when the sidetone
> has been disabled.

Is this another case in which it is required to change the idle-mode on 
a per-use-case basis? In the past I was trying to do the same with HDMI 
[1]. In that case it was decided to add the HWMOD_SWSUP_SIDLE to hwmod 
data with the drawback of using no-idle/force-idle rather than 
smart-idle[2][3].

[1] http://www.mail-archive.com/linux-omap at vger.kernel.org/msg60226.html
[2] http://www.mail-archive.com/linux-omap at vger.kernel.org/msg70463.html
[3] http://www.mail-archive.com/linux-omap at vger.kernel.org/msg70653.html
>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>   sound/soc/omap/mcbsp.c |   18 ++++++++++++++----
>   sound/soc/omap/mcbsp.h |    1 +
>   2 files changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/sound/soc/omap/mcbsp.c b/sound/soc/omap/mcbsp.c
> index c870023..e008898 100644
> --- a/sound/soc/omap/mcbsp.c
> +++ b/sound/soc/omap/mcbsp.c
> @@ -257,8 +257,15 @@ static void omap_st_on(struct omap_mcbsp *mcbsp)
>   {
>   	unsigned int w;
>
> -	if (mcbsp->pdata->enable_st_clock)
> -		mcbsp->pdata->enable_st_clock(mcbsp->id, 1);
> +	/*
> +	 * Sidetone uses McBSP ICLK - which must not idle when sidetones
> +	 * are enabled or sidetones start sounding ugly.
> +	 */
> +	w = MCBSP_READ(mcbsp, SYSCON);
> +	mcbsp->st_data->mcbsp_sidle = (w >> 3) & 0x3;
> +	w &= ~SIDLEMODE(0x3);
> +	w |= SIDLEMODE(0x1);
> +	MCBSP_WRITE(mcbsp, SYSCON, w);

Wouldn't this create a mismatch between the SYSCONFIG register and McBSP 
omap_hwmod._sysc_cache? Perhaps this could be done with a future 
omap_hwmod API?

Ricardo
>
>   	/* Enable McBSP Sidetone */
>   	w = MCBSP_READ(mcbsp, SSELCR);
> @@ -279,8 +286,11 @@ static void omap_st_off(struct omap_mcbsp *mcbsp)
>   	w = MCBSP_READ(mcbsp, SSELCR);
>   	MCBSP_WRITE(mcbsp, SSELCR, w & ~(SIDETONEEN));
>
> -	if (mcbsp->pdata->enable_st_clock)
> -		mcbsp->pdata->enable_st_clock(mcbsp->id, 0);
> +	/* Restore the SIDLEMODE as it was before the ST has been started */
> +	w = MCBSP_READ(mcbsp, SYSCON);
> +	w &= ~SIDLEMODE(0x3);
> +	w |= SIDLEMODE(mcbsp->st_data->mcbsp_sidle);
> +	MCBSP_WRITE(mcbsp, SYSCON, w);
>   }
>
>   static void omap_st_fir_write(struct omap_mcbsp *mcbsp, s16 *fir)
> diff --git a/sound/soc/omap/mcbsp.h b/sound/soc/omap/mcbsp.h
> index 49a6725..ba82846 100644
> --- a/sound/soc/omap/mcbsp.h
> +++ b/sound/soc/omap/mcbsp.h
> @@ -280,6 +280,7 @@ struct omap_mcbsp_st_data {
>   	int nr_taps;	/* Number of filter coefficients in use */
>   	s16 ch0gain;
>   	s16 ch1gain;
> +	unsigned int mcbsp_sidle;
>   };
>
>   struct omap_mcbsp {
>
