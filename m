From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 15 Jan 2014 15:35:40 +0800
Subject: imx6dl/imx6q fec rmii mode with external ref_clk
In-Reply-To: <20140114153012.GA22550@frolo.macqel>
References: <20140114153012.GA22550@frolo.macqel>
Message-ID: <20140115073536.GD1914@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 14, 2014 at 04:30:12PM +0100, Philippe De Muyter wrote:
> Hi,
> 
> On the custom board we are developping (imx6q and imx6dl), we have connected
> the fec to a switch chip using rmii mode, and we let the switch provide the
> reference clock to gpio_16.
> 
> I work currently with 3.13-rc8 and
> 
> - I do not have ethernet access working (tx timeout)
> - I do not find in the dtb files a description of the pad settings for the
> RMII mode
> - when searching about the setting for bit 21 ing GPR1, which seems to
> be important for my setting to work, I found the following mail:
> 	http://www.spinics.net/lists/devicetree/msg06450.html

Just for testing your hardware, does the following change make the
Ethernet work for you?

Shawn

diff --git a/arch/arm/mach-imx/mach-imx6q.c
b/arch/arm/mach-imx/mach-imx6q.c
index e51e3da..be8d074 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -188,7 +188,7 @@ static void __init imx6q_1588_init(void)
        if (!IS_ERR(gpr))
                regmap_update_bits(gpr, IOMUXC_GPR1,
                                IMX6Q_GPR1_ENET_CLK_SEL_MASK,
-                               IMX6Q_GPR1_ENET_CLK_SEL_ANATOP);
+                               0);
        else
                pr_err("failed to find fsl,imx6q-iomux-gpr regmap\n");
