From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 04 Jul 2016 11:40:15 +0200
Subject: [PATCH v3 1/2] clk: exynos5433: do not use CLK_IGNORE_UNUSED for
 SPI clocks
In-Reply-To: <1467270911-10971-2-git-send-email-andi.shyti@samsung.com>
References: <1467270911-10971-1-git-send-email-andi.shyti@samsung.com>
 <1467270911-10971-2-git-send-email-andi.shyti@samsung.com>
Message-ID: <577A2EFF.2010306@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/30/2016 09:15 AM, Andi Shyti wrote:
> The CLK_IGNORE_UNUSED flag has to be avoided whenever possible.

In general I would rather disagree.

> Use the CLK_IS_CRITICAL flag instead for critical SPI1 clocks,
> which enables the clock line during boot time.
> 
> Suggested-by: Tomasz Figa <tomasz.figa@gmail.com>
> Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
> ---
>  drivers/clk/samsung/clk-exynos5433.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/samsung/clk-exynos5433.c b/drivers/clk/samsung/clk-exynos5433.c
> index c3a5318..1f7c4951 100644
> --- a/drivers/clk/samsung/clk-exynos5433.c
> +++ b/drivers/clk/samsung/clk-exynos5433.c
> @@ -1662,7 +1662,7 @@ static struct samsung_gate_clock peric_gate_clks[] __initdata = {

> @@ -1677,7 +1677,7 @@ static struct samsung_gate_clock peric_gate_clks[] __initdata = {
>  	GATE(CLK_SCLK_SPI2, "sclk_spi2", "sclk_spi2_peric", ENABLE_SCLK_PERIC,
>  			5, CLK_SET_RATE_PARENT, 0),
>  	GATE(CLK_SCLK_SPI1, "sclk_spi1", "sclk_spi1_peric", ENABLE_SCLK_PERIC,
> -			4, CLK_IGNORE_UNUSED | CLK_SET_RATE_PARENT, 0),
> +			4, CLK_IS_CRITICAL | CLK_SET_RATE_PARENT, 0),

As Tomasz pointed out, this should be addressed in the driver/dts,
we shouldn't be patching board configurations into a per-SoC driver.
Other boards may want to keep this clock disabled.

What is an exact problem here, are you perhaps testing suspend to RAM?
I tested my sound support patches on top of v4.7-rc1 and everything
seemed to work well, I didn't notice any issues with the audio codec
which was the only slave on the SPI 1 bus.

Doesn't it help when you specify CLK_SCLK_SPI1 as the second clock
("spi_busclk0") of the spi_1 bus controller instead of
CLK_SCLK_SPI0_PERIC? CLK_SCLK_SPI0_PERIC seem to be parent of
CLK_SCLK_SPI1 so the enable state would be propagated.
