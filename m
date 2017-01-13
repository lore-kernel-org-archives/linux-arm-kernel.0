From: amelie.delaunay@st.com (Amelie DELAUNAY)
Date: Fri, 13 Jan 2017 16:56:54 +0100
Subject: [PATCH 3/3] rtc: stm32: use 32-bit cast for BIT() macro
In-Reply-To: <20170113153311.2611510-3-arnd@arndb.de>
References: <20170113153311.2611510-1-arnd@arndb.de>
 <20170113153311.2611510-3-arnd@arndb.de>
Message-ID: <26624cbe-7e71-35a4-b8df-f5ac5d15b1ec@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 01/13/2017 04:32 PM, Arnd Bergmann wrote:
> Using the ~ operator on a BIT() constant results in a large 'unsigned long'
> constant that won't fit into an 'unsigned int' function argument on 64-bit
> architectures, resulting in a harmless build warning in x86 allmodconfig:
>
> drivers/rtc/rtc-stm32.c: In function 'stm32_rtc_probe':
> drivers/rtc/rtc-stm32.c:651:51: error: large integer implicitly truncated to unsigned type [-Werror=overflow]
>   regmap_update_bits(rtc->dbp, PWR_CR, PWR_CR_DBP, ~PWR_CR_DBP);
I thought I would fix this warning by replacing all ~PWR_CR_DBP by 0, 
because the mask PWR_CR_DBP prevents other bits to be cleared.
In this way, I avoid the ugly cast...
>
> This works around the warning by adding an explict cast to 'u32', but
> that is unfortunately a bit ugly and I feel there should be a better
> way to do this, possibly with some changes to either the bitops.h
> header or the regmap API.
>
> Cc: Mark Brown <broonie@kernel.org>
> Fixes: 4e64350f42e2 ("rtc: add STM32 RTC driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/rtc/rtc-stm32.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/rtc/rtc-stm32.c b/drivers/rtc/rtc-stm32.c
> index 8c599f52124c..05d3dc89e55f 100644
> --- a/drivers/rtc/rtc-stm32.c
> +++ b/drivers/rtc/rtc-stm32.c
> @@ -92,7 +92,7 @@
>  /* STM32_PWR_CR */
>  #define PWR_CR				0x00
>  /* STM32_PWR_CR bit field */
> -#define PWR_CR_DBP			BIT(8)
> +#define PWR_CR_DBP			(u32)BIT(8)
>
>  struct stm32_rtc {
>  	struct rtc_device *rtc_dev;
>

Regards,
Amelie
