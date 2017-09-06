From: fabrice.gasnier@st.com (Fabrice Gasnier)
Date: Wed, 6 Sep 2017 18:16:33 +0200
Subject: [PATCH] iio: stm32: fix adc/trigger link error
In-Reply-To: <20170906125722.2522781-1-arnd@arndb.de>
References: <20170906125722.2522781-1-arnd@arndb.de>
Message-ID: <50ec54e0-85f7-8c32-475c-9b27a4e6ebd3@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/06/2017 02:56 PM, Arnd Bergmann wrote:
> The ADC driver can trigger on either the timer or the lptim
> trigger, but it only uses a Kconfig 'select' statement
> to ensure that the first of the two is present. When the lptim
> trigger is enabled as a loadable module, and the adc driver
> is built-in, we now get a link error:
> 
> drivers/iio/adc/stm32-adc.o: In function `stm32_adc_get_trig_extsel':
> stm32-adc.c:(.text+0x4e0): undefined reference to `is_stm32_lptim_trigger'
> 
> We could use a second 'select' statement and always have both
> trigger drivers enabled when the adc driver is, but it seems that
> the lptimer trigger was intentionally left optional, so it seems
> better to keep it that way.
Hi Arnd,

This is correct, not all stm32 have this hardware.
> 
> This adds a hack to use 'IS_REACHABLE()' rather than 'IS_ENABLED()',
> which avoids the link error, but instead leads to the lptimer trigger
> not being used in the broken configuration. I've added a runtime
> warning for this case to help users figure out what they did wrong
> if this should ever be done by accident.
> 
> Fixes: f0b638a7f6db ("iio: adc: stm32: add support for lptimer triggers")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Tested-by: Fabrice Gasnier <fabrice.gasnier@st.com>

Many thanks for the fix,
Best Regards,
Fabrice
> ---
>  include/linux/iio/timer/stm32-lptim-trigger.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/iio/timer/stm32-lptim-trigger.h b/include/linux/iio/timer/stm32-lptim-trigger.h
> index 34d59bfdce2d..464458d20b16 100644
> --- a/include/linux/iio/timer/stm32-lptim-trigger.h
> +++ b/include/linux/iio/timer/stm32-lptim-trigger.h
> @@ -16,11 +16,14 @@
>  #define LPTIM2_OUT	"lptim2_out"
>  #define LPTIM3_OUT	"lptim3_out"
>  
> -#if IS_ENABLED(CONFIG_IIO_STM32_LPTIMER_TRIGGER)
> +#if IS_REACHABLE(CONFIG_IIO_STM32_LPTIMER_TRIGGER)
>  bool is_stm32_lptim_trigger(struct iio_trigger *trig);
>  #else
>  static inline bool is_stm32_lptim_trigger(struct iio_trigger *trig)
>  {
> +#if IS_ENABLED(CONFIG_IIO_STM32_LPTIMER_TRIGGER)
> +	pr_warn_once("stm32 lptim_trigger not linked in\n");
> +#endif
>  	return false;
>  }
>  #endif
> 
