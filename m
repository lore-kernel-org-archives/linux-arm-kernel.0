From: arun.kk@samsung.com (Arun Kumar K)
Date: Thu, 1 May 2014 14:01:44 +0530
Subject: [PATCH v6] clk: Exynos5250: Add clocks for G3D
In-Reply-To: <53617DD6.60507@gmail.com>
References: <1398677821-11529-1-git-send-email-arun.kk@samsung.com>
 <53617DD6.60507@gmail.com>
Message-ID: <CALt3h78XP+W2TA4F4EtHxtCO0Fm48pmQi1gbir8ScsKLjwUw9w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

On Thu, May 1, 2014 at 4:18 AM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> On 28.04.2014 11:37, Arun Kumar K wrote:
>>
>> This patch adds the required clocks for ARM Mali IP
>> in Exynos5250.
>>
>> Signed-off-by: Arun Kumar K <arun.kk@samsung.com>
>> ---
>> Changes from v5
>> - Addressed comments from Tomasz Figa
>>    http://www.spinics.net/lists/arm-kernel/msg326118.html
>> Changes from v4
>> - Rebased on latest kernel
>> - Added macros
>> Changes from v3
>> - Renamed some clocks as per Tomasz Figa's comments
>> Changes from v2
>> - Rebased on clk-next
>> Changes from v1
>> - Removed exporting of parent DIV clock for g3d
>>    as per Tomsz Figa's comment.
>> ---
>>   drivers/clk/samsung/clk-exynos5250.c   |   15 ++++++++++++++-
>>   include/dt-bindings/clock/exynos5250.h |    4 +++-
>>   2 files changed, 17 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/clk/samsung/clk-exynos5250.c
>> b/drivers/clk/samsung/clk-exynos5250.c
>> index e7ee442..df02526 100644
>> --- a/drivers/clk/samsung/clk-exynos5250.c
>> +++ b/drivers/clk/samsung/clk-exynos5250.c
>> @@ -37,6 +37,7 @@
>>   #define VPLL_CON0             0x10140
>>   #define GPLL_CON0             0x10150
>>   #define SRC_TOP0              0x10210
>> +#define SRC_TOP1               0x10214
>>   #define SRC_TOP2              0x10218
>>   #define SRC_TOP3              0x1021c
>>   #define SRC_GSCL              0x10220
>> @@ -71,6 +72,7 @@
>>   #define GATE_IP_GSCL          0x10920
>>   #define GATE_IP_DISP1         0x10928
>>   #define GATE_IP_MFC           0x1092c
>> +#define GATE_IP_G3D            0x10930
>>   #define GATE_IP_GEN           0x10934
>>   #define GATE_IP_FSYS          0x10944
>>   #define GATE_IP_PERIC         0x10950
>> @@ -100,6 +102,7 @@ static unsigned long exynos5250_clk_regs[] __initdata
>> = {
>>         DIV_CPU0,
>>         SRC_CORE1,
>>         SRC_TOP0,
>> +       SRC_TOP1,
>>         SRC_TOP2,
>>         SRC_TOP3,
>>         SRC_GSCL,
>> @@ -133,6 +136,7 @@ static unsigned long exynos5250_clk_regs[] __initdata
>> = {
>>         DIV_PERIC5,
>>         GATE_IP_GSCL,
>>         GATE_IP_MFC,
>> +       GATE_IP_G3D,
>>         GATE_IP_GEN,
>>         GATE_IP_FSYS,
>>         GATE_IP_PERIC,
>> @@ -189,10 +193,12 @@ PNAME(mout_vpllsrc_p)     = { "fin_pll",
>> "sclk_hdmi27m" };
>>   PNAME(mout_vpll_p)    = { "mout_vpllsrc", "fout_vpll" };
>>   PNAME(mout_cpll_p)    = { "fin_pll", "fout_cpll" };
>>   PNAME(mout_epll_p)    = { "fin_pll", "fout_epll" };
>> +PNAME(mout_gpll_p)     = { "fin_pll", "fout_gpll" };
>>   PNAME(mout_mpll_user_p)       = { "fin_pll", "mout_mpll" };
>>   PNAME(mout_bpll_user_p)       = { "fin_pll", "mout_bpll" };
>>   PNAME(mout_aclk166_p) = { "mout_cpll", "mout_mpll_user" };
>>   PNAME(mout_aclk200_p) = { "mout_mpll_user", "mout_bpll_user" };
>> +PNAME(mout_aclk400_p)  = { "mout_aclk400_g3d_mid", "mout_gpll" };
>>   PNAME(mout_aclk200_sub_p) = { "fin_pll", "div_aclk200" };
>>   PNAME(mout_aclk266_sub_p) = { "fin_pll", "div_aclk266" };
>>   PNAME(mout_aclk333_sub_p) = { "fin_pll", "div_aclk333" };
>> @@ -273,12 +279,16 @@ static struct samsung_mux_clock
>> exynos5250_mux_clks[] __initdata = {
>>         MUX(0, "mout_aclk166", mout_aclk166_p, SRC_TOP0, 8, 1),
>>         MUX(0, "mout_aclk200", mout_aclk200_p, SRC_TOP0, 12, 1),
>>         MUX(0, "mout_aclk333", mout_aclk166_p, SRC_TOP0, 16, 1),
>> +       MUX(0, "mout_aclk400_g3d_mid", mout_aclk200_p, SRC_TOP0, 20, 1),
>> +
>> +       MUX(0, "mout_aclk400_g3d", mout_aclk400_p, SRC_TOP1, 28, 1),
>>
>>         MUX(0, "mout_cpll", mout_cpll_p, SRC_TOP2, 8, 1),
>>         MUX(0, "mout_epll", mout_epll_p, SRC_TOP2, 12, 1),
>>         MUX(0, "mout_vpll", mout_vpll_p, SRC_TOP2, 16, 1),
>>         MUX(0, "mout_mpll_user", mout_mpll_user_p, SRC_TOP2, 20, 1),
>>         MUX(0, "mout_bpll_user", mout_bpll_user_p, SRC_TOP2, 24, 1),
>> +       MUX(CLK_MOUT_GPLL, "mout_gpll", mout_gpll_p, SRC_TOP2, 28, 1),
>>
>>         MUX(0, "mout_aclk200_disp1_sub", mout_aclk200_sub_p, SRC_TOP3, 4,
>> 1),
>>         MUX(0, "mout_aclk266_gscl_sub", mout_aclk266_sub_p, SRC_TOP3, 8,
>> 1),
>> @@ -351,6 +361,8 @@ static struct samsung_div_clock exynos5250_div_clks[]
>> __initdata = {
>>         DIV(0, "div_aclk200", "mout_aclk200", DIV_TOP0, 12, 3),
>>         DIV(0, "div_aclk266", "mout_mpll_user", DIV_TOP0, 16, 3),
>>         DIV(0, "div_aclk333", "mout_aclk333", DIV_TOP0, 20, 3),
>> +       DIV(0, "div_aclk400_g3d", "mout_aclk400_g3d", DIV_TOP0,
>> +                                                       24, 3),
>>
>>         DIV(0, "div_aclk66_pre", "mout_mpll_user", DIV_TOP1, 24, 3),
>>
>> @@ -533,7 +545,8 @@ static struct samsung_gate_clock
>> exynos5250_gate_clks[] __initdata = {
>>                 0),
>>         GATE(CLK_SMMU_MFCL, "smmu_mfcl", "mout_aclk333_sub", GATE_IP_MFC,
>> 2, 0,
>>                 0),
>> -
>> +       GATE(CLK_G3D, "g3d", "div_aclk400_g3d", GATE_IP_G3D, 0,
>> +                                       CLK_SET_RATE_PARENT, 0),
>>         GATE(CLK_ROTATOR, "rotator", "div_aclk266", GATE_IP_GEN, 1, 0, 0),
>>         GATE(CLK_JPEG, "jpeg", "div_aclk166", GATE_IP_GEN, 2, 0, 0),
>>         GATE(CLK_MDMA1, "mdma1", "div_aclk266", GATE_IP_GEN, 4, 0, 0),
>> diff --git a/include/dt-bindings/clock/exynos5250.h
>> b/include/dt-bindings/clock/exynos5250.h
>> index 922f2dc..a3c6777 100644
>> --- a/include/dt-bindings/clock/exynos5250.h
>> +++ b/include/dt-bindings/clock/exynos5250.h
>> @@ -150,11 +150,13 @@
>>   #define CLK_G2D                       345
>>   #define CLK_MDMA0             346
>>   #define CLK_SMMU_MDMA0                347
>> +#define CLK_G3D                        348
>>
>>   /* mux clocks */
>>   #define CLK_MOUT_HDMI         1024
>> +#define CLK_MOUT_GPLL          1025
>>
>>   /* must be greater than maximal clock id */
>> -#define CLK_NR_CLKS            1025
>> +#define CLK_NR_CLKS            1026
>>
>>   #endif /* _DT_BINDINGS_CLOCK_EXYNOS_5250_H */
>>
>
> Applied.
>

Thanks. Can you have a look at this patch too -
https://patchwork.kernel.org/patch/4076161/
It is for the same purpose (for Mali GPU) in 5420 SoC.

Regards
Arun

> Best regards,
> Tomasz
