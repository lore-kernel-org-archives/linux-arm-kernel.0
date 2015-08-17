From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Mon, 17 Aug 2015 08:59:38 +0530
Subject: [1/4] clk: samsung: exynos3250: Add UART2 clock
In-Reply-To: <1439264784-30322-2-git-send-email-cw00.choi@samsung.com>
References: <1439264784-30322-2-git-send-email-cw00.choi@samsung.com>
Message-ID: <55D15522.7080603@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chanwoo,

Thanks for this patch. Similar patch[1] was posted long back, and there 
were some concern from your side, if you think those concerns are fixed, 
then my patch [1] are still valid and can be taken. If it needs to be 
rebase I am happy to do that.

[1] 
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-September/291239.html


Thanks,
Pankaj Dubey
On Tuesday 11 August 2015 09:16 AM, Chanwoo Choi wrote:
> This patch add the UART2 clocks (mux, divider, gate) of Exynos3250 SoC.
>
> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>
> ---
> drivers/clk/samsung/clk-exynos3250.c   | 6 ++++++
>   include/dt-bindings/clock/exynos3250.h | 6 +++++-
>   2 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/clk/samsung/clk-exynos3250.c b/drivers/clk/samsung/clk-exynos3250.c
> index 538de66a759e..2105863a3ace 100644
> --- a/drivers/clk/samsung/clk-exynos3250.c
> +++ b/drivers/clk/samsung/clk-exynos3250.c
> @@ -307,6 +307,7 @@ static struct samsung_mux_clock mux_clks[] __initdata = {
>   	MUX(CLK_MOUT_MMC0, "mout_mmc0", group_sclk_p, SRC_FSYS, 0, 4),
>
>   	/* SRC_PERIL0 */
> +	MUX(CLK_MOUT_UART2, "mout_uart2", group_sclk_p, SRC_PERIL0, 8, 4),
>   	MUX(CLK_MOUT_UART1, "mout_uart1", group_sclk_p, SRC_PERIL0, 4, 4),
>   	MUX(CLK_MOUT_UART0, "mout_uart0", group_sclk_p, SRC_PERIL0, 0, 4),
>
> @@ -389,6 +390,7 @@ static struct samsung_div_clock div_clks[] __initdata = {
>   	DIV(CLK_DIV_MMC0, "div_mmc0", "mout_mmc0", DIV_FSYS1, 0, 4),
>
>   	/* DIV_PERIL0 */
> +	DIV(CLK_DIV_UART2, "div_uart2", "mout_uart2", DIV_PERIL0, 8, 4),
>   	DIV(CLK_DIV_UART1, "div_uart1", "mout_uart1", DIV_PERIL0, 4, 4),
>   	DIV(CLK_DIV_UART0, "div_uart0", "mout_uart0", DIV_PERIL0, 0, 4),
>
> @@ -551,6 +553,9 @@ static struct samsung_gate_clock gate_clks[] __initdata = {
>   		GATE_SCLK_PERIL, 7, CLK_SET_RATE_PARENT, 0),
>   	GATE(CLK_SCLK_SPI0, "sclk_spi0", "div_spi0_pre",
>   		GATE_SCLK_PERIL, 6, CLK_SET_RATE_PARENT, 0),
> +
> +	GATE(CLK_SCLK_UART2, "sclk_uart2", "div_uart2",
> +		GATE_SCLK_PERIL, 2, CLK_SET_RATE_PARENT, 0),
>   	GATE(CLK_SCLK_UART1, "sclk_uart1", "div_uart1",
>   		GATE_SCLK_PERIL, 1, CLK_SET_RATE_PARENT, 0),
>   	GATE(CLK_SCLK_UART0, "sclk_uart0", "div_uart0",
> @@ -648,6 +653,7 @@ static struct samsung_gate_clock gate_clks[] __initdata = {
>   	GATE(CLK_I2C2, "i2c2", "div_aclk_100", GATE_IP_PERIL, 8, 0, 0),
>   	GATE(CLK_I2C1, "i2c1", "div_aclk_100", GATE_IP_PERIL, 7, 0, 0),
>   	GATE(CLK_I2C0, "i2c0", "div_aclk_100", GATE_IP_PERIL, 6, 0, 0),
> +	GATE(CLK_UART2, "uart2", "div_aclk_100", GATE_IP_PERIL, 2, 0, 0),
>   	GATE(CLK_UART1, "uart1", "div_aclk_100", GATE_IP_PERIL, 1, 0, 0),
>   	GATE(CLK_UART0, "uart0", "div_aclk_100", GATE_IP_PERIL, 0, 0, 0),
>   };
> diff --git a/include/dt-bindings/clock/exynos3250.h b/include/dt-bindings/clock/exynos3250.h
> index aab088d30199..89a7d97b002c 100644
> --- a/include/dt-bindings/clock/exynos3250.h
> +++ b/include/dt-bindings/clock/exynos3250.h
> @@ -78,6 +78,7 @@
>   #define CLK_MOUT_CORE			58
>   #define CLK_MOUT_APLL			59
>   #define CLK_MOUT_ACLK_266_SUB		60
> +#define CLK_MOUT_UART2			61
>
>   /* Dividers */
>   #define CLK_DIV_GPL			64
> @@ -126,6 +127,7 @@
>   #define CLK_DIV_CORE			107
>   #define CLK_DIV_HPM			108
>   #define CLK_DIV_COPY			109
> +#define CLK_DIV_UART2			110
>
>   /* Gates */
>   #define CLK_ASYNC_G3D			128
> @@ -222,6 +224,7 @@
>   #define CLK_BLOCK_MFC			219
>   #define CLK_BLOCK_CAM			220
>   #define CLK_SMIES			221
> +#define CLK_UART2			222
>
>   /* Special clocks */
>   #define CLK_SCLK_JPEG			224
> @@ -248,12 +251,13 @@
>   #define CLK_SCLK_SPI0			245
>   #define CLK_SCLK_UART1			246
>   #define CLK_SCLK_UART0			247
> +#define CLK_SCLK_UART2			248
>
>   /*
>    * Total number of clocks of main CMU.
>    * NOTE: Must be equal to last clock ID increased by one.
>    */
> -#define CLK_NR_CLKS			248
> +#define CLK_NR_CLKS			249
>
>   /*
>    * CMU DMC
>
