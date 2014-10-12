From: linux@rempel-privat.de (Oleksij Rempel)
Date: Sun, 12 Oct 2014 21:19:18 +0200
Subject: [PATCH v4 07/10] tty/serial/mxs-auart.c: add initial Alphascale
 ASM9260 support
In-Reply-To: <1413141561-8916-1-git-send-email-linux@rempel-privat.de>
References: <1413141561-8916-1-git-send-email-linux@rempel-privat.de>
Message-ID: <1413141561-8916-8-git-send-email-linux@rempel-privat.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alphascale ASM9260 uart IP has some common registers with
Freescale STMP37XX. This patch provide initial changes which
allow to reuse mxs-auart.c code for ASM9260.

Signed-off-by: Oleksij Rempel <linux@rempel-privat.de>
---
 drivers/tty/serial/Kconfig                     |   5 +-
 drivers/tty/serial/alphascale,asm9260_serial.h | 373 +++++++++++++++++++++++++
 drivers/tty/serial/mxs-auart.c                 | 344 +++++++++++++++--------
 3 files changed, 599 insertions(+), 123 deletions(-)
 create mode 100644 drivers/tty/serial/alphascale,asm9260_serial.h

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 26cec64..11bbb76 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1385,11 +1385,12 @@ config SERIAL_MSM_SMD
 	  ports via tty device interface for MSM chipset.
 
 config SERIAL_MXS_AUART
-	depends on ARCH_MXS
+	depends on ARCH_MXS || MACH_ASM9260
 	tristate "MXS AUART support"
 	select SERIAL_CORE
 	help
-	  This driver supports the MXS Application UART (AUART) port.
+	  This driver supports the MXS and Alphascale ASM9260 Application
+	  UART (AUART) port.
 
 config SERIAL_MXS_AUART_CONSOLE
 	bool "MXS AUART console support"
