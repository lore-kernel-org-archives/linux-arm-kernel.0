From: digetx@gmail.com (Dmitry Osipenko)
Date: Fri, 20 Apr 2018 13:50:10 +0300
Subject: [PATCH] ARM: tegra: fix ulpi regression on tegra20
In-Reply-To: <6600596.BijQW1iq1K@ax5200p>
References: <20180219151252.29289-1-marcel@ziswiler.com>
 <6600596.BijQW1iq1K@ax5200p>
Message-ID: <4f2ac009-8618-4b4d-e137-a5fd4907a56f@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20.04.2018 11:52, Marc Dietrich wrote:
> Hi Marcel,
> 
> Am Montag, 19. Februar 2018, 16:12:52 CEST schrieb Marcel Ziswiler:
>> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>>
>> Since commit f8f8f1d04494 ("clk: Don't touch hardware when reparenting
>> during registration") ULPI has been broken on Tegra20 leading to the
>> following error message during boot:
>>
>> [    1.974698] ulpi_phy_power_on: ulpi write failed
>> [    1.979384] tegra-ehci c5004000.usb: Failed to power on the phy
>> [    1.985434] tegra-ehci: probe of c5004000.usb failed with error -110
>>
>> Debugging through the changes and finally also consulting the TRM
>> revealed that rather than the CDEV2 clock off OSC requiring such pin
>> muxing actually the PLL_P_OUT4 clock is in use. It looks like so far it
>> just worked by chance of that one having been enabled which Stephen's
>> commit now changed when reparenting sclk away from pll_p_out4 leaving
>> that one disabled. Fix this by properly assigning the PLL_P_OUT4 clock
>> as the ULPI PHY clock.
> 
> I booted 4.17-rc1 (which includes this fix) on an AC100 (T20 paz00 board) and 
> the error above is still there. Surprisingly the error vanishes when I revert 
> your patch. So this patch actually *causes* the problem above on my board. 
> Could it be, that we need all four clocks? Dimitry mentioned on IRC that it 
> could also be a problem in the clock init table. I don't have the technical 
> background myself to fix it, but I still wonder what could be so different 
> between TrimSlice and AC100.

I managed to find CDEV clocks in TRM this time. Seems assigning CDEV2 clock to
"ulpi-link" was correct and both CDEV2 and PLL_P_OUT4 should be enabled, CDEV2
should gate the PLL_P_OUT4 that feeds USB HW and PLL_P_OUT4 should be
always-enabled because it is enabled by init_table, but apparently it is getting
disabled erroneously.

Marcel, could you please revert your patch, add
"trace_event=clk_enable,clk_disable,clk_set_parent tp_printk" to kernels cmdline
and post the log?

It looks like there is some clk framework bug, but just in case please also try
to apply this patch:

diff --git a/drivers/clk/tegra/clk-tegra-periph.c
b/drivers/clk/tegra/clk-tegra-periph.c
index 2acba2986bc6..407bd0c0ac2f 100644
--- a/drivers/clk/tegra/clk-tegra-periph.c
+++ b/drivers/clk/tegra/clk-tegra-periph.c
@@ -1024,7 +1024,7 @@ static void __init init_pllp(void __iomem *clk_base, void
__iomem *pmc_base,
                if (dt_clk) {
                        clk = tegra_clk_register_pll_out("pll_p_out4",
                                        "pll_p_out4_div", clk_base + PLLP_OUTB,
-                                       17, 16, CLK_IGNORE_UNUSED |
+                                       17, 16, CLK_IS_CRITICAL |
                                        CLK_SET_RATE_PARENT, 0,
                                        &PLLP_OUTB_lock);
                        *dt_clk = clk;
