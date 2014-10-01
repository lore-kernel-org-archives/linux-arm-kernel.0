From: j.uzycki@elproma.com.pl (=?UTF-8?B?SmFudXN6IFXFvHlja2k=?=)
Date: Wed, 01 Oct 2014 13:14:54 +0200
Subject: clk_set_rate, mux does not switch over, reparenting
Message-ID: <542BE22E.3060203@elproma.com.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I found the thread:
http://lists.infradead.org/pipermail/linux-arm-kernel/2012-December/138076.html

I'm trying to increase peripheral clock rate.
The case is: XTAL/PLL --> MUX --> DIV --> peripheral clock.
By default the MUX is set to XTAL=24MHz.
I can set peripheral clock to 24MHz or less (DIV works).
However MUX has also PLL=480MHz input.
Unfortunately clk_set_rate() over 24MHz does not work.
Exact clock path is: ref_xtal/pll0 - ptp_del(MUX) - ptp(DIV)
drivers/clk/mxs/clk-imx28.c defines CLK_SET_RATE_PARENT flag
for the ptp clock using mxs_clk_div().

I noticed that mxs_clk_mux() calls clk_register_mux()
with CLK_SET_RATE_NO_REPARENT flag. It looks suspicious
for ptp_sel (only ptp clock is and can be child of ptp_sel).
It seems "clk: add CLK_SET_RATE_NO_REPARENT flag"
patch for drivers/clk/mxs/clk.h was too general.
"Platform maintainers are encouraged to remove the flag
if they wish to allow mux reparenting on set_rate. "
Is defining mxs_clk_mux_reparent() without the flag
in addition to basic mxs_clk_mux() good idea?

best regards
Janusz