diff --git a/drivers/tty/serial/alphascale,asm9260_serial.h b/drivers/tty/serial/alphascale,asm9260_serial.h
new file mode 100644
index 0000000..eeed9c4
--- /dev/null
+++ b/drivers/tty/serial/alphascale,asm9260_serial.h
@@ -0,0 +1,373 @@
+/*
+ * Copyright (C) 2014 Oleksij Rempel <linux@rempel-privat.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _ALPHASCALE_ASM9260_SERIAL_H
+#define _ALPHASCALE_ASM9260_SERIAL_H
+
+/* RX ctrl register */
+#define ASM9260_HW_CTRL0			0x0000
+/* RW. Set to zero for normal operation. */
+#define ASM9260_BM_CTRL0_SFTRST			BIT(31)
+/*
+ * RW. 0 for normal operation; 1 gates all of the block level clocks off for
+ * miniminizing AC energy consumption.
+ */
+#define ASM9260_BM_CTRL0_CLKGATE		BIT(30)
+/*
+ * RW. Tell the UART to execute the RX DMA Command. The
+ * UART will clear this bit at the end of receive execution.
+ */
+#define ASM9260_BM_CTRL0_RXDMA_RUN		BIT(28)
+/* RW. 0 use FIFO for status register; 1 use DMA */
+#define ASM9260_BM_CTRL0_RXTO_SOURCE_STATUS	BIT(25)
+/*
+ * RW. RX TIMEOUT Enable. Valid for FIFO and DMA.
+ * Warning: If this bit is set to 0, the RX timeout will not affect receive DMA
+ * operation. If this bit is set to 1, a receive timeout will cause the receive
+ * DMA logic to terminate by filling the remaining DMA bytes with garbage data.
+ */
+#define ASM9260_BM_CTRL0_RXTO_ENABLE		BIT(24)
+/*
+ * RW. Receive Timeout Counter Value: number of 8-bit-time to wait before
+ * asserting timeout on the RX input. If the RXFIFO is not empty and the RX
+ * input is idle, then the watchdog counter will decrement each bit-time. Note
+ * 7-bit-time is added to the programmed value, so a value of zero will set
+ * the counter to 7-bit-time, a value of 0x1 gives 15-bit-time and so on. Also
+ * note that the counter is reloaded at the end of each frame, so if the frame
+ * is 10 bits long and the timeout counter value is zero, then timeout will
+ * occur (when FIFO is not empty) even if the RX input is not idle. The default
+ * value is 0x3 (31 bit-time).
+ */
+#define ASM9260_BM_CTRL0_RXTO_MASK		(0xff<<16)
+/* TIMEOUT = (100*7+1)*(1/BAUD) */
+#define ASM9260_BM_CTRL0_DEFAULT_RXTIMEOUT	(20<<16)
+/* RW. Number of bytes to receive. This must be a multiple of 4 */
+#define ASM9260_BM_CTRL0_RXDMA_COUNT_MASK	(0xffff<<0)
+
+/* TX ctrl register */
+#define ASM9260_HW_CTRL1			0x0010
+/*
+ * RW. Tell the UART to execute the TX DMA Command. The
+ * UART will clear this bit at the end of transmit execution.
+ */
+#define ASM9260_BM_CTRL1_TXDMA_RUN		BIT(28)
+/* RW. Number of bytes to transmit. */
+#define ASM9260_BM_CTRL1_TXDMA_COUNT_MASK	(0xffff << 0)
+
+#define ASM9260_HW_CTRL2			0x0020
+/*
+ * RW. Receive dma will terminate on error. (Cmd_end signal may not be asserted
+ * when this occurs.)
+ */
+#define ASM9260_BM_CTRL2_DMAONERROR		BIT(26)
+/*
+ * RW. Transmit DMA Enable. Data Register can be loaded with up to 4 bytes per
+ * write. TXFIFO must be enabled in TXDMA mode.
+ */
+#define ASM9260_BM_CTRL2_TXDMAE			BIT(25)
+/*
+ * RW. Receive DMA Enable. Data Register can be contain up to 4 bytes per read.
+ * RXFIFO must be enabled in RXDMA mode.
+ */
+#define ASM9260_BM_CTRL2_RXDMAE			BIT(24)
+/*
+ * RW. Receive Interrupt FIFO Level Select.
+ * The trigger points for the receive interrupt are as follows:
+ * ONE_EIGHTHS = 0x0 Trigger on FIFO full to at least 2 of 16 entries.
+ * ONE_QUARTER = 0x1 Trigger on FIFO full to at least 4 of 16 entries.
+ * ONE_HALF = 0x2 Trigger on FIFO full to at least 8 of 16 entries.
+ * THREE_QUARTERS = 0x3 Trigger on FIFO full to at least 12 of 16 entries.
+ * SEVEN_EIGHTHS = 0x4 Trigger on FIFO full to at least 14 of 16 entries.
+ */
+#define ASM9260_BM_CTRL2_RXIFLSEL		(7<<20)
+#define ASM9260_BM_CTRL2_DEFAULT_RXIFLSEL	(3<<20)
+/* RW. Same as RXIFLSEL */
+#define ASM9260_BM_CTRL2_TXIFLSEL		(7<<16)
+#define ASM9260_BM_CTRL2_DEFAULT_TXIFLSEL	(2<<16)
+/* RW. CTS Enable */
+#define ASM9260_BM_CTRL2_CTSE			BIT(15)
+/* RW. RTS Enable */
+#define ASM9260_BM_CTRL2_RTSE			BIT(14)
+/*
+ * RW. Manually trigger RTS. Works only if ASM9260_BM_CTRL2_RTSE = 0.
+ * When this bit is 1, the output is 0.
+ */
+#define ASM9260_BM_CTRL2_RTS			BIT(11)
+/* RW. Set DTR. When this bit is 1, the output is 0. */
+#define ASM9260_BM_CTRL2_DTR			BIT(10)
+/* RW. RX Enable */
+#define ASM9260_BM_CTRL2_RXE			BIT(9)
+/* RW. TX Enable */
+#define ASM9260_BM_CTRL2_TXE			BIT(8)
+/* RW. Loop Back Enable */
+#define ASM9260_BM_CTRL2_LBE			BIT(7)
+#define ASM9260_BM_CTRL2_PORT_ENABLE		BIT(0)
+
+#define ASM9260_HW_LINECTRL			0x0030
+#define ASM9260_BM_LCTRL_BAUD_DIVINT		(0xFFFF<<16)
+#define ASM9260_BM_LCTRL_BAUD_DIVFRA		(0x3F<<8)
+/*
+ * RW. Stick Parity Select. When bits 1, 2, and 7 of this register are set, the
+ * parity bit is transmitted and checked as a 0. When bits 1 and 7 are set,
+ * and bit 2 is 0, the parity bit is transmitted and checked as a 1. When this
+ * bit is cleared stick parity is disabled.
+ */
+#define ASM9260_BM_LCTRL_SPS			BIT(7)
+/* RW. Word length */
+#define ASM9260_BM_LCTRL_WLEN			(3<<5)
+#define ASM9260_BM_LCTRL_CHRL_5			(0<<5)
+#define ASM9260_BM_LCTRL_CHRL_6			(1<<5)
+#define ASM9260_BM_LCTRL_CHRL_7			(2<<5)
+#define ASM9260_BM_LCTRL_CHRL_8			(3<<5)
+/*
+ * RW. Enable FIFOs. If this bit is set to 1, transmit and receive FIFO buffers
+ * are enabled (FIFO mode). When cleared to 0, the FIFOs are disabled (character
+ * mode); that is, the FIFOs become 1-byte-deep holding registers.
+ */
+#define ASM9260_BM_LCTRL_FEN			BIT(4)
+/*
+ * RW. Two Stop Bits Select. If this bit is set to 1, two stop bits are
+ * transmitted at the end of the frame. The receive logic does not check for
+ * two stop bits being received.
+ */
+#define ASM9260_BM_LCTRL_STP2			BIT(3)
+#define ASM9260_BM_LCTRL_NBSTOP_1		(0<<3)
+#define ASM9260_BM_LCTRL_NBSTOP_2		(1<<3)
+/* RW. Even Parity Select. If disabled, then odd parity is performed. */
+#define ASM9260_BM_LCTRL_EPS			BIT(2)
+/* Parity Enable. */
+#define ASM9260_BM_LCTRL_PEN			BIT(1)
+#define ASM9260_BM_LCTRL_PAR_MARK		((3<<1) | (1<<7))
+#define ASM9260_BM_LCTRL_PAR_SPACE		((1<<1) | (1<<7))
+#define ASM9260_BM_LCTRL_PAR_ODD		((1<<1) | (0<<7))
+#define ASM9260_BM_LCTRL_PAR_EVEN		((3<<1) | (0<<7))
+#define ASM9260_BM_LCTRL_PAR_NONE		(0<<1)
+/*
+ * RW. Send Break. If this bit is set to 1, a low-level is continually output on
+ * the UARTTXD output, after completing transmission of the current character.
+ * For the proper execution of the break command, the software must set this bit
+ * for@least two complete frames. For normal use, this bit must be cleared
+ * to 0.
+ */
+#define ASM9260_BM_LCTRL_BREAK			BIT(0)
+
+/*
+ * Interrupt register.
+ * contains the interrupt enables and the interrupt status bits
+ */
+#define ASM9260_HW_INTR				0x0040
+/* Tx FIFO EMPTY Raw Interrupt enable */
+#define ASM9260_BM_INTR_TFEIEN			BIT(27)
+/* Overrun Error Interrupt Enable. */
+#define ASM9260_BM_INTR_OEIEN			BIT(26)
+/* Break Error Interrupt Enable. */
+#define ASM9260_BM_INTR_BEIEN			BIT(25)
+/* Parity Error Interrupt Enable. */
+#define ASM9260_BM_INTR_PEIEN			BIT(24)
+/* Framing Error Interrupt Enable. */
+#define ASM9260_BM_INTR_FEIEN			BIT(23)
+/*
+ * RW. Receive Timeout Interrupt Enable.
+ * If not set and FIFO is enabled, then RX will be triggered only
+ * if FIFO is full.
+ */
+#define ASM9260_BM_INTR_RTIEN			BIT(22)
+/* Transmit Interrupt Enable. */
+#define ASM9260_BM_INTR_TXIEN			BIT(21)
+/* Receive Interrupt Enable. */
+#define ASM9260_BM_INTR_RXIEN			BIT(20)
+/* nUARTDSR Modem Interrupt Enable. */
+#define ASM9260_BM_INTR_DSRMIEN			BIT(19)
+/* nUARTDCD Modem Interrupt Enable. */
+#define ASM9260_BM_INTR_DCDMIEN			BIT(18)
+/* nUARTCTS Modem Interrupt Enable. */
+#define ASM9260_BM_INTR_CTSMIEN			BIT(17)
+/* nUARTRI Modem Interrupt Enable. */
+#define ASM9260_BM_INTR_RIMIEN			BIT(16)
+/* Auto-Boud Timeout */
+#define ASM9260_BM_INTR_ABTO			BIT(13)
+#define ASM9260_BM_INTR_ABEO			BIT(12)
+/* Tx FIFO EMPTY Raw Interrupt state */
+#define ASM9260_BM_INTR_TFEIS			BIT(11)
+/* Overrun Error */
+#define ASM9260_BM_INTR_OEIS			BIT(10)
+/* Break Error */
+#define ASM9260_BM_INTR_BEIS			BIT(9)
+/* Parity Error */
+#define ASM9260_BM_INTR_PEIS			BIT(8)
+/* Framing Error */
+#define ASM9260_BM_INTR_FEIS			BIT(7)
+/* Receive Timeout */
+#define ASM9260_BM_INTR_RTIS			BIT(6)
+/* Transmit done */
+#define ASM9260_BM_INTR_TXIS			BIT(5)
+/* Receive done */
+#define ASM9260_BM_INTR_RXIS			BIT(4)
+#define ASM9260_BM_INTR_DSRMIS			BIT(3)
+#define ASM9260_BM_INTR_DCDMIS			BIT(2)
+#define ASM9260_BM_INTR_CTSMIS			BIT(1)
+#define ASM9260_BM_INTR_RIMIS			BIT(0)
+#define ASM9260_BM_INTR_DEF_MASK	(ASM9260_BM_INTR_RXIEN \
+		| ASM9260_BM_INTR_TXIEN | ASM9260_BM_INTR_RTIEN \
+		| ASM9260_BM_INTR_FEIEN | ASM9260_BM_INTR_PEIEN \
+		| ASM9260_BM_INTR_BEIEN | ASM9260_BM_INTR_OEIEN)
+#define ASM9260_BM_INTR_DEF_IS_MASK		(BM_INTR_DEF_MASK >> 16)
+#define ASM9260_BM_INTR_EN_MASK			(0x3fff0000)
+#define ASM9260_BM_INTR_IS_MASK			(0x00003fff)
+
+/*
+ * RW. In DMA mode, up to 4 Received/Transmit characters can be accessed at a
+ * time. In PIO mode, only one character can be accessed at a time. The status
+ * register contains the receive data flags and valid bits.
+ */
+#define ASM9260_HW_DATA				0x0050
+
+#define ASM9260_HW_STAT				0x0060
+/* RO. If 1, UARTAPP is present in this product. */
+#define ASM9260_BM_STAT_PRESENT			BIT(31)
+/* RO. If 1, HISPEED is present in this product. */
+#define ASM9260_BM_STAT_HISPEED			BIT(30)
+/* RO. UART Busy. */
+#define ASM9260_BM_STAT_BUSY			BIT(29)
+/* RO. Clear To Send. */
+#define ASM9260_BM_STAT_CTS			BIT(28)
+/* RO. Transmit FIFO/PIO Empty */
+#define ASM9260_BM_STAT_TXEMPTY			BIT(27)
+/* RO. Receive FIFO Full. */
+#define ASM9260_BM_STAT_RXFULL			BIT(26)
+/* RO. Transmit FIFO Full. */
+#define ASM9260_BM_STAT_TXFULL			BIT(25)
+/* RO. Receive FIFO Empty. */
+#define ASM9260_BM_STAT_RXEMPTY			BIT(24)
+/*
+ * RW. The invalid state of the last read of Receive Data. Each
+ * bit corresponds to one byte of the RX data. (1 = invalid.)
+ */
+#define ASM9260_BM_STAT_RXBYTE_INVALID_MASK	(0xf<<20)
+/*
+ * RO. Overrun Error. This bit is set to 1 if data is received and the FIFO is
+ * already full. This bit is cleared to 0 by any write to the Status Register.
+ * The FIFO contents remain valid since no further data is written when the
+ * FIFO is full; only the contents of the shift register are overwritten. The
+ * CPU must now read the data in order to empty the FIFO.
+ */
+#define ASM9260_BM_STAT_OVERRUNERR		BIT(19)
+/*
+ * RW. Break Error. For PIO mode, this is for the last character read from the
+ * data register. For DMA mode, it will be set to 1 if any received character
+ * for a particular RXDMA command had a Break Error. To clear this bit, write a
+ * zero to it. Note that clearing this bit does not affect the interrupt status,
+ * which must be cleared by writing the interrupt register.
+ */
+#define ASM9260_BM_STAT_BREAKERR		BIT(18)
+/* RW. Parity Error. Same as BREAKERR. */
+#define ASM9260_BM_STAT_PARITYERR		BIT(17)
+/* RW. Framing Erro. Same as BREAKERR. */
+#define ASM9260_BM_STAT_FRAMEERR		BIT(16)
+/* RO. Number of bytes received during a Receive DMA command. */
+#define ASM9260_BM_STAT_RXCOUNT_MASK		(0xffff<<0)
+
+/* RO. The UART Debug Register contains the state of the DMA signals. */
+#define ASM9260_HW_DEBUG			0x0070
+/* DMA Command Run Status */
+#define ASM9260_BM_DEBUG_TXDMARUN		BIT(5)
+#define ASM9260_BM_DEBUG_RXDMARUN		BIT(4)
+/* DMA Command End Status */
+#define ASM9260_BM_DEBUG_TXCMDEND		BIT(3)
+#define ASM9260_BM_DEBUG_RXCMDEND		BIT(2)
+/* DMA Request Status */
+#define ASM9260_BM_DEBUG_TXDMARQ		BIT(1)
+#define ASM9260_BM_DEBUG_RXDMARQ		BIT(0)
+
+#define ASM9260_HW_ILPR				0x0080
+
+#define ASM9260_HW_RS485CTRL			0x0090
+/*
+ * RW. This bit reverses the polarity of the direction control signal on the RTS
+ * (or DTR) pin.
+ * If 0, The direction control pin will be driven to logic ?0? when the
+ * transmitter has data to be sent. It will be driven to logic ?1? after the
+ * last bit of data has been transmitted.
+ */
+#define ASM9260_BM_RS485CTRL_ONIV		BIT(5)
+/* RW. Enable Auto Direction Control. */
+#define ASM9260_BM_RS485CTRL_DIR_CTRL		BIT(4)
+/*
+ * RW. If 0 and DIR_CTRL = 1, pin RTS is used for direction control.
+ * If 1 and DIR_CTRL = 1, pin DTR is used for direction control.
+ */
+#define ASM9260_BM_RS485CTRL_PINSEL		BIT(3)
+/* RW. Enable Auto Address Detect (AAD). */
+#define ASM9260_BM_RS485CTRL_AADEN		BIT(2)
+/* RW. Disable receiver. */
+#define ASM9260_BM_RS485CTRL_RXDIS		BIT(1)
+/* RW. Enable RS-485/EIA-485 Normal Multidrop Mode (NMM) */
+#define ASM9260_BM_RS485CTRL_RS485EN		BIT(0)
+
+#define ASM9260_HW_RS485ADRMATCH		0x00a0
+/* Contains the address match value. */
+#define ASM9260_BM_RS485ADRMATCH_MASK		(0xff<<0)
+
+#define ASM9260_HW_RS485DLY			0x00b0
+/*
+ * RW. Contains the direction control (RTS or DTR) delay value. This delay time
+ * is in periods of the baud clock.
+ */
+#define ASM9260_BM_RS485DLY_MASK		(0xff<<0)
+
+#define ASM9260_HW_AUTOBAUD			0x00c0
+/* WO. Auto-baud time-out interrupt clear bit. */
+#define ASM9260_BM_AUTOBAUD_ABTOIntClr		BIT(9)
+/* WO. End of auto-baud interrupt clear bit. */
+#define ASM9260_BM_AUTOBAUD_ABEOIntClr		BIT(8)
+/* Restart in case of timeout (counter restarts at next UART Rx falling edge) */
+#define ASM9260_BM_AUTOBAUD_AUTORESTART		BIT(2)
+/* Auto-baud mode select bit. 0 - Mode 0, 1 - Mode 1. */
+#define ASM9260_BM_AUTOBAUD_MODE		BIT(1)
+/*
+ * Auto-baud start (auto-baud is running). Auto-baud run bit. This bit is
+ * automatically cleared after auto-baud completion.
+ */
+#define ASM9260_BM_AUTOBAUD_START		BIT(0)
+
+#define ASM9260_HW_CTRL3			0x00d0
+#define ASM9260_BM_CTRL3_OUTCLK_DIV_MASK	(0xffff<<16)
+/*
+ * RW. Provide clk over OUTCLK pin. In case of asm9260 it can be configured on
+ * pins 137 and 144.
+ */
+#define ASM9260_BM_CTRL3_MASTERMODE		BIT(6)
+/* RW. Baud Rate Mode: 1 - Enable sync mode. 0 - async mode. */
+#define ASM9260_BM_CTRL3_SYNCMODE		BIT(4)
+/* RW. 1 - MSB bit send frist; 0 - LSB bit frist. */
+#define ASM9260_BM_CTRL3_MSBF			BIT(2)
+/* RW. 1 - sample rate = 8 x Baudrate; 0 - sample rate = 16 x Baudrate. */
+#define ASM9260_BM_CTRL3_BAUD8			BIT(1)
+/* RW. 1 - Set word lenght to 9bit. 0 - use ASM9260_BM_LCTRL_WLEN */
+#define ASM9260_BM_CTRL3_9BIT			BIT(0)
+
+#define ASM9260_HW_ISO7816_CTRL			0x00e0
+/* RW. Enable High Speed mode. */
+#define ASM9260_BM_ISO7816CTRL_HS		BIT(12)
+/* Disable Successive Receive NACK */
+#define ASM9260_BM_ISO7816CTRL_DS_NACK		BIT(8)
+#define ASM9260_BM_ISO7816CTRL_MAX_ITER_MASK	(0xff<<4)
+/* Receive NACK Inhibit */
+#define ASM9260_BM_ISO7816CTRL_INACK		BIT(3)
+#define ASM9260_BM_ISO7816CTRL_NEG_DATA		BIT(2)
+/* RW. 1 - ISO7816 mode; 0 - USART mode */
+#define ASM9260_BM_ISO7816CTRL_ENABLE		BIT(0)
+
+#define ASM9260_HW_ISO7816_ERRCNT		0x00f0
+/* Parity error counter. Will be cleared after reading */
+#define ASM9260_BM_ISO7816_NB_ERRORS_MASK	(0xff<<0)
+
+#define ASM9260_HW_ISO7816_STATUS		0x0100
+/* Max number of Repetitions Reached */
+#define ASM9260_BM_ISO7816_STAT_ITERATION	BIT(0)
+#endif
diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index b5c3292..b5a1455 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -1,17 +1,18 @@
 /*
- * Freescale STMP37XX/STMP378X Application UART driver
+ * Application UART driver for:
+ *	Freescale STMP37XX/STMP378X
+ *	Alphascale ASM9260
  *
  * Author: dmitry pervushin <dimka@embeddedalley.com>
  *
+ * Copyright 2014 Oleksij Rempel <linux@rempel-privat.de>
+ *	Provide Alphascale ASM9260 support.
  * Copyright 2008-2010 Freescale Semiconductor, Inc.
  * Copyright 2008 Embedded Alley Solutions, Inc All Rights Reserved.
  *
  * The code contained herein is licensed under the GNU General Public
  * License. You may obtain a copy of the GNU General Public License
  * Version 2 or later at the following locations:
- *
- * http://www.opensource.org/licenses/gpl-license.html
- * http://www.gnu.org/copyleft/gpl.html
  */
 
 #include <linux/kernel.h>
