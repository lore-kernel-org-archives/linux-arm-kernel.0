From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 10 Aug 2016 09:29:10 +0100
Subject: [RESEND v2 03/10] gpio: stmpe: fix edge and rising/falling edge
 detection
In-Reply-To: <1470814755-19447-4-git-send-email-patrice.chotard@st.com>
References: <1470814755-19447-1-git-send-email-patrice.chotard@st.com>
 <1470814755-19447-4-git-send-email-patrice.chotard@st.com>
Message-ID: <20160810082910.GI1581@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 10 Aug 2016, patrice.chotard at st.com wrote:

> From: Patrice Chotard <patrice.chotard@st.com>
> 
> By cross-checking STMPE 610/801/811/1601/2401/2403 datasheets,
> it appears that edge detection and rising/falling edge detection
> is not supported by all STMPE variant:
> 
>            GPIO              GPIO
>       Edge detection     rising/falling
>                          edge detection
>  610 |      X        |         X       |
>  801 |               |                 |
>  811 |      X        |         X       |
> 1600 |               |                 |
> 1601 |      X        |         X       |
> 1801 |               |         X       |
> 2401 |      X        |         X       |
> 2403 |      X        |         X       |
> 
> Rework stmpe_dbg_show_one() and stmpe_gpio_irq to correctly
> take these cases into account.
> 
> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/gpio/gpio-stmpe.c | 85 +++++++++++++++++++++++++++++++++--------------
>  1 file changed, 60 insertions(+), 25 deletions(-)

Applied, thanks.

> diff --git a/drivers/gpio/gpio-stmpe.c b/drivers/gpio/gpio-stmpe.c
> index 5197edf..bfc918c 100644
> --- a/drivers/gpio/gpio-stmpe.c
> +++ b/drivers/gpio/gpio-stmpe.c
> @@ -231,39 +231,74 @@ static void stmpe_dbg_show_one(struct seq_file *s,
>  			   gpio, label ?: "(none)",
>  			   val ? "hi" : "lo");
>  	} else {
> -		u8 edge_det_reg = stmpe->regs[STMPE_IDX_GPEDR_MSB] + num_banks - 1 - (offset / 8);
> -		u8 rise_reg = stmpe->regs[STMPE_IDX_GPRER_LSB] - (offset / 8);
> -		u8 fall_reg = stmpe->regs[STMPE_IDX_GPFER_LSB] - (offset / 8);
> -		u8 irqen_reg = stmpe->regs[STMPE_IDX_IEGPIOR_LSB] - (offset / 8);
> -		bool edge_det;
> -		bool rise;
> -		bool fall;
> +		u8 edge_det_reg;
> +		u8 rise_reg;
> +		u8 fall_reg;
> +		u8 irqen_reg;
> +
> +		char *edge_det_values[] = {"edge-inactive",
> +					   "edge-asserted",
> +					   "not-supported"};
> +		char *rise_values[] = {"no-rising-edge-detection",
> +				       "rising-edge-detection",
> +				       "not-supported"};
> +		char *fall_values[] = {"no-falling-edge-detection",
> +				       "falling-edge-detection",
> +				       "not-supported"};
> +		#define NOT_SUPPORTED_IDX 2
> +		u8 edge_det = NOT_SUPPORTED_IDX;
> +		u8 rise = NOT_SUPPORTED_IDX;
> +		u8 fall = NOT_SUPPORTED_IDX;
>  		bool irqen;
>  
> -		ret = stmpe_reg_read(stmpe, edge_det_reg);
> -		if (ret < 0)
> -			return;
> -		edge_det = !!(ret & mask);
> -		ret = stmpe_reg_read(stmpe, rise_reg);
> -		if (ret < 0)
> +		switch (stmpe->partnum) {
> +		case STMPE610:
> +		case STMPE811:
> +		case STMPE1601:
> +		case STMPE2401:
> +		case STMPE2403:
> +			edge_det_reg = stmpe->regs[STMPE_IDX_GPEDR_MSB] +
> +				       num_banks - 1 - (offset / 8);
> +			ret = stmpe_reg_read(stmpe, edge_det_reg);
> +			if (ret < 0)
> +				return;
> +			edge_det = !!(ret & mask);
> +
> +		case STMPE1801:
> +			rise_reg = stmpe->regs[STMPE_IDX_GPRER_LSB] -
> +				   (offset / 8);
> +			fall_reg = stmpe->regs[STMPE_IDX_GPFER_LSB] -
> +				   (offset / 8);
> +			ret = stmpe_reg_read(stmpe, rise_reg);
> +			if (ret < 0)
> +				return;
> +			rise = !!(ret & mask);
> +			ret = stmpe_reg_read(stmpe, fall_reg);
> +			if (ret < 0)
> +				return;
> +			fall = !!(ret & mask);
> +
> +		case STMPE801:
> +			irqen_reg = stmpe->regs[STMPE_IDX_IEGPIOR_LSB] -
> +				    (offset / 8);
> +			break;
> +
> +		default:
>  			return;
> -		rise = !!(ret & mask);
> -		ret = stmpe_reg_read(stmpe, fall_reg);
> -		if (ret < 0)
> -			return;
> -		fall = !!(ret & mask);
> +		}
> +
>  		ret = stmpe_reg_read(stmpe, irqen_reg);
>  		if (ret < 0)
>  			return;
>  		irqen = !!(ret & mask);
>  
> -		seq_printf(s, " gpio-%-3d (%-20.20s) in  %s %s %s%s%s",
> +		seq_printf(s, " gpio-%-3d (%-20.20s) in  %s %13s %13s %25s %25s",
>  			   gpio, label ?: "(none)",
>  			   val ? "hi" : "lo",
> -			   edge_det ? "edge-asserted" : "edge-inactive",
> -			   irqen ? "IRQ-enabled" : "",
> -			   rise ? " rising-edge-detection" : "",
> -			   fall ? " falling-edge-detection" : "");
> +			   edge_det_values[edge_det],
> +			   irqen ? "IRQ-enabled" : "IRQ-disabled",
> +			   rise_values[rise],
> +			   fall_values[fall]);
>  	}
>  }
>  
> @@ -322,8 +357,8 @@ static irqreturn_t stmpe_gpio_irq(int irq, void *dev)
>  
>  		stmpe_reg_write(stmpe, statmsbreg + i, status[i]);
>  
> -		/* Edge detect register is not present on 801 */
> -		if (stmpe->partnum != STMPE801)
> +		/* Edge detect register is not present on 801 and 1801 */
> +		if (stmpe->partnum != STMPE801 || stmpe->partnum != STMPE1801)
>  			stmpe_reg_write(stmpe, stmpe->regs[STMPE_IDX_GPEDR_MSB]
>  					+ i, status[i]);
>  	}

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
