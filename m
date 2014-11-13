From: kever.yang@rock-chips.com (Kever Yang)
Date: Thu, 13 Nov 2014 16:11:49 +0800
Subject: [PATCH] clk: rockchip: fix clock select order for usbphy480m_src
Message-ID: <1415866309-3277-1-git-send-email-kever.yang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to rk3288 trm, the mux selector locate at bit[12:11]
of CRU_CLKSEL13_CON shows:
2'b00: select HOST0 USB pll clock (clk_otgphy1)
2'b01: select HOST1 USB pll clock (clk_otgphy2)
2'b10: select OTG USB pll clock   (clk_otgphy0)

The clock map is in Fig. 3-4 CRU Clock Architecture Diagram 3
- clk_otgphy0 -> USB PHY OTG
- clk_otgphy1 -> USB PHY host0
- clk_otgphy2 -> USB PHY host1

Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
---

 drivers/clk/rockchip/clk-rk3288.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3288.c b/drivers/clk/rockchip/clk-rk3288.c
index 157b60b..4d70518 100644
--- a/drivers/clk/rockchip/clk-rk3288.c
+++ b/drivers/clk/rockchip/clk-rk3288.c
@@ -195,8 +195,8 @@ PNAME(mux_hsadcout_p)	= { "hsadc_src", "ext_hsadc" };
 PNAME(mux_edp_24m_p)	= { "ext_edp_24m", "xin24m" };
 PNAME(mux_tspout_p)	= { "cpll", "gpll", "npll", "xin27m" };
 
-PNAME(mux_usbphy480m_p)		= { "sclk_otgphy0", "sclk_otgphy1",
-				    "sclk_otgphy2" };
+PNAME(mux_usbphy480m_p)		= { "sclk_otgphy1", "sclk_otgphy2",
+				    "sclk_otgphy0" };
 PNAME(mux_hsicphy480m_p)	= { "cpll", "gpll", "usbphy480m_src" };
 PNAME(mux_hsicphy12m_p)		= { "hsicphy12m_xin12m", "hsicphy12m_usbphy" };
 
-- 
1.9.1
