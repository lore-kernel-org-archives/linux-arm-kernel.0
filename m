From: subhasish@mistralsolutions.com (Subhasish Ghosh)
Date: Fri, 11 Feb 2011 20:21:19 +0530
Subject: [PATCH v2 00/13] pruss mfd drivers
Message-ID: <1297435892-28278-1-git-send-email-subhasish@mistralsolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


                           PRUSS Functional Block Diagram
               /----------------------------------------------------\
               |                                                    |
               |                      |------|                      |
     32GPO<------->PRU CORE-0 <------>|      |<------> DRAM 0       |
     30GPI<------->(4KB IRAM)         |  S   |       (512 Bytes)    |
               |                      |      |                      |
     32GPO<------->PRU CORE-1 <------>|  C   |<------> DRAM 1       |
     30GPI<------->(4KB IRAM)         |      |       (512 Bytes)    |
               |                      |  R   |                      |
               |                      |      |                      |
 Ints to ARM/  |    Interrupt <------>|      |-------------------------> Master I/F (to SCR2)
 DSP INTC <------->Controller         |      |<------------------------- Slave I/F (from SCR2)
 Events from   |     (INTC)           |------|                      |
 Periph + PRUs |                                                    |
               \----------------------------------------------------/

Programmable Realtime Unit (PRU) is basically a 32-bit RISC
processor available within TI's DA8XX SOCs. It consists of local
instruction and data RAM and also has access to SOC resources
via a Switched Central Resource (SCR).

There are two PRU's available within DA8XX SOC's PRUSS, hence providing
two execution cores. Devices/Protocols can be emulated on these utilizing
either both or only one of the PRUs independently.

The rational behind the MFD driver being the fact that multiple devices can
be implemented on the cores independently.
It's also possible, as in our case, to implement a single device on both
the PRU's resulting in improved load sharing.

A detailed description is also available here:
http://processors.wiki.ti.com/index.php/Programmable_Realtime_Unit_Subsystem

version 2:
==========
* added pruss TTY Soft-UART driver.
* added pruss Soft-UART board and platform changes.
* fixed previous review comments.
* reordered patch sequence.

version 1:
==========
* added pruss mfd driver.
* added pruss mfd board and platform changes.
* added pruss SocketCAN driver.
* added pruss SocketCAN board and platform changes.
* added pruss SocketCAN GPIOs.
* added previous review comments.

Subhasish Ghosh (13):
  mfd: pruss mfd driver.
  da850: pruss platform specific additions.
  da850: pruss board specific additions.
  mfd: pruss CAN private data.
  da850: pruss CAN platform specific additions.
  da850: pruss CAN board specific additions.
  da850: pruss CAN platform specific changes for gpios.
  da850: pruss CAN board specific changes for gpios.
  can: pruss CAN driver.
  mfd: pruss SUART private data.
  da850: pruss SUART board specific additions.
  da850: pruss SUART platform specific additions.
  tty: pruss SUART driver

 arch/arm/mach-davinci/board-da850-evm.c            |  105 +
 arch/arm/mach-davinci/da850.c                      |   12 +
 arch/arm/mach-davinci/devices-da8xx.c              |   76 +
 arch/arm/mach-davinci/include/mach/da8xx.h         |    2 +
 arch/arm/mach-davinci/include/mach/mux.h           |    5 +
 drivers/mfd/Kconfig                                |   10 +
 drivers/mfd/Makefile                               |    1 +
 drivers/mfd/da8xx_pru.c                            |  446 ++++
 drivers/net/can/Kconfig                            |    1 +
 drivers/net/can/Makefile                           |    1 +
 drivers/net/can/da8xx_pruss/Kconfig                |   73 +
 drivers/net/can/da8xx_pruss/Makefile               |    7 +
 drivers/net/can/da8xx_pruss/pruss_can.c            |  758 +++++++
 drivers/net/can/da8xx_pruss/pruss_can_api.c        | 1227 ++++++++++
 drivers/net/can/da8xx_pruss/pruss_can_api.h        |  290 +++
 drivers/tty/serial/Kconfig                         |    2 +
 drivers/tty/serial/Makefile                        |    1 +
 drivers/tty/serial/da8xx_pruss/Kconfig             |   19 +
 drivers/tty/serial/da8xx_pruss/Makefile            |    9 +
 drivers/tty/serial/da8xx_pruss/pruss_suart.c       | 1014 +++++++++
 drivers/tty/serial/da8xx_pruss/pruss_suart_api.c   | 2350 ++++++++++++++++++++
 drivers/tty/serial/da8xx_pruss/pruss_suart_api.h   |  345 +++
 drivers/tty/serial/da8xx_pruss/pruss_suart_board.h |   58 +
 drivers/tty/serial/da8xx_pruss/pruss_suart_err.h   |   48 +
 drivers/tty/serial/da8xx_pruss/pruss_suart_mcasp.h |  526 +++++
 drivers/tty/serial/da8xx_pruss/pruss_suart_regs.h  |  153 ++
 drivers/tty/serial/da8xx_pruss/pruss_suart_utils.c |  384 ++++
 drivers/tty/serial/da8xx_pruss/pruss_suart_utils.h |   63 +
 include/linux/mfd/pruss/da8xx_pru.h                |  131 ++
 include/linux/mfd/pruss/da8xx_prucore.h            |   74 +
 include/linux/serial_core.h                        |    2 +
 31 files changed, 8193 insertions(+), 0 deletions(-)
 create mode 100644 drivers/mfd/da8xx_pru.c
 create mode 100644 drivers/net/can/da8xx_pruss/Kconfig
 create mode 100644 drivers/net/can/da8xx_pruss/Makefile
 create mode 100644 drivers/net/can/da8xx_pruss/pruss_can.c
 create mode 100644 drivers/net/can/da8xx_pruss/pruss_can_api.c
 create mode 100644 drivers/net/can/da8xx_pruss/pruss_can_api.h
 create mode 100644 drivers/tty/serial/da8xx_pruss/Kconfig
 create mode 100644 drivers/tty/serial/da8xx_pruss/Makefile
 create mode 100644 drivers/tty/serial/da8xx_pruss/pruss_suart.c
 create mode 100644 drivers/tty/serial/da8xx_pruss/pruss_suart_api.c
 create mode 100644 drivers/tty/serial/da8xx_pruss/pruss_suart_api.h
 create mode 100644 drivers/tty/serial/da8xx_pruss/pruss_suart_board.h
 create mode 100644 drivers/tty/serial/da8xx_pruss/pruss_suart_err.h
 create mode 100644 drivers/tty/serial/da8xx_pruss/pruss_suart_mcasp.h
 create mode 100644 drivers/tty/serial/da8xx_pruss/pruss_suart_regs.h
 create mode 100644 drivers/tty/serial/da8xx_pruss/pruss_suart_utils.c
 create mode 100644 drivers/tty/serial/da8xx_pruss/pruss_suart_utils.h
 create mode 100644 include/linux/mfd/pruss/da8xx_pru.h
 create mode 100644 include/linux/mfd/pruss/da8xx_prucore.h

-- 
1.7.2.3
