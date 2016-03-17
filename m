From: eric@anholt.net (Eric Anholt)
Date: Thu, 17 Mar 2016 10:10:19 -0700
Subject: [PATCH 3/8] clk: bcm2835: add missing osc and per clocks
In-Reply-To: <1456760642-2412-4-git-send-email-kernel@martin.sperl.org>
References: <1456760642-2412-1-git-send-email-kernel@martin.sperl.org>
 <1456760642-2412-4-git-send-email-kernel@martin.sperl.org>
Message-ID: <87egb99gjo.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

kernel at martin.sperl.org writes:

> From: Martin Sperl <kernel@martin.sperl.org>
>
> Add definitions for the following clocks:
> * AVE0
> * DFT
> * GP0
> * GP1
> * GP2
> * PULSE
> * SLIM
> * SMI
> * TEC
>
> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
> ---
>  drivers/clk/bcm/clk-bcm2835.c       |   71 +++++++++++++++++++++++++++++++++++
>  include/dt-bindings/clock/bcm2835.h |   10 +++++
>  2 files changed, 81 insertions(+)
>
> diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
> index 710cf15..f43e1ca 100644
> --- a/drivers/clk/bcm/clk-bcm2835.c
> +++ b/drivers/clk/bcm/clk-bcm2835.c
> @@ -118,6 +118,8 @@
>  #define CM_SDCCTL		0x1a8
>  #define CM_SDCDIV		0x1ac
>  #define CM_ARMCTL		0x1b0
> +#define CM_AVEOCTL		0x1b8
> +#define CM_AVEODIV		0x1bc
>  #define CM_EMMCCTL		0x1c0
>  #define CM_EMMCDIV		0x1c4
>  
> @@ -1738,6 +1740,18 @@ static const struct bcm2835_clk_desc clk_desc_array[] = {
>  		.div_reg = CM_TSENSDIV,
>  		.int_bits = 5,
>  		.frac_bits = 0),
> +	[BCM2835_CLOCK_PULSE]	= REGISTER_OSC_CLK(
> +		.name = "pulse",
> +		.ctl_reg = CM_PULSECTL,
> +		.div_reg = CM_PULSEDIV,
> +		.int_bits = 12,
> +		.frac_bits = 0),

As I noted in previous review, PULSE has another divider on it that you
haven't accounted for, so it would be broken if we exposed it.  I've
dropped it from the patch.

> +	[BCM2835_CLOCK_TEC]	= REGISTER_OSC_CLK(
> +		.name = "tec",
> +		.ctl_reg = CM_TECCTL,
> +		.div_reg = CM_TECDIV,
> +		.int_bits = 6,
> +		.frac_bits = 0),
>  
>  	/* clocks with vpu parent mux */
>  	[BCM2835_CLOCK_H264]	= REGISTER_VPU_CLK(
> @@ -1752,6 +1766,7 @@ static const struct bcm2835_clk_desc clk_desc_array[] = {
>  		.div_reg = CM_ISPDIV,
>  		.int_bits = 4,
>  		.frac_bits = 8),
> +
>  	/*
>  	 * Secondary SDRAM clock.  Used for low-voltage modes when the PLL
>  	 * in the SDRAM controller can't be used.
> @@ -1783,6 +1798,24 @@ static const struct bcm2835_clk_desc clk_desc_array[] = {
>  		.is_vpu_clock = true),
>  
>  	/* clocks with per parent mux */
> +	[BCM2835_CLOCK_AVEO]	= REGISTER_PER_CLK(
> +		.name = "aveo",
> +		.ctl_reg = CM_AVEOCTL,
> +		.div_reg = CM_AVEODIV,
> +		.int_bits = 4,
> +		.frac_bits = 0),
> +	[BCM2835_CLOCK_DFT]	= REGISTER_PER_CLK(
> +		.name = "dft",
> +		.ctl_reg = CM_DFTCTL,
> +		.div_reg = CM_DFTDIV,
> +		.int_bits = 5,
> +		.frac_bits = 0),
> +	[BCM2835_CLOCK_DFT]	= REGISTER_PER_CLK(
> +		.name = "dpi",
> +		.ctl_reg = CM_DPICTL,
> +		.div_reg = CM_DPIDIV,
> +		.int_bits = 4,
> +		.frac_bits = 8),
>  
>  	/* Arasan EMMC clock */
>  	[BCM2835_CLOCK_EMMC]	= REGISTER_PER_CLK(
> @@ -1791,6 +1824,30 @@ static const struct bcm2835_clk_desc clk_desc_array[] = {
>  		.div_reg = CM_EMMCDIV,
>  		.int_bits = 4,
>  		.frac_bits = 8),
> +
> +	/* General purpose (GPIO) clocks */
> +	[BCM2835_CLOCK_GP0]	= REGISTER_PER_CLK(
> +		.name = "gp0",
> +		.ctl_reg = CM_GP0CTL,
> +		.div_reg = CM_GP0DIV,
> +		.int_bits = 12,
> +		.frac_bits = 12,
> +		.is_mash_clock = true),
> +	[BCM2835_CLOCK_GP1]	= REGISTER_PER_CLK(
> +		.name = "gp1",
> +		.ctl_reg = CM_GP1CTL,
> +		.div_reg = CM_GP1DIV,
> +		.int_bits = 12,
> +		.frac_bits = 12,
> +		.is_mash_clock = true),
> +	[BCM2835_CLOCK_GP2]	= REGISTER_PER_CLK(
> +		.name = "gp2",
> +		.ctl_reg = CM_GP2CTL,
> +		.div_reg = CM_GP2DIV,
> +		.int_bits = 12,
> +		.frac_bits = 12,
> +		.is_mash_clock = true),

As I've noted previously, gp2 is not a mash clock.  I've dropped that
line.

Other than these two issues, this patch looks fine.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160317/1d636a58/attachment.sig>
