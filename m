From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 28 Jan 2016 17:17:02 +0100
Subject: [PATCH 1/7] usb: gadget: pxa25x_udc: move register definitions from
 arch
In-Reply-To: <1453997722-3489596-1-git-send-email-arnd@arndb.de>
References: <1453997722-3489596-1-git-send-email-arnd@arndb.de>
Message-ID: <1453997843-3489728-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ixp4xx and pxa25x both use this driver and provide a slightly
different set of register definitions for it. Aside from that,
the definition in the ixp4xx-regs.h header conflicts with the
on in the pxa27x device driver when compile-testing that:

In file included from ../drivers/usb/gadget/udc/pxa27x_udc.c:37:0:
../drivers/usb/gadget/udc/pxa27x_udc.h:26:0: warning: "UDCCR" redefined
 #define UDCCR  0x0000  /* UDC Control Register */
 ^
In file included from ../arch/arm/mach-ixp4xx/include/mach/hardware.h:27:0,
                 from ../arch/arm/mach-ixp4xx/include/mach/io.h:18,
                 from ../arch/arm/include/asm/io.h:194,
                 from ../include/linux/io.h:25,
                 from ../include/linux/irq.h:24,
                 from ../drivers/usb/gadget/udc/pxa27x_udc.c:23:
../arch/arm/mach-ixp4xx/include/mach/ixp4xx-regs.h:415:0: note: this is the location of the previous definition
 #define UDCCR  IXP4XX_USB_REG(IXP4XX_USB_BASE_VIRT+0x0000)

This addresses both issues by moving all the definitions into the
pxa25x_udc driver itself. It turns out the only difference between
them was 'UDCCS_IO_ROF', and that could well be a mistake when it
was incorrectly copied from pxa25x to ixp4xx.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-ixp4xx/include/mach/ixp4xx-regs.h | 198 ------------------------
 arch/arm/mach-pxa/include/mach/pxa25x-udc.h     | 163 -------------------
 drivers/usb/gadget/udc/pxa25x_udc.c             | 161 ++++++++++++++++++-
 3 files changed, 155 insertions(+), 367 deletions(-)

diff --git a/arch/arm/mach-ixp4xx/include/mach/ixp4xx-regs.h b/arch/arm/mach-ixp4xx/include/mach/ixp4xx-regs.h
index c5bae9c035d5..b7ddd27419c2 100644
--- a/arch/arm/mach-ixp4xx/include/mach/ixp4xx-regs.h
+++ b/arch/arm/mach-ixp4xx/include/mach/ixp4xx-regs.h
@@ -395,204 +395,6 @@
 #define CRP_AD_CBE_BESL         20
 #define CRP_AD_CBE_WRITE	0x00010000
 
