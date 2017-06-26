From: bich.hemon@st.com (Bich HEMON)
Date: Mon, 26 Jun 2017 12:49:16 +0000
Subject: [PATCH 17/20] dt-bindings: serial: stm32: add dma using note
In-Reply-To: <1498481318-1894-1-git-send-email-bich.hemon@st.com>
References: <1498481318-1894-1-git-send-email-bich.hemon@st.com>
Message-ID: <1498481318-1894-18-git-send-email-bich.hemon@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bich Hemon <bich.hemon@st.com>

Signed-off-by: Gerald Baeza <gerald.baeza@st.com>
---
 .../devicetree/bindings/serial/st,stm32-usart.txt  | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/st,stm32-usart.txt b/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
index 3b42138..6c1cfc8 100644
--- a/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
+++ b/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
@@ -18,6 +18,28 @@ Optional properties:
 - dmas: phandle(s) to DMA controller node(s). Refer to stm32-dma.txt
 - dma-names: "rx" and/or "tx"
 
+Note for dma using:
+- "tx" dma can be used without any constraint since it uses single
+dma transfers.
+- "rx" dma using requires some attention:
+   1) if you cannot anticipate the length of your received packets
+   and if your usart device embeds an internal fifo, then DON'T use
+   dma mode.
+   2) if you enable dma mode WITHOUT mdma intermediate copy (cf.
+   stm32-dma.txt), then the availability of the received data will
+   depend on the dma driver policy and it may be delayed until dma
+   internal fifo is full. The usart driver will see this checking
+   the dma residue when rx interrupt (RXNE or RTO) occurs.
+   3) if you enable dma mode WITH mdma intermediate copy (cf.
+   stm32-dma.txt) then the usart driver will never see the dma
+   residue becoming smaller than RX_BUF_P but it will get its
+   rx dma complete callback called when the cyclic transfer period
+   (RX_BUF_P) is reached.
+The three possibilities above are ordered from the most cpu time
+consuming one to the least one. The counterpart of this optimisation
+is the reception granularity achievable by the usart driver, from
+one byte up to RX_BUF_P.
+
 Note: Each usart controller should have an alias correctly numbered
 in "aliases" node.
 
-- 
1.9.1
