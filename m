From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Tue, 09 Dec 2014 10:31:30 +0900
Subject: [PATCH 06/19] clk: samsung: exynos5433: Add clocks for CMU_MIF
 domain
In-Reply-To: <54858D81.1080003@samsung.com>
References: <1417510196-6714-1-git-send-email-cw00.choi@samsung.com>
 <1417510196-6714-7-git-send-email-cw00.choi@samsung.com>
 <54858D81.1080003@samsung.com>
Message-ID: <548650F2.9090404@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pankaj,

On 12/08/2014 08:37 PM, Pankaj Dubey wrote:
> Hi Chanwoo,
> 
> On Tuesday 02 December 2014 02:19 PM, Chanwoo Choi wrote:
>> This patch adds the mux/divider/gate clock fo CMU_MIF domain which includes
> 
> nit: %s/fo/of

I'll fix it.

> 
>> the clocks for DMC(DRAM memory controller) and CCI(Cache Coherent Interconnect).
>> The CMU_MIF domain provides the source clocks for CMU_DISP/CMU_BUS2.
>>
>> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
>> Cc: Tomasz Figa <tomasz.figa@gmail.com>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Acked-by: Inki Dae <inki.dae@samsung.com>
>> Acked-by: Geunsik Lim <geunsik.lim@samsung.com>
>> ---
>>   drivers/clk/samsung/clk-exynos5433.c   | 590 +++++++++++++++++++++++++++++++++
>>   include/dt-bindings/clock/exynos5433.h | 190 ++++++++++-
>>   2 files changed, 779 insertions(+), 1 deletion(-)
>>
> 
> [snip]
> 
>>
>>   static struct samsung_pll_clock mif_pll_clks[] __initdata = {
>> @@ -768,9 +888,479 @@ static struct samsung_pll_clock mif_pll_clks[] __initdata = {
>>           MFC_PLL_LOCK, MFC_PLL_CON0, exynos5443_pll_rates),
>>   };
>>
>> +/* list of all parent clock list */
>> +PNAME(mout_mfc_pll_div2_p)    = { "mout_mfc_pll", "dout_mfc_pll", };
>> +PNAME(mout_bus_pll_div2_p)    = { "mout_bus_pll", "dout_bus_pll", };
>> +PNAME(mout_mem1_pll_div2_p)    = { "mout_mem1_pll", "dout_mem1_pll", };
>> +PNAME(mout_mem0_pll_div2_p)    = { "mout_mem0_pll", "dout_mem0_pll", };
>> +PNAME(mout_mfc_pll_p)        = { "fin_pll", "fout_mfc_pll", };
>> +PNAME(mout_bus_pll_p)        = { "fin_pll", "fout_bus_pll", };
>> +PNAME(mout_mem1_pll_p)        = { "fin_pll", "fout_mem1_pll", };
>> +PNAME(mout_mem0_pll_p)        = { "fin_pll", "fout_mem0_pll", };
>> +
>> +PNAME(mout_clk2x_phy_c_p)    = { "mout_mem0_pll_div2", "mout_clkm_phy_b", };
>> +PNAME(mout_clk2x_phy_b_p)    = { "mout_bus_pll_div2", "mout_clkm_phy_a", };
>> +PNAME(mout_clk2x_phy_a_p)    = { "mout_bus_pll_div2", "mout_mfc_pll_div2", };
>> +PNAME(mout_clkm_phy_c_p)    = { "mout_mem0_pll_div2", "mout_clkm_phy_b", };
> 
> As mout_clk2x_phy_c_p and mout_clkm_phy_c_p both has same parent list one of them can be dropped.

OK, I'll use common parent to remove duplicat code.

> 
>> +PNAME(mout_clkm_phy_b_p)    = { "mout_mem1_pll_div2", "mout_clkm_phy_a", };
>> +PNAME(mout_clkm_phy_a_p)    = { "mout_bus_pll_div2", "mout_mfc_pll_div2", };
> 
> As mout_clk2x_phy_a_p and mout_clkm_phy_a_p both has same parent list one of them can be dropped.

OK.

