From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 1 Jul 2010 16:01:40 +0100
Subject: [PATCH 3/3] ASoC: DaVinci: Added fast clock timing for McBSP (I2S)
In-Reply-To: <1277905678-4695-4-git-send-email-lamiaposta71@gmail.com>
References: <1277905678-4695-1-git-send-email-lamiaposta71@gmail.com>
	<1277905678-4695-4-git-send-email-lamiaposta71@gmail.com>
Message-ID: <20100701150140.GE8742@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 30, 2010 at 03:47:58PM +0200, Raffaele Recalcati wrote:

> +	/*
> +	 * This define works when both clock and FS are output for the cpu
> +	 * and makes clock very fast (FS is not symmetrical, but sampling
> +	 * frequency is better approximated
> +	 */
> +	bool i2s_fast_clock;

I'm having a hard time following the description here - which clock is
being made very fast?  The output clocks, which are the ones people can
observe, will presumably not suddenly start running very fast.

It's probably better to rename this option to reflect the actual
function (trading off between frequency accuracy and mark/space ratio)
rather than the way it's implemented internally.

> -		srgr |= DAVINCI_MCBSP_SRGR_FPER(mcbsp_word_length *
> -						16 - 1);
> +		if (dev->i2s_fast_clock) {
> +			clk_div = 256;
> +			do {
> +				framesize = (freq / (--clk_div)) /
> +					    params->rate_num *
> +					    params->rate_den;
> +			} while (((framesize < 33) || (framesize > 4095)) &&
> +				 (clk_div));
> +			clk_div--;
> +			srgr |= DAVINCI_MCBSP_SRGR_FPER(framesize - 1);
> +		} else {
> +			/* symmetric waveforms */
> +			clk_div = freq / (mcbsp_word_length * 16) /
> +				  params->rate_num * params->rate_den;
> +			srgr |= DAVINCI_MCBSP_SRGR_FPER(mcbsp_word_length *
> +							16 - 1);
> +		}

Hrm.  This doesn't really correspond to your commit message at all.
Your commit message makes it sound like you've changed something about
the clocking setup of the device, such as adding another clock source,
but what you've actually done here is change the method used to
calculate the divider.

I'm *guessing* that the actual effect of your change is that you will
normally end up selecting a very much higher bit clock than would
otherwise be the case.  It strikes me that there must be a better
algorithm for the calculation - for example, working up from the minimum
clock rate - which will give the same results as we currently have where
the driver is already generating accurate rates.
