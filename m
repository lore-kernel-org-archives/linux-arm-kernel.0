From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Wed, 19 Jul 2017 14:24:10 -0500
Subject: [PATCH 1/2] net: phy: at803x: Fix RGMII RX and TX clock delays
 setup
In-Reply-To: <33ed5f4f-9939-dc00-b973-db39c16f2393@sigmadesigns.com>
References: <b332dc3e-4478-e34b-2b3f-226aad8a11d4@sigmadesigns.com>
 <33ed5f4f-9939-dc00-b973-db39c16f2393@sigmadesigns.com>
Message-ID: <5ea9905f-e74a-4a43-dc5b-883ec9daf030@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On 07/19/2017 10:31 AM, Marc Gonzalez wrote:
> The current code supports enabling RGMII RX and TX clock delays.
> The unstated assumption is that these settings are disabled by
> default at reset, which is not the case.
> 
> RX clock delay is enabled at reset. And TX clock delay "survives"
> across SW resets. Thus, if the bootloader enables TX clock delay,
> it will remain enabled at reset in Linux.
> 
> Provide disable functions to configure the RGMII clock delays
> exactly as specified in the fwspec.
> 
> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
> ---
>   drivers/net/phy/at803x.c | 32 ++++++++++++++++++++++++--------
>   1 file changed, 24 insertions(+), 8 deletions(-)
This patch breaks am335x-evm networking.

To restore it I've had to apply below diff:
diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index 200d6ab..9578bdf 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -724,12 +724,12 @@
 
 &cpsw_emac0 {
        phy_id = <&davinci_mdio>, <0>;
-       phy-mode = "rgmii-txid";
+       phy-mode = "rgmii-id";
 };
 
 &cpsw_emac1 {
        phy_id = <&davinci_mdio>, <1>;
-       phy-mode = "rgmii-txid";
+       phy-mode = "rgmii-id";
 };
 
 &tscadc {

Sry, can't comment here to much - not E-PHY expert.

-- 
regards,
-grygorii