@@ -37,34 +38,23 @@
 #include <linux/dmaengine.h>
 
 #include <asm/cacheflush.h>
+#include "alphascale,asm9260_serial.h"
 
 #define MXS_AUART_PORTS 5
 #define MXS_AUART_FIFO_SIZE		16
+#define MXS_DEVICENAME			"ttyAPP"
+#define DRIVER_NAME			"mxs-auart"
+
+#define SET_REG				0x4
+#define CLR_REG				0x8
+#define TOG_REG				0xc
 
 #define AUART_CTRL0			0x00000000
-#define AUART_CTRL0_SET			0x00000004
-#define AUART_CTRL0_CLR			0x00000008
-#define AUART_CTRL0_TOG			0x0000000c
 #define AUART_CTRL1			0x00000010
-#define AUART_CTRL1_SET			0x00000014
-#define AUART_CTRL1_CLR			0x00000018
-#define AUART_CTRL1_TOG			0x0000001c
 #define AUART_CTRL2			0x00000020
-#define AUART_CTRL2_SET			0x00000024
-#define AUART_CTRL2_CLR			0x00000028
-#define AUART_CTRL2_TOG			0x0000002c
 #define AUART_LINECTRL			0x00000030
-#define AUART_LINECTRL_SET		0x00000034
-#define AUART_LINECTRL_CLR		0x00000038
-#define AUART_LINECTRL_TOG		0x0000003c
 #define AUART_LINECTRL2			0x00000040
