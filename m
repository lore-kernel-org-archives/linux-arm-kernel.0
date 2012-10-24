From: b32955@freescale.com (Huang Shijie)
Date: Wed, 24 Oct 2012 18:27:33 +0800
Subject: [PATCH v2 0/3] serial: mxs-auart: add DMA support for auart in mx28
Message-ID: <1351074456-25863-1-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds the DMA support for auart in mx28.
patch 1:
	In mx23, the DMA has a bug(see errata:2836). We can not add the
	DMA support in mx23, but we can add DMA support to auart in mx28.
	So in order to add the DMA support for the auart in mx28, we should add
	the platform_device_id to distinguish the distinguish SOCs.

patch 2: add the DMA support for mx28
	Only we meet the following conditions, we can enable the DMA support
	for auart:
        (1) We enable the DMA support in the dts file, such as
            arch/arm/boot/dts/imx28.dtsi.
        (2) We enable the hardware flow control.
        (3) We use the mx28, not the mx23. Due to hardware bug(see errata: 2836),
            we can not add the DMA support to mx23.

patch 3: enable the DMA support in dts for mx28 
	You can use the /ttyAPP0 to test this patch set. 
	I tested this patch in mx28-evk board.

v1 --> v2:
	[1] use the inline function, not a macro, to distinguish the SOCs.
	[2] remove the "inline" for mxs_auart_tx_chars().
	[3] use the `pio`, not the `pio[1]` to fill the DMA descriptor.
	[4] use bit operation to serialize the DMA TX.
	[5] use the RX/TX DMA channel to enable the DMA support, remove the
	    "fsl,auart-enable-dma".

Huang Shijie (3):
  serial: mxs-auart: distinguish the different SOCs
  serial: mxs-auart: add the DMA support for mx28
  ARM: dts: enable dma support for auart0 in mx28

 .../bindings/tty/serial/fsl-mxs-auart.txt          |    8 +
 arch/arm/boot/dts/imx28.dtsi                       |    1 +
 drivers/tty/serial/mxs-auart.c                     |  360 +++++++++++++++++++-
 3 files changed, 358 insertions(+), 11 deletions(-)
