From: avinashphilip@ti.com (Philip, Avinash)
Date: Thu, 28 Feb 2013 06:05:02 +0000
Subject: [PATCH 04/14] ARM: OMAP2+: Add function for configuring GPMC
 settings
In-Reply-To: <1361899842-30303-5-git-send-email-jon-hunter@ti.com>
References: <1361899842-30303-1-git-send-email-jon-hunter@ti.com>
 <1361899842-30303-5-git-send-email-jon-hunter@ti.com>
Message-ID: <518397C60809E147AF5323E0420B992E3EA8F007@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 26, 2013 at 23:00:31, Hunter, Jon wrote:
> The GPMC has various different configuration options such as bus-width,
> synchronous or asychronous mode selection, burst mode options etc.
> Currently, there is no common function for configuring these options and
> various devices set these options by either programming the GPMC CONFIG1
> register directly or by calling gpmc_cs_configure() to set some of the
> options.
> 
> Add a new function for configuring all of the GPMC options. Having a common
> function for configuring this options will simplify code and ease the
> migration to device-tree.
> 
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> ---
>  arch/arm/mach-omap2/gpmc.c |   65 ++++++++++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/gpmc.h |    6 ++++
>  2 files changed, 71 insertions(+)
> 
> diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
> index 465cac9..fb8dfd2 100644
> --- a/arch/arm/mach-omap2/gpmc.c
> +++ b/arch/arm/mach-omap2/gpmc.c
> @@ -1137,6 +1137,71 @@ int gpmc_calc_timings(struct gpmc_timings *gpmc_t,
>  	return 0;
>  }
>  
> +int gpmc_cs_program_settings(int cs, struct gpmc_settings *p)
> +{
> +	u32 config1;
> +
> +	if ((!p->device_width) || (p->device_width > GPMC_DEVWIDTH_16BIT)) {
> +		pr_err("%s: invalid width %d!", __func__, p->device_width);
> +		return -EINVAL;
> +	}
> +
> +	/* Address-data multiplexing not supported for NAND devices */
> +	if (p->device_nand && p->mux_add_data) {
> +		pr_err("%s: invalid configuration!\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	/* Page/burst mode supports lengths of 4, 8 and 16 bytes */
> +	if (p->burst_read || p->burst_write) {
> +		switch (p->burst_len) {
> +		case GPMC_BURST_4:
> +		case GPMC_BURST_8:
> +		case GPMC_BURST_16:
> +			break;
> +		default:
> +			pr_err("%s: invalid page/burst-length (%d)\n",
> +			       __func__, p->burst_len);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	if ((p->wait_on_read || p->wait_on_write) &&
> +	    (p->wait_pin > gpmc_nr_waitpins)) {
> +		pr_err("%s: invalid wait-pin (%d)\n", __func__, p->wait_pin);
> +		return -EINVAL;
> +	}
> +
> +	config1 = GPMC_CONFIG1_DEVICESIZE((p->device_width - 1));

Can you consider read_modify approach?
Thanks
Avinash 
