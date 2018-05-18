From: rdunlap@infradead.org (Randy Dunlap)
Date: Fri, 18 May 2018 09:56:24 -0700
Subject: [PATCH 1/2] mfd: stm32-timers: fix pwm-stm32 linker issue with
 COMPILE_TEST
In-Reply-To: <1526657044-14879-2-git-send-email-fabrice.gasnier@st.com>
References: <1526657044-14879-1-git-send-email-fabrice.gasnier@st.com>
 <1526657044-14879-2-git-send-email-fabrice.gasnier@st.com>
Message-ID: <0f03fe4b-0b5f-92f1-2929-c6c585432159@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/18/2018 08:24 AM, Fabrice Gasnier wrote:
> This is seen when COMPILE_TEST=y and MFD_STM32_TIMERS=n.
> drivers/pwm/pwm-stm32.o: In function 'stm32_pwm_raw_capture':
> pwm-stm32.c:... undefined reference to 'stm32_timers_dma_burst_read'
> Fixes: 0c6609805b63 ("mfd: stm32-timers: Add support for DMAs")
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  include/linux/mfd/stm32-timers.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/include/linux/mfd/stm32-timers.h b/include/linux/mfd/stm32-timers.h
> index 9da1d7e..067d146 100644
> --- a/include/linux/mfd/stm32-timers.h
> +++ b/include/linux/mfd/stm32-timers.h
> @@ -124,8 +124,20 @@ struct stm32_timers {
>  	struct stm32_timers_dma dma; /* Only to be used by the parent */
>  };
>  
> +#if IS_REACHABLE(CONFIG_MFD_STM32_TIMERS)
>  int stm32_timers_dma_burst_read(struct device *dev, u32 *buf,
>  				enum stm32_timers_dmas id, u32 reg,
>  				unsigned int num_reg, unsigned int bursts,
>  				unsigned long tmo_ms);
> +#else
> +static inline int stm32_timers_dma_burst_read(struct device *dev, u32 *buf,
> +					      enum stm32_timers_dmas id,
> +					      u32 reg,
> +					      unsigned int num_reg,
> +					      unsigned int bursts,
> +					      unsigned long tmo_ms)
> +{
> +	return -ENODEV;
> +}
> +#endif
>  #endif
> 


-- 
~Randy
