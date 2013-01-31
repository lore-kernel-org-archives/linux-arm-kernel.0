From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 31 Jan 2013 21:30:56 +0800
Subject: [REGRESSION+BISECT] imx6: 3.8+: sata failure with 24d340ac "ARM
 i.MX6: Fix ethernet PLL clocks"
In-Reply-To: <20130131113627.GA5452@luxor.wired.org>
References: <20130131113627.GA5452@luxor.wired.org>
Message-ID: <20130131133054.GD2735@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 31, 2013 at 12:36:27PM +0100, Paolo Pisati wrote:
> Hi,
> 
> sata doesn't work anymore in 3.8rcX (while it was ok in 3.7 + 1 patch[1]) and i've bisected
> it down to:
> 
Technically, it's not a regression since vanilla 3.7 kernel does not
have SATA work out of box.  So we do not have to maintain the function
when changing clock code.

Can you please try to see if the following change bring that SATA back
to work?

Shawn

diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
index c0c4e72..8f756af 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -436,6 +436,9 @@ int __init mx6q_clocks_init(void)
        for (i = 0; i < ARRAY_SIZE(clks_init_on); i++)
                clk_prepare_enable(clk[clks_init_on[i]]);

+       if (IS_ENABLED(CONFIG_SATA_AHCI_PLATFORM))
+               clk_prepare_enable(clk[sata_ref_100m]);
+
        /* Set initial power mode */
        imx6q_set_lpm(WAIT_CLOCKED);
