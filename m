From: fabrice.gasnier@st.com (Fabrice Gasnier)
Date: Tue, 15 Nov 2016 14:26:03 +0100
Subject: [PATCH v2 3/6] iio: adc: Add support for STM32 ADC
In-Reply-To: <535ffb14-a92f-1556-a4cb-f2be0508289a@metafoo.de>
References: <1478794738-28933-1-git-send-email-fabrice.gasnier@st.com>
 <1478794738-28933-4-git-send-email-fabrice.gasnier@st.com>
 <535ffb14-a92f-1556-a4cb-f2be0508289a@metafoo.de>
Message-ID: <954472c6-2ec8-48af-de7f-b5171eee692f@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/14/2016 01:11 PM, Lars-Peter Clausen wrote:
> On 11/10/2016 05:18 PM, Fabrice Gasnier wrote:
> [...]
>> + static int stm32_adc_single_conv(struct iio_dev *indio_dev,
>> +				 const struct iio_chan_spec *chan,
>> +				 int *res)
>> +{
>> +	struct stm32_adc *adc = iio_priv(indio_dev);
>> +	long timeout;
>> +	u32 val;
>> +	u16 result;
>> +	int ret;
>> +
>> +	reinit_completion(&adc->completion);
>> +
>> +	adc->buffer = &result;
>> +
>> +	/* Program chan number in regular sequence */
>> +	val = stm32_adc_readl(adc, STM32F4_ADCX_SQR3);
>> +	val &= ~STM32F4_SQ1_MASK;
>> +	val |= chan->channel << STM32F4_SQ1_SHIFT;
>> +	stm32_adc_writel(adc, STM32F4_ADCX_SQR3, val);
>> +
>> +	/* Set regular sequence len (0 for 1 conversion) */
>> +	stm32_adc_clr_bits(adc, STM32F4_ADCX_SQR1, STM32F4_L_MASK);
>> +
>> +	/* Trigger detection disabled (conversion can be launched in SW) */
>> +	stm32_adc_clr_bits(adc, STM32F4_ADCX_CR2, STM32F4_EXTEN_MASK);
>> +
>> +	stm32_adc_conv_irq_enable(adc);
>> +
>> +	stm32_adc_start_conv(adc);
>> +
>> +	timeout = wait_for_completion_interruptible_timeout(
>> +					&adc->completion, STM32_ADC_TIMEOUT);
>> +	if (timeout == 0) {
>> +		dev_warn(&indio_dev->dev, "Conversion timed out!\n");
> This should be dev_dbg() at most. This out of band reporting is not
> particular useful for applications as it is impossible to match the error to
> the action that triggered it. And you also report the error through the
> error code, so the applications knows what is going on.
>
>> +		ret = -ETIMEDOUT;
>> +	} else if (timeout < 0) {
>> +		dev_warn(&indio_dev->dev, "Interrupted conversion!\n");
>> +		ret = -EINTR;
> This should just propagate the error returned by wait_for_completion...().
> This will make sure that the right behavior occurs based on the SA_RESTART
> policy.
Hi Lars,

Thanks for reviewing.
I'll update this in next revision.

Regards,
Fabrice

>
>> +	} else {
>> +		*res = result;
>> +		ret = IIO_VAL_INT;
>> +	}
>> +
>> +	stm32_adc_stop_conv(adc);
>> +
>> +	stm32_adc_conv_irq_disable(adc);
>> +
>> +	return ret;
