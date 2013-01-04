From: grinberg@compulab.co.il (Igor Grinberg)
Date: Fri, 04 Jan 2013 08:50:21 +0200
Subject: [PATCH v2] ARM: pxa27x: fix ac97 controller warm reset code
In-Reply-To: <1357223976-9097-1-git-send-email-mikedunn@newsguy.com>
References: <1357223976-9097-1-git-send-email-mikedunn@newsguy.com>
Message-ID: <50E67BAD.7070702@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/03/13 16:39, Mike Dunn wrote:
> Change log:
> v2: Heed Igor's admonishment to define a macro instead of using MFP_CFG_OUT
>     directly.  Thanks.

Usually, the change log is not useful after applying the patch, so
it should go below the scissors line ("---").

> 
> This patch fixes some code that implements a work-around to a hardware bug in
> the ac97 controller on the pxa27x.  A bug in the controller's warm reset
> functionality requires that the mfp used by the controller as the AC97_RESET_n
> line be temporarily reconfigured as a generic output gpio (AF0) and manually
> held high for the duration of the warm reset cycle.  This is what was done in
> the original code, but it was broken long ago by commit
> fb1bf8cd13bfa7ed0364ab0d82f717fc020d35f6 
> ([ARM] pxa: introduce processor specific pxa27x_assert_ac97reset())
> which changed the mfp to a GPIO input instead of a high output.
> 
> Signed-off-by: Mike Dunn <mikedunn@newsguy.com>

Thanks!

Acked-by: Igor Grinberg <grinberg@compulab.co.il>

> ---
>  arch/arm/mach-pxa/include/mach/mfp-pxa27x.h |    3 +++
>  arch/arm/mach-pxa/pxa27x.c                  |    4 ++--
>  2 files changed, 5 insertions(+), 2 deletions(-)
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
>  
>  extern int keypad_set_wake(unsigned int on);
>  #endif /* __ASM_ARCH_MFP_PXA27X_H */
> diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
> index 8047ee0..616cb87 100644
> --- a/arch/arm/mach-pxa/pxa27x.c
> +++ b/arch/arm/mach-pxa/pxa27x.c
> @@ -47,9 +47,9 @@ void pxa27x_clear_otgph(void)
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

-- 
Regards,
Igor.