-#define AUART_LINECTRL2_SET		0x00000044
-#define AUART_LINECTRL2_CLR		0x00000048
-#define AUART_LINECTRL2_TOG		0x0000004c
 #define AUART_INTR			0x00000050
-#define AUART_INTR_SET			0x00000054
-#define AUART_INTR_CLR			0x00000058
-#define AUART_INTR_TOG			0x0000005c
 #define AUART_DATA			0x00000060
 #define AUART_STAT			0x00000070
 #define AUART_DEBUG			0x00000080
@@ -129,6 +119,17 @@ static struct uart_driver auart_driver;
 enum mxs_auart_type {
 	IMX23_AUART,
 	IMX28_AUART,
+	ASM9260_AUART,
+};
+
+struct mxs_auart_regs {
+	void __iomem *ctrl0;
+	void __iomem *ctrl1;
+	void __iomem *ctrl2;
+	void __iomem *linectrl;
+	void __iomem *intr;
+	void __iomem *data;
+	void __iomem *stat;
 };
 
 struct mxs_auart_port {
@@ -142,9 +143,11 @@ struct mxs_auart_port {
 	unsigned int ctrl;
 	enum mxs_auart_type devtype;
 
+	struct mxs_auart_regs regs;
 	unsigned int irq;
 
 	struct clk *clk;
+	struct clk *clk_ahb;
 	struct device *dev;
 
 	/* for DMA */
@@ -160,6 +163,7 @@ struct mxs_auart_port {
 static struct platform_device_id mxs_auart_devtype[] = {
 	{ .name = "mxs-auart-imx23", .driver_data = IMX23_AUART },
 	{ .name = "mxs-auart-imx28", .driver_data = IMX28_AUART },
+	{ .name = "as-auart-asm9260", .driver_data = ASM9260_AUART },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(platform, mxs_auart_devtype);
@@ -171,7 +175,11 @@ static struct of_device_id mxs_auart_dt_ids[] = {
 	}, {
 		.compatible = "fsl,imx23-auart",
 		.data = &mxs_auart_devtype[IMX23_AUART]
+	}, {
+		.compatible = "alphascale,asm9260-auart",
+		.data = &mxs_auart_devtype[ASM9260_AUART]
 	}, { /* sentinel */ }
+
 };
 MODULE_DEVICE_TABLE(of, mxs_auart_dt_ids);
 
@@ -180,6 +188,11 @@ static inline int is_imx28_auart(struct mxs_auart_port *s)
 	return s->devtype == IMX28_AUART;
 }
 
+static inline int is_asm9260_auart(struct mxs_auart_port *s)
+{
+	return s->devtype == ASM9260_AUART;
+}
+
 static inline bool auart_dma_enabled(struct mxs_auart_port *s)
 {
 	return s->flags & MXS_AUART_DMA_ENABLED;
@@ -281,19 +294,19 @@ static void mxs_auart_tx_chars(struct mxs_auart_port *s)
 	}
 
 
-	while (!(readl(s->port.membase + AUART_STAT) &
+	while (!(readl(s->regs.stat) &
 		 AUART_STAT_TXFF)) {
 		if (s->port.x_char) {
 			s->port.icount.tx++;
 			writel(s->port.x_char,
-				     s->port.membase + AUART_DATA);
+				     s->regs.data);
 			s->port.x_char = 0;
 			continue;
 		}
 		if (!uart_circ_empty(xmit) && !uart_tx_stopped(&s->port)) {
 			s->port.icount.tx++;
 			writel(xmit->buf[xmit->tail],
-				     s->port.membase + AUART_DATA);
+				     s->regs.data);
 			xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
 		} else
 			break;
@@ -303,10 +316,10 @@ static void mxs_auart_tx_chars(struct mxs_auart_port *s)
 
 	if (uart_circ_empty(&(s->port.state->xmit)))
 		writel(AUART_INTR_TXIEN,
-			     s->port.membase + AUART_INTR_CLR);
+			     s->regs.intr + CLR_REG);
 	else
 		writel(AUART_INTR_TXIEN,
-			     s->port.membase + AUART_INTR_SET);
+			     s->regs.intr + SET_REG);
 
 	if (uart_tx_stopped(&s->port))
 		mxs_auart_stop_tx(&s->port);
@@ -318,8 +331,8 @@ static void mxs_auart_rx_char(struct mxs_auart_port *s)
 	u32 stat;
 	u8 c;
 
-	c = readl(s->port.membase + AUART_DATA);
-	stat = readl(s->port.membase + AUART_STAT);
+	c = readl(s->regs.data);
+	stat = readl(s->regs.stat);
 
 	flag = TTY_NORMAL;
 	s->port.icount.rx++;
@@ -354,7 +367,7 @@ static void mxs_auart_rx_char(struct mxs_auart_port *s)
 
 	uart_insert_char(&s->port, stat, AUART_STAT_OERR, c, flag);
 out:
-	writel(stat, s->port.membase + AUART_STAT);
+	writel(stat, s->regs.stat);
 }
 
 static void mxs_auart_rx_chars(struct mxs_auart_port *s)
