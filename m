From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 12 Jan 2017 11:14:51 +0000
Subject: [PATCH v2 2/2] arm64: dts: juno: Adds missing CoreSight STM
 component.
In-Reply-To: <1484167449-14432-3-git-send-email-mike.leach@linaro.org>
References: <1484167449-14432-1-git-send-email-mike.leach@linaro.org>
 <1484167449-14432-3-git-send-email-mike.leach@linaro.org>
Message-ID: <0120ef9b-2e01-e00a-2de8-c540ab70af85@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/01/17 20:44, Mike Leach wrote:
> Add missing CoreSight STM component definition to Juno CoreSight
> infrastructure juno-cs-rX.dtsi files.
> 
> Component connected to different funnels depending on Juno platform variant.
> 
> Signed-off-by: Mike Leach <mike.leach@linaro.org>
> ---
>  arch/arm64/boot/dts/arm/juno-cs-r0.dtsi   | 16 ++++++++++++++++
>  arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi | 16 ++++++++++++++++
>  2 files changed, 32 insertions(+)
>

Can we avoid duplication with something like below ? I don't have strong
opinion but I just saw the opportunity. I can squash it in if you
agree(no need to repost).

Regards,
Sudeep

-->8

diff --git a/arch/arm64/boot/dts/arm/juno-base.dtsi
b/arch/arm64/boot/dts/arm/juno-base.dtsi
index 7c89000f954d..15fcd09d9d84 100644
--- a/arch/arm64/boot/dts/arm/juno-base.dtsi
+++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
@@ -83,6 +83,21 @@
 	 * The actual size is just 4K though 64K is reserved. Access to the
 	 * unmapped reserved region results in a DECERR response.
 	 */
+	stm at 20100000 {
+		compatible = "arm,coresight-stm", "arm,primecell";
+		reg = <0 0x20100000 0 0x1000>,
+		      <0 0x28000000 0 0x180000>;
+		reg-names = "stm-base", "stm-stimulus-base";
+
+		clocks = <&soc_smc50mhz>;
+		clock-names = "apb_pclk";
+		power-domains = <&scpi_devpd 0>;
+		port {
+			stm_out_port: endpoint {
+			};
+		};
+	};
+
 	etm0: etm at 22040000 {
 		compatible = "arm,coresight-etm4x", "arm,primecell";
 		reg = <0 0x22040000 0 0x1000>;
diff --git a/arch/arm64/boot/dts/arm/juno-r1.dts
b/arch/arm64/boot/dts/arm/juno-r1.dts
index 881339536e90..1c16a96ff677 100644
--- a/arch/arm64/boot/dts/arm/juno-r1.dts
+++ b/arch/arm64/boot/dts/arm/juno-r1.dts
@@ -228,3 +228,7 @@
 &gpu1_thermal_zone {
 	status = "okay";
 };
+
+&stm_out_port {
+	remote-endpoint = <&csys1_funnel_in_port0>;
+};
diff --git a/arch/arm64/boot/dts/arm/juno-r2.dts
b/arch/arm64/boot/dts/arm/juno-r2.dts
index fca3a1705114..69890cc1edae 100644
--- a/arch/arm64/boot/dts/arm/juno-r2.dts
+++ b/arch/arm64/boot/dts/arm/juno-r2.dts
@@ -228,3 +228,7 @@
 &gpu1_thermal_zone {
 	status = "okay";
 };
+
+&stm_out_port {
+	remote-endpoint = <&csys1_funnel_in_port0>;
+};
diff --git a/arch/arm64/boot/dts/arm/juno.dts
b/arch/arm64/boot/dts/arm/juno.dts
index c90c37b66db5..ad270e090ba4 100644
--- a/arch/arm64/boot/dts/arm/juno.dts
+++ b/arch/arm64/boot/dts/arm/juno.dts
@@ -204,3 +204,7 @@
 &etm5 {
 	cpu = <&A53_3>;
 };
+
+&stm_out_port {
+	remote-endpoint = <&main_funnel_in_port2>;
+};
