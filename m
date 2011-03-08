From: subhasish@mistralsolutions.com (Subhasish Ghosh)
Date: Tue,  8 Mar 2011 19:27:39 +0530
Subject: [PATCH v3 0/7] pruss mfd drivers
Message-ID: <1299592667-21367-1-git-send-email-subhasish@mistralsolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

				PRUSS Functional Block Diagram
		/-------------------------------------------------------\
		|							|
		|			|------|			|
	32GPO<------->PRU CORE-0 <----->|      |<----> DRAM 0		|
	30GPI<------->(4KB IRAM)	|  S   |	(512 Bytes)	|
		|			|      |			|
	32GPO<------->PRU CORE-1 <----->|  C   |<----> DRAM 1		|
	30GPI<------->(4KB IRAM)	|      |	(512 Bytes)	|
		|			|  R   |			|
		|			|      |			|
Ints to ARM/	|	Interrupt <---->|      |-------------------------> Master I/F (to SCR2)
DSP INTC <------------->Controller	|      |<------------------------- Slave I/F (from SCR2)
Events from	|	(INTC)		|------|			|
Periph + PRUs	|							|
		\-------------------------------------------------------/

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

version 3:
=========
* added locking to mfd driver.
* removed typedefs.
* resource allocation through mfd.
* renamed da8xx_register_pruss to da8xx_register_pruss_mfd.
* removed da8xx_pruss directory for suart.
* combined all suart headers.
* modified register structure for pruss.
* added function clk_add_alias_mcasp.
* suart api layer cleanup.
* removed semaphore usage.
* updated to latest internal code base.
* removed __suart_err/dbg.

version 2:
==========
* added pruss TTY Soft-UART driver.
* added pruss Soft-UART board and platform changes.
* fixed previous review comments.
* reordered patch sequence.

version 1:
==========
* added pruss mfd driver.

Subhasish Ghosh (7):
  mfd: add pruss mfd driver.
  da850: pruss platform specific additions.
  da850: pruss board specific additions.
  mfd: pruss SUART private data.
  da850: pruss SUART board specific additions.
  da850: pruss SUART platform specific additions.
  tty: add pruss SUART driver

 arch/arm/mach-davinci/board-da850-evm.c    |   68 ++
 arch/arm/mach-davinci/da850.c              |    7 +
 arch/arm/mach-davinci/devices-da8xx.c      |   83 ++
 arch/arm/mach-davinci/include/mach/da8xx.h |    2 +
 drivers/mfd/Kconfig                        |   10 +
 drivers/mfd/Makefile                       |    1 +
 drivers/mfd/da8xx_pru.c                    |  560 +++++++++
 drivers/tty/serial/Kconfig                 |   22 +
 drivers/tty/serial/Makefile                |   10 +
 drivers/tty/serial/pruss_suart.c           | 1058 +++++++++++++++++
 drivers/tty/serial/pruss_suart.h           | 1081 +++++++++++++++++
 drivers/tty/serial/pruss_suart_api.c       | 1757 ++++++++++++++++++++++++++++
 drivers/tty/serial/pruss_suart_utils.c     |  391 ++++++
 include/linux/mfd/da8xx/da8xx_pru.h        |  139 +++
 include/linux/mfd/da8xx/da8xx_prucore.h    |  129 ++
 include/linux/serial_core.h                |    2 +
 16 files changed, 5320 insertions(+), 0 deletions(-)
 create mode 100644 drivers/mfd/da8xx_pru.c
 create mode 100644 drivers/tty/serial/pruss_suart.c
 create mode 100644 drivers/tty/serial/pruss_suart.h
 create mode 100644 drivers/tty/serial/pruss_suart_api.c
 create mode 100644 drivers/tty/serial/pruss_suart_utils.c
 create mode 100644 include/linux/mfd/da8xx/da8xx_pru.h
 create mode 100644 include/linux/mfd/da8xx/da8xx_prucore.h

-- 
1.7.2.3
