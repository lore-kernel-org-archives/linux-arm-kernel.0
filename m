From: manabian@gmail.com (Joachim Eastwood)
Date: Sat, 11 Jul 2015 14:12:07 +0200
Subject: [PATCH 4/4] doc: dt: dma: add bindings for lpc1850-dmamux
In-Reply-To: <1436616727-4847-1-git-send-email-manabian@gmail.com>
References: <1436616727-4847-1-git-send-email-manabian@gmail.com>
Message-ID: <1436616727-4847-5-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device tree bindings documentation for the
lpc1850-dmamux DMA router.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 .../devicetree/bindings/dma/lpc1850-dmamux.txt     | 54 ++++++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/lpc1850-dmamux.txt

diff --git a/Documentation/devicetree/bindings/dma/lpc1850-dmamux.txt b/Documentation/devicetree/bindings/dma/lpc1850-dmamux.txt
new file mode 100644
index 000000000000..87740adb2995
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/lpc1850-dmamux.txt
@@ -0,0 +1,54 @@
+NXP LPC18xx/43xx DMA MUX (DMA request router)
+
+Required properties:
+- compatible:	"nxp,lpc1850-dmamux"
+- reg:		Memory map for accessing module
+- #dma-cells:	Should be set to <3>.
+		* 1st cell contain the master dma request signal
+		* 2nd cell contain the mux value (0-3) for the peripheral
+		* 3rd cell contain either 1 or 2 depending on the AHB
+		  master used.
+- dma-requests:	Number of DMA requests for the mux
+- dma-masters:	phandle pointing to the DMA controller
+
+The DMA controller node need to have the following poroperties:
+- dma-requests:	Number of DMA requests the controller can handle
+
+Example:
+
+dmac: dma at 40002000 {
+	compatible = "nxp,lpc1850-gpdma", "arm,pl080", "arm,primecell";
+	arm,primecell-periphid = <0x00041080>;
+	reg = <0x40002000 0x1000>;
+	interrupts = <2>;
+	clocks = <&ccu1 CLK_CPU_DMA>;
+	clock-names = "apb_pclk";
+	#dma-cells = <2>;
+	dma-channels = <8>;
+	dma-requests = <16>;
+	lli-bus-interface-ahb1;
+	lli-bus-interface-ahb2;
+	mem-bus-interface-ahb1;
+	mem-bus-interface-ahb2;
+	memcpy-burst-size = <256>;
+	memcpy-bus-width = <32>;
+};
+
+dmamux: dma-mux {
+	compatible = "nxp,lpc1850-dmamux";
+	#dma-cells = <3>;
+	dma-requests = <64>;
+	dma-masters = <&dmac>;
+};
+
+uart0: serial at 40081000 {
+	compatible = "nxp,lpc1850-uart", "ns16550a";
+	reg = <0x40081000 0x1000>;
+	reg-shift = <2>;
+	interrupts = <24>;
+	clocks = <&ccu2 CLK_APB0_UART0>, <&ccu1 CLK_CPU_UART0>;
+	clock-names = "uartclk", "reg";
+	dmas = <&dmamux 1 1 2
+		&dmamux 2 1 2>;
+	dma-names = "tx", "rx";
+};
-- 
1.8.0
