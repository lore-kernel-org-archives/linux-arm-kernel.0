From: john.stultz@linaro.org (John Stultz)
Date: Wed, 23 Mar 2011 14:46:25 -0700
Subject: [PATCH V12 4/4] ptp: Added a clock driver for the National
	Semiconductor PHYTER.
In-Reply-To: <f8af215ebe32a8c0f4b3a82b8ee7e8008b4feb1e.1298878618.git.richard.cochran@omicron.at>
References: <cover.1298878618.git.richard.cochran@omicron.at>
	<f8af215ebe32a8c0f4b3a82b8ee7e8008b4feb1e.1298878618.git.richard.cochran@omicron.at>
Message-ID: <1300916785.848.54.camel@work-vm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-02-28 at 08:58 +0100, Richard Cochran wrote:
> This patch adds support for the PTP clock found on the DP83640.
> The basic clock operations and one external time stamp have
> been implemented.

Just locking rule comment nits here.

> +static int tdr_write(int bc, struct phy_device *dev,
> +		     const struct timespec *ts, u16 cmd)
> +{
> +	ext_write(bc, dev, PAGE4, PTP_TDR, ts->tv_nsec & 0xffff);/* ns[15:0]  */
> +	ext_write(bc, dev, PAGE4, PTP_TDR, ts->tv_nsec >> 16);   /* ns[31:16] */
> +	ext_write(bc, dev, PAGE4, PTP_TDR, ts->tv_sec & 0xffff); /* sec[15:0] */
> +	ext_write(bc, dev, PAGE4, PTP_TDR, ts->tv_sec >> 16);    /* sec[31:16]*/
> +
> +	ext_write(bc, dev, PAGE4, PTP_CTL, cmd);
> +
> +	return 0;
> +}

The above needs to hold the extreg_lock, and should be commented as
such.

And again, the function names are sort of generic, and could use a
dp83640_ prefix or something.

thanks
-john