@@ -362,13 +375,13 @@ static void mxs_auart_rx_chars(struct mxs_auart_port *s)
 	u32 stat = 0;
 
 	for (;;) {
-		stat = readl(s->port.membase + AUART_STAT);
+		stat = readl(s->regs.stat);
 		if (stat & AUART_STAT_RXFE)
 			break;
 		mxs_auart_rx_char(s);
 	}
 
-	writel(stat, s->port.membase + AUART_STAT);
+	writel(stat, s->regs.stat);
 	tty_flip_buffer_push(&s->port.state->port);
 }
 
@@ -404,7 +417,7 @@ static void mxs_auart_set_mctrl(struct uart_port *u, unsigned mctrl)
 {
 	struct mxs_auart_port *s = to_auart_port(u);
 
-	u32 ctrl = readl(u->membase + AUART_CTRL2);
+	u32 ctrl = readl(s->regs.ctrl2);
 
 	ctrl &= ~(AUART_CTRL2_RTSEN | AUART_CTRL2_RTS);
 	if (mctrl & TIOCM_RTS) {
@@ -415,14 +428,14 @@ static void mxs_auart_set_mctrl(struct uart_port *u, unsigned mctrl)
 	}
 
 	s->ctrl = mctrl;
-	writel(ctrl, u->membase + AUART_CTRL2);
+	writel(ctrl, s->regs.ctrl2);
 }
 
 static u32 mxs_auart_get_mctrl(struct uart_port *u)
 {
 	struct mxs_auart_port *s = to_auart_port(u);
-	u32 stat = readl(u->membase + AUART_STAT);
-	int ctrl2 = readl(u->membase + AUART_CTRL2);
+	u32 stat = readl(s->regs.stat);
+	int ctrl2 = readl(s->regs.ctrl2);
 	u32 mctrl = s->ctrl;
 
 	mctrl &= ~TIOCM_CTS;
@@ -445,14 +458,14 @@ static void dma_rx_callback(void *arg)
 
 	dma_unmap_sg(s->dev, &s->rx_sgl, 1, DMA_FROM_DEVICE);
 
-	stat = readl(s->port.membase + AUART_STAT);
+	stat = readl(s->regs.stat);
 	stat &= ~(AUART_STAT_OERR | AUART_STAT_BERR |
 			AUART_STAT_PERR | AUART_STAT_FERR);
 
 	count = stat & AUART_STAT_RXCOUNT_MASK;
 	tty_insert_flip_string(port, s->rx_dma_buf, count);
 
-	writel(stat, s->port.membase + AUART_STAT);
+	writel(stat, s->regs.stat);
 	tty_flip_buffer_push(port);
 
 	/* start the next DMA for RX. */
@@ -506,8 +519,8 @@ static void mxs_auart_dma_exit_channel(struct mxs_auart_port *s)
 		s->rx_dma_chan = NULL;
 	}
 
-	kfree(s->tx_dma_buf);
-	kfree(s->rx_dma_buf);
+	devm_kfree(s->dev, s->tx_dma_buf);
+	devm_kfree(s->dev, s->rx_dma_buf);
 	s->tx_dma_buf = NULL;
 	s->rx_dma_buf = NULL;
 }
@@ -516,7 +529,7 @@ static void mxs_auart_dma_exit(struct mxs_auart_port *s)
 {
 
 	writel(AUART_CTRL2_TXDMAE | AUART_CTRL2_RXDMAE | AUART_CTRL2_DMAONERR,
-		s->port.membase + AUART_CTRL2_CLR);
+		s->regs.ctrl2 + CLR_REG);
 
 	mxs_auart_dma_exit_channel(s);
 	s->flags &= ~MXS_AUART_DMA_ENABLED;
@@ -533,7 +546,8 @@ static int mxs_auart_dma_init(struct mxs_auart_port *s)
 	s->rx_dma_chan = dma_request_slave_channel(s->dev, "rx");
 	if (!s->rx_dma_chan)
 		goto err_out;
-	s->rx_dma_buf = kzalloc(UART_XMIT_SIZE, GFP_KERNEL | GFP_DMA);
+	s->rx_dma_buf = devm_kzalloc(s->dev,
+			UART_XMIT_SIZE, GFP_KERNEL | GFP_DMA);
 	if (!s->rx_dma_buf)
 		goto err_out;
 
@@ -541,7 +555,8 @@ static int mxs_auart_dma_init(struct mxs_auart_port *s)
 	s->tx_dma_chan = dma_request_slave_channel(s->dev, "tx");
 	if (!s->tx_dma_chan)
 		goto err_out;
-	s->tx_dma_buf = kzalloc(UART_XMIT_SIZE, GFP_KERNEL | GFP_DMA);
+	s->tx_dma_buf = devm_kzalloc(s->dev,
+			UART_XMIT_SIZE, GFP_KERNEL | GFP_DMA);
 	if (!s->tx_dma_buf)
 		goto err_out;
 
