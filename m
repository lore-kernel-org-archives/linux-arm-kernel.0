From: elen.song@atmel.com (Elen Song)
Date: Mon, 22 Jul 2013 16:30:23 +0800
Subject: [PATCH 0/8 V3] serial: at91: make usart and uart support dma transfer
Message-ID: <1374481831-24573-1-git-send-email-elen.song@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After at91sam9g45 socs, the usart only support dma transfer.
This patch serial focus on:
1) distinguish pdc and dma transfer
2) support usart dma rx and tx transfer
3) distinguish usart and uart
4) support uart dma rx and tx transfer

For those only support PDC transfer socs, we use "atmel,use-dma-rx/tx" to establish a PDC transfer.
For those only support DMA transfer socs, we not only use "atmel,use-dma-rx/tx", but also describe dma binding to establish a DMA transfer.
We switch the name from "use-dma" to "use-pdc" in serial driver to state more clearly.
We also distinguish usart and uart by read ip name, the dbgu is regard as a uart.
Because uart lack timeout function, we use software timer to trigger rx.

Compare to v1, this patch serials improve:
1) use function pointer instead of if/else
2) "atmel,use-dma-rx/tx" represent a PDC transfer,
   but when add the dma bindings, it is a dma transfer
3) do not use strncmp in get ip name
4) remove modification in documentation part

Compare to v2, this patch serials improve:
1) change type from short to bool in use_pdc_rx/tx
2) merge uart and dbgu patch
3) add document 

Elen Song (8):
  serial: at91: correct definition from DMA to PDC
  serial: at91: use function pointer to choose pdc or pio
  serial: at91: add tx dma support
  serial: at91: add rx dma support
  serial: at91: support run time switch transfer mode
  serial: at91: distinguish usart and uart
  serial: at91: make UART support dma and pdc transfers
  serial: at91: add dma support in usart binding descriptions

 .../devicetree/bindings/tty/serial/atmel-usart.txt |   18 +-
 drivers/tty/serial/atmel_serial.c                  |  842 ++++++++++++++++----
 include/linux/atmel_serial.h                       |    2 +
 3 files changed, 725 insertions(+), 137 deletions(-)

-- 
1.7.9.5
