From: b32955@freescale.com (Huang Shijie)
Date: Wed, 3 Jul 2013 17:42:32 +0800
Subject: [PATCH v2 0/5] serial: imx: add DMA support for imx6
Message-ID: <1372844557-3078-1-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(1) This patch set adds the DMA support for the imx serial driver.
    The uart with the dma support is usually used by the Bluetooth.

    For the firmware's limit, i only enable the DMA for imx6 serials.
    If we have proper firmware for imx53 (or other chips), we can also
    enable the DMA for it.

(2) We only enable the DMA support when the following are meet:

    [1] The uart port supports the hardware flow control(CTS/RTS).
      (Some uart port does not support the CTS/RTS.)

    [2] The application enables the CTS/RTS.

    [3] The Soc is imx6 serials.
      For the sdma's firmware limit, we do not support the DMA except
      the imx6 platform.

    [4] The uart is not used as a console.


(3) Tested this patch set by:
	connecting a imx6q-arm2 board(DTE) with a imx53 board(DCE).

v1 --> v2:
	[0] use the "fsl,imx6q-uart" as the new compatible value.
	[1] move dma_is_inited to imx_uart_dma_init();
	    move dma_is_enabled to imx_enable_dma();
	[2] move imx_disable_dma() to the front place of the imx_shutdown(),
	    just before calls the imx_uart_dma_exit().
	[3] misc    
	

Huang Shijie (5):
  serial: imx: distinguish the imx6q uart from the others
  serial: imx: add DMA support for imx6q
  ARM: dts: imx6sl: add "fsl,imx6q-uart" for uart compatible
  ARM: dts: imx6q: add dte pinctrl for uart2
  ARM: dts: enable the uart2 for imx6q-arm2

 arch/arm/boot/dts/imx6q-arm2.dts |   10 +
 arch/arm/boot/dts/imx6q.dtsi     |    9 +
 arch/arm/boot/dts/imx6sl.dtsi    |   15 +-
 drivers/tty/serial/imx.c         |  422 +++++++++++++++++++++++++++++++++++++-
 4 files changed, 444 insertions(+), 12 deletions(-)