@@ -571,7 +586,7 @@ static void mxs_auart_settermios(struct uart_port *u,
 	cflag = termios->c_cflag;
 
 	ctrl = AUART_LINECTRL_FEN;
-	ctrl2 = readl(u->membase + AUART_CTRL2);
+	ctrl2 = readl(s->regs.ctrl2);
 
 	/* byte size */
 	switch (cflag & CSIZE) {
@@ -656,13 +671,21 @@ static void mxs_auart_settermios(struct uart_port *u,
 	}
 
 	/* set baud rate */
-	baud = uart_get_baud_rate(u, termios, old, 0, u->uartclk);
-	div = u->uartclk * 32 / baud;
+	if (is_asm9260_auart(s)) {
+		baud = uart_get_baud_rate(u, termios, old,
+				u->uartclk * 4 / 0x3FFFFF,
+				u->uartclk / 16);
+		div = u->uartclk * 4 / baud;
+	} else {
+		baud = uart_get_baud_rate(u, termios, old, 0, u->uartclk);
+		div = u->uartclk * 32 / baud;
+	}
+
 	ctrl |= AUART_LINECTRL_BAUD_DIVFRAC(div & 0x3F);
 	ctrl |= AUART_LINECTRL_BAUD_DIVINT(div >> 6);
+	writel(ctrl, s->regs.linectrl);
 
-	writel(ctrl, u->membase + AUART_LINECTRL);
-	writel(ctrl2, u->membase + AUART_CTRL2);
+	writel(ctrl2, s->regs.ctrl2);
 
 	uart_update_timeout(u, termios->c_cflag, baud);
 
@@ -672,7 +695,7 @@ static void mxs_auart_settermios(struct uart_port *u,
 		if (!mxs_auart_dma_prep_rx(s)) {
 			/* Disable the normal RX interrupt. */
 			writel(AUART_INTR_RXIEN | AUART_INTR_RTIEN,
-					u->membase + AUART_INTR_CLR);
+					s->regs.intr + CLR_REG);
 		} else {
 			mxs_auart_dma_exit(s);
 			dev_err(s->dev, "We can not start up the DMA.\n");
@@ -684,21 +707,21 @@ static irqreturn_t mxs_auart_irq_handle(int irq, void *context)
 {
 	u32 istat;
 	struct mxs_auart_port *s = context;
-	u32 stat = readl(s->port.membase + AUART_STAT);
+	u32 stat = readl(s->regs.stat);
 
-	istat = readl(s->port.membase + AUART_INTR);
+	istat = readl(s->regs.intr);
 
 	/* ack irq */
 	writel(istat & (AUART_INTR_RTIS
 		| AUART_INTR_TXIS
 		| AUART_INTR_RXIS
 		| AUART_INTR_CTSMIS),
-			s->port.membase + AUART_INTR_CLR);
+			s->regs.intr + CLR_REG);
 
 	if (istat & AUART_INTR_CTSMIS) {
 		uart_handle_cts_change(&s->port, stat & AUART_STAT_CTS);
 		writel(AUART_INTR_CTSMIS,
-				s->port.membase + AUART_INTR_CLR);
+				s->regs.intr + CLR_REG);
 		istat &= ~AUART_INTR_CTSMIS;
 	}
 
@@ -716,20 +739,20 @@ static irqreturn_t mxs_auart_irq_handle(int irq, void *context)
 	return IRQ_HANDLED;
 }
 
-static void mxs_auart_reset(struct uart_port *u)
+static void mxs_auart_reset(struct mxs_auart_port *s)
 {
 	int i;
 	unsigned int reg;
 
-	writel(AUART_CTRL0_SFTRST, u->membase + AUART_CTRL0_CLR);
+	writel(AUART_CTRL0_SFTRST, s->regs.ctrl0 + CLR_REG);
 
 	for (i = 0; i < 10000; i++) {
-		reg = readl(u->membase + AUART_CTRL0);
+		reg = readl(s->regs.ctrl0);
 		if (!(reg & AUART_CTRL0_SFTRST))
 			break;
 		udelay(3);
 	}
-	writel(AUART_CTRL0_CLKGATE, u->membase + AUART_CTRL0_CLR);
+	writel(AUART_CTRL0_CLKGATE, s->regs.ctrl0 + CLR_REG);
 }
 
 static int mxs_auart_startup(struct uart_port *u)
@@ -741,12 +764,12 @@ static int mxs_auart_startup(struct uart_port *u)
 	if (ret)
 		return ret;
 
-	writel(AUART_CTRL0_CLKGATE, u->membase + AUART_CTRL0_CLR);
+	writel(AUART_CTRL0_CLKGATE, s->regs.ctrl0 + CLR_REG);
 
-	writel(AUART_CTRL2_UARTEN, u->membase + AUART_CTRL2_SET);
+	writel(AUART_CTRL2_UARTEN, s->regs.ctrl2 + SET_REG);
 
 	writel(AUART_INTR_RXIEN | AUART_INTR_RTIEN | AUART_INTR_CTSMIEN,
-			u->membase + AUART_INTR);
+			s->regs.intr);
 
 	/* Reset FIFO size (it could have changed if DMA was enabled) */
 	u->fifosize = MXS_AUART_FIFO_SIZE;
@@ -755,7 +778,7 @@ static int mxs_auart_startup(struct uart_port *u)
 	 * Enable fifo so all four bytes of a DMA word are written to
 	 * output (otherwise, only the LSB is written, ie. 1 in 4 bytes)
 	 */
-	writel(AUART_LINECTRL_FEN, u->membase + AUART_LINECTRL_SET);
+	writel(AUART_LINECTRL_FEN, s->regs.linectrl + SET_REG);
 
 	return 0;
 }
@@ -767,19 +790,21 @@ static void mxs_auart_shutdown(struct uart_port *u)
 	if (auart_dma_enabled(s))
 		mxs_auart_dma_exit(s);
 
-	writel(AUART_CTRL2_UARTEN, u->membase + AUART_CTRL2_CLR);
+	writel(AUART_CTRL2_UARTEN, s->regs.ctrl2 + CLR_REG);
 
 	writel(AUART_INTR_RXIEN | AUART_INTR_RTIEN | AUART_INTR_CTSMIEN,
-			u->membase + AUART_INTR_CLR);
+			s->regs.intr + CLR_REG);
 
