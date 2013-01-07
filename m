From: grinberg@compulab.co.il (Igor Grinberg)
Date: Mon, 07 Jan 2013 11:31:51 +0200
Subject: [PATCH 2/4] ALSA: pxa27x: fix ac97 warm reset bug work-around code
In-Reply-To: <1357499640-13871-3-git-send-email-mikedunn@newsguy.com>
References: <1357499640-13871-1-git-send-email-mikedunn@newsguy.com>
 <1357499640-13871-3-git-send-email-mikedunn@newsguy.com>
Message-ID: <50EA9607.7050408@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/06/13 21:13, Mike Dunn wrote:
> This patch fixes some code that implements a work-around to a hardware bug in
> the ac97 controller on the pxa27x.  A bug in the controller's warm reset
> functionality requires that the mfp used by the controller as the AC97_nRESET
> line be temporarily reconfigured as a generic output gpio (AF0) and manually
> held high for the duration of the warm reset cycle.  This is what was done in
> the original code, but it was broken long ago by commit
> fb1bf8cd13bfa7ed0364ab0d82f717fc020d35f6 
> ([ARM] pxa: introduce processor specific pxa27x_assert_ac97reset())
> which changed the mfp to a GPIO input instead of a high output.
> 
> Tested on a palm treo 680 machine.  Reportedly, this broken code only prevents a
> warm reset on hardware that lacks a pull-up on the line, which appears to be the
> case for me.
> 
> Signed-off-by: Mike Dunn <mikedunn@newsguy.com>
> ---
> 
> An earlier version of this patch failed to drive the output high as intended.
> Thanks again Igor!  Warm reset now works and need not be skipped.
> 
>  arch/arm/mach-pxa/include/mach/mfp-pxa27x.h |    3 +++
>  arch/arm/mach-pxa/pxa27x.c                  |   13 +++++++++++--
>  2 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-pxa/include/mach/mfp-pxa27x.h b/arch/arm/mach-pxa/include/mach/mfp-pxa27x.h
> index a611ad3..8281e17 100644
> --- a/arch/arm/mach-pxa/include/mach/mfp-pxa27x.h
> +++ b/arch/arm/mach-pxa/include/mach/mfp-pxa27x.h
> @@ -463,6 +463,9 @@
>  	GPIO76_LCD_PCLK,	\
>  	GPIO77_LCD_BIAS
>  
> +/* these enable a work-around for a hw bug in pxa27x during ac97 warm reset */
> +#define GPIO113_AC97_nRESET_GPIO_HIGH MFP_CFG_OUT(GPIO113, AF0, DRIVE_HIGH)
> +#define GPIO95_AC97_nRESET_GPIO_HIGH MFP_CFG_OUT(GPIO95, AF0, DRIVE_HIGH)

Do we really need to change the LPM? Because DRIVE_* only affect LPM.

>  
>  extern int keypad_set_wake(unsigned int on);
>  #endif /* __ASM_ARCH_MFP_PXA27X_H */
> diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
> index 8047ee0..eea90fe 100644
> --- a/arch/arm/mach-pxa/pxa27x.c
> +++ b/arch/arm/mach-pxa/pxa27x.c
> @@ -47,14 +47,23 @@ void pxa27x_clear_otgph(void)
>  EXPORT_SYMBOL(pxa27x_clear_otgph);
>  
>  static unsigned long ac97_reset_config[] = {
> -	GPIO113_GPIO,
> +	GPIO113_AC97_nRESET_GPIO_HIGH,
>  	GPIO113_AC97_nRESET,
> -	GPIO95_GPIO,
> +	GPIO95_AC97_nRESET_GPIO_HIGH,
>  	GPIO95_AC97_nRESET,
>  };
>  
>  void pxa27x_assert_ac97reset(int reset_gpio, int on)
>  {
> +	/* set direction and level before switching from ac97 alt fn to gpio */
> +	if (on) {
> +		int ret = gpio_direction_output(reset_gpio, 1);
> +		if (ret) {
> +			pr_err("%s: gpio_direction_output failed: %d\n",
> +				__func__, ret);
> +			return;
> +		}
> +	}

Same concern, as you raised in reply to my patch.
As pxa2xx_mfp_config() changes GPDR for input,
the above should be done after the MFP AF0 switch.

>  	if (reset_gpio == 113)
>  		pxa2xx_mfp_config(on ? &ac97_reset_config[0] :
>  				       &ac97_reset_config[1], 1);

-- 
Regards,
Igor.
