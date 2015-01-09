From: gautamvivek1987@gmail.com (Vivek Gautam)
Date: Fri, 9 Jan 2015 17:24:07 +0530
Subject: [PATCH 2/4] clk: samsung: exynos7: add clocks for SPI block
In-Reply-To: <CAFp+6iFzawDY1wFA-2AQUHFCk54WsaCJAOkrqvX9t7b-XugY8g@mail.gmail.com>
References: <1418995427-7712-1-git-send-email-padma.v@samsung.com>
 <1418995427-7712-3-git-send-email-padma.v@samsung.com>
 <CAFp+6iFzawDY1wFA-2AQUHFCk54WsaCJAOkrqvX9t7b-XugY8g@mail.gmail.com>
Message-ID: <CAFp+6iHaJ3b9+ERygksNLcyG9PxP2yf-6BTtwFgFgcUOqX+PVg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 9, 2015 at 5:18 PM, Vivek Gautam <gautamvivek1987@gmail.com> wrote:
> Hi Padma,
>
>
> On Fri, Dec 19, 2014 at 6:53 PM, Padmavathi Venna <padma.v@samsung.com> wrote:
>> Add clock support for 5 SPI channels.
>>
>> Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
>> ---
>>  drivers/clk/samsung/clk-exynos7.c       |   73 +++++++++++++++++++++++++++++++
>>  include/dt-bindings/clock/exynos7-clk.h |   22 ++++++++-
>>  2 files changed, 93 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/clk/samsung/clk-exynos7.c b/drivers/clk/samsung/clk-exynos7.c
>> index 954f9a0..cf5e50e 100644
>> --- a/drivers/clk/samsung/clk-exynos7.c
>> +++ b/drivers/clk/samsung/clk-exynos7.c
>> @@ -166,9 +166,15 @@ CLK_OF_DECLARE(exynos7_clk_topc, "samsung,exynos7-clock-topc",
>>  #define MUX_SEL_TOP00                  0x0200
>>  #define MUX_SEL_TOP01                  0x0204
>>  #define MUX_SEL_TOP03                  0x020C
>> +#define MUX_SEL_TOP0_PERIC1            0x0234
>> +#define MUX_SEL_TOP0_PERIC2            0x0238
>>  #define MUX_SEL_TOP0_PERIC3            0x023C
>>  #define DIV_TOP03                      0x060C
>> +#define DIV_TOP0_PERIC1                        0x0634
>> +#define DIV_TOP0_PERIC2                        0x0638
>>  #define DIV_TOP0_PERIC3                        0x063C
>> +#define ENABLE_SCLK_TOP0_PERIC1                0x0A34
>> +#define ENABLE_SCLK_TOP0_PERIC2                0x0A38
>>  #define ENABLE_SCLK_TOP0_PERIC3                0x0A3C
>>
>>  /* List of parent clocks for Muxes in CMU_TOP0 */
>> @@ -194,9 +200,15 @@ static unsigned long top0_clk_regs[] __initdata = {
>>         MUX_SEL_TOP00,
>>         MUX_SEL_TOP01,
>>         MUX_SEL_TOP03,
>> +       MUX_SEL_TOP0_PERIC1,
>> +       MUX_SEL_TOP0_PERIC2,
>>         MUX_SEL_TOP0_PERIC3,
>>         DIV_TOP03,
>> +       DIV_TOP0_PERIC1,
>> +       DIV_TOP0_PERIC2,
>>         DIV_TOP0_PERIC3,
>> +       ENABLE_SCLK_TOP0_PERIC1,
>> +       ENABLE_SCLK_TOP0_PERIC2,
>>         ENABLE_SCLK_TOP0_PERIC3,
>>  };
>>
>> @@ -218,10 +230,16 @@ static struct samsung_mux_clock top0_mux_clks[] __initdata = {
>>         MUX(0, "mout_aclk_peric1_66", mout_top0_group1, MUX_SEL_TOP03, 12, 2),
>>         MUX(0, "mout_aclk_peric0_66", mout_top0_group1, MUX_SEL_TOP03, 20, 2),
>>
>> +       MUX(0, "mout_sclk_spi1", mout_top0_group1, MUX_SEL_TOP0_PERIC1, 8, 2),
>> +       MUX(0, "mout_sclk_spi0", mout_top0_group1, MUX_SEL_TOP0_PERIC1, 20, 2),
>> +
>> +       MUX(0, "mout_sclk_spi3", mout_top0_group1, MUX_SEL_TOP0_PERIC2, 8, 2),
>> +       MUX(0, "mout_sclk_spi2", mout_top0_group1, MUX_SEL_TOP0_PERIC2, 20, 2),
>>         MUX(0, "mout_sclk_uart3", mout_top0_group1, MUX_SEL_TOP0_PERIC3, 4, 2),
>>         MUX(0, "mout_sclk_uart2", mout_top0_group1, MUX_SEL_TOP0_PERIC3, 8, 2),
>>         MUX(0, "mout_sclk_uart1", mout_top0_group1, MUX_SEL_TOP0_PERIC3, 12, 2),
>>         MUX(0, "mout_sclk_uart0", mout_top0_group1, MUX_SEL_TOP0_PERIC3, 16, 2),
>> +       MUX(0, "mout_sclk_spi4", mout_top0_group1, MUX_SEL_TOP0_PERIC3, 20, 2),
>>  };
>>
>>  static struct samsung_div_clock top0_div_clks[] __initdata = {
>> @@ -230,13 +248,29 @@ static struct samsung_div_clock top0_div_clks[] __initdata = {
>>         DIV(DOUT_ACLK_PERIC0, "dout_aclk_peric0_66", "mout_aclk_peric0_66",
>>                 DIV_TOP03, 20, 6),
>>
>> +       DIV(0, "dout_sclk_spi1", "mout_sclk_spi1", DIV_TOP0_PERIC1, 8, 12),
>> +       DIV(0, "dout_sclk_spi0", "mout_sclk_spi0", DIV_TOP0_PERIC1, 20, 12),
>> +
>> +       DIV(0, "dout_sclk_spi3", "mout_sclk_spi3", DIV_TOP0_PERIC2, 8, 12),
>> +       DIV(0, "dout_sclk_spi2", "mout_sclk_spi2", DIV_TOP0_PERIC2, 20, 12),
>> +
>>         DIV(0, "dout_sclk_uart3", "mout_sclk_uart3", DIV_TOP0_PERIC3, 4, 4),
>>         DIV(0, "dout_sclk_uart2", "mout_sclk_uart2", DIV_TOP0_PERIC3, 8, 4),
>>         DIV(0, "dout_sclk_uart1", "mout_sclk_uart1", DIV_TOP0_PERIC3, 12, 4),
>>         DIV(0, "dout_sclk_uart0", "mout_sclk_uart0", DIV_TOP0_PERIC3, 16, 4),
>> +       DIV(0, "dout_sclk_spi4", "mout_sclk_spi4", DIV_TOP0_PERIC3, 20, 12),
>>  };
>>
>>  static struct samsung_gate_clock top0_gate_clks[] __initdata = {
>> +       GATE(CLK_SCLK_SPI1, "sclk_spi1", "dout_sclk_spi1",
>> +               ENABLE_SCLK_TOP0_PERIC1, 8, CLK_SET_RATE_PARENT, 0),
>> +       GATE(CLK_SCLK_SPI0, "sclk_spi0", "dout_sclk_spi0",
>> +               ENABLE_SCLK_TOP0_PERIC1, 20, CLK_SET_RATE_PARENT, 0),
>> +
>> +       GATE(CLK_SCLK_SPI3, "sclk_spi3", "dout_sclk_spi3",
>> +               ENABLE_SCLK_TOP0_PERIC2, 8, CLK_SET_RATE_PARENT, 0),
>> +       GATE(CLK_SCLK_SPI2, "sclk_spi2", "dout_sclk_spi2",
>> +               ENABLE_SCLK_TOP0_PERIC2, 20, CLK_SET_RATE_PARENT, 0),
>>         GATE(CLK_SCLK_UART3, "sclk_uart3", "dout_sclk_uart3",
>>                 ENABLE_SCLK_TOP0_PERIC3, 4, 0, 0),
>>         GATE(CLK_SCLK_UART2, "sclk_uart2", "dout_sclk_uart2",
>> @@ -245,6 +279,8 @@ static struct samsung_gate_clock top0_gate_clks[] __initdata = {
>>                 ENABLE_SCLK_TOP0_PERIC3, 12, 0, 0),
>>         GATE(CLK_SCLK_UART0, "sclk_uart0", "dout_sclk_uart0",
>>                 ENABLE_SCLK_TOP0_PERIC3, 16, 0, 0),
>> +       GATE(CLK_SCLK_SPI4, "sclk_spi4", "dout_sclk_spi4",
>> +               ENABLE_SCLK_TOP0_PERIC3, 20, CLK_SET_RATE_PARENT, 0),
>>  };
>>
>>  static struct samsung_fixed_factor_clock top0_fixed_factor_clks[] __initdata = {
>> @@ -520,6 +556,7 @@ static void __init exynos7_clk_peric0_init(struct device_node *np)
>>  /* Register Offset definitions for CMU_PERIC1 (0x14C80000) */
>>  #define MUX_SEL_PERIC10                        0x0200
>>  #define MUX_SEL_PERIC11                        0x0204
>> +#define MUX_SEL_PERIC12                        0x0208
>>  #define ENABLE_PCLK_PERIC1             0x0900
>>  #define ENABLE_SCLK_PERIC10            0x0A00
>>
>> @@ -531,10 +568,16 @@ PNAME(mout_aclk_peric1_66_p)      = { "fin_pll", "dout_aclk_peric1_66" };
>>  PNAME(mout_sclk_uart1_p)       = { "fin_pll", "sclk_uart1" };
>>  PNAME(mout_sclk_uart2_p)       = { "fin_pll", "sclk_uart2" };
>>  PNAME(mout_sclk_uart3_p)       = { "fin_pll", "sclk_uart3" };
>> +PNAME(mout_sclk_spi0_p)                = { "fin_pll", "sclk_spi0" };
>> +PNAME(mout_sclk_spi1_p)                = { "fin_pll", "sclk_spi1" };
>> +PNAME(mout_sclk_spi2_p)                = { "fin_pll", "sclk_spi2" };
>> +PNAME(mout_sclk_spi3_p)                = { "fin_pll", "sclk_spi3" };
>> +PNAME(mout_sclk_spi4_p)                = { "fin_pll", "sclk_spi4" };
>>
>>  static unsigned long peric1_clk_regs[] __initdata = {
>>         MUX_SEL_PERIC10,
>>         MUX_SEL_PERIC11,
>> +       MUX_SEL_PERIC12,
>>         ENABLE_PCLK_PERIC1,
>>         ENABLE_SCLK_PERIC10,
>>  };
>> @@ -543,6 +586,16 @@ static struct samsung_mux_clock peric1_mux_clks[] __initdata = {
>>         MUX(0, "mout_aclk_peric1_66_user", mout_aclk_peric1_66_p,
>>                 MUX_SEL_PERIC10, 0, 1),
>>
>> +       MUX_F(0, "mout_sclk_spi0_user", mout_sclk_spi0_p,
>> +               MUX_SEL_PERIC11, 0, 1, CLK_SET_RATE_PARENT, 0),
>> +       MUX_F(0, "mout_sclk_spi1_user", mout_sclk_spi1_p,
>> +               MUX_SEL_PERIC11, 4, 1, CLK_SET_RATE_PARENT, 0),
>> +       MUX_F(0, "mout_sclk_spi2_user", mout_sclk_spi2_p,
>> +               MUX_SEL_PERIC11, 8, 1, CLK_SET_RATE_PARENT, 0),
>> +       MUX_F(0, "mout_sclk_spi3_user", mout_sclk_spi3_p,
>> +               MUX_SEL_PERIC11, 12, 1, CLK_SET_RATE_PARENT, 0),
>> +       MUX_F(0, "mout_sclk_spi4_user", mout_sclk_spi4_p,
>> +               MUX_SEL_PERIC11, 16, 1, CLK_SET_RATE_PARENT, 0),
>>         MUX(0, "mout_sclk_uart1_user", mout_sclk_uart1_p,
>>                 MUX_SEL_PERIC11, 20, 1),
>>         MUX(0, "mout_sclk_uart2_user", mout_sclk_uart2_p,
>> @@ -568,6 +621,16 @@ static struct samsung_gate_clock peric1_gate_clks[] __initdata = {
>>                 ENABLE_PCLK_PERIC1, 10, 0, 0),
>>         GATE(PCLK_UART3, "pclk_uart3", "mout_aclk_peric1_66_user",
>>                 ENABLE_PCLK_PERIC1, 11, 0, 0),
>> +       GATE(PCLK_SPI0, "pclk_spi0", "mout_aclk_peric1_66_user",
>> +               ENABLE_PCLK_PERIC1, 12, 0, 0),
>> +       GATE(PCLK_SPI1, "pclk_spi1", "mout_aclk_peric1_66_user",
>> +               ENABLE_PCLK_PERIC1, 13, 0, 0),
>> +       GATE(PCLK_SPI2, "pclk_spi2", "mout_aclk_peric1_66_user",
>> +               ENABLE_PCLK_PERIC1, 14, 0, 0),
>> +       GATE(PCLK_SPI3, "pclk_spi3", "mout_aclk_peric1_66_user",
>> +               ENABLE_PCLK_PERIC1, 15, 0, 0),
>> +       GATE(PCLK_SPI4, "pclk_spi4", "mout_aclk_peric1_66_user",
>> +               ENABLE_PCLK_PERIC1, 16, 0, 0),
>>
>>         GATE(SCLK_UART1, "sclk_uart1_user", "mout_sclk_uart1_user",
>>                 ENABLE_SCLK_PERIC10, 9, 0, 0),
>> @@ -575,6 +638,16 @@ static struct samsung_gate_clock peric1_gate_clks[] __initdata = {
>>                 ENABLE_SCLK_PERIC10, 10, 0, 0),
>>         GATE(SCLK_UART3, "sclk_uart3_user", "mout_sclk_uart3_user",
>>                 ENABLE_SCLK_PERIC10, 11, 0, 0),
>> +       GATE(SCLK_SPI0, "sclk_spi0_user", "mout_sclk_spi0_user",
>> +               ENABLE_SCLK_PERIC10, 12, CLK_SET_RATE_PARENT, 0),
>> +       GATE(SCLK_SPI1, "sclk_spi1_user", "mout_sclk_spi1_user",
>> +               ENABLE_SCLK_PERIC10, 13, CLK_SET_RATE_PARENT, 0),
>> +       GATE(SCLK_SPI2, "sclk_spi2_user", "mout_sclk_spi2_user",
>> +               ENABLE_SCLK_PERIC10, 14, CLK_SET_RATE_PARENT, 0),
>> +       GATE(SCLK_SPI3, "sclk_spi3_user", "mout_sclk_spi3_user",
>> +               ENABLE_SCLK_PERIC10, 15, CLK_SET_RATE_PARENT, 0),
>> +       GATE(SCLK_SPI4, "sclk_spi4_user", "mout_sclk_spi4_user",
>> +               ENABLE_SCLK_PERIC10, 16, CLK_SET_RATE_PARENT, 0),
>>  };
>>
>>  static struct samsung_cmu_info peric1_cmu_info __initdata = {
>> diff --git a/include/dt-bindings/clock/exynos7-clk.h b/include/dt-bindings/clock/exynos7-clk.h
>> index a6c4d8e..3bba9ec 100644
>> --- a/include/dt-bindings/clock/exynos7-clk.h
>> +++ b/include/dt-bindings/clock/exynos7-clk.h
>> @@ -26,7 +26,13 @@
>>  #define CLK_SCLK_UART1                 4
>>  #define CLK_SCLK_UART2                 5
>>  #define CLK_SCLK_UART3                 6
>> -#define TOP0_NR_CLK                    7
>> +#define CLK_SCLK_SPI0                  7
>> +#define CLK_SCLK_SPI1                  8
>> +#define CLK_SCLK_SPI2                  9
>> +#define CLK_SCLK_SPI3                  10
>> +#define CLK_SCLK_SPI4                  11
>> +#define CLK_SCLK_SPI5                  12
>
> I don't see this CLK_SCLK_SPI5 being used anywhere in the patch.
> Possibly you didn't want to add it here.
>
>> +#define TOP0_NR_CLK                    13
>>
>>  /* TOP1 */
>>  #define DOUT_ACLK_FSYS1_200            1
>> @@ -70,7 +76,19 @@
>>  #define PCLK_HSI2C6                    9
>>  #define PCLK_HSI2C7                    10
>>  #define PCLK_HSI2C8                    11
>> -#define PERIC1_NR_CLK                  12
>> +#define PCLK_SPI0                      12
>> +#define PCLK_SPI1                      13
>> +#define PCLK_SPI2                      14
>> +#define PCLK_SPI3                      15
>> +#define PCLK_SPI4                      16
>> +#define PCLK_SPI5                      17
>> +#define SCLK_SPI0                      18
>> +#define SCLK_SPI1                      19
>> +#define SCLK_SPI2                      20
>> +#define SCLK_SPI3                      21
>> +#define SCLK_SPI4                      22
>> +#define SCLK_SPI5                      23
>
> Same here for SCLK_SPI5, unused in the patch.
>
> [snip]
>
> The rest all looks good in this patch. I have also verified from the Exynos7 UM.

missed it earlier. You may also want to add update documentation for
clock sources
of peric1 block.


-- 
Best Regards
Vivek Gautam
Samsung R&D Institute, Bangalore
India