-	writel(AUART_CTRL0_CLKGATE, u->membase + AUART_CTRL0_SET);
+	writel(AUART_CTRL0_CLKGATE, s->regs.ctrl0 + SET_REG);
 
 	clk_disable_unprepare(s->clk);
 }
 
 static unsigned int mxs_auart_tx_empty(struct uart_port *u)
 {
-	if (readl(u->membase + AUART_STAT) & AUART_STAT_TXFE)
+	struct mxs_auart_port *s = to_auart_port(u);
+
+	if (readl(s->regs.stat) & AUART_STAT_TXFE)
 		return TIOCSER_TEMT;
 	else
 		return 0;
@@ -790,29 +815,35 @@ static void mxs_auart_start_tx(struct uart_port *u)
 	struct mxs_auart_port *s = to_auart_port(u);
 
 	/* enable transmitter */
-	writel(AUART_CTRL2_TXE, u->membase + AUART_CTRL2_SET);
+	writel(AUART_CTRL2_TXE, s->regs.ctrl2 + SET_REG);
 
 	mxs_auart_tx_chars(s);
 }
 
 static void mxs_auart_stop_tx(struct uart_port *u)
 {
-	writel(AUART_CTRL2_TXE, u->membase + AUART_CTRL2_CLR);
+	struct mxs_auart_port *s = to_auart_port(u);
+
+	writel(AUART_CTRL2_TXE, s->regs.ctrl2 + CLR_REG);
 }
 
 static void mxs_auart_stop_rx(struct uart_port *u)
 {
-	writel(AUART_CTRL2_RXE, u->membase + AUART_CTRL2_CLR);
+	struct mxs_auart_port *s = to_auart_port(u);
+
+	writel(AUART_CTRL2_RXE, s->regs.ctrl2 + CLR_REG);
 }
 
 static void mxs_auart_break_ctl(struct uart_port *u, int ctl)
 {
+	struct mxs_auart_port *s = to_auart_port(u);
+
 	if (ctl)
 		writel(AUART_LINECTRL_BRK,
-			     u->membase + AUART_LINECTRL_SET);
+			     s->regs.linectrl + SET_REG);
 	else
 		writel(AUART_LINECTRL_BRK,
-			     u->membase + AUART_LINECTRL_CLR);
+			     s->regs.linectrl + CLR_REG);
 }
 
 static struct uart_ops mxs_auart_ops = {
@@ -838,15 +869,16 @@ static struct mxs_auart_port *auart_port[MXS_AUART_PORTS];
 #ifdef CONFIG_SERIAL_MXS_AUART_CONSOLE
 static void mxs_auart_console_putchar(struct uart_port *port, int ch)
 {
+	struct mxs_auart_port *s = to_auart_port(port);
 	unsigned int to = 1000;
 
-	while (readl(port->membase + AUART_STAT) & AUART_STAT_TXFF) {
+	while (readl(s->regs.stat) & AUART_STAT_TXFF) {
 		if (!to--)
 			break;
 		udelay(1);
 	}
 
-	writel(ch, port->membase + AUART_DATA);
+	writel(ch, s->regs.data);
 }
 
 static void
@@ -866,18 +898,18 @@ auart_console_write(struct console *co, const char *str, unsigned int count)
 	clk_enable(s->clk);
 
 	/* First save the CR then disable the interrupts */
-	old_ctrl2 = readl(port->membase + AUART_CTRL2);
-	old_ctrl0 = readl(port->membase + AUART_CTRL0);
+	old_ctrl2 = readl(s->regs.ctrl2);
+	old_ctrl0 = readl(s->regs.ctrl0);
 
 	writel(AUART_CTRL0_CLKGATE,
-		     port->membase + AUART_CTRL0_CLR);
+		     s->regs.ctrl0 + CLR_REG);
 	writel(AUART_CTRL2_UARTEN | AUART_CTRL2_TXE,
-		     port->membase + AUART_CTRL2_SET);
+		     s->regs.ctrl2 + SET_REG);
 
 	uart_console_write(port, str, count, mxs_auart_console_putchar);
 
 	/* Finally, wait for transmitter to become empty ... */