-
-/*
- * USB Device Controller
- *
- * These are used by the USB gadget driver, so they don't follow the
- * IXP4XX_ naming convetions.
- *
- */
-# define IXP4XX_USB_REG(x)       (*((volatile u32 *)(x)))
-
-/* UDC Undocumented - Reserved1 */
-#define UDC_RES1	IXP4XX_USB_REG(IXP4XX_USB_BASE_VIRT+0x0004)  
-/* UDC Undocumented - Reserved2 */
-#define UDC_RES2	IXP4XX_USB_REG(IXP4XX_USB_BASE_VIRT+0x0008)  
-/* UDC Undocumented - Reserved3 */
-#define UDC_RES3	IXP4XX_USB_REG(IXP4XX_USB_BASE_VIRT+0x000C)  
-/* UDC Control Register */
-#define UDCCR		IXP4XX_USB_REG(IXP4XX_USB_BASE_VIRT+0x0000)  
-/* UDC Endpoint 0 Control/Status Register */
-#define UDCCS0		IXP4XX_USB_REG(IXP4XX_USB_BASE_VIRT+0x0010)  
-/* UDC Endpoint 1 (IN) Control/Status Register */
-#define UDCCS1		IXP4XX_USB_REG(IXP4XX_USB_BASE_VIRT+0x0014)  
-/* UDC Endpoint 2 (OUT) Control/Status Register */
-#define UDCCS2		IXP4XX_USB_REG(IXP4XX_USB_BASE_VIRT+0x0018)  
-/* UDC Endpoint 3 (IN) Control/Status Register */
-#define UDCCS3		IXP4XX_USB_REG(IXP4XX_USB_BASE_VIRT+0x001C)  
-/* UDC Endpoint 4 (OUT) Control/Status Register */
-#define UDCCS4		IXP4XX_USB_REG(IXP4XX_USB_BASE_VIRT+0x0020)  
-/* UDC Endpoint 5 (Interrupt) Control/Status Register */
-#define UDCCS5		IXP4XX_USB_REG(IXP4XX_USB_BASE_VIRT+0x0024)  
-/* UDC Endpoint 6 (IN) Control/Status Register */
-#define UDCCS6		IXP4XX_USB_REG(IXP4XX_USB_BASE_VIRT+0x0028)  
-/* UDC Endpoint 7 (OUT) Control/Status Register */
-#define UDCCS7		IXP4XX_USB_REG(IXP4XX_USB_BASE_VIRT+0x002C)  
-/* UDC Endpoint 8 (IN) Control/Status Register */
-#define UDCCS8		IXP4XX_USB_REG(IXP4XX_USB_BASE_VIRT+0x0030)  
-/* UDC Endpoint 9 (OUT) Control/Status Register */
-#define UDCCS9		IXP4XX_USB_REG(IXP4XX_USB_BASE_VIRT+0x0034)  
-/* UDC Endpoint 10 (Interrupt) Control/Status Register */
-#define UDCCS10		IXP4XX_USB_REG(IXP4XX_USB_BASE_VIRT+0x0038)  
-/* UDC Endpoint 11 (IN) Control/Status Register */
-#define UDCCS11		IXP4XX_USB_REG(IXP4XX_USB_BASE_VIRT+0x003C)  
-/* UDC Endpoint 12 (OUT) Control/Status Register */
-#define UDCCS12		IXP4XX_USB_REG(IXP4XX_USB_BASE_VIRT+0x0040)  
-/* UDC Endpoint 13 (IN) Control/Status Register */
-#define UDCCS13		IXP4XX_USB_REG(IXP4XX_USB_BASE_VIRT+0x0044)  
-/* UDC Endpoint 14 (OUT) Control/Status Register */
-#define UDCCS14		IXP4XX_USB_REG(IXP4XX_USB_BASE_VIRT+0x0048)  
-/* UDC Endpoint 15 (Interrupt) Control/Status Register */
-#define UDCCS15		IXP4XX_USB_REG(IXP4XX_USB_BASE_VIRT+0x004C)  
-/* UDC Frame Number Register High */
-#define UFNRH		IXP4XX_USB_REG(IXP4XX_USB_BASE_VIRT+0x0060)  
-/* UDC Frame Number Register Low */
-#define UFNRL		IXP4XX_USB_REG(IXP4XX_USB_BASE_VIRT+0x0064)  
-/* UDC Byte Count Reg 2 */
-#define UBCR2		IXP4XX_USB_REG(IXP4XX_USB_BASE_VIRT+0x0068)  
-/* UDC Byte Count Reg 4 */
-#define UBCR4		IXP4XX_USB_REG(IXP4XX_USB_BASE_VIRT+0x006c)  
-/* UDC Byte Count Reg 7 */
-#define UBCR7		IXP4XX_USB_REG(IXP4XX_USB_BASE_VIRT+0x0070)  
-/* UDC Byte Count Reg 9 */
-#define UBCR9		IXP4XX_USB_REG(IXP4XX_USB_BASE_VIRT+0x0074)  
-/* UDC Byte Count Reg 12 */
-#define UBCR12		IXP4XX_USB_REG(IXP4XX_USB_BASE_VIRT+0x0078)  
-/* UDC Byte Count Reg 14 */
-#define UBCR14		IXP4XX_USB_REG(IXP4XX_USB_BASE_VIRT+0x007c)  
-/* UDC Endpoint 0 Data Register */
-#define UDDR0		IXP4XX_USB_REG(IXP4XX_USB_BASE_VIRT+0x0080)  
-/* UDC Endpoint 1 Data Register */
-#define UDDR1		IXP4XX_USB_REG(IXP4XX_USB_BASE_VIRT+0x0100)  
-/* UDC Endpoint 2 Data Register */
-#define UDDR2		IXP4XX_USB_REG(IXP4XX_USB_BASE_VIRT+0x0180)  
-/* UDC Endpoint 3 Data Register */
-#define UDDR3		IXP4XX_USB_REG(IXP4XX_USB_BASE_VIRT+0x0200)  
-/* UDC Endpoint 4 Data Register */
-#define UDDR4		IXP4XX_USB_REG(IXP4XX_USB_BASE_VIRT+0x0400)  
-/* UDC Endpoint 5 Data Register */
-#define UDDR5		IXP4XX_USB_REG(IXP4XX_USB_BASE_VIRT+0x00A0)  
-/* UDC Endpoint 6 Data Register */
-#define UDDR6		IXP4XX_USB_REG(IXP4XX_USB_BASE_VIRT+0x0600)  
-/* UDC Endpoint 7 Data Register */
-#define UDDR7		IXP4XX_USB_REG(IXP4XX_USB_BASE_VIRT+0x0680)  
-/* UDC Endpoint 8 Data Register */
-#define UDDR8		IXP4XX_USB_REG(IXP4XX_USB_BASE_VIRT+0x0700)  
-/* UDC Endpoint 9 Data Register */
-#define UDDR9		IXP4XX_USB_REG(IXP4XX_USB_BASE_VIRT+0x0900)  
-/* UDC Endpoint 10 Data Register */
-#define UDDR10		IXP4XX_USB_REG(IXP4XX_USB_BASE_VIRT+0x00C0)  
-/* UDC Endpoint 11 Data Register */
-#define UDDR11		IXP4XX_USB_REG(IXP4XX_USB_BASE_VIRT+0x0B00)  
-/* UDC Endpoint 12 Data Register */
-#define UDDR12		IXP4XX_USB_REG(IXP4XX_USB_BASE_VIRT+0x0B80)  
-/* UDC Endpoint 13 Data Register */
-#define UDDR13		IXP4XX_USB_REG(IXP4XX_USB_BASE_VIRT+0x0C00)  
-/* UDC Endpoint 14 Data Register */
-#define UDDR14		IXP4XX_USB_REG(IXP4XX_USB_BASE_VIRT+0x0E00)  
-/* UDC Endpoint 15 Data Register */
-#define UDDR15		IXP4XX_USB_REG(IXP4XX_USB_BASE_VIRT+0x00E0)  
-/* UDC Interrupt Control Register 0 */
-#define UICR0		IXP4XX_USB_REG(IXP4XX_USB_BASE_VIRT+0x0050)  
-/* UDC Interrupt Control Register 1 */
-#define UICR1		IXP4XX_USB_REG(IXP4XX_USB_BASE_VIRT+0x0054)  
-/* UDC Status Interrupt Register 0 */
-#define USIR0		IXP4XX_USB_REG(IXP4XX_USB_BASE_VIRT+0x0058)  
-/* UDC Status Interrupt Register 1 */
-#define USIR1		IXP4XX_USB_REG(IXP4XX_USB_BASE_VIRT+0x005C)  
-
-#define UDCCR_UDE	(1 << 0)	/* UDC enable */
-#define UDCCR_UDA	(1 << 1)	/* UDC active */
-#define UDCCR_RSM	(1 << 2)	/* Device resume */
-#define UDCCR_RESIR	(1 << 3)	/* Resume interrupt request */
-#define UDCCR_SUSIR	(1 << 4)	/* Suspend interrupt request */
-#define UDCCR_SRM	(1 << 5)	/* Suspend/resume interrupt mask */
-#define UDCCR_RSTIR	(1 << 6)	/* Reset interrupt request */
-#define UDCCR_REM	(1 << 7)	/* Reset interrupt mask */
-
-#define UDCCS0_OPR	(1 << 0)	/* OUT packet ready */
-#define UDCCS0_IPR	(1 << 1)	/* IN packet ready */
-#define UDCCS0_FTF	(1 << 2)	/* Flush Tx FIFO */
-#define UDCCS0_DRWF	(1 << 3)	/* Device remote wakeup feature */
-#define UDCCS0_SST	(1 << 4)	/* Sent stall */
-#define UDCCS0_FST	(1 << 5)	/* Force stall */
-#define UDCCS0_RNE	(1 << 6)	/* Receive FIFO no empty */
-#define UDCCS0_SA	(1 << 7)	/* Setup active */
-
-#define UDCCS_BI_TFS	(1 << 0)	/* Transmit FIFO service */
-#define UDCCS_BI_TPC	(1 << 1)	/* Transmit packet complete */
-#define UDCCS_BI_FTF	(1 << 2)	/* Flush Tx FIFO */
-#define UDCCS_BI_TUR	(1 << 3)	/* Transmit FIFO underrun */
-#define UDCCS_BI_SST	(1 << 4)	/* Sent stall */
-#define UDCCS_BI_FST	(1 << 5)	/* Force stall */
-#define UDCCS_BI_TSP	(1 << 7)	/* Transmit short packet */
-
-#define UDCCS_BO_RFS	(1 << 0)	/* Receive FIFO service */
-#define UDCCS_BO_RPC	(1 << 1)	/* Receive packet complete */
-#define UDCCS_BO_DME	(1 << 3)	/* DMA enable */
-#define UDCCS_BO_SST	(1 << 4)	/* Sent stall */
-#define UDCCS_BO_FST	(1 << 5)	/* Force stall */
-#define UDCCS_BO_RNE	(1 << 6)	/* Receive FIFO not empty */
-#define UDCCS_BO_RSP	(1 << 7)	/* Receive short packet */
-
-#define UDCCS_II_TFS	(1 << 0)	/* Transmit FIFO service */
-#define UDCCS_II_TPC	(1 << 1)	/* Transmit packet complete */
-#define UDCCS_II_FTF	(1 << 2)	/* Flush Tx FIFO */
-#define UDCCS_II_TUR	(1 << 3)	/* Transmit FIFO underrun */
-#define UDCCS_II_TSP	(1 << 7)	/* Transmit short packet */
-
-#define UDCCS_IO_RFS	(1 << 0)	/* Receive FIFO service */
-#define UDCCS_IO_RPC	(1 << 1)	/* Receive packet complete */
-#define UDCCS_IO_ROF	(1 << 3)	/* Receive overflow */
-#define UDCCS_IO_DME	(1 << 3)	/* DMA enable */
-#define UDCCS_IO_RNE	(1 << 6)	/* Receive FIFO not empty */
-#define UDCCS_IO_RSP	(1 << 7)	/* Receive short packet */
-
-#define UDCCS_INT_TFS	(1 << 0)	/* Transmit FIFO service */
-#define UDCCS_INT_TPC	(1 << 1)	/* Transmit packet complete */
-#define UDCCS_INT_FTF	(1 << 2)	/* Flush Tx FIFO */
-#define UDCCS_INT_TUR	(1 << 3)	/* Transmit FIFO underrun */
-#define UDCCS_INT_SST	(1 << 4)	/* Sent stall */
-#define UDCCS_INT_FST	(1 << 5)	/* Force stall */
-#define UDCCS_INT_TSP	(1 << 7)	/* Transmit short packet */
-
-#define UICR0_IM0	(1 << 0)	/* Interrupt mask ep 0 */
-#define UICR0_IM1	(1 << 1)	/* Interrupt mask ep 1 */
-#define UICR0_IM2	(1 << 2)	/* Interrupt mask ep 2 */
-#define UICR0_IM3	(1 << 3)	/* Interrupt mask ep 3 */
-#define UICR0_IM4	(1 << 4)	/* Interrupt mask ep 4 */
-#define UICR0_IM5	(1 << 5)	/* Interrupt mask ep 5 */
-#define UICR0_IM6	(1 << 6)	/* Interrupt mask ep 6 */
-#define UICR0_IM7	(1 << 7)	/* Interrupt mask ep 7 */
-
-#define UICR1_IM8	(1 << 0)	/* Interrupt mask ep 8 */
-#define UICR1_IM9	(1 << 1)	/* Interrupt mask ep 9 */
-#define UICR1_IM10	(1 << 2)	/* Interrupt mask ep 10 */
-#define UICR1_IM11	(1 << 3)	/* Interrupt mask ep 11 */
-#define UICR1_IM12	(1 << 4)	/* Interrupt mask ep 12 */
-#define UICR1_IM13	(1 << 5)	/* Interrupt mask ep 13 */
-#define UICR1_IM14	(1 << 6)	/* Interrupt mask ep 14 */
-#define UICR1_IM15	(1 << 7)	/* Interrupt mask ep 15 */
-
-#define USIR0_IR0	(1 << 0)	/* Interrupt request ep 0 */
-#define USIR0_IR1	(1 << 1)	/* Interrupt request ep 1 */
-#define USIR0_IR2	(1 << 2)	/* Interrupt request ep 2 */
-#define USIR0_IR3	(1 << 3)	/* Interrupt request ep 3 */
-#define USIR0_IR4	(1 << 4)	/* Interrupt request ep 4 */
-#define USIR0_IR5	(1 << 5)	/* Interrupt request ep 5 */
-#define USIR0_IR6	(1 << 6)	/* Interrupt request ep 6 */
-#define USIR0_IR7	(1 << 7)	/* Interrupt request ep 7 */
-
-#define USIR1_IR8	(1 << 0)	/* Interrupt request ep 8 */
-#define USIR1_IR9	(1 << 1)	/* Interrupt request ep 9 */
-#define USIR1_IR10	(1 << 2)	/* Interrupt request ep 10 */
-#define USIR1_IR11	(1 << 3)	/* Interrupt request ep 11 */
-#define USIR1_IR12	(1 << 4)	/* Interrupt request ep 12 */
-#define USIR1_IR13	(1 << 5)	/* Interrupt request ep 13 */
-#define USIR1_IR14	(1 << 6)	/* Interrupt request ep 14 */
-#define USIR1_IR15	(1 << 7)	/* Interrupt request ep 15 */
-
 #define DCMD_LENGTH	0x01fff		/* length mask (max = 8K - 1) */
 
 /* "fuse" bits of IXP_EXP_CFG2 */
