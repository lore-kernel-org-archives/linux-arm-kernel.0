From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Mon, 28 Jun 2010 12:11:13 -0700
Subject: [PATCH] ASoC: DaVinci: Added support for cpu clocking I2S
In-Reply-To: <1277707487-3371-1-git-send-email-lamiaposta71@gmail.com>
References: <1277707487-3371-1-git-send-email-lamiaposta71@gmail.com>
Message-ID: <4C28F3D1.5060806@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Raffaele Recalcati wrote:
> +		if (dev->i2s_fast_clock) {
> +			clk_div = 256;
can you have
   f = (freq / params->rate_num) * params->rate_den;
> +			do {
> +				framesize = (freq / (--clk_div)) /
> +					    params->rate_num *
> +					    params->rate_den;
and
				framesize = f / (--clk_div);
> +			} while (((framesize < 33) || (framesize > 4095)) &&
> +				 (clk_div));
> +			clk_div--;
looks like clk_div can go negative here, should the above while say (clk_div > 1)
> +			srgr |= DAVINCI_MCBSP_SRGR_FPER(framesize - 1);
> +		} else {
> +			/* symmetric waveforms */
> +			clk_div = freq / (mcbsp_word_length * 16) /
> +				  params->rate_num * params->rate_den;
> +			srgr |= DAVINCI_MCBSP_SRGR_FPER(mcbsp_word_length *
> +							16 - 1);
> +		}
> +		clk_div &= 0xFF;
> +		srgr |= clk_div;
