From: peter.chen@nxp.com (Peter Chen)
Date: Thu, 25 Aug 2016 01:26:10 +0000
Subject: [PATCH] ARM: imx6: enable WAIT mode hardware workaround for imx6sx
In-Reply-To: <1471885400-9140-1-git-send-email-Anson.Huang@nxp.com>
References: <1471885400-9140-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <HE1PR04MB145001C26FC1A9A40849F0308BED0@HE1PR04MB1450.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 
>Need to enable INT_MEM_CLK_LPM bit in CCM_CGPR for WAIT mode, without
>this bit set, if there is pending interrupt during ARM platform entering WAIT mode
>without power gating, cache data will be corrupted, this is a hardware workaround for
>WAIT mode and must be enabled.
>
>Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
>---
> arch/arm/mach-imx/cpuidle-imx6sx.c | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/arch/arm/mach-imx/cpuidle-imx6sx.c b/arch/arm/mach-imx/cpuidle-
>imx6sx.c
>index 3c6672b..41cdce6 100644
>--- a/arch/arm/mach-imx/cpuidle-imx6sx.c
>+++ b/arch/arm/mach-imx/cpuidle-imx6sx.c
>@@ -90,6 +90,7 @@ static struct cpuidle_driver imx6sx_cpuidle_driver = {
>
> int __init imx6sx_cpuidle_init(void)
> {
>+	imx6q_set_int_mem_clk_lpm(true);
> 	imx6_enable_rbc(false);
> 	/*
> 	 * set ARM power up/down timing to the fastest,
>--
>1.9.1

It fixed the system unstable problem at my imx6sx-sdb board. So:
Tested-by: Peter Chen <peter.chen@nxp.com>

Peter
