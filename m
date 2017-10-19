From: olivier.moysan@st.com (Olivier Moysan)
Date: Thu, 19 Oct 2017 15:03:17 +0200
Subject: [INTERNAL][PATCH 1/7] ASoC: stm32: Add synchronization to SAI bindings
In-Reply-To: <1508418203-16840-1-git-send-email-olivier.moysan@st.com>
References: <1508418203-16840-1-git-send-email-olivier.moysan@st.com>
Message-ID: <1508418203-16840-2-git-send-email-olivier.moysan@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add synchronization configuration to STM32 SAI bindings.
This patch also adds peripheral clock which is required
to access synchronization register.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 Documentation/devicetree/bindings/sound/st,stm32-sai.txt | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/st,stm32-sai.txt b/Documentation/devicetree/bindings/sound/st,stm32-sai.txt
index f1c5ae5..1f9cd70 100644
--- a/Documentation/devicetree/bindings/sound/st,stm32-sai.txt
+++ b/Documentation/devicetree/bindings/sound/st,stm32-sai.txt
@@ -10,13 +10,21 @@ Required properties:
   - reg: Base address and size of SAI common register set.
   - clocks: Must contain phandle and clock specifier pairs for each entry
 	in clock-names.
-  - clock-names: Must contain "x8k" and "x11k"
+  - clock-names: Must contain "pclk" "x8k" and "x11k"
+	"pclk": Clock which feeds the peripheral bus interface.
+	        Mandatory for "st,stm32h7-sai" compatible.
+	        Not used for "st,stm32f4-sai" compatible.
 	"x8k": SAI parent clock for sampling rates multiple of 8kHz.
 	"x11k": SAI parent clock for sampling rates multiple of 11.025kHz.
   - interrupts: cpu DAI interrupt line shared by SAI sub-blocks
 
 Optional properties:
   - resets: Reference to a reset controller asserting the SAI
+  - st,sync: specify synchronization mode.
+	By default SAI sub-block is in asynchronous mode.
+	This property sets SAI sub-block as slave of another SAI sub-block.
+	Must contain the phandle and index of the sai sub-block providing
+	the synchronization.
 
 SAI subnodes:
 Two subnodes corresponding to SAI sub-block instances A et B can be defined.
@@ -52,8 +60,8 @@ sai1: sai1 at 40015800 {
 	#size-cells = <1>;
 	ranges = <0 0x40015800 0x400>;
 	reg = <0x40015800 0x4>;
-	clocks = <&rcc PLL1_Q>, <&rcc PLL2_P>;
-	clock-names = "x8k", "x11k";
+	clocks = <&rcc SAI1_CK>, <&rcc PLL1_Q>, <&rcc PLL2_P>;
+	clock-names = "pclk", "x8k", "x11k";
 	interrupts = <87>;
 
 	sai1a: audio-controller at 40015804 {
-- 
1.9.1
