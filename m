From: claude.youn@gmail.com (Seungwhan Youn)
Date: Fri, 8 Oct 2010 19:53:42 +0900
Subject: [PATCH 8/10] ARM: S5PV210: Add EPLL clock operations
In-Reply-To: <001d01cb66d3$c7799e00$566cda00$%kim@samsung.com>
References: <1286191550-22197-1-git-send-email-sw.youn@samsung.com>
	<1286194060-19860-1-git-send-email-sw.youn@samsung.com>
	<001d01cb66d3$c7799e00$566cda00$%kim@samsung.com>
Message-ID: <AANLkTinVMMyM6kgwbwN+iRiuyyp6r55P-XLRDeXuPgM4@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 8, 2010 at 7:29 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Seungwhan Youn wrote:
>>
>> This patch adds EPLL specific clock get_rate/set_rate operations
>> on S5PV210.
>>
>> Signed-off-by: Seungwhan Youn <sw.youn@samsung.com>
>> ---
>> ?arch/arm/mach-s5pv210/clock.c ? ? ? ?| ? 95
>> ++++++++++++++++++++++++++++++++++
>> ?arch/arm/plat-s5p/include/plat/pll.h | ? ?2 +
>> ?2 files changed, 97 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-s5pv210/clock.c b/arch/arm/mach-s5pv210/clock.c
>> index bcbe7e9..affa5a0 100644
>> --- a/arch/arm/mach-s5pv210/clock.c
>> +++ b/arch/arm/mach-s5pv210/clock.c
>> @@ -1003,6 +1003,97 @@ static struct clksrc_clk *sysclks[] = {
>> ? ? ? &clk_sclk_spdif,
>> ?};
>>
>> +static int s5pv210_epll_enable(struct clk *clk, int enable)
>> +{
>> + ? ? unsigned int ctrlbit = clk->ctrlbit;
>> + ? ? unsigned int epll_con = __raw_readl(S5P_EPLL_CON0) & ~ctrlbit;
>> +
>> + ? ? if (enable)
>> + ? ? ? ? ? ? __raw_writel(epll_con | ctrlbit, S5P_EPLL_CON0);
>> + ? ? else
>> + ? ? ? ? ? ? __raw_writel(epll_con, S5P_EPLL_CON0);
>> +
>> + ? ? return 0;
>> +}
>> +
>
> Maybe if we move s5p64x0_epll_enable() to common part i.e.,
> plat-s5p/clock.c, we can use common_epll_enable() in here.
> Of course, need to sort out the regarding definitions such as
> S5PXX_EPLL_CON0...
>

Okay, I'll fix.

>> +static unsigned long s5pv210_epll_get_rate(struct clk *clk)
>> +{
>> + ? ? return clk->rate;
>> +}
>> +
>> +static u32 epll_div[][6] = {
>> + ? ? { ?48000000, 0, 48, 3, 3, 0 },
>> + ? ? { ?96000000, 0, 48, 3, 2, 0 },
>> + ? ? { 144000000, 1, 72, 3, 2, 0 },
>> + ? ? { 192000000, 0, 48, 3, 1, 0 },
>> + ? ? { 288000000, 1, 72, 3, 1, 0 },
>> + ? ? { ?32750000, 1, 65, 3, 4, 35127 },
>> + ? ? { ?32768000, 1, 65, 3, 4, 35127 },
>> + ? ? { ?45158400, 0, 45, 3, 3, 10355 },
>> + ? ? { ?45000000, 0, 45, 3, 3, 10355 },
>> + ? ? { ?45158000, 0, 45, 3, 3, 10355 },
>> + ? ? { ?49125000, 0, 49, 3, 3, 9961 },
>> + ? ? { ?49152000, 0, 49, 3, 3, 9961 },
>> + ? ? { ?67737600, 1, 67, 3, 3, 48366 },
>> + ? ? { ?67738000, 1, 67, 3, 3, 48366 },
>> + ? ? { ?73800000, 1, 73, 3, 3, 47710 },
>> + ? ? { ?73728000, 1, 73, 3, 3, 47710 },
>> + ? ? { ?36000000, 1, 32, 3, 4, 0 },
>> + ? ? { ?60000000, 1, 60, 3, 3, 0 },
>> + ? ? { ?72000000, 1, 72, 3, 3, 0 },
>> + ? ? { ?80000000, 1, 80, 3, 3, 0 },
>> + ? ? { ?84000000, 0, 42, 3, 2, 0 },
>> + ? ? { ?50000000, 0, 50, 3, 3, 0 },
>> +};
>> +
>> +static int s5pv210_epll_set_rate(struct clk *clk, unsigned long rate)
>> +{
>> + ? ? unsigned int epll_con, epll_con_k;
>> + ? ? unsigned int i;
>> +
>> + ? ? /* Return if nothing changed */
>> + ? ? if (clk->rate == rate)
>> + ? ? ? ? ? ? return 0;
>> +
>> + ? ? epll_con = __raw_readl(S5P_EPLL_CON0);
>> + ? ? epll_con_k = __raw_readl(S5P_EPLL_CON1);
>> +
>> + ? ? epll_con_k &= ~(PLL90XX_KDIV_MASK << PLL90XX_KDIV_SHIFT);
>> + ? ? epll_con &= ~(PLL90XX_VSEL_MASK << PLL90XX_VSEL_SHIFT |
>> + ? ? ? ? ? ? ? ? ? ? PLL90XX_MDIV_MASK << PLL90XX_MDIV_SHIFT |
>> + ? ? ? ? ? ? ? ? ? ? PLL90XX_PDIV_MASK << PLL90XX_PDIV_SHIFT |
>> + ? ? ? ? ? ? ? ? ? ? PLL90XX_SDIV_MASK << PLL90XX_SDIV_SHIFT);
>> +
>> + ? ? for (i = 0; i < ARRAY_SIZE(epll_div); i++) {
>> + ? ? ? ? ? ? if (epll_div[i][0] == rate) {
>> + ? ? ? ? ? ? ? ? ? ? epll_con_k |= epll_div[i][5] << 0;
>> + ? ? ? ? ? ? ? ? ? ? epll_con |= (epll_div[i][1] << PLL90XX_VSEL_SHIFT |
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? epll_div[i][2] <<
>> PLL90XX_MDIV_SHIFT |
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? epll_div[i][3] <<
>> PLL90XX_PDIV_SHIFT |
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? epll_div[i][4] <<
>> PLL90XX_SDIV_SHIFT);
>> + ? ? ? ? ? ? ? ? ? ? break;
>> + ? ? ? ? ? ? }
>> + ? ? }
>> +
>> + ? ? if (i == ARRAY_SIZE(epll_div)) {
>> + ? ? ? ? ? ? printk(KERN_ERR "%s: Invalid Clock EPLL Frequency\n",
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? __func__);
>> + ? ? ? ? ? ? return -EINVAL;
>> + ? ? }
>> +
>> + ? ? __raw_writel(epll_con, S5P_EPLL_CON0);
>> + ? ? __raw_writel(epll_con_k, S5P_EPLL_CON1);
>> +
>> + ? ? clk->rate = rate;
>> +
>> + ? ? return 0;
>> +}
>> +
>
> Same...

This also, I'll fix it.

(snip)

Thanks,
Claude
