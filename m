From: kevin.wells@nxp.com (Kevin Wells)
Date: Fri, 20 Nov 2009 02:11:38 +0100
Subject: RFC [PATCH 8/9] Added plc32xx platform include files
Message-ID: <083DF309106F364B939360100EC290F804F54D5611@eu1rdcrdc1wx030.exi.nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Added plc32xx platform include files

Signed-off-by: Kevin Wells <kevin.wells@nxp.com>
---
 arch/arm/mach-lpc32xx/include/mach/board.h      |   84 ++++++++++++++
 arch/arm/mach-lpc32xx/include/mach/clkdev.h     |   29 +++++
 arch/arm/mach-lpc32xx/include/mach/clock.h      |   47 ++++++++
 arch/arm/mach-lpc32xx/include/mach/gpio.h       |   74 +++++++++++++
 arch/arm/mach-lpc32xx/include/mach/hardware.h   |   43 +++++++
 arch/arm/mach-lpc32xx/include/mach/i2c.h        |   64 +++++++++++
 arch/arm/mach-lpc32xx/include/mach/io.h         |   31 +++++
 arch/arm/mach-lpc32xx/include/mach/irqs.h       |  134 +++++++++++++++++++++++
 arch/arm/mach-lpc32xx/include/mach/memory.h     |  119 ++++++++++++++++++++
 arch/arm/mach-lpc32xx/include/mach/system.h     |   40 +++++++
 arch/arm/mach-lpc32xx/include/mach/timex.h      |   31 +++++
 arch/arm/mach-lpc32xx/include/mach/uncompress.h |  111 +++++++++++++++++++
 arch/arm/mach-lpc32xx/include/mach/vmalloc.h    |   33 ++++++
 13 files changed, 840 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-lpc32xx/include/mach/board.h
 create mode 100644 arch/arm/mach-lpc32xx/include/mach/clkdev.h
 create mode 100644 arch/arm/mach-lpc32xx/include/mach/clock.h
 create mode 100644 arch/arm/mach-lpc32xx/include/mach/gpio.h
 create mode 100644 arch/arm/mach-lpc32xx/include/mach/hardware.h
 create mode 100644 arch/arm/mach-lpc32xx/include/mach/i2c.h
 create mode 100644 arch/arm/mach-lpc32xx/include/mach/io.h
 create mode 100644 arch/arm/mach-lpc32xx/include/mach/irqs.h
 create mode 100644 arch/arm/mach-lpc32xx/include/mach/memory.h
 create mode 100644 arch/arm/mach-lpc32xx/include/mach/system.h
 create mode 100644 arch/arm/mach-lpc32xx/include/mach/timex.h
 create mode 100644 arch/arm/mach-lpc32xx/include/mach/uncompress.h
 create mode 100644 arch/arm/mach-lpc32xx/include/mach/vmalloc.h

