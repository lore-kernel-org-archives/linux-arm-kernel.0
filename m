From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 12 Mar 2014 12:03:24 +0100
Subject: [PATCH] clk: exynos4: Add clock ID for ppmuleft/right
In-Reply-To: <1394608090-25362-1-git-send-email-cw00.choi@samsung.com>
References: <1394608090-25362-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <53203EFC.1020109@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chanwoo,

On 12/03/14 08:08, Chanwoo Choi wrote:
> There is no gate for the PPMU Left/Right to the LEFT/RIGHTBUS block.
> So, this patch add ppmuleft/right clock which is used to calculate memory bus
> utilization by using PPMU(Performance Profiling Monitoring Unit).
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/clk/samsung/clk-exynos4.c   |  2 ++
>  include/dt-bindings/clock/exynos4.h | 26 ++++++++++++++------------
>  2 files changed, 16 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-exynos4.c
> index 010f071..3819485 100644
> --- a/drivers/clk/samsung/clk-exynos4.c
> +++ b/drivers/clk/samsung/clk-exynos4.c
> @@ -717,6 +717,8 @@ static struct samsung_gate_clock exynos4_gate_clks[] __initdata = {
>  			0, 0),
>  	GATE(CLK_AC97, "ac97", "aclk100", GATE_IP_PERIL, 27,
>  			0, 0),
> +	GATE(CLK_PPMULEFT, "ppmuleft", "aclk200", GATE_IP_LEFTBUS, 1, 0, 0),
> +	GATE(CLK_PPMURIGHT, "ppmuright", "aclk200", GATE_IP_RIGHTBUS, 1, 0, 0),
>  };
>  
>  /* list of gate clocks supported in exynos4210 soc */
> diff --git a/include/dt-bindings/clock/exynos4.h b/include/dt-bindings/clock/exynos4.h
> index 75aff33..cd7fecf 100644
> --- a/include/dt-bindings/clock/exynos4.h
> +++ b/include/dt-bindings/clock/exynos4.h
> @@ -215,20 +215,22 @@
>  #define CLK_SPI1_ISP_SCLK	381 /* Exynos4x12 only */
>  #define CLK_UART_ISP_SCLK	382 /* Exynos4x12 only */
>  #define CLK_TMU_APBIF		383
> +#define CLK_PPMULEFT		384
> +#define CLK_PPMURIGHT		385
>  
>  /* mux clocks */
> -#define CLK_MOUT_FIMC0		384

You must not change the existing clock indices like this, use indexes
that are currently unused for CLK_PPMU* clocks.
If you do that the kernel would stop working with existing dtbs.
This interface is an ABI, so you can't just rearrange the indices
at will like this.

--
Regards,
Sylwester