> 
>> +
>> +PNAME(mout_aclk_mifnm_200_p)    = { "mout_mem0_pll_div2", "div_mif_pre", };
>> +PNAME(mout_aclk_mifnm_400_p)    = { "mout_mem1_pll_div2", "mout_bus_pll_div2",};
>> +
>> +PNAME(mout_aclk_disp_333_b_p)    = { "mout_aclk_disp_333_a",
>> +                    "mout_bus_pll_div2", };
>> +PNAME(mout_aclk_disp_333_a_p)    = { "mout_mfc_pll_div2", "sclk_mphy_pll", };
>> +
>> +PNAME(mout_sclk_decon_vclk_c_p)    = { "mout_sclk_decon_vclk_b",
>> +                    "sclk_mphy_pll", };
>> +PNAME(mout_sclk_decon_vclk_b_p)    = { "mout_sclk_decon_vclk_a",
>> +                    "mout_mfc_pll_div2", };
>> +PNAME(mout_sclk_decon_vclk_a_p)    = { "fin_pll", "mout_bus_pll_div2", };
>> +PNAME(mout_sclk_decon_eclk_c_p)    = { "mout_sclk_decon_eclk_b",
>> +                    "sclk_mphy_pll", };
>> +PNAME(mout_sclk_decon_eclk_b_p)    = { "mout_sclk_decon_eclk_a",
>> +                    "mout_mfc_pll_div2", };
>> +PNAME(mout_sclk_decon_eclk_a_p)    = { "fin_pll", "mout_bus_pll_div2", };
>> +
>> +PNAME(mout_sclk_decon_tv_eclk_c_p) = { "mout_sclk_decon_tv_eclk_b",
>> +                       "sclk_mphy_pll", };
>> +PNAME(mout_sclk_decon_tv_eclk_b_p) = { "mout_sclk_decon_tv_eclk_a",
>> +                       "mout_mfc_pll_div2", };
>> +PNAME(mout_sclk_decon_tv_eclk_a_p) = { "fin_pll", "mout_bus_pll_div2", };
>> +PNAME(mout_sclk_dsd_c_p)    = { "mout_sclk_dsd_b", "mout_bus_pll_div2", };
>> +PNAME(mout_sclk_dsd_b_p)    = { "mout_sclk_dsd_a", "sclk_mphy_pll", };
>> +PNAME(mout_sclk_dsd_a_p)    = { "fin_pll", "mout_mfc_pll_div2", };
>> +
>> +PNAME(mout_sclk_dsim0_c_p)    = { "mout_sclk_dsim0_b", "sclk_mphy_pll", };
>> +PNAME(mout_sclk_dsim0_b_p)    = { "mout_sclk_dsim0_a", "mout_mfc_pll_div2" };
>> +PNAME(mout_sclk_dsim0_a_p)    = { "fin_pll", "mout_bus_pll_div2", };
>> +
>> +PNAME(mout_sclk_decon_tv_vclk_c_p) = { "mout_sclk_decon_tv_vclk_b",
>> +                       "sclk_mphy_pll", };
>> +PNAME(mout_sclk_decon_tv_vclk_b_p) = { "mout_sclk_decon_tv_vclk_a",
>> +                       "mout_mfc_pll_div2", };
>> +PNAME(mout_sclk_decon_tv_vclk_a_p) = { "fin_pll", "mout_bus_pll_div2", };
>> +PNAME(mout_sclk_dsim1_c_p)    = { "mout_sclk_dsim1_b", "sclk_mphy_pll", };
>> +PNAME(mout_sclk_dsim1_b_p)    = { "mout_sclk_dsim1_a", "mout_mfc_pll_div2",};
>> +PNAME(mout_sclk_dsim1_a_p)    = { "fin_pll", "mout_bus_pll_div2", };
>> +
> 
> Same way I can see {"fin_pll", "mout_bus_pll_div2", } this combination of parents is repeated six times above in different PNAME, which can be replaced by one PNAME list with some common name, thus saving of 5 lines.

OK.

> 
>> +static struct samsung_fixed_factor_clock mif_fixed_factor_clks[] __initdata = {
>> +    /* dout_{mfc|bus|mem1|mem0}_pll is half fixed rate from parent mux */
>> +    FFACTOR(CLK_DOUT_MFC_PLL, "dout_mfc_pll", "mout_mfc_pll", 1, 1, 0),
>> +    FFACTOR(CLK_DOUT_BUS_PLL, "dout_bus_pll", "mout_bus_pll", 1, 1, 0),
>> +    FFACTOR(CLK_DOUT_MEM1_PLL, "dout_mem1_pll", "mout_mem1_pll", 1, 1, 0),
>> +    FFACTOR(CLK_DOUT_MEM0_PLL, "dout_mem0_pll", "mout_mem0_pll", 1, 1, 0),
>> +};
>> +

Thanks for your review.

Best Regards,
Chanwoo Choi