-	while (readl(port->membase + AUART_STAT) & AUART_STAT_BUSY) {
+	while (readl(s->regs.stat) & AUART_STAT_BUSY) {
 		udelay(1);
 		if (!to--)
 			break;
@@ -889,24 +921,25 @@ auart_console_write(struct console *co, const char *str, unsigned int count)
 	 * unused, but that is better than to disable it while it is still
 	 * transmitting.
 	 */
-	if (!(readl(port->membase + AUART_STAT) & AUART_STAT_BUSY)) {
-		writel(old_ctrl0, port->membase + AUART_CTRL0);
-		writel(old_ctrl2, port->membase + AUART_CTRL2);
+	if (!(readl(s->regs.stat) & AUART_STAT_BUSY)) {
+		writel(old_ctrl0, s->regs.ctrl0);
+		writel(old_ctrl2, s->regs.ctrl2);
 	}
 
 	clk_disable(s->clk);
 }
 
 static void __init
-auart_console_get_options(struct uart_port *port, int *baud,
+auart_console_get_options(struct mxs_auart_port *s, int *baud,
 			  int *parity, int *bits)
 {
+	struct uart_port *port = &s->port;
 	unsigned int lcr_h, quot;
 
-	if (!(readl(port->membase + AUART_CTRL2) & AUART_CTRL2_UARTEN))
+	if (!(readl(s->regs.ctrl2) & AUART_CTRL2_UARTEN))
 		return;
 
-	lcr_h = readl(port->membase + AUART_LINECTRL);
+	lcr_h = readl(s->regs.linectrl);
 
 	*parity = 'n';
 	if (lcr_h & AUART_LINECTRL_PEN) {
@@ -921,10 +954,10 @@ auart_console_get_options(struct uart_port *port, int *baud,
 	else
 		*bits = 8;
 
-	quot = ((readl(port->membase + AUART_LINECTRL)
+	quot = ((readl(s->regs.linectrl)
 			& AUART_LINECTRL_BAUD_DIVINT_MASK))
 			    >> (AUART_LINECTRL_BAUD_DIVINT_SHIFT - 6);
-	quot |= ((readl(port->membase + AUART_LINECTRL)
+	quot |= ((readl(s->regs.linectrl)
 			& AUART_LINECTRL_BAUD_DIVFRAC_MASK))
 				>> AUART_LINECTRL_BAUD_DIVFRAC_SHIFT;
 	if (quot == 0)
@@ -950,6 +983,7 @@ auart_console_setup(struct console *co, char *options)
 	 */
 	if (co->index == -1 || co->index >= ARRAY_SIZE(auart_port))
 		co->index = 0;
+
 	s = auart_port[co->index];
 	if (!s)
 		return -ENODEV;
@@ -961,7 +995,7 @@ auart_console_setup(struct console *co, char *options)
 	if (options)
 		uart_parse_options(options, &baud, &parity, &bits, &flow);
 	else
-		auart_console_get_options(&s->port, &baud, &parity, &bits);
+		auart_console_get_options(s, &baud, &parity, &bits);
 
 	ret = uart_set_options(&s->port, co, baud, parity, bits, flow);
 
@@ -971,7 +1005,7 @@ auart_console_setup(struct console *co, char *options)
 }
 
 static struct console auart_console = {
-	.name		= "ttyAPP",
+	.name		= MXS_DEVICENAME,
 	.write		= auart_console_write,
 	.device		= uart_console_device,
 	.setup		= auart_console_setup,
@@ -983,8 +1017,8 @@ static struct console auart_console = {
 
 static struct uart_driver auart_driver = {
 	.owner		= THIS_MODULE,
-	.driver_name	= "ttyAPP",
-	.dev_name	= "ttyAPP",
+	.driver_name	= MXS_DEVICENAME,
+	.dev_name	= MXS_DEVICENAME,
 	.major		= 0,
 	.minor		= 0,
 	.nr		= MXS_AUART_PORTS,
@@ -993,6 +1027,58 @@ static struct uart_driver auart_driver = {
 #endif
 };
 
+static void mxs_init_regs(struct mxs_auart_port *s)
+{
+	s->regs.ctrl0	= s->port.membase + AUART_CTRL0;
+	s->regs.ctrl1	= s->port.membase + AUART_CTRL1;
+	s->regs.ctrl2	= s->port.membase + AUART_CTRL2;
+	s->regs.linectrl	= s->port.membase + AUART_LINECTRL;
+
+	if (is_asm9260_auart(s)) {
+		s->regs.intr	= s->port.membase + ASM9260_HW_INTR;
+		s->regs.data	= s->port.membase + ASM9260_HW_DATA;
+		s->regs.stat	= s->port.membase + ASM9260_HW_STAT;
+	} else {
+		s->regs.intr	= s->port.membase + AUART_INTR;
+		s->regs.data	= s->port.membase + AUART_DATA;
+		s->regs.stat	= s->port.membase + AUART_STAT;
+	}
+}
+
+static int mxs_get_dt_clks(struct mxs_auart_port *s,
+		struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	int clk_idx = 0, err;
+
+	s->clk = of_clk_get(np, clk_idx);
+	if (IS_ERR(s->clk))
+		goto out_err;
+
+	/* configure AHB clock */
+	clk_idx = 1;
+	s->clk_ahb = of_clk_get(np, clk_idx);
+	if (IS_ERR(s->clk_ahb))
+		goto out_err;
+
+	err = clk_prepare_enable(s->clk_ahb);
+	if (err)
+		dev_err(s->dev, "Failed to enable ahb_clk!\n");
+
+	err = clk_set_rate(s->clk, clk_get_rate(s->clk_ahb));
+	if (err)
+		dev_err(s->dev, "Failed to set rate!\n");
+
+	err = clk_prepare_enable(s->clk);
+	if (err)
+		dev_err(s->dev, "Failed to enable clk!\n");
+
+	return 0;
+out_err:
+	dev_err(s->dev, "%s: Failed to get clk (%i)\n", __func__, clk_idx);
+	return 1;
+}
+
 /*
  * This function returns 1 if pdev isn't a device instatiated by dt, 0 if it
  * could successfully get all information from dt or a negative errno.
@@ -1029,77 +1115,98 @@ static int mxs_auart_probe(struct platform_device *pdev)
 	int ret = 0;
 	struct resource *r;
 
-	s = kzalloc(sizeof(struct mxs_auart_port), GFP_KERNEL);
+	s = devm_kzalloc(&pdev->dev,
+			sizeof(struct mxs_auart_port), GFP_KERNEL);
 	if (!s) {
 		ret = -ENOMEM;
 		goto out;
 	}
 
+	s->port.dev = s->dev = &pdev->dev;
+
 	ret = serial_mxs_probe_dt(s, pdev);
 	if (ret > 0)
 		s->port.line = pdev->id < 0 ? 0 : pdev->id;
 	else if (ret < 0)
-		goto out_free;
+		return ret;
 
 	if (of_id) {
 		pdev->id_entry = of_id->data;
 		s->devtype = pdev->id_entry->driver_data;
 	}
 
-	s->clk = clk_get(&pdev->dev, NULL);
-	if (IS_ERR(s->clk)) {
-		ret = PTR_ERR(s->clk);
-		goto out_free;
+	if (is_asm9260_auart(s)) {
+		if (mxs_get_dt_clks(s, pdev))
+			return -ENODEV;
+	} else {
+		s->clk = devm_clk_get(&pdev->dev, NULL);
+		if (IS_ERR(s->clk))
+			return PTR_ERR(s->clk);
 	}
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!r) {
-		ret = -ENXIO;
-		goto out_free_clk;
+		dev_err(s->dev, "platform_get_resource filed!\n");
+		return -ENXIO;
+	}
+
+	if (!devm_request_mem_region(s->dev, r->start, resource_size(r),
+				dev_name(s->dev))) {
+		dev_err(s->dev, "request_mem_region filed!\n");
+		return -ENXIO;
+	}
+
+	s->port.membase = devm_ioremap_nocache(s->dev, r->start,
+			resource_size(r));
+	if (!s->port.membase) {
+		dev_err(s->dev, "ioremap filed!\n");
+		return -ENXIO;
 	}
 
 	s->port.mapbase = r->start;
-	s->port.membase = ioremap(r->start, resource_size(r));
 	s->port.ops = &mxs_auart_ops;
 	s->port.iotype = UPIO_MEM;
 	s->port.fifosize = MXS_AUART_FIFO_SIZE;
 	s->port.uartclk = clk_get_rate(s->clk);
 	s->port.type = PORT_IMX;
-	s->port.dev = s->dev = &pdev->dev;
+
+	mxs_init_regs(s);
 
 	s->ctrl = 0;
 
 	s->irq = platform_get_irq(pdev, 0);
 	s->port.irq = s->irq;
-	ret = request_irq(s->irq, mxs_auart_irq_handle, 0, dev_name(&pdev->dev), s);
+	ret = devm_request_threaded_irq(s->dev, s->irq, NULL,
+			mxs_auart_irq_handle, IRQF_ONESHOT,
+			dev_name(&pdev->dev), s);
 	if (ret)
-		goto out_free_clk;
+		return ret;
 
 	platform_set_drvdata(pdev, s);
 
 	auart_port[s->port.line] = s;
 
-	mxs_auart_reset(&s->port);
+	mxs_auart_reset(s);
 
 	ret = uart_add_one_port(&auart_driver, &s->port);
 	if (ret)
-		goto out_free_irq;
+		goto out;
+
 
-	version = readl(s->port.membase + AUART_VERSION);
-	dev_info(&pdev->dev, "Found APPUART %d.%d.%d\n",
-	       (version >> 24) & 0xff,
-	       (version >> 16) & 0xff, version & 0xffff);
+	/* ASM9260 don't have version reg */
+	if (is_asm9260_auart(s))
+		dev_info(&pdev->dev, "Found APPUART ASM9260\n");
+	else {
+		version = readl(s->port.membase + AUART_VERSION);
+		dev_info(&pdev->dev, "Found APPUART %d.%d.%d\n",
+			 (version >> 24) & 0xff,
+			 (version >> 16) & 0xff, version & 0xffff);
+	}
 
 	return 0;
 
-out_free_irq:
-	auart_port[pdev->id] = NULL;
-	free_irq(s->irq, s);
-out_free_clk:
-	clk_put(s->clk);
-out_free:
-	kfree(s);
 out:
+	auart_port[pdev->id] = NULL;
 	return ret;
 }
 
@@ -1110,11 +1217,6 @@ static int mxs_auart_remove(struct platform_device *pdev)
 	uart_remove_one_port(&auart_driver, &s->port);
 
 	auart_port[pdev->id] = NULL;
-
-	clk_put(s->clk);
-	free_irq(s->irq, s);
-	kfree(s);
-
 	return 0;
 }
 
@@ -1122,7 +1224,7 @@ static struct platform_driver mxs_auart_driver = {
 	.probe = mxs_auart_probe,
 	.remove = mxs_auart_remove,
 	.driver = {
-		.name = "mxs-auart",
+		.name = DRIVER_NAME,
 		.owner = THIS_MODULE,
 		.of_match_table = mxs_auart_dt_ids,
 	},
@@ -1157,4 +1259,4 @@ module_init(mxs_auart_init);
 module_exit(mxs_auart_exit);
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Freescale MXS application uart driver");
-MODULE_ALIAS("platform:mxs-auart");
+MODULE_ALIAS("platform:" DRIVER_NAME);
-- 
1.9.1
