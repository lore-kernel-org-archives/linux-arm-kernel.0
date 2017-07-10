From: o.rempel@pengutronix.de (Oleksij Rempel)
Date: Mon, 10 Jul 2017 16:42:18 +0200
Subject: [PATCH v1 0/2] provide imx rproc driver
Message-ID: <20170710144220.31594-1-o.rempel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

this patch set to provide remoteproc functionality on
i.MX7D SoC.

For testing I used this simple counter written in ASM:
======================================
        .syntax unified
        .text
        .thumb
        .int 0x10020000                 @ Initial SP value
        .int reset + 1

reset:

        mov     r0, #0x55
        ldr     r1, =(0x40)
1:
        str     r0, [r1]
        add     r0, 1
        b       1b

        /* Dummy data, required by remoteproc loader */
        /* Please FIXME, this part seem to be incorrect */
        .data
        .section .resource_table, "aw"
        .word   1, 0, 0, 0      /* struct resource_table base */
        .word   0               /* uint32_t offset[1] */
============================================================
compiled with:
${CROSS}as -o imx7m4.o imx7m4.S
${CROSS}ld -Ttext=0x0 -o imx7m4.elf imx7m4.o
cp imx7m4.elf /srv/nfs/sid-armhf/lib/firmware/rproc-imx_rproc-fw

Functionality was confirmed with current OpenOCD master.
OpenOCD cfg file can be found here:
https://github.com/olerem/openocd/blob/imx7-2017.06.14/tcl/target/imx7.cfg

Oleksij Rempel (2):
  remoteproc: dt: Provide bindings for iMX6SX/7D Remote Processor
    Controller driver
  remoteproc: imx_rproc: add a NXP/Freescale imx_rproc driver

 .../devicetree/bindings/remoteproc/imx-rproc.txt   |  44 +++
 drivers/remoteproc/Kconfig                         |  10 +
 drivers/remoteproc/Makefile                        |   1 +
 drivers/remoteproc/imx_rproc.c                     | 417 +++++++++++++++++++++
 4 files changed, 472 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/imx-rproc.txt
 create mode 100644 drivers/remoteproc/imx_rproc.c

-- 
2.11.0