diff --git a/arch/arm/mach-pxa/include/mach/pxa25x-udc.h b/arch/arm/mach-pxa/include/mach/pxa25x-udc.h
index 1b80a4805a60..e69de29bb2d1 100644
--- a/arch/arm/mach-pxa/include/mach/pxa25x-udc.h
+++ b/arch/arm/mach-pxa/include/mach/pxa25x-udc.h
@@ -1,163 +0,0 @@
-#ifndef _ASM_ARCH_PXA25X_UDC_H
-#define _ASM_ARCH_PXA25X_UDC_H
-
-#ifdef _ASM_ARCH_PXA27X_UDC_H
-#error "You can't include both PXA25x and PXA27x UDC support"
-#endif
-
-#define UDC_RES1	__REG(0x40600004)  /* UDC Undocumented - Reserved1 */
-#define UDC_RES2	__REG(0x40600008)  /* UDC Undocumented - Reserved2 */
-#define UDC_RES3	__REG(0x4060000C)  /* UDC Undocumented - Reserved3 */
-
-#define UDCCR		__REG(0x40600000)  /* UDC Control Register */
-#define UDCCR_UDE	(1 << 0)	/* UDC enable */
-#define UDCCR_UDA	(1 << 1)	/* UDC active */
-#define UDCCR_RSM	(1 << 2)	/* Device resume */
-#define UDCCR_RESIR	(1 << 3)	/* Resume interrupt request */
-#define UDCCR_SUSIR	(1 << 4)	/* Suspend interrupt request */
-#define UDCCR_SRM	(1 << 5)	/* Suspend/resume interrupt mask */
-#define UDCCR_RSTIR	(1 << 6)	/* Reset interrupt request */
-#define UDCCR_REM	(1 << 7)	/* Reset interrupt mask */
-
-#define UDCCS0		__REG(0x40600010)  /* UDC Endpoint 0 Control/Status Register */
-#define UDCCS0_OPR	(1 << 0)	/* OUT packet ready */
-#define UDCCS0_IPR	(1 << 1)	/* IN packet ready */
-#define UDCCS0_FTF	(1 << 2)	/* Flush Tx FIFO */
-#define UDCCS0_DRWF	(1 << 3)	/* Device remote wakeup feature */
-#define UDCCS0_SST	(1 << 4)	/* Sent stall */
-#define UDCCS0_FST	(1 << 5)	/* Force stall */
-#define UDCCS0_RNE	(1 << 6)	/* Receive FIFO no empty */
-#define UDCCS0_SA	(1 << 7)	/* Setup active */
-
-/* Bulk IN - Endpoint 1,6,11 */
-#define UDCCS1		__REG(0x40600014)  /* UDC Endpoint 1 (IN) Control/Status Register */
-#define UDCCS6		__REG(0x40600028)  /* UDC Endpoint 6 (IN) Control/Status Register */
-#define UDCCS11		__REG(0x4060003C)  /* UDC Endpoint 11 (IN) Control/Status Register */
-
-#define UDCCS_BI_TFS	(1 << 0)	/* Transmit FIFO service */
-#define UDCCS_BI_TPC	(1 << 1)	/* Transmit packet complete */
-#define UDCCS_BI_FTF	(1 << 2)	/* Flush Tx FIFO */
-#define UDCCS_BI_TUR	(1 << 3)	/* Transmit FIFO underrun */
-#define UDCCS_BI_SST	(1 << 4)	/* Sent stall */
-#define UDCCS_BI_FST	(1 << 5)	/* Force stall */
-#define UDCCS_BI_TSP	(1 << 7)	/* Transmit short packet */
-
-/* Bulk OUT - Endpoint 2,7,12 */
-#define UDCCS2		__REG(0x40600018)  /* UDC Endpoint 2 (OUT) Control/Status Register */
-#define UDCCS7		__REG(0x4060002C)  /* UDC Endpoint 7 (OUT) Control/Status Register */
-#define UDCCS12		__REG(0x40600040)  /* UDC Endpoint 12 (OUT) Control/Status Register */
-
-#define UDCCS_BO_RFS	(1 << 0)	/* Receive FIFO service */
-#define UDCCS_BO_RPC	(1 << 1)	/* Receive packet complete */
-#define UDCCS_BO_DME	(1 << 3)	/* DMA enable */
-#define UDCCS_BO_SST	(1 << 4)	/* Sent stall */
-#define UDCCS_BO_FST	(1 << 5)	/* Force stall */
-#define UDCCS_BO_RNE	(1 << 6)	/* Receive FIFO not empty */
-#define UDCCS_BO_RSP	(1 << 7)	/* Receive short packet */
-
-/* Isochronous IN - Endpoint 3,8,13 */
-#define UDCCS3		__REG(0x4060001C)  /* UDC Endpoint 3 (IN) Control/Status Register */
-#define UDCCS8		__REG(0x40600030)  /* UDC Endpoint 8 (IN) Control/Status Register */
-#define UDCCS13		__REG(0x40600044)  /* UDC Endpoint 13 (IN) Control/Status Register */
-
-#define UDCCS_II_TFS	(1 << 0)	/* Transmit FIFO service */
-#define UDCCS_II_TPC	(1 << 1)	/* Transmit packet complete */
-#define UDCCS_II_FTF	(1 << 2)	/* Flush Tx FIFO */
-#define UDCCS_II_TUR	(1 << 3)	/* Transmit FIFO underrun */
-#define UDCCS_II_TSP	(1 << 7)	/* Transmit short packet */
-
-/* Isochronous OUT - Endpoint 4,9,14 */
-#define UDCCS4		__REG(0x40600020)  /* UDC Endpoint 4 (OUT) Control/Status Register */
-#define UDCCS9		__REG(0x40600034)  /* UDC Endpoint 9 (OUT) Control/Status Register */
-#define UDCCS14		__REG(0x40600048)  /* UDC Endpoint 14 (OUT) Control/Status Register */
-
-#define UDCCS_IO_RFS	(1 << 0)	/* Receive FIFO service */
-#define UDCCS_IO_RPC	(1 << 1)	/* Receive packet complete */
-#define UDCCS_IO_ROF	(1 << 2)	/* Receive overflow */
-#define UDCCS_IO_DME	(1 << 3)	/* DMA enable */
-#define UDCCS_IO_RNE	(1 << 6)	/* Receive FIFO not empty */
-#define UDCCS_IO_RSP	(1 << 7)	/* Receive short packet */
-
-/* Interrupt IN - Endpoint 5,10,15 */
-#define UDCCS5		__REG(0x40600024)  /* UDC Endpoint 5 (Interrupt) Control/Status Register */
-#define UDCCS10		__REG(0x40600038)  /* UDC Endpoint 10 (Interrupt) Control/Status Register */
-#define UDCCS15		__REG(0x4060004C)  /* UDC Endpoint 15 (Interrupt) Control/Status Register */
-
-#define UDCCS_INT_TFS	(1 << 0)	/* Transmit FIFO service */
-#define UDCCS_INT_TPC	(1 << 1)	/* Transmit packet complete */
-#define UDCCS_INT_FTF	(1 << 2)	/* Flush Tx FIFO */
-#define UDCCS_INT_TUR	(1 << 3)	/* Transmit FIFO underrun */
-#define UDCCS_INT_SST	(1 << 4)	/* Sent stall */
-#define UDCCS_INT_FST	(1 << 5)	/* Force stall */
-#define UDCCS_INT_TSP	(1 << 7)	/* Transmit short packet */
-
-#define UFNRH		__REG(0x40600060)  /* UDC Frame Number Register High */
-#define UFNRL		__REG(0x40600064)  /* UDC Frame Number Register Low */
-#define UBCR2		__REG(0x40600068)  /* UDC Byte Count Reg 2 */
-#define UBCR4		__REG(0x4060006c)  /* UDC Byte Count Reg 4 */
-#define UBCR7		__REG(0x40600070)  /* UDC Byte Count Reg 7 */
-#define UBCR9		__REG(0x40600074)  /* UDC Byte Count Reg 9 */
-#define UBCR12		__REG(0x40600078)  /* UDC Byte Count Reg 12 */
-#define UBCR14		__REG(0x4060007c)  /* UDC Byte Count Reg 14 */
-#define UDDR0		__REG(0x40600080)  /* UDC Endpoint 0 Data Register */
-#define UDDR1		__REG(0x40600100)  /* UDC Endpoint 1 Data Register */
-#define UDDR2		__REG(0x40600180)  /* UDC Endpoint 2 Data Register */
-#define UDDR3		__REG(0x40600200)  /* UDC Endpoint 3 Data Register */
-#define UDDR4		__REG(0x40600400)  /* UDC Endpoint 4 Data Register */
-#define UDDR5		__REG(0x406000A0)  /* UDC Endpoint 5 Data Register */
-#define UDDR6		__REG(0x40600600)  /* UDC Endpoint 6 Data Register */
-#define UDDR7		__REG(0x40600680)  /* UDC Endpoint 7 Data Register */
-#define UDDR8		__REG(0x40600700)  /* UDC Endpoint 8 Data Register */
-#define UDDR9		__REG(0x40600900)  /* UDC Endpoint 9 Data Register */
-#define UDDR10		__REG(0x406000C0)  /* UDC Endpoint 10 Data Register */
-#define UDDR11		__REG(0x40600B00)  /* UDC Endpoint 11 Data Register */
-#define UDDR12		__REG(0x40600B80)  /* UDC Endpoint 12 Data Register */
-#define UDDR13		__REG(0x40600C00)  /* UDC Endpoint 13 Data Register */
-#define UDDR14		__REG(0x40600E00)  /* UDC Endpoint 14 Data Register */
-#define UDDR15		__REG(0x406000E0)  /* UDC Endpoint 15 Data Register */
-
-#define UICR0		__REG(0x40600050)  /* UDC Interrupt Control Register 0 */
-
-#define UICR0_IM0	(1 << 0)	/* Interrupt mask ep 0 */
-#define UICR0_IM1	(1 << 1)	/* Interrupt mask ep 1 */
-#define UICR0_IM2	(1 << 2)	/* Interrupt mask ep 2 */
-#define UICR0_IM3	(1 << 3)	/* Interrupt mask ep 3 */
-#define UICR0_IM4	(1 << 4)	/* Interrupt mask ep 4 */
-#define UICR0_IM5	(1 << 5)	/* Interrupt mask ep 5 */
-#define UICR0_IM6	(1 << 6)	/* Interrupt mask ep 6 */
-#define UICR0_IM7	(1 << 7)	/* Interrupt mask ep 7 */
-
-#define UICR1		__REG(0x40600054)  /* UDC Interrupt Control Register 1 */
-
-#define UICR1_IM8	(1 << 0)	/* Interrupt mask ep 8 */
-#define UICR1_IM9	(1 << 1)	/* Interrupt mask ep 9 */
-#define UICR1_IM10	(1 << 2)	/* Interrupt mask ep 10 */
-#define UICR1_IM11	(1 << 3)	/* Interrupt mask ep 11 */
-#define UICR1_IM12	(1 << 4)	/* Interrupt mask ep 12 */
-#define UICR1_IM13	(1 << 5)	/* Interrupt mask ep 13 */
-#define UICR1_IM14	(1 << 6)	/* Interrupt mask ep 14 */
-#define UICR1_IM15	(1 << 7)	/* Interrupt mask ep 15 */
-
-#define USIR0		__REG(0x40600058)  /* UDC Status Interrupt Register 0 */
-
-#define USIR0_IR0	(1 << 0)	/* Interrupt request ep 0 */
-#define USIR0_IR1	(1 << 1)	/* Interrupt request ep 1 */
-#define USIR0_IR2	(1 << 2)	/* Interrupt request ep 2 */
-#define USIR0_IR3	(1 << 3)	/* Interrupt request ep 3 */
-#define USIR0_IR4	(1 << 4)	/* Interrupt request ep 4 */
-#define USIR0_IR5	(1 << 5)	/* Interrupt request ep 5 */
-#define USIR0_IR6	(1 << 6)	/* Interrupt request ep 6 */
-#define USIR0_IR7	(1 << 7)	/* Interrupt request ep 7 */
-
-#define USIR1		__REG(0x4060005C)  /* UDC Status Interrupt Register 1 */
-
-#define USIR1_IR8	(1 << 0)	/* Interrupt request ep 8 */
-#define USIR1_IR9	(1 << 1)	/* Interrupt request ep 9 */
-#define USIR1_IR10	(1 << 2)	/* Interrupt request ep 10 */
-#define USIR1_IR11	(1 << 3)	/* Interrupt request ep 11 */
-#define USIR1_IR12	(1 << 4)	/* Interrupt request ep 12 */
-#define USIR1_IR13	(1 << 5)	/* Interrupt request ep 13 */
-#define USIR1_IR14	(1 << 6)	/* Interrupt request ep 14 */
-#define USIR1_IR15	(1 << 7)	/* Interrupt request ep 15 */
-
-#endif
diff --git a/drivers/usb/gadget/udc/pxa25x_udc.c b/drivers/usb/gadget/udc/pxa25x_udc.c
index b82cb14850b6..26537f50374d 100644
--- a/drivers/usb/gadget/udc/pxa25x_udc.c
+++ b/drivers/usb/gadget/udc/pxa25x_udc.c
@@ -48,18 +48,167 @@
 #include <linux/usb/gadget.h>
 #include <linux/usb/otg.h>
 
