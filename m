From: ezequiel@vanguardiasur.com.ar (Ezequiel Garcia)
Date: Thu, 18 Dec 2014 17:44:49 -0300
Subject: GPMC clock question
Message-ID: <54933CC1.9010301@vanguardiasur.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony, Roger:

As far as I can see, the GPMC interface clock (GPMC_FCLK) is not
properly modeled in the devicetree. Instead, hwmod magic seems to be used.

arch/arm/mach-omap2/omap_hwmod_33xx_43xx_interconnect_data.c:
struct omap_hwmod_ocp_if am33xx_l3_s__gpmc = {
        .master         = &am33xx_l3_s_hwmod,
        .slave          = &am33xx_gpmc_hwmod,
        .clk            = "l3s_gclk",
        .addr           = am33xx_gpmc_addr_space,
        .user           = OCP_USER_MPU,
};

I'd like to know what would be the appropriate DT model for this clock.
Perhaps, as child of CORE_M4_CLK, divided by 2:

gpmc_fclk: gpmc_fclk {
                #clock-cells = <0>;
                compatible = "fixed-factor-clock";
                clocks = <&dpll_core_m4_ck>;
                clock-mult = <1>;
                clock-div = <2>;
        };

How does it look? Also, I'm wondering if this works OK when used with
the hwmod stuff.

Thanks a lot in advance!
-- 
Ezequiel Garcia, VanguardiaSur
www.vanguardiasur.com.ar
