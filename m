From: eric@anholt.net (Eric Anholt)
Date: Mon, 01 Feb 2016 17:51:17 -0800
Subject: [PATCH V4 5/7] clk: bcm2835: add missing 22 HW-clocks.
In-Reply-To: <1452867667-2447-6-git-send-email-kernel@martin.sperl.org>
References: <1452867667-2447-1-git-send-email-kernel@martin.sperl.org>
 <1452867667-2447-6-git-send-email-kernel@martin.sperl.org>
Message-ID: <87h9hr517u.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

kernel at martin.sperl.org writes:

> From: Martin Sperl <kernel@martin.sperl.org>
>
> There were 22 HW clocks missing from the clock driver.
>
> These have been included and int_bits and frac_bits
> have been set correctly based on information extracted
> from the broadcom videocore headers
> (http://www.broadcom.com/docs/support/videocore/Brcm_Android_ICS_Graphics_Stack.tar.gz)
>
> For an extracted view of the registers please see:
> https://github.com/msperl/rpi-registers/blob/master/md/Region_CM.md
>
> bcm2835_clock_per_parents has been assigned as the parent
> clock for all new clocks, but this may not be correct
> in all cases - documentation on this is not publicly
> available, so some modifications may be needed in the
> future.

We need the parents to be correct if we're going to land the patch.
I'll try to update them.

I'm not a fan of this "let's just shove everything we can find in some
header file into the .c and hope for the best."  Most of these clocks
were left out intentionally.

> There are a 3 more clocks that possibly could get implemented
> as gates instead of clocks:
>
>
> There are comments to indicate those.
>
> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
> ---
>  drivers/clk/bcm/clk-bcm2835.c       |  260 ++++++++++++++++++++++++++++++++++-
>  include/dt-bindings/clock/bcm2835.h |   22 +++
>  2 files changed, 276 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
> index 8bc0a76..1640288 100644
> --- a/drivers/clk/bcm/clk-bcm2835.c
> +++ b/drivers/clk/bcm/clk-bcm2835.c
> @@ -92,8 +92,18 @@
>  #define CM_PCMDIV		0x09c
>  #define CM_PWMCTL		0x0a0
>  #define CM_PWMDIV		0x0a4
> +#define CM_SLIMCTL		0x0a8
> +#define CM_SLIMDIV		0x0ac
>  #define CM_SMICTL		0x0b0
>  #define CM_SMIDIV		0x0b4
> +#define CM_TCNTCTL		0x0c0
> +#define CM_TCNTDIV		0x0c4
> +#define CM_TECCTL		0x0c8
> +#define CM_TECDIV		0x0cc
> +#define CM_TD0CTL		0x0d0
> +#define CM_TD0DIV		0x0d4
> +#define CM_TD1CTL		0x0d8
> +#define CM_TD1DIV		0x0dc
>  #define CM_TSENSCTL		0x0e0
>  #define CM_TSENSDIV		0x0e4
>  #define CM_TIMERCTL		0x0e8
> @@ -107,6 +117,9 @@
>  #define CM_SDCCTL		0x1a8
>  #define CM_SDCDIV		0x1ac
>  #define CM_ARMCTL		0x1b0
> +#define CM_ARMDIV		0x1b4
> +#define CM_AVEOCTL		0x1b8
> +#define CM_AVEODIV		0x1bc
>  #define CM_EMMCCTL		0x1c0
>  #define CM_EMMCDIV		0x1c4
>
> @@ -829,6 +842,219 @@ static const struct bcm2835_clock_data bcm2835_clock_pcm_data = {
>  	.frac_bits = 12,
>  };
>
> +static const struct bcm2835_clock_data bcm2835_clock_aveo_data = {
> +	.name = "aveo",
> +	.num_mux_parents = ARRAY_SIZE(bcm2835_clock_per_parents),
> +	.parents = bcm2835_clock_per_parents,
> +	.ctl_reg = CM_AVEOCTL,
> +	.div_reg = CM_AVEODIV,
> +	.int_bits = 4,
> +	.frac_bits = 12,
> +};

AVEO has 0 fractional bits

> +static const struct bcm2835_clock_data bcm2835_clock_ccp2_data = {
> +	/* this is possibly a gate */
> +	.name = "ccp2",
> +	.num_mux_parents = ARRAY_SIZE(bcm2835_clock_per_parents),
> +	.parents = bcm2835_clock_per_parents,
> +	.ctl_reg = CM_CCP2CTL,
> +	.div_reg = CM_CCP2DIV,
> +	.int_bits = 1,
> +	.frac_bits = 0,
> +};

CCP2 is a gate from a different clock source, so this won't work.

> +static const struct bcm2835_clock_data bcm2835_clock_dsi0p_data = {
> +	/* this is possibly a gate */
> +	.name = "dsi0p",
> +	.num_mux_parents = ARRAY_SIZE(bcm2835_clock_per_parents),
> +	.parents = bcm2835_clock_per_parents,
> +	.ctl_reg = CM_DSI0PCTL,
> +	.div_reg = CM_DSI0PDIV,
> +	.int_bits = 1,
> +	.frac_bits = 0,
> +};
> +
> +static const struct bcm2835_clock_data bcm2835_clock_dsi1p_data = {
> +	/* this is possibly a gate */
> +	.name = "dsi1p",
> +	.num_mux_parents = ARRAY_SIZE(bcm2835_clock_per_parents),
> +	.parents = bcm2835_clock_per_parents,
> +	.ctl_reg = CM_DSI1PCTL,
> +	.div_reg = CM_DSI1PDIV,
> +	.int_bits = 1,
> +	.frac_bits = 0,
> +};

DSI0/1 pixel clocks take different clock sources and are gates off of
them, so these definitions don't work.

> +
> +static const struct bcm2835_clock_data bcm2835_clock_gnric_data = {
> +	.name = "gnric",
> +	.num_mux_parents = ARRAY_SIZE(bcm2835_clock_per_parents),
> +	.parents = bcm2835_clock_per_parents,
> +	.ctl_reg = CM_GNRICCTL,
> +	.div_reg = CM_GNRICDIV,
> +	.int_bits = 12,
> +	.frac_bits = 12,
> +};

GNRIC isn't an actual clock, it's just what's used for describing the
overall structure of clocks.

> +static const struct bcm2835_clock_data bcm2835_clock_peria_data = {
> +	.name = "peria",
> +	.num_mux_parents = ARRAY_SIZE(bcm2835_clock_per_parents),
> +	.parents = bcm2835_clock_per_parents,
> +	.ctl_reg = CM_PERIACTL,
> +	.div_reg = CM_PERIADIV,
> +	.int_bits = 12,
> +	.frac_bits = 12,
> +};

This register doesn't do anything, because the debug bit in the power
manager is not set.  We don't think we should expose a clock gate if it
doesn't work, I think.

> +static const struct bcm2835_clock_data bcm2835_clock_pulse_data = {
> +	.name = "pulse",
> +	.num_mux_parents = ARRAY_SIZE(bcm2835_clock_per_parents),
> +	.parents = bcm2835_clock_per_parents,
> +	.ctl_reg = CM_PULSECTL,
> +	.div_reg = CM_PULSEDIV,
> +	.int_bits = 12,
> +	.frac_bits = 0,
> +};

There's some other divider involved in this clock, won't give correct results.

> +static const struct bcm2835_clock_data bcm2835_clock_td0_data = {
> +	.name = "td0",
> +	.num_mux_parents = ARRAY_SIZE(bcm2835_clock_per_parents),
> +	.parents = bcm2835_clock_per_parents,
> +	.ctl_reg = CM_TD0CTL,
> +	.div_reg = CM_TD0DIV,
> +	.int_bits = 12,
> +	.frac_bits = 12,
> +};
> +
> +static const struct bcm2835_clock_data bcm2835_clock_td1_data = {
> +	.name = "td1",
> +	.num_mux_parents = ARRAY_SIZE(bcm2835_clock_per_parents),
> +	.parents = bcm2835_clock_per_parents,
> +	.ctl_reg = CM_TD1CTL,
> +	.div_reg = CM_TD1DIV,
> +	.int_bits = 12,
> +	.frac_bits = 12,
> +};

These are some other clock generator, not the generic or mash ones used
elsewhere.  I wouldn't enable them without testing.

> +static const struct bcm2835_clock_data bcm2835_clock_tec_data = {
> +	.name = "tec",
> +	.num_mux_parents = ARRAY_SIZE(bcm2835_clock_per_parents),
> +	.parents = bcm2835_clock_per_parents,
> +	.ctl_reg = CM_TECCTL,
> +	.div_reg = CM_TECDIV,
> +	.int_bits = 6,
> +	.frac_bits = 0,
> +};

TEC should be osc parents.

> -/*
> - * CM_PERIICTL (and CM_PERIACTL, CM_SYSCTL and CM_VPUCTL if
> - * you have the debug bit set in the power manager, which we
> - * don't bother exposing) are individual gates off of the
> - * non-stop vpu clock.
> - */
>  static const struct bcm2835_gate_data bcm2835_clock_peri_image_data = {
>  	.name = "peri_image",
>  	.parent = "vpu",
>  	.ctl_reg = CM_PERIICTL,
>  };
>
> +static const struct bcm2835_gate_data bcm2835_clock_sys_data = {
> +	.name = "sys",
> +	.parent = "vpu",
> +	.ctl_reg = CM_SYSCTL,
> +};

same concern as peria.

> +
>  struct bcm2835_pll {
>  	struct clk_hw hw;
>  	struct bcm2835_cprman *cprman;
> @@ -1591,9 +1817,31 @@ static const struct bcm2835_clk_desc clk_desc_array[] = {
>  	[BCM2835_CLOCK_EMMC]	= REGISTER_CLK(&bcm2835_clock_emmc_data),
>  	[BCM2835_CLOCK_PWM]	= REGISTER_CLK(&bcm2835_clock_pwm_data),
>  	[BCM2835_CLOCK_PCM]	= REGISTER_CLK(&bcm2835_clock_pcm_data),
> +	[BCM2835_CLOCK_AVEO]	= REGISTER_CLK(&bcm2835_clock_aveo_data),
> +	[BCM2835_CLOCK_CAM0]	= REGISTER_CLK(&bcm2835_clock_cam0_data),
> +	[BCM2835_CLOCK_CAM1]	= REGISTER_CLK(&bcm2835_clock_cam1_data),
> +	[BCM2835_CLOCK_CCP2]	= REGISTER_CLK(&bcm2835_clock_ccp2_data),
> +	[BCM2835_CLOCK_DFT]	= REGISTER_CLK(&bcm2835_clock_dft_data),
> +	[BCM2835_CLOCK_DPI]	= REGISTER_CLK(&bcm2835_clock_dpi_data),
> +	[BCM2835_CLOCK_DSI0E]	= REGISTER_CLK(&bcm2835_clock_dsi0e_data),
> +	[BCM2835_CLOCK_DSI0P]	= REGISTER_CLK(&bcm2835_clock_dsi0p_data),
> +	[BCM2835_CLOCK_DSI1E]	= REGISTER_CLK(&bcm2835_clock_dsi1e_data),
> +	[BCM2835_CLOCK_DSI1P]	= REGISTER_CLK(&bcm2835_clock_dsi1p_data),
> +	[BCM2835_CLOCK_GNRIC]	= REGISTER_CLK(&bcm2835_clock_gnric_data),
> +	[BCM2835_CLOCK_GP0]	= REGISTER_CLK(&bcm2835_clock_gp0_data),
> +	[BCM2835_CLOCK_GP1]	= REGISTER_CLK(&bcm2835_clock_gp1_data),
> +	[BCM2835_CLOCK_GP2]	= REGISTER_CLK(&bcm2835_clock_gp2_data),
> +	[BCM2835_CLOCK_PERIA]	= REGISTER_CLK(&bcm2835_clock_peria_data),
> +	[BCM2835_CLOCK_PULSE]	= REGISTER_CLK(&bcm2835_clock_pulse_data),
> +	[BCM2835_CLOCK_SLIM]	= REGISTER_CLK(&bcm2835_clock_slim_data),
> +	[BCM2835_CLOCK_SMI]	= REGISTER_CLK(&bcm2835_clock_smi_data),
> +	[BCM2835_CLOCK_TD0]	= REGISTER_CLK(&bcm2835_clock_td0_data),
> +	[BCM2835_CLOCK_TD1]	= REGISTER_CLK(&bcm2835_clock_td1_data),
> +	[BCM2835_CLOCK_TEC]	= REGISTER_CLK(&bcm2835_clock_tec_data),
>  	/* the gates */
>  	[BCM2835_CLOCK_PERI_IMAGE] = REGISTER_GATE(
>  		&bcm2835_clock_peri_image_data),
> +	[BCM2835_CLOCK_SYS]	= REGISTER_GATE(&bcm2835_clock_sys_data),
>  };
>
>  static int bcm2835_clk_probe(struct platform_device *pdev)
> diff --git a/include/dt-bindings/clock/bcm2835.h b/include/dt-bindings/clock/bcm2835.h
> index 9a7b4a5..d29f181 100644
> --- a/include/dt-bindings/clock/bcm2835.h
> +++ b/include/dt-bindings/clock/bcm2835.h
> @@ -45,3 +45,25 @@
>  #define BCM2835_CLOCK_PERI_IMAGE	29
>  #define BCM2835_CLOCK_PWM		30
>  #define BCM2835_CLOCK_PCM		31
> +#define BCM2835_CLOCK_AVEO		32
> +#define BCM2835_CLOCK_CAM0		33
> +#define BCM2835_CLOCK_CAM1		34
> +#define BCM2835_CLOCK_CCP2		35
> +#define BCM2835_CLOCK_DFT		36
> +#define BCM2835_CLOCK_DPI		37
> +#define BCM2835_CLOCK_DSI0E		38
> +#define BCM2835_CLOCK_DSI0P		39
> +#define BCM2835_CLOCK_DSI1E		40
> +#define BCM2835_CLOCK_DSI1P		41
> +#define BCM2835_CLOCK_GNRIC		42
> +#define BCM2835_CLOCK_GP0		43
> +#define BCM2835_CLOCK_GP1		44
> +#define BCM2835_CLOCK_GP2		45
> +#define BCM2835_CLOCK_PERIA		46
> +#define BCM2835_CLOCK_PULSE		47
> +#define BCM2835_CLOCK_SLIM		48
> +#define BCM2835_CLOCK_SMI		49
> +#define BCM2835_CLOCK_SYS		50
> +#define BCM2835_CLOCK_TD0		51
> +#define BCM2835_CLOCK_TD1		52
> +#define BCM2835_CLOCK_TEC		53
> --
> 1.7.10.4
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160201/f5d1a9ff/attachment-0001.sig>
