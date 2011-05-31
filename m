From: subhasish@mistralsolutions.com (Subhasish Ghosh)
Date: Tue, 31 May 2011 13:15:38 +0530
Subject: [PATCH v5 0/1] pruss mfd drivers.
Message-ID: <1306827939-4133-1-git-send-email-subhasish@mistralsolutions.com>
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

version 5:
=========
MFD:
* Moved the MFD drivers into staging.
* Added v4 code comments.

version 4:
=========
MFD:
* added mfd_cells in the board file
* exported seperate multiwrite/read functions
* removed clk_get_pruss api
* improved coding style
* removed code duplications
* renamed files to pruss based
* used make C=1
* added __iomem cookie for io addresses
* used iowrite/read instead of __raw variants

SUART:
* changes for the new mfd_cell implementation
* code cleanup
* used iowrite/read instead of __raw variants
* used make C=1

NOTE:
* as requested by the owner the CAN driver patch is submitted seperately.

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

Subhasish Ghosh (1):
  drivers:staging:pruss: add pruss staging mfd driver.

 drivers/staging/Kconfig            |    2 +
 drivers/staging/Makefile           |    1 +
 drivers/staging/pruss/Kconfig      |   16 ++
 drivers/staging/pruss/Makefile     |    5 +
 drivers/staging/pruss/TODO         |   14 +
 drivers/staging/pruss/pruss.c      |  483 ++++++++++++++++++++++++++++++++++++
 drivers/staging/pruss/pruss.h      |  130 ++++++++++
 drivers/staging/pruss/pruss_core.h |  132 ++++++++++
 8 files changed, 783 insertions(+), 0 deletions(-)
 create mode 100644 drivers/staging/pruss/Kconfig
 create mode 100644 drivers/staging/pruss/Makefile
 create mode 100644 drivers/staging/pruss/TODO
 create mode 100644 drivers/staging/pruss/pruss.c
 create mode 100644 drivers/staging/pruss/pruss.h
 create mode 100644 drivers/staging/pruss/pruss_core.h

-- 
1.7.2.3
