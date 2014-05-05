From: shaik.samsung@gmail.com (Shaik Ameer Basha)
Date: Mon, 5 May 2014 09:44:45 +0530
Subject: [PATCH v3 02/16] clk: exynos5420: add clocks for ISP block
In-Reply-To: <5362BDA2.6060503@gmail.com>
References: <1398344632-18623-1-git-send-email-shaik.ameer@samsung.com>
 <1398344632-18623-3-git-send-email-shaik.ameer@samsung.com>
 <5362BDA2.6060503@gmail.com>
Message-ID: <CAOD6ATpE-3ZH-zZv3Ba=R4mqi+QGVKPKbEw+rS9psP9S3NkOhA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,


On Fri, May 2, 2014 at 3:03 AM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> On 24.04.2014 15:03, Shaik Ameer Basha wrote:
>>
>> This patch adds missing clocks for ISP block
>>
>> Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
>> Signed-off-by: Shaik Ameer Basha <shaik.ameer@samsung.com>
>> ---
>>   drivers/clk/samsung/clk-exynos5420.c |   80
>> ++++++++++++++++++++++++++++++++++
>>   1 file changed, 80 insertions(+)
>>
>> diff --git a/drivers/clk/samsung/clk-exynos5420.c
>> b/drivers/clk/samsung/clk-exynos5420.c
>> index 389d4b1..972da5d 100755
>> --- a/drivers/clk/samsung/clk-exynos5420.c
>> +++ b/drivers/clk/samsung/clk-exynos5420.c
>> @@ -57,6 +57,7 @@
>>   #define SRC_FSYS              0x10244
>>   #define SRC_PERIC0            0x10250
>>   #define SRC_PERIC1            0x10254
>> +#define SRC_ISP                        0x10270
>>   #define SRC_TOP10             0x10280
>>   #define SRC_TOP11             0x10284
>>   #define SRC_TOP12             0x10288
>> @@ -77,12 +78,15 @@
>>   #define DIV_PERIC2            0x10560
>>   #define DIV_PERIC3            0x10564
>>   #define DIV_PERIC4            0x10568
>> +#define SCLK_DIV_ISP0          0x10580
>> +#define SCLK_DIV_ISP1          0x10584
>>   #define GATE_BUS_TOP          0x10700
>>   #define GATE_BUS_FSYS0                0x10740
>>   #define GATE_BUS_PERIC                0x10750
>>   #define GATE_BUS_PERIC1               0x10754
>>   #define GATE_BUS_PERIS0               0x10760
>>   #define GATE_BUS_PERIS1               0x10764
>> +#define GATE_TOP_SCLK_ISP      0x10870
>>   #define GATE_IP_GSCL0         0x10910
>>   #define GATE_IP_GSCL1         0x10920
>>   #define GATE_IP_MFC           0x1092c
>> @@ -145,6 +149,7 @@ static unsigned long exynos5420_clk_regs[] __initdata
>> = {
>>         SRC_MASK_FSYS,
>>         SRC_MASK_PERIC0,
>>         SRC_MASK_PERIC1,
>> +       SRC_ISP,
>>         DIV_TOP0,
>>         DIV_TOP1,
>>         DIV_TOP2,
>> @@ -158,12 +163,15 @@ static unsigned long exynos5420_clk_regs[]
>> __initdata = {
>>         DIV_PERIC2,
>>         DIV_PERIC3,
>>         DIV_PERIC4,
>> +       SCLK_DIV_ISP0,
>> +       SCLK_DIV_ISP1,
>>         GATE_BUS_TOP,
>>         GATE_BUS_FSYS0,
>>         GATE_BUS_PERIC,
>>         GATE_BUS_PERIC1,
>>         GATE_BUS_PERIS0,
>>         GATE_BUS_PERIS1,
>> +       GATE_TOP_SCLK_ISP,
>>         GATE_IP_GSCL0,
>>         GATE_IP_GSCL1,
>>         GATE_IP_MFC,
>> @@ -250,6 +258,15 @@ PNAME(mout_user_aclk200_fsys_p)    = {"fin_pll",
>> "mout_sw_aclk200_fsys"};
>>
>>   PNAME(mout_sw_aclk200_fsys2_p) = {"dout_aclk200_fsys2",
>> "mout_sclk_spll"};
>>   PNAME(mout_user_aclk200_fsys2_p) = {"fin_pll", "mout_sw_aclk200_fsys2"};
>> +PNAME(mout_sw_aclk400_isp_p) = {"dout_aclk400_isp", "mout_sclk_spll"};
>> +PNAME(mout_user_aclk400_isp_p) = {"fin_pll", "mout_sw_aclk400_isp"};
>> +
>> +PNAME(mout_sw_aclk333_432_isp0_p) = {"dout_aclk333_432_isp0",
>> +                                       "mout_sclk_spll"};
>> +PNAME(mout_user_aclk333_432_isp0_p) = {"fin_pll",
>> "mout_sw_aclk333_432_isp0"};
>> +
>> +PNAME(mout_sw_aclk333_432_isp_p) = {"dout_aclk333_432_isp",
>> "mout_sclk_spll"};
>> +PNAME(mout_user_aclk333_432_isp_p) = {"fin_pll",
>> "mout_sw_aclk333_432_isp"};
>>
>>   PNAME(mout_sw_aclk200_p) = {"dout_aclk200", "mout_sclk_spll"};
>>   PNAME(mout_aclk200_disp1_p) = {"fin_pll", "mout_sw_aclk200"};
>> @@ -265,6 +282,7 @@ PNAME(mout_user_aclk166_p) = {"fin_pll",
>> "mout_sw_aclk166"};
>>
>>   PNAME(mout_sw_aclk266_p) = {"dout_aclk266", "mout_sclk_spll"};
>>   PNAME(mout_user_aclk266_p) = {"fin_pll", "mout_sw_aclk266"};
>> +PNAME(mout_user_aclk266_isp_p) = {"fin_pll", "mout_sw_aclk266"};
>>
>>   PNAME(mout_sw_aclk333_432_gscl_p) = {"dout_aclk333_432_gscl",
>> "mout_sclk_spll"};
>>   PNAME(mout_user_aclk333_432_gscl_p) = {"fin_pll",
>> "mout_sw_aclk333_432_gscl"};
>> @@ -448,6 +466,31 @@ static struct samsung_mux_clock exynos5420_mux_clks[]
>> __initdata = {
>>         MUX(0, "mout_spi0", mout_group2_p, SRC_PERIC1, 20, 3),
>>         MUX(0, "mout_spi1", mout_group2_p, SRC_PERIC1, 24, 3),
>>         MUX(0, "mout_spi2", mout_group2_p, SRC_PERIC1, 28, 3),
>> +       MUX(0, "mout_aclk400_isp", mout_group1_p, SRC_TOP0, 0, 2),
>> +       MUX(0, "mout_sw_aclk400_isp", mout_sw_aclk400_isp_p,
>> +               SRC_TOP10, 0, 1),
>> +       MUX(0, "mout_user_aclk400_isp", mout_user_aclk400_isp_p,
>> +               SRC_TOP3, 0, 1),
>> +       MUX(0, "mout_aclk333_432_isp0", mout_group4_p, SRC_TOP1, 12, 2),
>> +       MUX(0, "mout_sw_aclk333_432_isp0", mout_sw_aclk333_432_isp0_p,
>> +               SRC_TOP11, 12, 1),
>> +       MUX(0, "mout_user_aclk333_432_isp0", mout_user_aclk333_432_isp0_p,
>> +               SRC_TOP4, 12, 1),
>> +       MUX(0, "mout_aclk333_432_isp", mout_group4_p,
>> +               SRC_TOP1, 4, 2),
>> +       MUX(0, "mout_sw_aclk333_432_isp", mout_sw_aclk333_432_isp_p,
>> +               SRC_TOP11, 4, 1),
>> +       MUX(0, "mout_user_aclk333_432_isp", mout_user_aclk333_432_isp_p,
>> +               SRC_TOP4, 4, 1),
>> +       MUX(0, "mout_user_aclk266_isp", mout_user_aclk266_isp_p,
>> +               SRC_TOP4, 16, 1),
>> +
>> +       /* ISP Block */
>> +       MUX(0, "mout_pwm_isp", mout_group2_p, SRC_ISP, 24, 3),
>> +       MUX(0, "mout_uart_isp", mout_group2_p, SRC_ISP, 20, 3),
>> +       MUX(0, "mout_spi0_isp", mout_group2_p, SRC_ISP, 12, 3),
>> +       MUX(0, "mout_spi1_isp", mout_group2_p, SRC_ISP, 16, 3),
>> +       MUX(0, "mout_isp_sensor", mout_group2_p, SRC_ISP, 28, 3),
>>   };
>>
>>   static struct samsung_div_clock exynos5420_div_clks[] __initdata = {
>> @@ -528,6 +571,22 @@ static struct samsung_div_clock exynos5420_div_clks[]
>> __initdata = {
>>         DIV(0, "dout_pre_spi0", "dout_spi0", DIV_PERIC4, 8, 8),
>>         DIV(0, "dout_pre_spi1", "dout_spi1", DIV_PERIC4, 16, 8),
>>         DIV(0, "dout_pre_spi2", "dout_spi2", DIV_PERIC4, 24, 8),
>> +
>> +       /* ISP Block */
>> +       DIV(0, "dout_aclk400_isp", "mout_aclk400_isp", DIV_TOP0, 0, 3),
>> +       DIV(0, "dout_aclk333_432_isp0", "mout_aclk333_432_isp0",
>> +               DIV_TOP1, 16, 3),
>> +       DIV(0, "dout_aclk333_432_isp", "mout_aclk333_432_isp",
>> +               DIV_TOP1, 4, 3),
>> +       DIV(0, "dout_pwm_isp", "mout_pwm_isp", SCLK_DIV_ISP1, 28, 4),
>> +       DIV(0, "dout_uart_isp", "mout_uart_isp", SCLK_DIV_ISP1, 24, 4),
>> +       DIV(0, "dout_spi0_isp", "mout_spi0_isp", SCLK_DIV_ISP1, 16, 4),
>> +       DIV(0, "dout_spi1_isp", "mout_spi1_isp", SCLK_DIV_ISP1, 20, 4),
>> +       DIV(0, "dout_spi0_isp_pre", "dout_spi0_isp", SCLK_DIV_ISP1, 0, 8),
>> +       DIV(0, "dout_spi1_isp_pre", "dout_spi1_isp", SCLK_DIV_ISP1, 8, 8),
>> +       DIV(0, "dout_isp_sensor0", "mout_isp_sensor", SCLK_DIV_ISP0, 8,
>> 8),
>> +       DIV(0, "dout_isp_sensor1", "mout_isp_sensor", SCLK_DIV_ISP0, 16,
>> 8),
>> +       DIV(0, "dout_isp_sensor2", "mout_isp_sensor", SCLK_DIV_ISP0, 24,
>> 8),
>>   };
>>
>>   static struct samsung_gate_clock exynos5420_gate_clks[] __initdata = {
>> @@ -759,6 +818,27 @@ static struct samsung_gate_clock
>> exynos5420_gate_clks[] __initdata = {
>>                 0),
>>         GATE(CLK_SMMU_MIXER, "smmu_mixer", "aclk200_disp1", GATE_IP_DISP1,
>> 9, 0,
>>                 0),
>> +       GATE(0, "aclk266_isp", "mout_user_aclk266_isp",
>> +                       GATE_BUS_TOP, 13, 0, 0),
>> +       GATE(0, "aclk400_isp", "mout_user_aclk400_isp",
>> +                       GATE_BUS_TOP, 16, 0, 0),
>> +       GATE(0, "aclk333_432_isp0",
>> +                       "mout_user_aclk333_432_isp0", GATE_BUS_TOP, 5, 0,
>> 0),
>> +       GATE(0, "aclk333_432_isp",
>> +                       "mout_user_aclk333_432_isp", GATE_BUS_TOP, 8, 0,
>> 0),
>
>
> What are these 4 gate clocks needed for? Do we really need this kind of

These are the clocks coming out of CMU_TOP and provided to the ISP block.
These clocks are provided to IPs like ISP, DRC, SCALERC, SCALERP,
Coreted-A5, FD etc.,

Actually there are gates specific to each IP after the above four gates.
CMU_TOP ---> Above Four Gates  ---> Gates specific to ISP IPs ---> ISP IPs

Above four gates will not be used directly by any driver.

> gating granularity? Isn't there a gate bit in one of GATE_IP_* registers?

Yes, these clocks doesn't have gate bits in any of GATE_IP_* registers.

Regards,
Shaik Ameer Basha

>
> Best regards,
> Tomasz
