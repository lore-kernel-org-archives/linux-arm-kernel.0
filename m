From: richardcochran@gmail.com (Richard Cochran)
Date: Fri, 2 Nov 2012 10:19:03 +0100
Subject: [PATCH 4/4] FEC: Add time stamping code and a PTP hardware clock
In-Reply-To: <1351657531-25989-1-git-send-email-Frank.Li@freescale.com>
References: <1351657531-25989-1-git-send-email-Frank.Li@freescale.com>
Message-ID: <20121102091902.GA3437@netboy.at.omicron.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 31, 2012 at 12:25:31PM +0800, Frank Li wrote:

> diff --git a/drivers/net/ethernet/freescale/Kconfig b/drivers/net/ethernet/freescale/Kconfig
> index feff516..ff3be53 100644
> --- a/drivers/net/ethernet/freescale/Kconfig
> +++ b/drivers/net/ethernet/freescale/Kconfig
> @@ -92,4 +92,13 @@ config GIANFAR
>  	  This driver supports the Gigabit TSEC on the MPC83xx, MPC85xx,
>  	  and MPC86xx family of chips, and the FEC on the 8540.
>  
> +config FEC_PTP
> +	bool "PTP Hardware Clock (PHC)"
> +	depends on FEC
> +	select PPS
> +	select PTP_1588_CLOCK
> +	--help---
> +	  Say Y here if you want to use PTP Hardware Clock (PHC) in the
> +	  driver.  Only the basic clock operations have been implemented.
> +

Does the PTP function work with every FEC on ColdFire and i.MX?

Or do you need to limit this option in some way?

>  endif # NET_VENDOR_FREESCALE

...

> diff --git a/drivers/net/ethernet/freescale/fec_ptp.c b/drivers/net/ethernet/freescale/fec_ptp.c
> new file mode 100644
> index 0000000..9b91da9
> --- /dev/null
> +++ b/drivers/net/ethernet/freescale/fec_ptp.c

...

> +/**
> + * fec_ptp_adjfreq - adjust ptp cycle frequency
> + * @ptp: the ptp clock structure
> + * @ppb: parts per billion adjustment from base
> + *
> + * Adjust the frequency of the ptp cycle counter by the
> + * indicated ppb from the base frequency.
> + *
> + * Because ENET hardware frequency adjust is complex,
> + * using software method to do that.
> + */
> +static int fec_ptp_adjfreq(struct ptp_clock_info *ptp, s32 ppb)
> +{
> +	u64 diff;
> +	unsigned long flags;
> +	int neg_adj = 0;
> +
> +	struct fec_enet_private *fep =
> +	    container_of(ptp, struct fec_enet_private, ptp_caps);
> +
> +	if (ppb < 0) {
> +		ppb = -ppb;
> +		neg_adj = 1;
> +	}
> +
> +	spin_lock_irqsave(&fep->tmreg_lock, flags);
> +	/*
> +	 * dummy read to set cycle_last in tc to now.
> +	 * So use adjusted mult to calculate when next call
> +	 * timercounter_read.
> +	 */
> +	timecounter_read(&fep->tc);

You can reduce the time that the spin lock is held by moving the next
four lines before the locked region:

> +	fep->cc.mult = FEC_CC_MULT;
> +	diff = fep->cc.mult;
> +	diff *= ppb;
> +	diff = div_u64(diff, 1000000000ULL);

> +
> +	if (neg_adj)
> +		fep->cc.mult -= diff;
> +	else
> +		fep->cc.mult += diff;
> +
> +	spin_unlock_irqrestore(&fep->tmreg_lock, flags);
> +
> +	return 0;
> +}

Thanks,
Richard