-/*
- * This driver is PXA25x only.  Grab the right register definitions.
- */
-#ifdef CONFIG_ARCH_PXA
-#include <mach/pxa25x-udc.h>
 #include <mach/hardware.h>
-#endif
 
 #ifdef CONFIG_ARCH_LUBBOCK
 #include <mach/lubbock.h>
 #endif
 
+#ifdef CONFIG_ARCH_IXP4XX
+#define __UDC_REG(x) (*((volatile u32 *)(IXP4XX_USB_BASE_VIRT + (x))))
+#endif
+
+#ifdef CONFIG_ARCH_PXA
+#define __UDC_REG(x) __REG(0x40600000 + (x))
+#endif
+
+#define UDCCR		__UDC_REG(0x0000)  /* UDC Control Register */
+#define UDC_RES1	__UDC_REG(0x0004)  /* UDC Undocumented - Reserved1 */
+#define UDC_RES2	__UDC_REG(0x0008)  /* UDC Undocumented - Reserved2 */
+#define UDC_RES3	__UDC_REG(0x000C)  /* UDC Undocumented - Reserved3 */
+#define UDCCS0		__UDC_REG(0x0010)  /* UDC Endpoint 0 Control/Status Register */
+#define UDCCS1		__UDC_REG(0x0014)  /* UDC Endpoint 1 (IN) Control/Status Register */
+#define UDCCS2		__UDC_REG(0x0018)  /* UDC Endpoint 2 (OUT) Control/Status Register */
+#define UDCCS3		__UDC_REG(0x001C)  /* UDC Endpoint 3 (IN) Control/Status Register */
+#define UDCCS4		__UDC_REG(0x0020)  /* UDC Endpoint 4 (OUT) Control/Status Register */
+#define UDCCS5		__UDC_REG(0x0024)  /* UDC Endpoint 5 (Interrupt) Control/Status Register */
+#define UDCCS6		__UDC_REG(0x0028)  /* UDC Endpoint 6 (IN) Control/Status Register */
+#define UDCCS7		__UDC_REG(0x002C)  /* UDC Endpoint 7 (OUT) Control/Status Register */
+#define UDCCS8		__UDC_REG(0x0030)  /* UDC Endpoint 8 (IN) Control/Status Register */
+#define UDCCS9		__UDC_REG(0x0034)  /* UDC Endpoint 9 (OUT) Control/Status Register */
+#define UDCCS10		__UDC_REG(0x0038)  /* UDC Endpoint 10 (Interrupt) Control/Status Register */
+#define UDCCS11		__UDC_REG(0x003C)  /* UDC Endpoint 11 (IN) Control/Status Register */
+#define UDCCS12		__UDC_REG(0x0040)  /* UDC Endpoint 12 (OUT) Control/Status Register */
+#define UDCCS13		__UDC_REG(0x0044)  /* UDC Endpoint 13 (IN) Control/Status Register */
+#define UDCCS14		__UDC_REG(0x0048)  /* UDC Endpoint 14 (OUT) Control/Status Register */
+#define UDCCS15		__UDC_REG(0x004C)  /* UDC Endpoint 15 (Interrupt) Control/Status Register */
+#define UFNRH		__UDC_REG(0x0060)  /* UDC Frame Number Register High */
+#define UFNRL		__UDC_REG(0x0064)  /* UDC Frame Number Register Low */
+#define UBCR2		__UDC_REG(0x0068)  /* UDC Byte Count Reg 2 */
+#define UBCR4		__UDC_REG(0x006c)  /* UDC Byte Count Reg 4 */
+#define UBCR7		__UDC_REG(0x0070)  /* UDC Byte Count Reg 7 */
+#define UBCR9		__UDC_REG(0x0074)  /* UDC Byte Count Reg 9 */
+#define UBCR12		__UDC_REG(0x0078)  /* UDC Byte Count Reg 12 */
+#define UBCR14		__UDC_REG(0x007c)  /* UDC Byte Count Reg 14 */
+#define UDDR0		__UDC_REG(0x0080)  /* UDC Endpoint 0 Data Register */
+#define UDDR1		__UDC_REG(0x0100)  /* UDC Endpoint 1 Data Register */
+#define UDDR2		__UDC_REG(0x0180)  /* UDC Endpoint 2 Data Register */
+#define UDDR3		__UDC_REG(0x0200)  /* UDC Endpoint 3 Data Register */
+#define UDDR4		__UDC_REG(0x0400)  /* UDC Endpoint 4 Data Register */
+#define UDDR5		__UDC_REG(0x00A0)  /* UDC Endpoint 5 Data Register */
+#define UDDR6		__UDC_REG(0x0600)  /* UDC Endpoint 6 Data Register */
+#define UDDR7		__UDC_REG(0x0680)  /* UDC Endpoint 7 Data Register */
+#define UDDR8		__UDC_REG(0x0700)  /* UDC Endpoint 8 Data Register */
+#define UDDR9		__UDC_REG(0x0900)  /* UDC Endpoint 9 Data Register */
+#define UDDR10		__UDC_REG(0x00C0)  /* UDC Endpoint 10 Data Register */
+#define UDDR11		__UDC_REG(0x0B00)  /* UDC Endpoint 11 Data Register */
+#define UDDR12		__UDC_REG(0x0B80)  /* UDC Endpoint 12 Data Register */
+#define UDDR13		__UDC_REG(0x0C00)  /* UDC Endpoint 13 Data Register */
+#define UDDR14		__UDC_REG(0x0E00)  /* UDC Endpoint 14 Data Register */
+#define UDDR15		__UDC_REG(0x00E0)  /* UDC Endpoint 15 Data Register */
+
+#define UICR0		__UDC_REG(0x0050)  /* UDC Interrupt Control Register 0 */
+#define UICR1		__UDC_REG(0x0054)  /* UDC Interrupt Control Register 1 */
+
+#define USIR0		__UDC_REG(0x0058)  /* UDC Status Interrupt Register 0 */
+#define USIR1		__UDC_REG(0x005C)  /* UDC Status Interrupt Register 1 */
+
+#define UDCCR_UDE	(1 << 0)	/* UDC enable */
+#define UDCCR_UDA	(1 << 1)	/* UDC active */
+#define UDCCR_RSM	(1 << 2)	/* Device resume */
+#define UDCCR_RESIR	(1 << 3)	/* Resume interrupt request */
+#define UDCCR_SUSIR	(1 << 4)	/* Suspend interrupt request */
+#define UDCCR_SRM	(1 << 5)	/* Suspend/resume interrupt mask */
+#define UDCCR_RSTIR	(1 << 6)	/* Reset interrupt request */
+#define UDCCR_REM	(1 << 7)	/* Reset interrupt mask */
+
+#define UDCCS0_OPR	(1 << 0)	/* OUT packet ready */
+#define UDCCS0_IPR	(1 << 1)	/* IN packet ready */
+#define UDCCS0_FTF	(1 << 2)	/* Flush Tx FIFO */
+#define UDCCS0_DRWF	(1 << 3)	/* Device remote wakeup feature */
+#define UDCCS0_SST	(1 << 4)	/* Sent stall */
+#define UDCCS0_FST	(1 << 5)	/* Force stall */
+#define UDCCS0_RNE	(1 << 6)	/* Receive FIFO no empty */
+#define UDCCS0_SA	(1 << 7)	/* Setup active */
+
+#define UDCCS_BI_TFS	(1 << 0)	/* Transmit FIFO service */
+#define UDCCS_BI_TPC	(1 << 1)	/* Transmit packet complete */
+#define UDCCS_BI_FTF	(1 << 2)	/* Flush Tx FIFO */
+#define UDCCS_BI_TUR	(1 << 3)	/* Transmit FIFO underrun */
+#define UDCCS_BI_SST	(1 << 4)	/* Sent stall */
+#define UDCCS_BI_FST	(1 << 5)	/* Force stall */
+#define UDCCS_BI_TSP	(1 << 7)	/* Transmit short packet */
+
+#define UDCCS_BO_RFS	(1 << 0)	/* Receive FIFO service */
+#define UDCCS_BO_RPC	(1 << 1)	/* Receive packet complete */
+#define UDCCS_BO_DME	(1 << 3)	/* DMA enable */
+#define UDCCS_BO_SST	(1 << 4)	/* Sent stall */
+#define UDCCS_BO_FST	(1 << 5)	/* Force stall */
+#define UDCCS_BO_RNE	(1 << 6)	/* Receive FIFO not empty */
+#define UDCCS_BO_RSP	(1 << 7)	/* Receive short packet */
+
+#define UDCCS_II_TFS	(1 << 0)	/* Transmit FIFO service */
+#define UDCCS_II_TPC	(1 << 1)	/* Transmit packet complete */
+#define UDCCS_II_FTF	(1 << 2)	/* Flush Tx FIFO */
+#define UDCCS_II_TUR	(1 << 3)	/* Transmit FIFO underrun */
+#define UDCCS_II_TSP	(1 << 7)	/* Transmit short packet */
+
+#define UDCCS_IO_RFS	(1 << 0)	/* Receive FIFO service */
+#define UDCCS_IO_RPC	(1 << 1)	/* Receive packet complete */
+#ifdef CONFIG_ARCH_IXP4XX /* FIXME: is this right?, datasheed says '2' */
+#define UDCCS_IO_ROF	(1 << 3)	/* Receive overflow */
+#endif
+#ifdef CONFIG_ARCH_PXA
+#define UDCCS_IO_ROF	(1 << 2)	/* Receive overflow */
+#endif
+#define UDCCS_IO_DME	(1 << 3)	/* DMA enable */
+#define UDCCS_IO_RNE	(1 << 6)	/* Receive FIFO not empty */
+#define UDCCS_IO_RSP	(1 << 7)	/* Receive short packet */
+
+#define UDCCS_INT_TFS	(1 << 0)	/* Transmit FIFO service */
+#define UDCCS_INT_TPC	(1 << 1)	/* Transmit packet complete */
+#define UDCCS_INT_FTF	(1 << 2)	/* Flush Tx FIFO */
+#define UDCCS_INT_TUR	(1 << 3)	/* Transmit FIFO underrun */
+#define UDCCS_INT_SST	(1 << 4)	/* Sent stall */
+#define UDCCS_INT_FST	(1 << 5)	/* Force stall */
+#define UDCCS_INT_TSP	(1 << 7)	/* Transmit short packet */
+
+#define UICR0_IM0	(1 << 0)	/* Interrupt mask ep 0 */
+#define UICR0_IM1	(1 << 1)	/* Interrupt mask ep 1 */
+#define UICR0_IM2	(1 << 2)	/* Interrupt mask ep 2 */
+#define UICR0_IM3	(1 << 3)	/* Interrupt mask ep 3 */
+#define UICR0_IM4	(1 << 4)	/* Interrupt mask ep 4 */
+#define UICR0_IM5	(1 << 5)	/* Interrupt mask ep 5 */
+#define UICR0_IM6	(1 << 6)	/* Interrupt mask ep 6 */
+#define UICR0_IM7	(1 << 7)	/* Interrupt mask ep 7 */
+
+#define UICR1_IM8	(1 << 0)	/* Interrupt mask ep 8 */
+#define UICR1_IM9	(1 << 1)	/* Interrupt mask ep 9 */
+#define UICR1_IM10	(1 << 2)	/* Interrupt mask ep 10 */
+#define UICR1_IM11	(1 << 3)	/* Interrupt mask ep 11 */
+#define UICR1_IM12	(1 << 4)	/* Interrupt mask ep 12 */
+#define UICR1_IM13	(1 << 5)	/* Interrupt mask ep 13 */
+#define UICR1_IM14	(1 << 6)	/* Interrupt mask ep 14 */
+#define UICR1_IM15	(1 << 7)	/* Interrupt mask ep 15 */
+
+#define USIR0_IR0	(1 << 0)	/* Interrupt request ep 0 */
+#define USIR0_IR1	(1 << 1)	/* Interrupt request ep 1 */
+#define USIR0_IR2	(1 << 2)	/* Interrupt request ep 2 */
+#define USIR0_IR3	(1 << 3)	/* Interrupt request ep 3 */
+#define USIR0_IR4	(1 << 4)	/* Interrupt request ep 4 */
+#define USIR0_IR5	(1 << 5)	/* Interrupt request ep 5 */
+#define USIR0_IR6	(1 << 6)	/* Interrupt request ep 6 */
+#define USIR0_IR7	(1 << 7)	/* Interrupt request ep 7 */
+
+#define USIR1_IR8	(1 << 0)	/* Interrupt request ep 8 */
+#define USIR1_IR9	(1 << 1)	/* Interrupt request ep 9 */
+#define USIR1_IR10	(1 << 2)	/* Interrupt request ep 10 */
+#define USIR1_IR11	(1 << 3)	/* Interrupt request ep 11 */
+#define USIR1_IR12	(1 << 4)	/* Interrupt request ep 12 */
+#define USIR1_IR13	(1 << 5)	/* Interrupt request ep 13 */
+#define USIR1_IR14	(1 << 6)	/* Interrupt request ep 14 */
+#define USIR1_IR15	(1 << 7)	/* Interrupt request ep 15 */
+
 /*
  * This driver handles the USB Device Controller (UDC) in Intel's PXA 25x
  * series processors.  The UDC for the IXP 4xx series is very similar.
-- 
2.7.0
