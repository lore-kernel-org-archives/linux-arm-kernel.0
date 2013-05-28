From: mpa@pengutronix.de (Markus Pargmann)
Date: Tue, 28 May 2013 16:47:57 +0200
Subject: [PATCH v6 09/10] ASoC: fsl: Move fsl-ssi binding doc to sound/
In-Reply-To: <1369752478-30260-1-git-send-email-mpa@pengutronix.de>
References: <1369752478-30260-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1369752478-30260-10-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

fsl-ssi was located in powerpc/fsl/ssi.txt. This is no powerpc specific
device, so it should be moved to sound/ as it connects to differen audio
codecs.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 .../devicetree/bindings/powerpc/fsl/ssi.txt        | 73 ----------------------
 .../devicetree/bindings/sound/fsl,ssi.txt          | 73 ++++++++++++++++++++++
 2 files changed, 73 insertions(+), 73 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/powerpc/fsl/ssi.txt
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,ssi.txt

diff --git a/Documentation/devicetree/bindings/powerpc/fsl/ssi.txt b/Documentation/devicetree/bindings/powerpc/fsl/ssi.txt
deleted file mode 100644
index 5ff76c9..0000000
--- a/Documentation/devicetree/bindings/powerpc/fsl/ssi.txt
+++ /dev/null
@@ -1,73 +0,0 @@
-Freescale Synchronous Serial Interface
-
-The SSI is a serial device that communicates with audio codecs.  It can
-be programmed in AC97, I2S, left-justified, or right-justified modes.
-
-Required properties:
-- compatible:       Compatible list, contains "fsl,ssi".
-- cell-index:       The SSI, <0> = SSI1, <1> = SSI2, and so on.
-- reg:              Offset and length of the register set for the device.
-- interrupts:       <a b> where a is the interrupt number and b is a
-                    field that represents an encoding of the sense and
-                    level information for the interrupt.  This should be
-                    encoded based on the information in section 2)
-                    depending on the type of interrupt controller you
-                    have.
-- interrupt-parent: The phandle for the interrupt controller that
-                    services interrupts for this device.
-- fsl,mode:         The operating mode for the SSI interface.
-                    "i2s-slave" - I2S mode, SSI is clock slave
-                    "i2s-master" - I2S mode, SSI is clock master
-                    "lj-slave" - left-justified mode, SSI is clock slave
-                    "lj-master" - l.j. mode, SSI is clock master
-                    "rj-slave" - right-justified mode, SSI is clock slave
-                    "rj-master" - r.j., SSI is clock master
-                    "ac97-slave" - AC97 mode, SSI is clock slave
-                    "ac97-master" - AC97 mode, SSI is clock master
-- fsl,playback-dma: Phandle to a node for the DMA channel to use for
-                    playback of audio.  This is typically dictated by SOC
-                    design.  See the notes below.
-- fsl,capture-dma:  Phandle to a node for the DMA channel to use for
-                    capture (recording) of audio.  This is typically dictated
-                    by SOC design.  See the notes below.
-- fsl,fifo-depth:   The number of elements in the transmit and receive FIFOs.
-                    This number is the maximum allowed value for SFCSR[TFWM0].
-- fsl,ssi-asynchronous:
-                    If specified, the SSI is to be programmed in asynchronous
-                    mode.  In this mode, pins SRCK, STCK, SRFS, and STFS must
-                    all be connected to valid signals.  In synchronous mode,
-                    SRCK and SRFS are ignored.  Asynchronous mode allows
-                    playback and capture to use different sample sizes and
-                    sample rates.  Some drivers may require that SRCK and STCK
-                    be connected together, and SRFS and STFS be connected
-                    together.  This would still allow different sample sizes,
-                    but not different sample rates.
-
-Optional properties:
-- codec-handle:     Phandle to a 'codec' node that defines an audio
-                    codec connected to this SSI.  This node is typically
-                    a child of an I2C or other control node.
-
-Child 'codec' node required properties:
-- compatible:       Compatible list, contains the name of the codec
-
-Child 'codec' node optional properties:
-- clock-frequency:  The frequency of the input clock, which typically comes
-                    from an on-board dedicated oscillator.
-
-Notes on fsl,playback-dma and fsl,capture-dma:
-
-On SOCs that have an SSI, specific DMA channels are hard-wired for playback
-and capture.  On the MPC8610, for example, SSI1 must use DMA channel 0 for
-playback and DMA channel 1 for capture.  SSI2 must use DMA channel 2 for
-playback and DMA channel 3 for capture.  The developer can choose which
-DMA controller to use, but the channels themselves are hard-wired.  The
-purpose of these two properties is to represent this hardware design.
-
-The device tree nodes for the DMA channels that are referenced by
-"fsl,playback-dma" and "fsl,capture-dma" must be marked as compatible with
-"fsl,ssi-dma-channel".  The SOC-specific compatible string (e.g.
-"fsl,mpc8610-dma-channel") can remain.  If these nodes are left as
-"fsl,elo-dma-channel" or "fsl,eloplus-dma-channel", then the generic Elo DMA
-drivers (fsldma) will attempt to use them, and it will conflict with the
-sound drivers.
diff --git a/Documentation/devicetree/bindings/sound/fsl,ssi.txt b/Documentation/devicetree/bindings/sound/fsl,ssi.txt
new file mode 100644
index 0000000..5ff76c9
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/fsl,ssi.txt
@@ -0,0 +1,73 @@
+Freescale Synchronous Serial Interface
+
+The SSI is a serial device that communicates with audio codecs.  It can
+be programmed in AC97, I2S, left-justified, or right-justified modes.
+
+Required properties:
+- compatible:       Compatible list, contains "fsl,ssi".
+- cell-index:       The SSI, <0> = SSI1, <1> = SSI2, and so on.
+- reg:              Offset and length of the register set for the device.
+- interrupts:       <a b> where a is the interrupt number and b is a
+                    field that represents an encoding of the sense and
+                    level information for the interrupt.  This should be
+                    encoded based on the information in section 2)
+                    depending on the type of interrupt controller you
+                    have.
+- interrupt-parent: The phandle for the interrupt controller that
+                    services interrupts for this device.
+- fsl,mode:         The operating mode for the SSI interface.
+                    "i2s-slave" - I2S mode, SSI is clock slave
+                    "i2s-master" - I2S mode, SSI is clock master
+                    "lj-slave" - left-justified mode, SSI is clock slave
+                    "lj-master" - l.j. mode, SSI is clock master
+                    "rj-slave" - right-justified mode, SSI is clock slave
+                    "rj-master" - r.j., SSI is clock master
+                    "ac97-slave" - AC97 mode, SSI is clock slave
+                    "ac97-master" - AC97 mode, SSI is clock master
+- fsl,playback-dma: Phandle to a node for the DMA channel to use for
+                    playback of audio.  This is typically dictated by SOC
+                    design.  See the notes below.
+- fsl,capture-dma:  Phandle to a node for the DMA channel to use for
+                    capture (recording) of audio.  This is typically dictated
+                    by SOC design.  See the notes below.
+- fsl,fifo-depth:   The number of elements in the transmit and receive FIFOs.
+                    This number is the maximum allowed value for SFCSR[TFWM0].
+- fsl,ssi-asynchronous:
+                    If specified, the SSI is to be programmed in asynchronous
+                    mode.  In this mode, pins SRCK, STCK, SRFS, and STFS must
+                    all be connected to valid signals.  In synchronous mode,
+                    SRCK and SRFS are ignored.  Asynchronous mode allows
+                    playback and capture to use different sample sizes and
+                    sample rates.  Some drivers may require that SRCK and STCK
+                    be connected together, and SRFS and STFS be connected
+                    together.  This would still allow different sample sizes,
+                    but not different sample rates.
+
+Optional properties:
+- codec-handle:     Phandle to a 'codec' node that defines an audio
+                    codec connected to this SSI.  This node is typically
+                    a child of an I2C or other control node.
+
+Child 'codec' node required properties:
+- compatible:       Compatible list, contains the name of the codec
+
+Child 'codec' node optional properties:
+- clock-frequency:  The frequency of the input clock, which typically comes
+                    from an on-board dedicated oscillator.
+
+Notes on fsl,playback-dma and fsl,capture-dma:
+
+On SOCs that have an SSI, specific DMA channels are hard-wired for playback
+and capture.  On the MPC8610, for example, SSI1 must use DMA channel 0 for
+playback and DMA channel 1 for capture.  SSI2 must use DMA channel 2 for
+playback and DMA channel 3 for capture.  The developer can choose which
+DMA controller to use, but the channels themselves are hard-wired.  The
+purpose of these two properties is to represent this hardware design.
+
+The device tree nodes for the DMA channels that are referenced by
+"fsl,playback-dma" and "fsl,capture-dma" must be marked as compatible with
+"fsl,ssi-dma-channel".  The SOC-specific compatible string (e.g.
+"fsl,mpc8610-dma-channel") can remain.  If these nodes are left as
+"fsl,elo-dma-channel" or "fsl,eloplus-dma-channel", then the generic Elo DMA
+drivers (fsldma) will attempt to use them, and it will conflict with the
+sound drivers.
-- 
1.8.2.1
