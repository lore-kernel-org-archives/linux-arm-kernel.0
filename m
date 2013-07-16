From: elen.song@atmel.com (Elen Song)
Date: Tue, 16 Jul 2013 10:43:39 +0800
Subject: [PATCH V2 0/8] serial: at91: make usart and uart support dma transfer
Message-ID: <1373942627-7121-1-git-send-email-elen.song@atmel.com>
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

Elen Song (7):
  serial: at91: correct definition from DMA to PDC
  serial: at91: add tx dma support
  serial: at91: add rx dma support
  serial: at91: make DBGU support dma and pdc transfers
  serial: at91: distinguish usart and uart
  serial: at91: modify UART to use software timer to trigger rx
  serial: at91: add dma support in usart binding descriptions

 Documentation/devicetree/bindings/serial/rs485.txt |    4 +-
 .../devicetree/bindings/tty/serial/atmel-usart.txt |   29 +-
 arch/arm/boot/dts/at91rm9200.dtsi                  |   16 +-
 arch/arm/boot/dts/at91sam9260.dtsi                 |   24 +-
 arch/arm/boot/dts/at91sam9263.dtsi                 |   12 +-
 arch/arm/boot/dts/at91sam9g45.dtsi                 |   16 +-
 arch/arm/mach-at91/at91rm9200_devices.c            |   20 +-
 arch/arm/mach-at91/at91sam9260_devices.c           |   28 +-
 arch/arm/mach-at91/at91sam9261_devices.c           |   16 +-
 arch/arm/mach-at91/at91sam9263_devices.c           |   16 +-
 arch/arm/mach-at91/at91sam9g45_devices.c           |   20 +-
 arch/arm/mach-at91/at91sam9rl_devices.c            |   20 +-
 drivers/tty/serial/atmel_serial.c                  |  582 ++++++++++++++++++--
 include/linux/atmel_serial.h                       |    2 +
 include/linux/platform_data/atmel.h                |    2 +
 15 files changed, 665 insertions(+), 142 deletions(-)

-- 
1.7.9.5