diff --git a/arch/arm/mach-lpc32xx/include/mach/board.h b/arch/arm/mach-lpc32xx/include/mach/board.h
new file mode 100644
index 0000000..ae2e650
--- /dev/null
+++ b/arch/arm/mach-lpc32xx/include/mach/board.h
@@ -0,0 +1,84 @@
+/*
+ * mach-lpc32xx/include/mach/board.h
+ *
+ * Author: Kevin Wells <kevin.wells@nxp.com>
+ *
+ * Copyright (C) 2009 NXP Semiconductors
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+
+#ifndef __ASM_ARCH_BOARD_H
+#define __ASM_ARCH_BOARD_H
+
+#include "platform.h"
+#include <linux/mtd/partitions.h>
+
+/*
+ * NAND platform configuration structure
+ */
+typedef int (*en_wp_func_t)(int);
+struct lpc32XX_nand_cfg {
+       u32 wdr_clks;
+       u32 wwidth;
+       u32 whold;
+       u32 wsetup;
+       u32 rdr_clks;
+       u32 rwidth;
+       u32 rhold;
+       u32 rsetup;
+       int use16bus;
+       en_wp_func_t enable_write_prot;
+       struct mtd_partition* (*partition_info)(int, int*);
+};
+
+/*
+ * Key scanner platform configuration structure
+ */
+struct lpc32XX_kscan_cfg {
+       u32 matrix_sz;  /* Size of matrix in XxY, ie. 3 = 3x3 */
+       int *keymap;
+       u32 deb_clks;   /* Debounce clocks (based on 32KHz clock) */
+       u32 scan_delay; /* Scan delay (based on 32KHz clock) */
+};
+
+/*
+ * Network configuration structure
+ */
+typedef int (*get_mac_func_t)(u8 *mac);
+typedef void * (*alloc_netram_t)(u32 buffer_size);
+typedef void (*free_netram_t)(void *buffer, u32 buffer_size);
+struct lpc_net_cfg {
+       get_mac_func_t get_mac_addr;
+       alloc_netram_t alloc_netram;
+       free_netram_t free_netram;
+       int phy_irq;
+       u32 phy_mask;
+};
+
+/*
+ * USB device configuration structure
+ */
+typedef void (*usc_chg_event_func_t)(int);
+struct lpc32xx_usbd_cfg {
+       int vbus_drv_polarity; /* 0=active low drive for VBUS */
+       usc_chg_event_func_t conn_chgb;
+       usc_chg_event_func_t susp_chgb;
+       usc_chg_event_func_t rmwk_chgb;
+};
+
+#endif
+
diff --git a/arch/arm/mach-lpc32xx/include/mach/clkdev.h b/arch/arm/mach-lpc32xx/include/mach/clkdev.h
new file mode 100644
index 0000000..5167b84
--- /dev/null
+++ b/arch/arm/mach-lpc32xx/include/mach/clkdev.h
@@ -0,0 +1,29 @@
+/*
+ * mach-lpc32xx/include/mach/clock.h
+ *
+ * Author: Kevin Wells <kevin.wells@nxp.com>
+ *
+ * Copyright (C) 2009 NXP Semiconductors
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#ifndef __ASM_MACH_CLKDEV_H
+#define __ASM_MACH_CLKDEV_H
+
+#define __clk_get(clk) ({ 1; })
+#define __clk_put(clk) do { } while (0)
+
+#endif
diff --git a/arch/arm/mach-lpc32xx/include/mach/clock.h b/arch/arm/mach-lpc32xx/include/mach/clock.h
new file mode 100644
index 0000000..e4f168f
--- /dev/null
+++ b/arch/arm/mach-lpc32xx/include/mach/clock.h
@@ -0,0 +1,47 @@
+/*
+ * mach-lpc32xx/include/mach/clock.h
+ *
+ * Author: Kevin Wells <kevin.wells@nxp.com>
+ *
+ * Copyright (C) 2009 NXP Semiconductors
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#ifndef __ARCH_ARM_CLOCK_H__
+#define __ARCH_ARM_CLOCK_H__
+
+struct clk {
+       struct list_head node;
+       struct module *owner;
+       struct clk *parent;
+       u32 rate;
+       u32 flags;
+       s8 usecount;
+
+       int (*set_rate) (struct clk *, u32);
+       u32 (*round_rate) (struct clk *, u32);
+       int (*enable) (struct clk *clk, int);
+       int (*set_parent) (struct clk * clk, struct clk * parent);
+       u32 (*get_rate) (struct clk *clk);
+
+       /* Register and mask for some clocks */
+       u32 enable_reg;
+       u32 enable_mask;
+};
+
+#define CLK_FLAG_FIXED         0x01
+
+#endif
diff --git a/arch/arm/mach-lpc32xx/include/mach/gpio.h b/arch/arm/mach-lpc32xx/include/mach/gpio.h
new file mode 100644
index 0000000..e8c0fac
--- /dev/null
+++ b/arch/arm/mach-lpc32xx/include/mach/gpio.h
@@ -0,0 +1,74 @@
+/*
+ * mach-lpc32xx/include/mach/gpio.h
+ *
+ * Author: Kevin Wells <kevin.wells@nxp.com>
+ *
+ * Copyright (C) 2009 NXP Semiconductors
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#ifndef __ASM_ARCH_GPIO_H
+#define __ASM_ARCH_GPIO_H
+
+#include <linux/errno.h>
+#include <asm-generic/gpio.h>
+
+/*
+ * Note!
+ * Muxed GP pins need to be setup to the GP state in the board level
+ * code prior to using this driver.
+ * GPI pins : 28xP3 group
+ * GPO pins : 24xP3 group
+ * GPIO pins: 8xP0 group, 24xP1 group, 13xP2 group, 6xP3 group
+ */
+
+#define GPIO_P0_MAX 8
+#define GPIO_P1_MAX 24
+#define GPIO_P2_MAX 13
+#define GPIO_P3_MAX 6
+#define GPI_P3_MAX 28
+#define GPO_P3_MAX 24
+
+#define GPIO_P0_GRP 0
+#define GPIO_P1_GRP (GPIO_P0_GRP + GPIO_P0_MAX)
+#define GPIO_P2_GRP (GPIO_P1_GRP + GPIO_P1_MAX)
+#define GPIO_P3_GRP (GPIO_P2_GRP + GPIO_P2_MAX)
+#define GPI_P3_GRP (GPIO_P3_GRP + GPIO_P3_MAX)
+#define GPO_P3_GRP (GPI_P3_GRP + GPI_P3_MAX)
+
+/*
+ * A specific GPIO can be selected with this macro
+ * ie, GPIO_05 can be selected with LPC32XX_GPIO(GPIO_P3_GRP, 5)
+ */
+#define LPC32XX_GPIO(x,y) ((x) + (y))
+
+static inline int gpio_get_value(unsigned gpio) {
+       return __gpio_get_value(gpio);
+}
+
+static inline void gpio_set_value(unsigned gpio, int value) {
+       __gpio_set_value(gpio, value);
+}
+
+static inline int gpio_cansleep(unsigned gpio) {
+       return __gpio_cansleep(gpio);
+}
+
+static inline int gpio_to_irq(unsigned gpio) {
+       return __gpio_to_irq(gpio);
+}
+
+#endif
diff --git a/arch/arm/mach-lpc32xx/include/mach/hardware.h b/arch/arm/mach-lpc32xx/include/mach/hardware.h
new file mode 100644
index 0000000..b7f0138
--- /dev/null
+++ b/arch/arm/mach-lpc32xx/include/mach/hardware.h
@@ -0,0 +1,43 @@
+/*
+ * mach-lpc32xx/include/mach/hardware.h
+ *
+ * Author: Kevin Wells <kevin.wells@nxp.com>
+ *
+ * Copyright (C) 2009 NXP Semiconductors
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#ifndef __ASM_ARCH_HARDWARE_H
+#define __ASM_ARCH_HARDWARE_H
+
+#include <asm/sizes.h>
+
+/*
+ * Start of virtual addresses for IO devices
+ */
+#define IO_BASE                0xF0000000
+
+#define io_p2v(x)      (IO_BASE | (((x) & 0xff000000) >> 4) |\
+                        ((x) & 0x000fffff))
+#define io_v2p(x)      ((((x) & 0x0ff00000) << 4) | ((x) & 0x000fffff))
+
+/*
+ * This macro relies on fact that for all HW i/o addresses bits 20-23 are 0
+ */
+#define IO_ADDRESS(x)  (((((x) & 0xff000000) >> 4) | ((x) & 0xfffff)) |\
+                        IO_BASE)
+
+#endif
diff --git a/arch/arm/mach-lpc32xx/include/mach/i2c.h b/arch/arm/mach-lpc32xx/include/mach/i2c.h
new file mode 100644
index 0000000..259ac53
--- /dev/null
+++ b/arch/arm/mach-lpc32xx/include/mach/i2c.h
@@ -0,0 +1,64 @@
+/*
+ * PNX4008-specific tweaks for I2C IP3204 block
+ *
+ * Author: Vitaly Wool <vwool@ru.mvista.com>
+ *
+ * 2005 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#ifndef __ASM_ARCH_I2C_H__
+#define __ASM_ARCH_I2C_H__
+
+enum {
+       mstatus_tdi = 0x00000001,
+       mstatus_afi = 0x00000002,
+       mstatus_nai = 0x00000004,
+       mstatus_drmi = 0x00000008,
+       mstatus_active = 0x00000020,
+       mstatus_scl = 0x00000040,
+       mstatus_sda = 0x00000080,
+       mstatus_rff = 0x00000100,
+       mstatus_rfe = 0x00000200,
+       mstatus_tff = 0x00000400,
+       mstatus_tfe = 0x00000800,
+};
+
+enum {
+       mcntrl_tdie = 0x00000001,
+       mcntrl_afie = 0x00000002,
+       mcntrl_naie = 0x00000004,
+       mcntrl_drmie = 0x00000008,
+       mcntrl_daie = 0x00000020,
+       mcntrl_rffie = 0x00000040,
+       mcntrl_tffie = 0x00000080,
+       mcntrl_reset = 0x00000100,
+       mcntrl_cdbmode = 0x00000400,
+};
+
+enum {
+       rw_bit = 1 << 0,
+       start_bit = 1 << 8,
+       stop_bit = 1 << 9,
+};
+
+#define I2C_REG_RX(a)  ((a)->ioaddr)           /* Rx FIFO reg (RO) */
+#define I2C_REG_TX(a)  ((a)->ioaddr)           /* Tx FIFO reg (WO) */
+#define I2C_REG_STS(a) ((a)->ioaddr + 0x04)    /* Status reg (RO) */
+#define I2C_REG_CTL(a) ((a)->ioaddr + 0x08)    /* Ctl reg */
+#define I2C_REG_CKL(a) ((a)->ioaddr + 0x0c)    /* Clock divider low */
+#define I2C_REG_CKH(a) ((a)->ioaddr + 0x10)    /* Clock divider high */
+#define I2C_REG_ADR(a) ((a)->ioaddr + 0x14)    /* I2C address */
+#define I2C_REG_RFL(a) ((a)->ioaddr + 0x18)    /* Rx FIFO level (RO) */
+#define I2C_REG_TFL(a) ((a)->ioaddr + 0x1c)    /* Tx FIFO level (RO) */
+#define I2C_REG_RXB(a) ((a)->ioaddr + 0x20)    /* Num of bytes Rx-ed (RO) */
+#define I2C_REG_TXB(a) ((a)->ioaddr + 0x24)    /* Num of bytes Tx-ed (RO) */
+#define I2C_REG_TXS(a) ((a)->ioaddr + 0x28)    /* Tx slave FIFO (RO) */
+#define I2C_REG_STFL(a)        ((a)->ioaddr + 0x2c)    /* Tx slave FIFO level (RO) */
+
+#define HCLK_MHZ               13
+#define I2C_CHIP_NAME          "PNX4008-I2C"
+
+#endif                         /* __ASM_ARCH_I2C_H___ */
diff --git a/arch/arm/mach-lpc32xx/include/mach/io.h b/arch/arm/mach-lpc32xx/include/mach/io.h
new file mode 100644
index 0000000..bc2aa9a
--- /dev/null
+++ b/arch/arm/mach-lpc32xx/include/mach/io.h
@@ -0,0 +1,31 @@
+/*
+ * mach-lpc32xx/include/mach/io.h
+ *
+ * Author: Kevin Wells <kevin.wells@nxp.com>
+ *
+ * Copyright (C) 2009 NXP Semiconductors
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#ifndef __ASM_ARM_ARCH_IO_H
+#define __ASM_ARM_ARCH_IO_H
+
+#define IO_SPACE_LIMIT 0xffffffff
+
+#define __io(a)                __typesafe_io(a)
+#define __mem_pci(a)   (a)
+
+#endif
diff --git a/arch/arm/mach-lpc32xx/include/mach/irqs.h b/arch/arm/mach-lpc32xx/include/mach/irqs.h
new file mode 100644
index 0000000..b80f92b
--- /dev/null
+++ b/arch/arm/mach-lpc32xx/include/mach/irqs.h
@@ -0,0 +1,134 @@
+/*
+ * mach-lpc32xx/include/mach/irqs.h
+ *
+ * Author: Kevin Wells <kevin.wells@nxp.com>
+ *
+ * Copyright (C) 2009 NXP Semiconductors
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#ifndef __ASM_ARM_ARCH_IRQS_H
+#define __ASM_ARM_ARCH_IRQS_H
+
+/*
+ * Register offsets
+ */
+#define INTC_MASK              0x00
+#define INTC_RAW_STAT          0x04
+#define INTC_STAT              0x08
+#define INTC_POLAR             0x0C
+#define INTC_ACT_TYPE          0x10
+#define INTC_TYPE              0x14
+
+/*
+ * Software interrupt group offsets
+ */
+#define INTC_SIC1_OFFS         32
+#define INTC_SIC2_OFFS         64
+
+/*
+ * MIC interrupts
+ */
+#define IRQ_SUB1IRQ            0
+#define IRQ_SUB2IRQ            1
+#define IRQ_PWM3               3
+#define IRQ_PWM4               4
+#define IRQ_HSTIMER            5
+#define IRQ_WATCH              6
+#define IRQ_UART_IIR3          7
+#define IRQ_UART_IIR4          8
+#define IRQ_UART_IIR5          9
+#define IRQ_UART_IIR6          10
+#define IRQ_FLASH              11
+#define IRQ_SD1                        13
+#define IRQ_LCD                        14
+#define IRQ_SD0                        15
+#define IRQ_TIMER0             16
+#define IRQ_TIMER1             17
+#define IRQ_TIMER2             18
+#define IRQ_TIMER3             19
+#define IRQ_SSP0               20
+#define IRQ_SSP1               21
+#define IRQ_I2S0               22
+#define IRQ_I2S1               23
+#define IRQ_UART_IIR7          24
+#define IRQ_UART_IIR2          25
+#define IRQ_UART_IIR1          26
+#define IRQ_MSTIMER            27
+#define IRQ_DMA                        28
+#define IRQ_ETHERNET           29
+#define IRQ_SUB1FIQ            30
+#define IRQ_SUB2FIQ            31
+
+/*
+ * SIC1 interrupts
+ */
+#define IRQ_JTAG_COMM_TX       (INTC_SIC1_OFFS + 1)
+#define IRQ_JTAG_COMM_RX       (INTC_SIC1_OFFS + 2)
+#define IRQ_GPI_11             (INTC_SIC1_OFFS + 4)
+#define IRQ_TS_P               (INTC_SIC1_OFFS + 6)
+#define IRQ_TS_IRQ             (INTC_SIC1_OFFS + 7)
+#define IRQ_TS_AUX             (INTC_SIC1_OFFS + 8)
+#define IRQ_SPI2               (INTC_SIC1_OFFS + 12)
+#define IRQ_PLLUSB             (INTC_SIC1_OFFS + 13)
+#define IRQ_PLLHCLK            (INTC_SIC1_OFFS + 14)
+#define IRQ_PLL397             (INTC_SIC1_OFFS + 17)
+#define IRQ_I2C_2              (INTC_SIC1_OFFS + 18)
+#define IRQ_I2C_1              (INTC_SIC1_OFFS + 19)
+#define IRQ_RTC                        (INTC_SIC1_OFFS + 20)
+#define IRQ_KEY                        (INTC_SIC1_OFFS + 22)
+#define IRQ_SPI1               (INTC_SIC1_OFFS + 23)
+#define IRQ_SW                 (INTC_SIC1_OFFS + 24)
+#define IRQ_USB_OTG_TIMER      (INTC_SIC1_OFFS + 25)
+#define IRQ_USB_OTG_ATX                (INTC_SIC1_OFFS + 26)
+#define IRQ_USB_HOST           (INTC_SIC1_OFFS + 27)
+#define IRQ_USB_DEV_DMA                (INTC_SIC1_OFFS + 28)
+#define IRQ_USB_DEV_LP         (INTC_SIC1_OFFS + 29)
+#define IRQ_USB_DEV_HP         (INTC_SIC1_OFFS + 30)
+#define IRQ_USB_I2C            (INTC_SIC1_OFFS + 31)
+
+/*
+ * SIC2 interrupts
+ */
+#define IRQ_GPIO_00            (INTC_SIC2_OFFS + 0)
+#define IRQ_GPIO_01            (INTC_SIC2_OFFS + 1)
+#define IRQ_GPIO_02            (INTC_SIC2_OFFS + 2)
+#define IRQ_GPIO_03            (INTC_SIC2_OFFS + 3)
+#define IRQ_GPIO_04            (INTC_SIC2_OFFS + 4)
+#define IRQ_GPIO_05            (INTC_SIC2_OFFS + 5)
+#define IRQ_SPI2_DATAIN                (INTC_SIC2_OFFS + 6)
+#define IRQ_U2_HCTS            (INTC_SIC2_OFFS + 7)
+#define IRQ_P0_P1_IRQ          (INTC_SIC2_OFFS + 8)
+#define IRQ_GPI_08             (INTC_SIC2_OFFS + 9)
+#define IRQ_GPI_09             (INTC_SIC2_OFFS + 10)
+#define IRQ_GPI_10             (INTC_SIC2_OFFS + 11)
+#define IRQ_U7_HCTS            (INTC_SIC2_OFFS + 12)
+#define IRQ_GPI_07             (INTC_SIC2_OFFS + 15)
+#define IRQ_SDIO               (INTC_SIC2_OFFS + 18)
+#define IRQ_U5_RX              (INTC_SIC2_OFFS + 19)
+#define IRQ_SPI1_DATAIN                (INTC_SIC2_OFFS + 20)
+#define IRQ_GPI_00             (INTC_SIC2_OFFS + 22)
+#define IRQ_GPI_01             (INTC_SIC2_OFFS + 23)
+#define IRQ_GPI_02             (INTC_SIC2_OFFS + 24)
+#define IRQ_GPI_03             (INTC_SIC2_OFFS + 25)
+#define IRQ_GPI_04             (INTC_SIC2_OFFS + 26)
+#define IRQ_GPI_05             (INTC_SIC2_OFFS + 27)
+#define IRQ_GPI_06             (INTC_SIC2_OFFS + 28)
+#define IRQ_SYSCLK             (INTC_SIC2_OFFS + 31)
+
+#define NR_IRQS                        96
+
+#endif
diff --git a/arch/arm/mach-lpc32xx/include/mach/memory.h b/arch/arm/mach-lpc32xx/include/mach/memory.h
new file mode 100644
index 0000000..0958e85
--- /dev/null
+++ b/arch/arm/mach-lpc32xx/include/mach/memory.h
@@ -0,0 +1,119 @@
+/*
+ * mach-lpc32xx/include/mach/memory.h
+ *
+ * Author: Kevin Wells <kevin.wells@nxp.com>
+ *
+ * Copyright (C) 2009 NXP Semiconductors
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#ifndef __ASM_ARCH_MEMORY_H
+#define __ASM_ARCH_MEMORY_H
+
+/*
+ * Physical DRAM offset.
+ */
+#define PHYS_OFFSET    (0x80000000)
+
+#if defined (CONFIG_ARCH_DISCONTIGMEM_ENABLE)
+/*
+ * There are 2 nodes in the system when 2 DRAM devices are used on DYCS0 and
+ * DYCS1. Based on the virtual address passed, here, return node 0 if the
+ * address is in the DYCS0 range or node 1 if it is in the DYCS1 range.
+ */
+
+#if defined(CONFIG_MACH_LPC32XX_DRAM_SIZE_32)
+/*
+ * This support is added for systems that have 2 8MByte devices on different
+ * chip selects (DYCS0 and DYCS1). In this configuration, there is a memory
+ * hole between the 2 devices such that the addresses are as follows:
+ * DYCS0 - 0x80000000 - 0x81ffffff (node 0, 8Kpages)
+ * DYCS1 - 0xa0000000 - 0xa1ffffff (node 1, 8Kpages)
+ */
+#define KVADDR_TO_NID(addr) \
+      (((unsigned long) (addr) - PAGE_OFFSET) >> 25)
+
+#define LOCAL_MAP_NR(addr) \
+       (((unsigned long)(addr) & 0x01ffffff) >> PAGE_SHIFT)
+
+#define __virt_to_phys(x) \
+       ((((unsigned long) (x) & ~0x02000000) - PAGE_OFFSET + PHYS_OFFSET) |\
+       (((unsigned long) (x) & 0x02000000) << 4))
+
+#define __phys_to_virt(x) \
+       ((((unsigned long) (x) & ~0x20000000) - PHYS_OFFSET + PAGE_OFFSET) |\
+       (((unsigned long) (x) & 0x20000000) >> 4))
+#endif
+
+#if defined(CONFIG_MACH_LPC32XX_DRAM_SIZE_64)
+/*
+ * This support is added for systems that have 2 64MByte devices on different
+ * chip selects (DYCS0 and DYCS1). In this configuration, there is a memory
+ * hole between the 2 devices such that the addresses are as follows:
+ * DYCS0 - 0x80000000 - 0x83ffffff (node 0, 16Kpages)
+ * DYCS1 - 0xa0000000 - 0xa3ffffff (node 1, 16Kpages)
+ */
+#define KVADDR_TO_NID(addr) \
+       (((unsigned long) (addr) - PAGE_OFFSET) >> 26)
+
+#define LOCAL_MAP_NR(addr) \
+       (((unsigned long)(addr) & 0x03ffffff) >> PAGE_SHIFT)
+
+#define __virt_to_phys(x) \
+       ((((unsigned long) (x) & ~0x04000000) - PAGE_OFFSET + PHYS_OFFSET) |\
+       (((unsigned long) (x) & 0x04000000) << 3))
+
+#define __phys_to_virt(x) \
+       ((((unsigned long) (x) & ~0x20000000) - PHYS_OFFSET + PAGE_OFFSET) |\
+       (((unsigned long) (x) & 0x20000000) >> 3))
+#endif
+
+#if defined(CONFIG_MACH_LPC32XX_DRAM_SIZE_128)
+/*
+ * This support is added for systems that have 2 128MByte devices on different
+ * chip selects (DYCS0 and DYCS1). In this configuration, there is a memory
+ * hole between the 2 devices such that the addresses are as follows:
+ * DYCS0 - 0x80000000 - 0x87ffffff (node 0, 32Kpages)
+ * DYCS1 - 0xa0000000 - 0xa7ffffff (node 1, 32Kpages)
+ */
+#define KVADDR_TO_NID(addr) \
+       (((unsigned long) (addr) - PAGE_OFFSET) >> 27)
+
+#define LOCAL_MAP_NR(addr) \
+       (((unsigned long)(addr) & 0x07ffffff) >> PAGE_SHIFT)
+
+#define __virt_to_phys(x) \
+       ((((unsigned long) (x) & ~0x08000000) - PAGE_OFFSET + PHYS_OFFSET) |\
+       (((unsigned long) (x) & 0x08000000) << 2))
+
+#define __phys_to_virt(x) \
+       ((((unsigned long) (x) & ~0x20000000) - PHYS_OFFSET + PAGE_OFFSET) |\
+       (((unsigned long) (x) & 0x20000000) >> 2))
+#endif
+
+/*
+ * Convert a page frame number to a node id
+ */
+#define PFN_TO_NID(pfn) \
+       (((unsigned long) (pfn) - PHYS_PFN_OFFSET) >> (29 - PAGE_SHIFT))
+
+#else
+#define __virt_to_bus(x) ((x) - PAGE_OFFSET + PHYS_OFFSET)
+#define __bus_to_virt(x) ((x) + PAGE_OFFSET - PHYS_OFFSET)
+#endif /* defined (CONFIG_ARCH_DISCONTIGMEM_ENABLE) */
+
+#endif
+
diff --git a/arch/arm/mach-lpc32xx/include/mach/system.h b/arch/arm/mach-lpc32xx/include/mach/system.h
new file mode 100644
index 0000000..b985aee
--- /dev/null
+++ b/arch/arm/mach-lpc32xx/include/mach/system.h
@@ -0,0 +1,40 @@
+/*
+ * mach-lpc32xx/include/mach/system.h
+ *
+ * Author: Kevin Wells <kevin.wells@nxp.com>
+ *
+ * Copyright (C) 2009 NXP Semiconductors
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#ifndef __ASM_ARCH_SYSTEM_H
+#define __ASM_ARCH_SYSTEM_H
+
+#include <mach/hardware.h>
+#include <mach/io.h>
+#include <mach/platform.h>
+
+static void arch_idle(void)
+{
+       cpu_do_idle();
+}
+
+static inline void arch_reset(char mode, const char *cmd)
+{
+       cpu_reset(0);
+}
+
+#endif
diff --git a/arch/arm/mach-lpc32xx/include/mach/timex.h b/arch/arm/mach-lpc32xx/include/mach/timex.h
new file mode 100644
index 0000000..4385fc7
--- /dev/null
+++ b/arch/arm/mach-lpc32xx/include/mach/timex.h
@@ -0,0 +1,31 @@
+/*
+ * mach-lpc32xx/include/mach/timex.h
+ *
+ * Author: Kevin Wells <kevin.wells@nxp.com>
+ *
+ * Copyright (C) 2009 NXP Semiconductors
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#ifndef __ASM_ARCH_TIMEX_H
+#define __ASM_ARCH_TIMEX_H
+
+#include <mach/platform.h>
+
+#define CLOCK_TICK_RATE        (MAIN_OSC_FREQ)
+
+#endif
+
diff --git a/arch/arm/mach-lpc32xx/include/mach/uncompress.h b/arch/arm/mach-lpc32xx/include/mach/uncompress.h
new file mode 100644
index 0000000..3dc18c3
--- /dev/null
+++ b/arch/arm/mach-lpc32xx/include/mach/uncompress.h
@@ -0,0 +1,111 @@
+/*
+ * mach-lpc32xx/include/mach/uncompress.h
+ *
+ * Author: Kevin Wells <kevin.wells@nxp.com>
+ *
+ * Copyright (C) 2009 NXP Semiconductors
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#ifndef __ASM_ARM_ARCH_UNCOMPRESS_H
+#define __ASM_ARM_ARCH_UNCOMPRESS_H
+
+#include <mach/platform.h>
+
+#if defined (CONFIG_UNCOMP_HSU1) || defined (CONFIG_UNCOMP_HSU2) || defined (CONFIG_UNCOMP_HSU7)
+/*
+ * High speed UART uncompress output support
+*/
+#if defined (CONFIG_UNCOMP_HSU1)
+#define HSUART_FIFO     (*(volatile unsigned long*)(HS_UART1_BASE + 0x00))
+#define HSUART_LEVEL    (*(volatile unsigned long*)(HS_UART1_BASE + 0x04))
+#endif
+
+#if defined (CONFIG_UNCOMP_HSU2)
+#define HSUART_FIFO     (*(volatile unsigned long*)(HS_UART2_BASE + 0x00))
+#define HSUART_LEVEL    (*(volatile unsigned long*)(HS_UART2_BASE + 0x04))
+#endif
+
+#if defined (CONFIG_UNCOMP_HSU7)
+#define HSUART_FIFO     (*(volatile unsigned long*)(HS_UART7_BASE + 0x00))
+#define HSUART_LEVEL    (*(volatile unsigned long*)(HS_UART7_BASE + 0x04))
+#endif
+
+static inline void putc(int ch)
+{
+       /* Wait for transmit FIFO to empty */
+       while ((HSUART_LEVEL & 0xFF00) != 0);
+       HSUART_FIFO = ch;
+}
+static inline void flush(void)
+{
+       /* Don't see a reset? */
+       /* Then just wait for transmition to complete */
+       while ((HSUART_LEVEL & 0xFF00) != 0);
+}
+
+#else
+/*
+ * Standard UART uncompress output support
+*/
+
+#define UART_FIFO_CTL_TX_RESET (1 << 2)
+#define UART_STATUS_TX_MT      (1 << 6)
+
+#if defined (CONFIG_UNCOMP_U3)
+#define UART_DATA      (*(volatile unsigned long*) (UART3_BASE + 0x00))
+#define UART_FIFO_CTL  (*(volatile unsigned long*) (UART3_BASE + 0x08))
+#define UART_STATUS    (*(volatile unsigned long*) (UART3_BASE + 0x14))
+#endif
+
+#if defined (CONFIG_UNCOMP_U4)
+#define UART_DATA      (*(volatile unsigned long*) (UART4_BASE + 0x00))
+#define UART_FIFO_CTL  (*(volatile unsigned long*) (UART4_BASE + 0x08))
+#define UART_STATUS    (*(volatile unsigned long*) (UART4_BASE + 0x14))
+#endif
+
+#if defined (CONFIG_UNCOMP_U5)
+#define UART_DATA      (*(volatile unsigned long*) (UART5_BASE + 0x00))
+#define UART_FIFO_CTL  (*(volatile unsigned long*) (UART5_BASE + 0x08))
+#define UART_STATUS    (*(volatile unsigned long*) (UART5_BASE + 0x14))
+#endif
+
+#if defined (CONFIG_UNCOMP_U6)
+#define UART_DATA      (*(volatile unsigned long*) (UART6_BASE + 0x00))
+#define UART_FIFO_CTL  (*(volatile unsigned long*) (UART6_BASE + 0x08))
+#define UART_STATUS    (*(volatile unsigned long*) (UART6_BASE + 0x14))
+#endif
+
+static inline void putc(int ch)
+{
+       /* Wait for transmit FIFO to empty */
+       while ((UART_STATUS & UART_STATUS_TX_MT) == 0);
+
+       UART_DATA = ch;
+}
+
+static inline void flush(void)
+{
+       UART_FIFO_CTL |= UART_FIFO_CTL_TX_RESET;
+}
+#endif
+
+/* NULL functions; we don't presently need them */
+#define arch_decomp_setup()
+#define arch_decomp_wdog()
+
+#endif
+
diff --git a/arch/arm/mach-lpc32xx/include/mach/vmalloc.h b/arch/arm/mach-lpc32xx/include/mach/vmalloc.h
new file mode 100644
index 0000000..7bbf2c2
--- /dev/null
+++ b/arch/arm/mach-lpc32xx/include/mach/vmalloc.h
@@ -0,0 +1,33 @@
+/*
+ * mach-lpc32xx/include/mach/vmalloc.h
+ *
+ * Author: Kevin Wells <kevin.wells@nxp.com>
+ *
+ * Copyright (C) 2009 NXP Semiconductors
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#ifndef __ASM_ARCH_VMALLOC_H
+#define __ASM_ARCH_VMALLOC_H
+
+#if defined (CONFIG_ARCH_DISCONTIGMEM_ENABLE)
+#define VMALLOC_END    (0xF0000000)
+
+#else
+#define VMALLOC_END    (PAGE_OFFSET + 0x10000000)
+#endif
+
+#endif
--
1.6.0.6
