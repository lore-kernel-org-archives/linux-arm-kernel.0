From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 20 May 2015 15:34:17 -0700
Subject: [PATCH 1/2 v4] clk: sirf: add CSR atlas7 clk and reset support
In-Reply-To: <1432111834-21178-1-git-send-email-21cnbao@gmail.com>
References: <1432111834-21178-1-git-send-email-21cnbao@gmail.com>
Message-ID: <20150520223417.GW31753@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/20, Barry Song wrote:
> From: Zhiwu Song <Zhiwu.Song@csr.com>
> 
> the hardware node includes both clock and reset support, so it
> is named as "car".
> this patch implements Flexible clocks(mux, divider, gate), Selectable
> clock(mux, divider, gate), root clock(gate),leaf clock(gate), others.
> it also implements the reset controller functionality.
> 
> Signed-off-by: Zhiwu Song <Zhiwu.Song@csr.com>
> Signed-off-by: Guo Zeng <Guo.Zeng@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> ---

Applied to clk-next with two checkpatches squelched


WARNING: __initdata should be placed after divider_list[]
#740: FILE: drivers/clk/sirf/clk-atlas7.c:637:
+static __initdata struct atlas7_div_init_data divider_list[] = {

WARNING: static const char * array should probably be static const char * const
#1061: FILE: drivers/clk/sirf/clk-atlas7.c:958:
+static const char *vip_clk_parents[] = {


---8<----
diff --git a/drivers/clk/sirf/clk-atlas7.c b/drivers/clk/sirf/clk-atlas7.c
index aeb6cfb4e72f..7e36d9623a4b 100644
--- a/drivers/clk/sirf/clk-atlas7.c
+++ b/drivers/clk/sirf/clk-atlas7.c
@@ -634,7 +634,7 @@ static struct clk_dto clk_disp1_dto = {
 	},
 };
 
-static __initdata struct atlas7_div_init_data divider_list[] = {
+static struct atlas7_div_init_data divider_list[] __initdata = {
 	/* div_name, parent_name, gate_name, clk_flag, divider_flag, gate_flag, div_offset, shift, wdith, gate_offset, bit_enable, lock */
 	{ "sys0pll_qa1", "sys0pll_fixdiv", "sys0pll_a1", 0, 0, 0, SIRFSOC_CLKC_USBPHY_CLKDIV_CFG, 0, 6, SIRFSOC_CLKC_USBPHY_CLKDIV_ENA, 0, &usbphy_div_lock },
 	{ "sys1pll_qa1", "sys1pll_fixdiv", "sys1pll_a1", 0, 0, 0, SIRFSOC_CLKC_USBPHY_CLKDIV_CFG, 8, 6, SIRFSOC_CLKC_USBPHY_CLKDIV_ENA, 4, &usbphy_div_lock },
@@ -955,7 +955,7 @@ static const char * const sdr_clk_parents[] = {
 	"sys1pll_a17",
 };
 
-static const char *vip_clk_parents[] = {
+static const char * const vip_clk_parents[] = {
 	"xin",
 	"xinw",
 	"sys2pll_a20",


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
