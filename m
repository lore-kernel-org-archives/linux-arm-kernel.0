From: jic23@kernel.org (Jonathan Cameron)
Date: Sun, 28 Jan 2018 08:19:25 +0000
Subject: [PATCH] iio: adc: stm32: fix stm32h7_adc_enable error handling
In-Reply-To: <1516723497-9018-1-git-send-email-fabrice.gasnier@st.com>
References: <1516723497-9018-1-git-send-email-fabrice.gasnier@st.com>
Message-ID: <20180128081925.524a3e08@archlinux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 23 Jan 2018 17:04:56 +0100
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> Error handling in stm32h7_adc_enable routine doesn't unwind enable
> sequence correctly. ADEN can only be cleared by hardware (e.g. by
> writing one to ADDIS).
> It's also better to clear ADRDY just after it's been set by hardware.
> 
> Fixes: 95e339b6e85d ("iio: adc: stm32: add support for STM32H7")
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Applied to fixes-togreg-post-rc1 branch of iio.git and marked for
stable.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/stm32-adc.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
> index ca3b865..8177a92 100644
> --- a/drivers/iio/adc/stm32-adc.c
> +++ b/drivers/iio/adc/stm32-adc.c
> @@ -735,8 +735,6 @@ static int stm32h7_adc_enable(struct stm32_adc *adc)
>  	int ret;
>  	u32 val;
>  
> -	/* Clear ADRDY by writing one, then enable ADC */
> -	stm32_adc_set_bits(adc, STM32H7_ADC_ISR, STM32H7_ADRDY);
>  	stm32_adc_set_bits(adc, STM32H7_ADC_CR, STM32H7_ADEN);
>  
>  	/* Poll for ADRDY to be set (after adc startup time) */
> @@ -744,8 +742,11 @@ static int stm32h7_adc_enable(struct stm32_adc *adc)
>  					   val & STM32H7_ADRDY,
>  					   100, STM32_ADC_TIMEOUT_US);
>  	if (ret) {
> -		stm32_adc_clr_bits(adc, STM32H7_ADC_CR, STM32H7_ADEN);
> +		stm32_adc_set_bits(adc, STM32H7_ADC_CR, STM32H7_ADDIS);
>  		dev_err(&indio_dev->dev, "Failed to enable ADC\n");
> +	} else {
> +		/* Clear ADRDY by writing one */
> +		stm32_adc_set_bits(adc, STM32H7_ADC_ISR, STM32H7_ADRDY);
>  	}
>  
>  	return ret;
