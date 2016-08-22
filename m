From: peter.chen@nxp.com (Peter Chen)
Date: Mon, 22 Aug 2016 08:26:47 +0000
Subject: [PATCH] ARM: imx6: add missing BM_CLPCR_BYPASS_PMIC_READY setting
 for imx6sx
In-Reply-To: <1471881205-6389-1-git-send-email-Anson.Huang@nxp.com>
References: <1471881205-6389-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <HE1PR04MB1450E23EC1E757E4ED10AC1E8BE80@HE1PR04MB1450.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

  
>i.MX6SX has bypass PMIC ready function, as this function is normally NOT enabled
>on the board design, so we need to bypass the PMIC ready pin check during DSM
>mode resume flow, otherwise, the internal DSM resume logic will be waiting for this
>signal to be ready forever and cause resume fail.
>
>Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
>---
> arch/arm/mach-imx/pm-imx6.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/arch/arm/mach-imx/pm-imx6.c b/arch/arm/mach-imx/pm-imx6.c index
>67bab74..fe708e2 100644
>--- a/arch/arm/mach-imx/pm-imx6.c
>+++ b/arch/arm/mach-imx/pm-imx6.c
>@@ -310,7 +310,7 @@ int imx6_set_lpm(enum mxc_cpu_pwr_mode mode)
> 		val |= 0x3 << BP_CLPCR_STBY_COUNT;
> 		val |= BM_CLPCR_VSTBY;
> 		val |= BM_CLPCR_SBYOS;
>-		if (cpu_is_imx6sl())
>+		if (cpu_is_imx6sl() || cpu_is_imx6sx())
> 			val |= BM_CLPCR_BYPASS_PMIC_READY;
> 		if (cpu_is_imx6sl() || cpu_is_imx6sx() || cpu_is_imx6ul())
> 			val |= BM_CLPCR_BYP_MMDC_CH0_LPM_HS;
>--

With above changes, the suspend mode "mem" can work well.
Tested-by: Peter Chen <peter.chen@nxp.com>

You can consider add below tag:
Cc: <stable@vger.kernel.org> # 4.1+

Peter
