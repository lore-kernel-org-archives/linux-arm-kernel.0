From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Mon, 31 May 2010 13:58:39 +0200
Subject: Samsung Crypto engine problems
Message-ID: <4C03A46F.10700@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I'm currently trying to develop a driver for the Samsung crypto engine
available
in S3C64XX and S5PC100 SoC's (the only SoC's I could find datasheets for).

However, I'm running into problems in both DMA and FIFO mode: when using
DMA,
the RX transfer seems to be pushing (len-4) bytes to the FIFO, which
results in
the FIFO waiting for the last 4 bytes and halting the entire operation.

When using PIO (FIFO mode), everything seems to work smoothly until the
kernel
self-test runs DES decryption test 1 (which is a 24 byte data transfer). The
data gets pushed to the RX FIFO and the DES engine responds with an
interrupt
indicating it has done its job, but the TX FIFO interrupt never gets
triggered
and thus the decrypted data never gets fetched.

Any pointers to what I've could done wrong would be thankful.

(I've attached my current work as an inline patch below)

P.S.: this was tested on a S3C6410 SoC, the only one I have access to. I've
tried to make the register accesses as generic as possible so the
S5PC100 SoC's
can use the driver too, but that's untested. Any confirmation that the
AES en-
and decryption self-tests succeed would be appreciated (these tests
succeed on
my S3C6410).

--
Maurus Cuelenaere


diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 3f8718f..3e80510 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -680,6 +680,7 @@ config ARCH_S3C64XX
     select S3C_DEV_NAND
     select USB_ARCH_HAS_OHCI
     select SAMSUNG_GPIOLIB_4BIT
+    select SAMSUNG_DEV_SSS
     help
       Samsung S3C64XX series based systems

@@ -705,6 +706,7 @@ config ARCH_S5PC1XX
     select HAVE_CLK
     select CPU_V7
     select ARM_L1_CACHE_SHIFT_6
+    select SAMSUNG_DEV_SSS
     help
       Samsung S5PC1XX series based systems

diff --git a/arch/arm/mach-s3c64xx/clock.c b/arch/arm/mach-s3c64xx/clock.c
index d3e11a1..bdb173c 100644
--- a/arch/arm/mach-s3c64xx/clock.c
+++ b/arch/arm/mach-s3c64xx/clock.c
@@ -230,6 +230,12 @@ static struct clk init_clocks_disable[] = {
         .parent        = &clk_h,
         .enable        = s3c64xx_hclk_ctrl,
         .ctrlbit    = S3C_CLKCON_HCLK_SDMA1,
+    }, {
+        .name        = "secur",
+        .id        = -1,
+        .parent        = &clk_h2,
+        .enable        = s3c64xx_sclk_ctrl,
+        .ctrlbit    = S3C_CLKCON_SCLK_SECUR
     },
 };

diff --git a/arch/arm/mach-s3c64xx/include/mach/map.h
b/arch/arm/mach-s3c64xx/include/mach/map.h
index 9fdd50c..fa80afc 100644
--- a/arch/arm/mach-s3c64xx/include/mach/map.h
+++ b/arch/arm/mach-s3c64xx/include/mach/map.h
@@ -87,6 +87,9 @@
 #define S3C64XX_PA_USB_HSPHY    (0x7C100000)
 #define S3C64XX_VA_USB_HSPHY    S3C_ADDR_CPU(0x00200000)

+#define SAMSUNG_PA_SSS        (0x7D000000)
+#define SAMSUNG_SZ_SSS        (SZ_1M * 10 + SZ_256)
+
 /* place VICs close together */
 #define VA_VIC0            (S3C_VA_IRQ + 0x00)
 #define VA_VIC1            (S3C_VA_IRQ + 0x10000)
diff --git a/arch/arm/mach-s3c64xx/include/mach/regs-sss.h
b/arch/arm/mach-s3c64xx/include/mach/regs-sss.h
new file mode 100644
index 0000000..3a0769f
--- /dev/null
+++ b/arch/arm/mach-s3c64xx/include/mach/regs-sss.h
@@ -0,0 +1,27 @@
+/*
+ * linux/arch/arm/mach-s3c64xx/include/mach/regs-sss.h
+ *
+ * Copyright (C) 2010 Maurus Cuelenaere
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#ifndef __MACH_S3C64XX_REGS_SSS_H
+#define __MACH_S3C64XX_REGS_SSS_H __FILE__
+
+#define SSS_OFF_CFG                (0x000000)
+#define SSS_OFF_AES_RX                (0x100000)
+#define SSS_OFF_TDES_RX                (0x200000)
+#define SSS_OFF_HASH_RX                (0x300000)
+#define SSS_OFF_FIFO_RX                (0x400000)
+#define SSS_OFF_AES_TX                (0x500000)
+#define SSS_OFF_TDES_TX                (0x600000)
+#define SSS_OFF_HASH_TX                (0x700000)
+#define SSS_OFF_FIFO_TX                (0x800000)
+#define SSS_OFF_SDMA_RX                (0x900000)
+#define SSS_OFF_SDMA_TX                (0xA00000)
+
+#endif /* __MACH_S3C64XX_REGS_SSS_H */
diff --git a/arch/arm/mach-s5pc100/include/mach/map.h
b/arch/arm/mach-s5pc100/include/mach/map.h
index 4681ebe..1d842b5 100644
--- a/arch/arm/mach-s5pc100/include/mach/map.h
+++ b/arch/arm/mach-s5pc100/include/mach/map.h
@@ -116,6 +116,10 @@
 #define S5PC100_PA_SDRAM    (0x20000000)
 #define S5PC1XX_PA_SDRAM    S5PC100_PA_SDRAM

+/* Crypto Engine */
+#define SAMSUNG_PA_SSS        (0xF4000000)
+#define SAMSUNG_SZ_SSS        (SZ_1M * 3 + SZ_64K)
+
 /* compatibility defines. */
 #define S3C_PA_RTC        S5PC100_PA_RTC
 #define S3C_PA_UART        S5PC100_PA_UART
diff --git a/arch/arm/mach-s5pc100/include/mach/regs-sss.h
b/arch/arm/mach-s5pc100/include/mach/regs-sss.h
new file mode 100644
index 0000000..41b3e6b
--- /dev/null
+++ b/arch/arm/mach-s5pc100/include/mach/regs-sss.h
@@ -0,0 +1,29 @@
+/*
+ * linux/arch/arm/mach-s5pc100/include/mach/regs-sss.h
+ *
+ * Copyright (C) 2010 Maurus Cuelenaere
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#ifndef __MACH_S5PC100_REGS_SSS_H
+#define __MACH_S5PC100_REGS_SSS_H __FILE__
+
+#define SSS_OFF_CFG                (0x000000)
+#define SSS_OFF_FIFO_RX                (0x010000)
+#define SSS_OFF_AES_RX                (0x040000)
+#define SSS_OFF_TDES_RX                (0x050000)
+#define SSS_OFF_HASH_RX                (0x060000)
+
+#define SSS_OFF_FIFO_TX                (0x110000)
+#define SSS_OFF_AES_TX                (0x140000)
+#define SSS_OFF_TDES_TX                (0x150000)
+#define SSS_OFF_HASH_TX                (0x160000)
+
+#define SSS_OFF_SDMA_RX                (0x200000)
+#define SSS_OFF_SDMA_TX                (0x300000)
+
+#endif /* __MACH_S5PC100_REGS_SSS_H */
diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index 229919e..c001d54 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -211,6 +211,11 @@ config SAMSUNG_DEV_TS
     help
         Common in platform device definitions for touchscreen device

+config SAMSUNG_DEV_SSS
+    bool
+    help
+        Compile in platform device definitions for Security Sub-Systems
+
 # DMA

 config S3C_DMA
diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
index 4828849..43a3c64 100644
--- a/arch/arm/plat-samsung/Makefile
+++ b/arch/arm/plat-samsung/Makefile
@@ -45,6 +45,7 @@ obj-$(CONFIG_S3C_DEV_RTC)    += dev-rtc.o

 obj-$(CONFIG_SAMSUNG_DEV_ADC)    += dev-adc.o
 obj-$(CONFIG_SAMSUNG_DEV_TS)    += dev-ts.o
+obj-$(CONFIG_SAMSUNG_DEV_SSS)    += dev-sss.o

 # DMA support

diff --git a/arch/arm/plat-samsung/dev-sss.c
b/arch/arm/plat-samsung/dev-sss.c
new file mode 100644
index 0000000..6c662a1
--- /dev/null
+++ b/arch/arm/plat-samsung/dev-sss.c
@@ -0,0 +1,46 @@
+/* linux/arch/arm/plat-samsung/dev-sss.c
+ *
+ * Copyright (c) 2010 Maurus Cuelenaere
+ *
+ * Based on arch/arm/plat-samsung/dev-hsmmc1.c
+ * original file Copyright (c) 2008 Simtec Electronics
+ *
+ * Samsung series device definition for security sub-system
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+
+#include <mach/irqs.h>
+#include <mach/map.h>
+
+#include <plat/devs.h>
+
+static struct resource s3c_sss_resource[] = {
+    {
+        .start = SAMSUNG_PA_SSS,
+        .end   = SAMSUNG_PA_SSS + SAMSUNG_SZ_SSS - 1,
+        .flags = IORESOURCE_MEM,
+    }, {
+        .start = IRQ_SEC,
+        .end   = IRQ_SEC,
+        .flags = IORESOURCE_IRQ,
+    }
+};
+
+static u64 s3c_device_sss_dmamask = 0xffffffffUL;
+
+struct platform_device s3c_device_sss = {
+    .name        = "s3c-sss",
+    .id        = -1,
+    .num_resources    = ARRAY_SIZE(s3c_sss_resource),
+    .resource    = s3c_sss_resource,
+    .dev        = {
+        .dma_mask        = &s3c_device_sss_dmamask,
+        .coherent_dma_mask    = 0xffffffffUL,
+    },
+};
diff --git a/arch/arm/plat-samsung/include/plat/devs.h
b/arch/arm/plat-samsung/include/plat/devs.h
index ef69e56..c689fae 100644
--- a/arch/arm/plat-samsung/include/plat/devs.h
+++ b/arch/arm/plat-samsung/include/plat/devs.h
@@ -64,6 +64,8 @@ extern struct platform_device s3c_device_nand;
 extern struct platform_device s3c_device_usbgadget;
 extern struct platform_device s3c_device_usb_hsotg;

+extern struct platform_device s3c_device_sss;
+
 extern struct platform_device s5pv210_device_ac97;
 extern struct platform_device s5pv210_device_pcm0;
 extern struct platform_device s5pv210_device_pcm1;
diff --git a/arch/arm/plat-samsung/include/plat/regs-sss.h
b/arch/arm/plat-samsung/include/plat/regs-sss.h
new file mode 100644
index 0000000..f54cd3b
--- /dev/null
+++ b/arch/arm/plat-samsung/include/plat/regs-sss.h
@@ -0,0 +1,153 @@
+/*
+ * linux/arch/arm/plat-samsung/include/plat/regs-sss.h
+ *
+ * Copyright (C) 2010 Maurus Cuelenaere
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#ifndef __PLAT_SAMSUNG_REGS_SSS_H
+#define __PLAT_SAMSUNG_REGS_SSS_H __FILE__
+
+#include <mach/regs-sss.h>
+
+/* Config */
+#define DnI_CFG                (SSS_OFF_CFG + 0x00)
+
+#define DnI_CFG_WrPrivMismatch        (1 << 31)
+#define DnI_CFG_RdPrivMismatch        (1 << 30)
+#define DnI_CFG_SHA_Intr_Status        (1 << 22)
+#define DnI_CFG_DES_Intr_Status        (1 << 21)
+#define DnI_CFG_AES_Intr_Status        (1 << 20)
+#define DnI_CFG_FTx_Intr_Status        (1 << 17)
+#define DnI_CFG_FRx_Intr_Status        (1 << 16)
+#define DnI_CFG_SHA_Intr_En        (1 << 14)
+#define DnI_CFG_DES_Intr_En        (1 << 13)
+#define DnI_CFG_AES_Intr_En        (1 << 12)
+#define DnI_CFG_FTx_Intr_En        (1 << 9)
+#define DnI_CFG_FRx_Intr_En        (1 << 8)
+#define DnI_CFG_TxTrgLevel(n)        (((n / 4) & 7) << 5)
+#define DnI_CFG_TxDmaEnb        (1 << 4)
+#define DnI_CFG_RxTrgLevel(n)        (((n / 4) & 7) << 1)
+#define DnI_CFG_RxDmaEnb        (1 << 0)
+
+/* FIFO */
+#define FRx_Ctrl            (SSS_OFF_FIFO_RX + 0x00)
+#define FRx_MLen            (SSS_OFF_FIFO_RX + 0x04)
+#define FRx_BlkSz            (SSS_OFF_FIFO_RX + 0x08)
+#define FRx_Addr            (SSS_OFF_FIFO_RX + 0x0C)
+#define FRx_MLenCnt            (SSS_OFF_FIFO_RX + 0x10)
+#define FRx_Buf                (SSS_OFF_FIFO_RX + 0x40)
+
+#define FTx_Ctrl            (SSS_OFF_FIFO_TX + 0x00)
+#define FTx_MLen            (SSS_OFF_FIFO_TX + 0x04)
+#define FTx_BlkSz            (SSS_OFF_FIFO_TX + 0x08)
+#define FTx_Addr            (SSS_OFF_FIFO_TX + 0x0C)
+#define FTx_MLenCnt            (SSS_OFF_FIFO_TX + 0x10)
+#define FTx_Buf                (SSS_OFF_FIFO_TX + 0x40)
+
+#define FXx_Ctrl_WrPrivError        (1 << 31)
+#define FXx_Ctrl_RdPrivError        (1 << 30)
+#define FXx_Ctrl_Full            (1 << 27)
+#define FXx_Ctrl_Empty            (1 << 26)
+#define FXx_Ctrl_Done            (1 << 25)
+#define FXx_Ctrl_Running        (1 << 24)
+#define FRx_Ctrl_Wd2Write(n)        ((n & 0xFF) << 16)
+#define FRx_Ctrl_Wd2Read(n)        ((n & 0xFF) << 8)
+#define FTx_Ctrl_Wd2Read(n)        ((n & 0xFF) << 16)
+#define FTx_Ctrl_Wd2Write(n)        ((n & 0xFF) << 8)
+#define FXx_Ctrl_Module_AES        (0 << 6)
+#define FXx_Ctrl_Module_DES        (1 << 6)
+#define FXx_Ctrl_Module_SHA        (2 << 6)
+#define FXx_Ctrl_Host_Rd_En        (1 << 5)
+#define FXx_Ctrl_Host_Wr_En        (1 << 4)
+#define FRx_Ctrl_Sync_Tx        (1 << 3)
+#define FXx_Ctrl_Reset            (1 << 2)
+#define FXx_Ctrl_ERROR_En        (1 << 1)
+#define FXx_Ctrl_Start            (1 << 0)
+
+#define FXx_BlkSz_LastValidByte(n)    ((n & 3) << 16)
+
+/* AES */
+#define AES_CTRL            (SSS_OFF_AES_RX + 0x00)
+#define AES_DIN                (SSS_OFF_AES_RX + 0x10)
+#define AES_DOUT            (SSS_OFF_AES_TX + 0x20)
+#define AES_KEY                (SSS_OFF_AES_RX + 0x80)
+#define AES_IV                (SSS_OFF_AES_RX + 0xA0)
+#define AES_CTR                (SSS_OFF_AES_RX + 0xB0)
+
+#define AES_CTRL_WrPrivMismatch        (1 << 31)
+#define AES_CTRL_RdPrivMismatch        (1 << 30)
+#define AES_CTRL_OutReady        (1 << 10)
+#define AES_CTRL_InReady        (1 << 9)
+#define AES_CTRL_ContDecOn        (1 << 8)
+#define AES_CTRL_CtrWidth_16bits    (0 << 6)
+#define AES_CTRL_CtrWidth_32bits    (1 << 6)
+#define AES_CTRL_CtrWidth_64bits    (2 << 6)
+#define AES_CTRL_OpMode_ECB        (1 << 4)
+#define AES_CTRL_OpMode_CBC        (2 << 4)
+#define AES_CTRL_OpMode_CTR        (3 << 4)
+#define AES_CTRL_OpDirection_Enc    (0 << 3)
+#define AES_CTRL_OpDirection_Dec    (1 << 3)
+#define AES_CTRL_KeyMode_128bits    (0 << 1)
+#define AES_CTRL_KeyMode_192bits    (1 << 1)
+#define AES_CTRL_KeyMode_256bits    (2 << 1)
+#define AES_CTRL_OpEnable        (1 << 0)
+
+/* TDES */
+#define TDES_CTRL            (SSS_OFF_TDES_RX + 0x00)
+#define TDES_KEY            (SSS_OFF_TDES_RX + 0x10)
+#define TDES_INPUT            (SSS_OFF_TDES_RX + 0x40)
+#define TDES_OUTPUT            (SSS_OFF_TDES_TX + 0x48)
+#define TDES_IV                (SSS_OFF_TDES_RX + 0x50)
+
+#define TDES_CTRL_WrPrivMismatch    (1 << 31)
+#define TDES_CTRL_RdPrivMismatch    (1 << 30)
+#define TDES_CTRL_OutReady        (1 << 7)
+#define TDES_CTRL_InReady        (1 << 6)
+#define TDES_CTRL_Mode_Des        (0 << 5)
+#define TDES_CTRL_Mode_Tdes        (1 << 5)
+#define TDES_CTRL_Mode_ECB        (1 << 3)
+#define TDES_CTRL_Mode_CBC        (2 << 3)
+#define TDES_CTRL_OpDirection_Enc    (0 << 2)
+#define TDES_CTRL_OpDirection_Dec    (1 << 2)
+#define TDES_CTRL_IntMode        (1 << 1)
+#define TDES_CTRL_OpEnable        (1 << 0)
+
+/* SHA1/PRNG */
+#define HASH_CTRL            (SSS_OFF_HASH_RX + 0x00)
+#define HASH_DATA            (SSS_OFF_HASH_RX + 0x04)
+#define HASH_STATUS            (SSS_OFF_HASH_RX + 0x30)
+#define HASH_OUTPUT            (SSS_OFF_HASH_TX + 0x34)
+#define HASH_MIDOUT            (SSS_OFF_HASH_RX + 0x5C)
+#define HASH_IV                (SSS_OFF_HASH_RX + 0x70)
+#define PRE_MSG_LENGTH            (SSS_OFF_HASH_RX + 0x84)
+
+#define HASH_CTRL_USE_IV        (1 << 8)
+#define HASH_CTRL_End_of_Hash_byte(n)    ((n & 3) << 6)
+#define HASH_CTRL_SEED_SETTING_ENB    (1 << 5)
+#define HASH_CTRL_Hash_Input_Finished    (1 << 4)
+#define HASH_CTRL_Hash_Start        (1 << 3)
+#define HASH_CTRL_Data_Selection    (1 << 2)
+#define HASH_CTRL_Engine_HMAC        (0 << 0)
+#define HASH_CTRL_Engine_SHA1        (1 << 0)
+#define HASH_CTRL_Engine_PRNG        (2 << 0)
+
+#define HASH_STATUS_BUFFER_IN_ENB    (1 << 4)
+#define HASH_STATUS_Engine_Ready    (1 << 3)
+#define HASH_STATUS_RNG_Ready        (1 << 2)
+#define HASH_STATUS_32bit_Ready        (1 << 1)
+#define HASH_STATUS_Output_Ready    (1 << 0)
+
+/* SDMA */
+#define SDMA_FRx_Buf            (SSS_OFF_SDMA_RX + 0x40)
+#define SDMA_FTx_Buf            (SSS_OFF_SDMA_TX + 0x40)
+
+/* Generic */
+#define WrPrivMismatch            (1 << 31)
+#define RdPrivMismatch            (1 << 30)
+
+#endif /* __PLAT_SAMSUNG_REGS_SSS_H */
diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index b08403d..0e78047 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -222,4 +222,18 @@ config CRYPTO_DEV_PPC4XX
     help
       This option allows you to have support for AMCC crypto acceleration.

+config CRYPTO_DEV_SSS
+    tristate "Samsung Security Sub-Systems"
+    depends on SAMSUNG_DEV_SSS
+    select CRYPTO_AES
+    select CRYPTO_DES
+    select CRYPTO_SHA1
+    select CRYPTO_HMAC
+    select CRYPTO_ALGAPI
+    select CRYPTO_BLKCIPHER2
+    select CRYPTO_HASH
+    help
+        This driver utilizes the cryptographic engine in Samsung S3C64XX
+        and S5PC100 SoCs.
+
 endif # CRYPTO_HW
diff --git a/drivers/crypto/Makefile b/drivers/crypto/Makefile
index 6ffcb3f..ef14b4d 100644
--- a/drivers/crypto/Makefile
+++ b/drivers/crypto/Makefile
@@ -6,3 +6,4 @@ obj-$(CONFIG_CRYPTO_DEV_MV_CESA) += mv_cesa.o
 obj-$(CONFIG_CRYPTO_DEV_TALITOS) += talitos.o
 obj-$(CONFIG_CRYPTO_DEV_IXP4XX) += ixp4xx_crypto.o
 obj-$(CONFIG_CRYPTO_DEV_PPC4XX) += amcc/
+obj-$(CONFIG_CRYPTO_DEV_SSS) += s3c-sss.o
diff --git a/drivers/crypto/s3c-sss.c b/drivers/crypto/s3c-sss.c
new file mode 100644
index 0000000..df3a2da
--- /dev/null
+++ b/drivers/crypto/s3c-sss.c
@@ -0,0 +1,1237 @@
+/*
+ * linux/drivers/crypto/s3c-sss.c
+ *
+ * Copyright (C) 2010 Maurus Cuelenaere
+ *
+ * Support for S3C64XX Security Sub-Systems
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#define DEBUG
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/spinlock.h>
+#include <linux/interrupt.h>
+#include <linux/crypto.h>
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/dma-mapping.h>
+#include <linux/timer.h>
+
+#include <crypto/internal/hash.h>
+#include <crypto/algapi.h>
+#include <crypto/aes.h>
+#include <crypto/des.h>
+#include <crypto/ctr.h>
+#include <crypto/sha.h>
+#include <crypto/scatterwalk.h>
+
+#include <mach/dma.h>
+
+#include <plat/regs-sss.h>
+
+#define SSS_CRA_PRIORITY    300
+#define SSS_MAX_KEY_SIZE    AES_MAX_KEY_SIZE
+#define SSS_FIFO_SIZE        (0x40U)
+#define SSS_TIMEOUT        3
+
+/**
+ * struct s3c_sss - driver state.
+ * @dev:
+ * @clock: clock associated with peripheral
+ * @irq: irq associated with peripheral
+ * @regs: pointer to mapped registers
+ * @regs_phys: pointer to physical address of registers
+ * @regs_res: pointer to struct resource representing registers
+ * @cur_req: pointer to pending request (can be NULL)
+ * @dma_client: struct used for passing to DMA core
+ * @lock: lock used for synchronizing queue accesses
+ * @tasklet:
+ * @timer: timer used for timing out faulty requests
+ * @queue: queue containing requests
+ */
+struct s3c_sss {
+    struct device            *dev;
+
+    struct clk            *clock;
+    int                irq;
+    void __iomem            *regs;
+    void __iomem            *regs_phys;
+    struct resource            *regs_res;
+
+    struct ablkcipher_request    *cur_req;
+    struct s3c2410_dma_client    dma_client;
+    spinlock_t            lock;
+    struct tasklet_struct        tasklet;
+    struct timer_list        timer;
+    struct crypto_queue        queue;
+};
+
+/**
+ * struct sss_context - cipher/hash key state
+ * @key: storage for the key
+ * @key_len: length of the key
+ * @dev: pointer to struct containing the driver state
+ */
+struct sss_context {
+    u8                key[SSS_MAX_KEY_SIZE];
+    unsigned int            key_len;
+
+    struct s3c_sss            *dev;
+};
+
+/**
+ * struct sss_fifo_channel - FIFO handling state
+ *
+ * @dev: pointer to struct containing the driver state
+ */
+struct sss_fifo_channel {
+    /* DMA */
+    struct scatterlist        *cur_sg;
+    int                offset;
+    int                sg_count;
+
+    /* generic */
+    enum {
+        FIFO_RX,
+        FIFO_TX
+    }                type;
+    struct scatterlist        *sg;
+    size_t                req_size;
+    size_t                bytes_done;
+    struct s3c_sss            *dev;
+};
+
+/**
+ * struct sss_req_context - driver-specific data associated with a request
+ * @algorithm: algorithm used in request
+ * @blk_cipher: block cipher used in request
+ * @direction: whether to encrypt or decrypt
+ * @rx: RX FIFO channel, see struct sss_fifo_channel
+ * @tx: TX FIFO channel, see struct sss_fifo_channel
+ * @setup_done: whether hardware has been setup
+ * @err: indicates any occured error during request
+ */
+struct sss_req_context {
+    enum sss_algorithm {
+        ALGO_AES,
+        ALGO_DES,
+        ALGO_TDES,
+        ALGO_SHA1,
+        ALGO_HMAC_SHA1,
+    }                algorithm;
+    enum sss_block_cipher {
+        CIPH_ECB,
+        CIPH_CBC,
+        CIPH_CTR,
+    }                blk_cipher;
+    enum sss_direction {
+        ENCRYPT,
+        DECRYPT,
+    }                direction;
+
+    struct sss_fifo_channel        rx;
+    struct sss_fifo_channel        tx;
+    bool                setup_done;
+    int                err;
+};
+
+struct sss_crypto_wrapper
+{
+    struct crypto_alg         alg;
+    struct s3c_sss            *dev;
+};
+
+/*** Helper functions ***/
+
+static inline struct s3c_sss *to_sss(struct crypto_alg *alg)
+{
+    return container_of(alg, struct sss_crypto_wrapper, alg)->dev;
+}
+
+#define fifo_to_req_ctx(fifo, type) container_of((fifo), \
+                         struct sss_req_context, type)
+
+static inline struct sss_req_context *sss_to_req_ctx(struct s3c_sss *sss)
+{
+    struct ablkcipher_request *req = sss->cur_req;
+    return req ? ablkcipher_request_ctx(req) : NULL;
+}
+
+static inline unsigned int fifo_to_dma_channel(struct sss_fifo_channel
*chan)
+{
+    return chan->type == FIFO_TX ? DMACH_SECURITY_TX : DMACH_SECURITY_RX;
+}
+
+static inline bool sss_dma_enabled(void)
+{
+    /* DMA is disabled till someone figures out why it's not transmitting
+       all data to the crypto engine. */
+    return false;
+}
+
+static int count_sgs(struct scatterlist *sg)
+{
+    int i;
+
+    for (i=0; sg; i++)
+        sg = sg_next(sg);
+
+    return i;
+}
+
+static inline void orrl(u32 val, void __iomem *reg)
+{
+    writel(readl(reg) | val, reg);
+}
+
+/*** HW handling ***/
+
+static void sss_dump_regs(struct s3c_sss *sss)
+{
+    dev_dbg(sss->dev, "DnI_CFG: %x\n", readl(sss->regs + DnI_CFG));
+
+    dev_dbg(sss->dev, "FRx_Ctrl: %x\n", readl(sss->regs + FRx_Ctrl));
+    dev_dbg(sss->dev, "FRx_MLen: %x\n", readl(sss->regs + FRx_MLen));
+    dev_dbg(sss->dev, "FRx_BlkSz: %x\n", readl(sss->regs + FRx_BlkSz));
+    dev_dbg(sss->dev, "FRx_Addr: %x\n", readl(sss->regs + FRx_Addr));
+    dev_dbg(sss->dev, "FRx_MLenCnt: %x\n", readl(sss->regs + FRx_MLenCnt));
+
+    dev_dbg(sss->dev, "FTx_Ctrl: %x\n", readl(sss->regs + FTx_Ctrl));
+    dev_dbg(sss->dev, "FTx_MLen: %x\n", readl(sss->regs + FTx_MLen));
+    dev_dbg(sss->dev, "FTx_BlkSz: %x\n", readl(sss->regs + FTx_BlkSz));
+    dev_dbg(sss->dev, "FTx_Addr: %x\n", readl(sss->regs + FTx_Addr));
+    dev_dbg(sss->dev, "FTx_MLenCnt: %x\n", readl(sss->regs + FTx_MLenCnt));
+
+    dev_dbg(sss->dev, "AES_CTRL: %x\n", readl(sss->regs + AES_CTRL));
+    dev_dbg(sss->dev, "TDES_CTRL: %x\n", readl(sss->regs + TDES_CTRL));
+    dev_dbg(sss->dev, "HASH_CTRL: %x\n", readl(sss->regs + HASH_CTRL));
+    dev_dbg(sss->dev, "HASH_STATUS: %x\n", readl(sss->regs + HASH_STATUS));
+}
+
+static void sss_reset_fifo(struct s3c_sss *sss, int reg, const char* name)
+{
+    int timeout = 1000;
+    u32 val;
+
+    writel(FXx_Ctrl_Reset, sss->regs + reg);
+
+    while (timeout-- > 0) {
+        val = readl(sss->regs + reg);
+        if (!(val & FXx_Ctrl_Reset))
+            break;
+    }
+
+    if (timeout <= 0)
+        dev_warn(sss->dev, "Failed to reset %s!\n", name);
+}
+
+static void sss_reset_hw(struct s3c_sss *sss)
+{
+    u32 val = 0;
+
+    if (sss_dma_enabled())
+        val |= (DnI_CFG_RxDmaEnb | DnI_CFG_TxDmaEnb |
+            DnI_CFG_RxTrgLevel(16) | DnI_CFG_TxTrgLevel(16));
+
+    writel(val, sss->regs + DnI_CFG);
+
+    /* Reset FIFOs */
+    sss_reset_fifo(sss, FRx_Ctrl, "FIFO_RX");
+    sss_reset_fifo(sss, FTx_Ctrl, "FIFO_TX");
+
+    /* Ensure all subsystems are disabled */
+    writel(0, sss->regs + AES_CTRL);
+    writel(0, sss->regs + TDES_CTRL);
+    writel(0, sss->regs + HASH_CTRL);
+}
+
+static void check_priv_mismatch(struct s3c_sss *sss, const char* name,
int reg)
+{
+    u32 val = readl(sss->regs + reg);
+
+    if (val & RdPrivMismatch)
+        dev_warn(sss->dev, "%s read privilege mismatch! (0x%x)\n", name,
+             val);
+
+    if (val & WrPrivMismatch)
+        dev_warn(sss->dev, "%s write privilege mismatch! (0x%x)\n",
+             name, val);
+}
+
+static irqreturn_t sss_irq(int irq, void *priv)
+{
+    struct s3c_sss *sss = priv;
+    u32 cfg = readl(sss->regs + DnI_CFG);
+
+    check_priv_mismatch(sss, "CONFIG", DnI_CFG);
+
+    if (cfg & DnI_CFG_FRx_Intr_Status) {
+        dev_dbg(sss->dev, "%s: FIFO_RX IRQ\n", __func__);
+        check_priv_mismatch(sss, "FIFO RX", FRx_Ctrl);
+
+        if (sss->cur_req && !sss_dma_enabled()) {
+            struct sss_fifo_channel *ch = &sss_to_req_ctx(sss)->rx;
+            if (ch->req_size) {
+                dev_dbg(sss->dev, "Increasing consumption with %d
bytes\n", ch->req_size);
+                ch->bytes_done += ch->req_size;
+                ch->req_size = 0;
+                tasklet_schedule(&sss->tasklet);
+            }
+        }
+    }
+
+    if (cfg & DnI_CFG_FTx_Intr_Status) {
+        dev_dbg(sss->dev, "%s: FIFO_TX IRQ\n", __func__);
+        check_priv_mismatch(sss, "FIFO TX", FTx_Ctrl);
+
+        if (sss->cur_req && !sss_dma_enabled())
+            tasklet_schedule(&sss->tasklet);
+    }
+
+    if (cfg & DnI_CFG_SHA_Intr_Status) {
+        dev_dbg(sss->dev, "%s: HASH IRQ\n", __func__);
+    }
+
+    if (cfg & DnI_CFG_DES_Intr_Status) {
+        dev_dbg(sss->dev, "%s: TDES IRQ\n", __func__);
+        check_priv_mismatch(sss, "TDES", TDES_CTRL);
+    }
+
+    if (cfg & DnI_CFG_AES_Intr_Status) {
+        dev_dbg(sss->dev, "%s: AES IRQ\n", __func__);
+        check_priv_mismatch(sss, "AES", AES_CTRL);
+    }
+
+    return IRQ_HANDLED;
+}
+
+static void sss_dma_cb(struct s3c2410_dma_chan *chan, void *pw, int size,
+               enum s3c2410_dma_buffresult res)
+{
+    struct sss_fifo_channel *fifo_chan = pw;
+    struct s3c_sss *sss = fifo_chan->dev;
+    struct sss_req_context *req_ctx;
+
+    dev_dbg(sss->dev, "DMA callback: %s!\n",
+        fifo_chan->type == FIFO_RX ? "RX" : "TX");
+
+    if (fifo_chan->type == FIFO_RX)
+        req_ctx = fifo_to_req_ctx(fifo_chan, rx);
+    else
+        req_ctx = fifo_to_req_ctx(fifo_chan, tx);
+
+    switch (res) {
+    case S3C2410_RES_OK:
+        fifo_chan->bytes_done += fifo_chan->req_size;
+        fifo_chan->offset += fifo_chan->req_size;
+        fifo_chan->req_size = 0;
+        break;
+    case S3C2410_RES_ERR:
+    case S3C2410_RES_ABORT:
+    default:
+        dev_err(sss->dev, "Error occured during DMA transfer!\n");
+        if (!req_ctx->err)
+            req_ctx->err = -EIO;
+    }
+
+    tasklet_schedule(&sss->tasklet);
+}
+
+static int sss_setup_dma(struct s3c_sss *sss, unsigned int channel)
+{
+    enum s3c2410_dmasrc source;
+    unsigned long reg;
+    int ret;
+
+    ret = s3c2410_dma_request(channel, &sss->dma_client, sss);
+    if (ret < 0)
+        return ret;
+
+    if (channel == DMACH_SECURITY_RX) {
+        reg = (unsigned long)(sss->regs_phys + SDMA_FRx_Buf);
+        source = S3C2410_DMASRC_MEM;
+    } else { /* DMACH_SECURITY_TX */
+        reg = (unsigned long)(sss->regs_phys + SDMA_FTx_Buf);
+        source = S3C2410_DMASRC_HW;
+    }
+
+    s3c2410_dma_config(channel, 4);
+    s3c2410_dma_devconfig(channel, source, reg);
+    s3c2410_dma_set_buffdone_fn(channel, sss_dma_cb);
+
+    return 0;
+}
+
+static void sss_setup_hw(struct s3c_sss *sss)
+{
+    struct ablkcipher_request *req = sss->cur_req;
+    struct sss_context *ctx = crypto_tfm_ctx(req->base.tfm);
+    struct sss_req_context *req_ctx = ablkcipher_request_ctx(req);
+    u32 val, cfg, fifo_rx, fifo_tx;
+
+    printk("%s: setting up hw\n", __func__);
+
+    sss_reset_hw(sss);
+
+    cfg = readl(sss->regs + DnI_CFG);
+
+    fifo_rx = (FXx_Ctrl_Host_Rd_En | FXx_Ctrl_Host_Wr_En |
+           FRx_Ctrl_Sync_Tx);
+    fifo_tx = (FXx_Ctrl_Host_Rd_En | FXx_Ctrl_Host_Wr_En);
+
+    switch (req_ctx->algorithm) {
+    case ALGO_AES:
+        cfg |= DnI_CFG_AES_Intr_En;
+        fifo_rx |= FXx_Ctrl_Module_AES;
+        fifo_tx |= FXx_Ctrl_Module_AES;
+
+        switch (req_ctx->blk_cipher) {
+        case CIPH_ECB:
+            val = AES_CTRL_OpMode_ECB;
+            break;
+        case CIPH_CBC:
+            val = AES_CTRL_OpMode_CBC;
+            memcpy(sss->regs + AES_IV, req->info, 16);
+            break;
+        case CIPH_CTR:
+            val = AES_CTRL_OpMode_CTR;
+            memcpy(sss->regs + AES_CTR, req->info, 16); /* ??? */
+            break;
+        }
+
+        if (req_ctx->direction == DECRYPT &&
+            req_ctx->blk_cipher != CIPH_CTR)
+            val |= AES_CTRL_OpDirection_Dec;
+        else
+            val |= AES_CTRL_OpDirection_Enc;
+
+        switch (ctx->key_len) {
+        case AES_KEYSIZE_128:
+            val |= AES_CTRL_KeyMode_128bits;
+            break;
+        case AES_KEYSIZE_192:
+            val |= AES_CTRL_KeyMode_192bits;
+            break;
+        case AES_KEYSIZE_256:
+            val |= AES_CTRL_KeyMode_256bits;
+            break;
+        }
+        memcpy(sss->regs + AES_KEY, ctx->key, ctx->key_len);
+
+        writel(val, sss->regs + AES_CTRL);
+
+        writel(AES_BLOCK_SIZE / 4, sss->regs + FRx_BlkSz);
+        writel(AES_BLOCK_SIZE / 4, sss->regs + FTx_BlkSz);
+        writel(sss->regs_phys + AES_DIN, sss->regs + FRx_Addr);
+        writel(sss->regs_phys + AES_DOUT, sss->regs + FTx_Addr);
+
+        break;
+    case ALGO_DES:
+    case ALGO_TDES:
+        cfg |= DnI_CFG_DES_Intr_En;
+        fifo_rx |= FXx_Ctrl_Module_DES;
+        fifo_tx |= FXx_Ctrl_Module_DES;
+
+        switch (req_ctx->blk_cipher) {
+        case CIPH_ECB:
+            val = TDES_CTRL_Mode_ECB;
+            break;
+        case CIPH_CBC:
+            val = TDES_CTRL_Mode_CBC;
+            memcpy(sss->regs + TDES_IV, req->info, 16);
+            break;
+        case CIPH_CTR:
+            /* NOP */
+            break;
+        }
+
+        val |= (req_ctx->direction == DECRYPT ?
+            TDES_CTRL_OpDirection_Dec : TDES_CTRL_OpDirection_Enc);
+        val |= (req_ctx->algorithm == ALGO_TDES ? TDES_CTRL_Mode_Tdes :
+            TDES_CTRL_Mode_Des);
+        val |= (TDES_CTRL_IntMode);
+
+        memcpy(sss->regs + TDES_KEY, ctx->key, ctx->key_len);
+
+        writel(val, sss->regs + TDES_CTRL);
+
+        writel(DES_BLOCK_SIZE / 4, sss->regs + FRx_BlkSz);
+        writel(DES_BLOCK_SIZE / 4, sss->regs + FTx_BlkSz);
+        writel(sss->regs_phys + TDES_INPUT, sss->regs + FRx_Addr);
+        writel(sss->regs_phys + TDES_OUTPUT, sss->regs + FTx_Addr);
+
+        break;
+    case ALGO_SHA1:
+        cfg |= DnI_CFG_SHA_Intr_En;
+        fifo_rx |= FXx_Ctrl_Module_SHA;
+        fifo_tx |= FXx_Ctrl_Module_SHA;
+
+        /*TODO*/
+
+        break;
+    }
+
+    cfg |= (DnI_CFG_FTx_Intr_En | DnI_CFG_FRx_Intr_En);
+    writel(cfg, sss->regs + DnI_CFG);
+
+    writel(fifo_rx, sss->regs + FRx_Ctrl);
+    writel(fifo_tx, sss->regs + FTx_Ctrl);
+}
+
+static void sss_setup_hw_mlen(struct sss_fifo_channel *chan, size_t len)
+{
+    struct s3c_sss *sss = chan->dev;
+
+    if (chan->type == FIFO_RX) {
+        writel(len / 4, sss->regs + FRx_MLen);
+        orrl(FXx_Ctrl_Start, sss->regs + FRx_Ctrl);
+    } else {
+        writel(len / 4, sss->regs + FTx_MLen);
+        orrl(FXx_Ctrl_Start, sss->regs + FTx_Ctrl);
+    }
+}
+
+static int sss_setup_dma_channel(struct sss_fifo_channel *chan)
+{
+    struct s3c_sss *sss = chan->dev;
+    unsigned int channel = fifo_to_dma_channel(chan);
+    int ret;
+
+    if (chan->offset >= sg_dma_len(chan->cur_sg)) {
+        chan->cur_sg = sg_next(chan->cur_sg);
+        chan->offset = 0;
+    }
+
+    chan->req_size = min(sg_dma_len(chan->cur_sg) - chan->offset,
+                 SSS_FIFO_SIZE);
+
+    sss_setup_hw_mlen(chan, chan->req_size);
+
+    dev_dbg(sss->dev, "Enqueue'ing for %s: %x (%d)\n",
+        channel == DMACH_SECURITY_TX ? "TX" : "RX",
+        sg_dma_address(chan->cur_sg) + chan->offset, chan->req_size);
+
+    ret = s3c2410_dma_enqueue(channel, chan,
+                  sg_dma_address(chan->cur_sg) + chan->offset,
+                  chan->req_size);
+    if (ret)
+        return ret;
+
+    return s3c2410_dma_ctrl(fifo_to_dma_channel(chan),
S3C2410_DMAOP_START);
+}
+
+static void sss_setup_fifo(struct sss_fifo_channel *chan)
+{
+    struct s3c_sss *sss = chan->dev;
+    struct ablkcipher_request *req = sss->cur_req;
+    enum dma_data_direction dir;
+    unsigned int sg_flags;
+
+    if (chan->type == FIFO_RX) {
+        sg_flags = SG_MITER_FROM_SG;
+        chan->sg = req->src;
+        dir = DMA_TO_DEVICE;
+    } else {
+        sg_flags = SG_MITER_TO_SG;
+        chan->sg = req->dst;
+        dir = DMA_FROM_DEVICE;
+    }
+
+    if (sss_dma_enabled()) {
+        int sg_count = count_sgs(chan->sg);
+        chan->sg_count = dma_map_sg(sss->dev, chan->sg, sg_count, dir);
+        chan->cur_sg = chan->sg;
+
+        s3c2410_dma_ctrl(fifo_to_dma_channel(chan),
+                 S3C2410_DMAOP_FLUSH);
+    }
+}
+
+static int sss_handle_fifo(struct sss_fifo_channel *chan)
+{
+    struct s3c_sss *sss = chan->dev;
+    struct ablkcipher_request *req = sss->cur_req;
+    void __iomem *fifo;
+
+    if (chan->req_size)
+        /* FIFO is still transferring data */
+        return -EINPROGRESS;
+
+    if (sss_dma_enabled())
+        return sss_setup_dma_channel(chan);
+
+    /* PIO */
+    if (chan->type == FIFO_RX)
+        fifo = sss->regs + FRx_Buf;
+    else
+        fifo = sss->regs + FTx_Buf;
+
+    chan->req_size = min(req->nbytes - chan->bytes_done, SSS_FIFO_SIZE);
+
+    sss_setup_hw_mlen(chan, chan->req_size);
+
+    dev_dbg(sss->dev, "Transferring %d bytes to FIFO_%s\n", chan->req_size,
+        chan->type == FIFO_TX ? "TX" : "RX");
+
+    scatterwalk_map_and_copy(fifo, chan->sg, chan->bytes_done,
+                 chan->req_size, (chan->type == FIFO_TX));
+
+    if (chan->type == FIFO_TX) {
+        chan->bytes_done += chan->req_size;
+        chan->req_size = 0;
+    }
+
+    return 0;
+}
+
+static void sss_cleanup_fifo(struct sss_fifo_channel *chan)
+{
+    struct s3c_sss *sss = chan->dev;
+    enum dma_data_direction dir;
+
+    if (sss_dma_enabled()) {
+        if (chan->type == FIFO_RX)
+            dir = DMA_TO_DEVICE;
+        else
+            dir = DMA_FROM_DEVICE;
+
+        dma_unmap_sg(sss->dev, chan->sg, chan->sg_count, dir);
+
+        s3c2410_dma_ctrl(fifo_to_dma_channel(chan), S3C2410_DMAOP_STOP);
+    }
+}
+
+static void sss_timer_callback(unsigned long priv)
+{
+    struct s3c_sss *sss = (struct s3c_sss *)priv;
+    struct sss_req_context *req_ctx = sss_to_req_ctx(sss);
+
+    dev_err(sss->dev, "Request timed out!\n");
+    req_ctx->err = -ETIMEDOUT;
+
+    tasklet_schedule(&sss->tasklet);
+}
+
+static void sss_tasklet_callback(unsigned long priv)
+{
+    struct s3c_sss *sss = (struct s3c_sss *)priv;
+    struct sss_req_context *req_ctx;
+    struct ablkcipher_request *req;
+    unsigned long flags;
+
+    if (!sss->cur_req) {
+        spin_lock_irqsave(&sss->lock, flags);
+        sss->cur_req = ablkcipher_dequeue_request(&sss->queue);
+        spin_unlock_irqrestore(&sss->lock, flags);
+
+        if (!sss->cur_req) {
+            dev_warn(sss->dev, "Tasklet was called without any "
+                       "pending request!\n");
+            return;
+        }
+    }
+
+    /*TODO: backlog*/
+
+    req = sss->cur_req;
+    req_ctx = ablkcipher_request_ctx(req);
+
+    dev_dbg(sss->dev, "Current request: %p (%d)\n", req, req->nbytes);
+
+    if (!req_ctx->setup_done) {
+        sss_setup_hw(sss);
+        sss_setup_fifo(&req_ctx->rx);
+        sss_setup_fifo(&req_ctx->tx);
+        req_ctx->setup_done = true;
+    }
+
+    if (timer_pending(&sss->timer))
+        del_timer(&sss->timer);
+
+    if (!req_ctx->err && (req_ctx->rx.bytes_done < req->nbytes ||
+                  req_ctx->tx.bytes_done < req->nbytes)) {
+        int ret;
+
+        if (req_ctx->tx.bytes_done < req_ctx->rx.bytes_done)
+            /* Keep TX in sync with RX */
+            ret = sss_handle_fifo(&req_ctx->tx);
+        else
+            /* Transmit some more data to RX */
+            ret = sss_handle_fifo(&req_ctx->rx);
+
+        if (ret && ret != -EINPROGRESS) {
+            req_ctx->err = ret;
+            goto done;
+        }
+
+        mod_timer(&sss->timer, jiffies + SSS_TIMEOUT * HZ);
+        return;
+    }
+
+done:
+    dev_dbg(sss->dev, "Transfer done!\n");
+    sss_cleanup_fifo(&req_ctx->rx);
+    sss_cleanup_fifo(&req_ctx->tx);
+
+    req->base.complete(&req->base, req_ctx->err);
+    sss->cur_req = NULL;
+
+    /* Check whether there's still work to do */
+    spin_lock_irqsave(&sss->lock, flags);
+    if (sss->queue.qlen || crypto_get_backlog(&sss->queue))
+        tasklet_schedule(&sss->tasklet);
+    spin_unlock_irqrestore(&sss->lock, flags);
+}
+
+/*** SW handling ***/
+
+static int sss_crypto_generic(struct ablkcipher_request *req,
+                  enum sss_algorithm alg,
+                  enum sss_block_cipher blk_ciph,
+                  enum sss_direction dir)
+{
+    struct sss_context *ctx = crypto_tfm_ctx(req->base.tfm);
+    struct sss_req_context *req_ctx = ablkcipher_request_ctx(req);
+    struct s3c_sss *sss = ctx->dev;
+    unsigned long flags;
+    int ret;
+
+    memset(req_ctx, 0, sizeof(struct sss_req_context));
+
+    dev_dbg(sss->dev, "%s: %s %d\n", __func__,
crypto_tfm_alg_name(req->base.tfm), dir);
+
+    req_ctx->algorithm = alg;
+    req_ctx->blk_cipher = blk_ciph;
+    req_ctx->direction = dir;
+
+    req_ctx->rx.dev = sss;
+    req_ctx->rx.type = FIFO_RX;
+    req_ctx->tx.dev = sss;
+    req_ctx->tx.type = FIFO_TX;
+
+    spin_lock_irqsave(&sss->lock, flags);
+    ret = ablkcipher_enqueue_request(&sss->queue, req);
+    spin_unlock_irqrestore(&sss->lock, flags);
+
+    if (ret == -EINPROGRESS)
+        tasklet_schedule(&sss->tasklet);
+    else
+        dev_err(sss->dev, "Couldn't enqueue request!\n");
+
+    return ret;
+}
+
+static int sss_aes_setkey(struct crypto_ablkcipher *cipher, const u8 *key,
+              unsigned int len)
+{
+    struct crypto_tfm *tfm    = crypto_ablkcipher_tfm(cipher);
+    struct sss_context *ctx    = crypto_tfm_ctx(tfm);
+
+    switch (len) {
+    case AES_KEYSIZE_128:
+    case AES_KEYSIZE_192:
+    case AES_KEYSIZE_256:
+        break;
+    default:
+        crypto_ablkcipher_set_flags(cipher, CRYPTO_TFM_RES_BAD_KEY_LEN);
+        return -EINVAL;
+    }
+
+    memcpy(ctx->key, key, len);
+    ctx->key_len = len;
+
+    return 0;
+}
+
+static int sss_des_setkey(struct crypto_ablkcipher *cipher, const u8 *key,
+              unsigned int len)
+{
+    struct crypto_tfm *tfm    = crypto_ablkcipher_tfm(cipher);
+    struct sss_context *ctx    = crypto_tfm_ctx(tfm);
+
+    if (len > SSS_MAX_KEY_SIZE) {
+        crypto_ablkcipher_set_flags(cipher, CRYPTO_TFM_RES_BAD_KEY_LEN);
+        return -EINVAL;
+    }
+
+    /* RFC2451: weak key checks SHOULD be performed */
+    if (len == DES_KEY_SIZE) {
+        u32 tmp[DES_EXPKEY_WORDS];
+        int ret = des_ekey(tmp, key);
+
+        if (unlikely(ret == 0) &&
+            (crypto_tfm_get_flags(tfm) & CRYPTO_TFM_REQ_WEAK_KEY)) {
+            crypto_tfm_set_flags(tfm, CRYPTO_TFM_RES_WEAK_KEY);
+            return -EINVAL;
+        }
+    }
+
+    memcpy(ctx->key, key, len);
+    ctx->key_len = len;
+
+    return 0;
+}
+
+static int sss_cra_init(struct crypto_tfm *tfm)
+{
+    struct s3c_sss *sss = to_sss(tfm->__crt_alg);
+    struct sss_context *ctx = crypto_tfm_ctx(tfm);
+
+    ctx->dev = sss;
+    tfm->crt_ablkcipher.reqsize = sizeof(struct sss_req_context);
+
+    return 0;
+}
+
+static int sss_aes_cbc_encrypt(struct ablkcipher_request *req)
+{
+    return sss_crypto_generic(req, ALGO_AES, CIPH_CBC, ENCRYPT);
+}
+
+static int sss_aes_cbc_decrypt(struct ablkcipher_request *req)
+{
+    return sss_crypto_generic(req, ALGO_AES, CIPH_CBC, DECRYPT);
+}
+
+static int sss_aes_ecb_encrypt(struct ablkcipher_request *req)
+{
+    return sss_crypto_generic(req, ALGO_AES, CIPH_ECB, ENCRYPT);
+}
+
+static int sss_aes_ecb_decrypt(struct ablkcipher_request *req)
+{
+    return sss_crypto_generic(req, ALGO_AES, CIPH_ECB, DECRYPT);
+}
+
+static int sss_aes_ctr_encrypt(struct ablkcipher_request *req)
+{
+    return sss_crypto_generic(req, ALGO_AES, CIPH_CTR, ENCRYPT);
+}
+
+static int sss_aes_ctr_decrypt(struct ablkcipher_request *req)
+{
+    return sss_crypto_generic(req, ALGO_AES, CIPH_CTR, DECRYPT);
+}
+
+static int sss_des_ecb_encrypt(struct ablkcipher_request *req)
+{
+    return sss_crypto_generic(req, ALGO_DES, CIPH_ECB, ENCRYPT);
+}
+
+static int sss_des_ecb_decrypt(struct ablkcipher_request *req)
+{
+    return sss_crypto_generic(req, ALGO_DES, CIPH_ECB, DECRYPT);
+}
+
+static int sss_des_cbc_encrypt(struct ablkcipher_request *req)
+{
+    return sss_crypto_generic(req, ALGO_DES, CIPH_CBC, ENCRYPT);
+}
+
+static int sss_des_cbc_decrypt(struct ablkcipher_request *req)
+{
+    return sss_crypto_generic(req, ALGO_DES, CIPH_CBC, DECRYPT);
+}
+
+static int sss_tdes_ecb_encrypt(struct ablkcipher_request *req)
+{
+    return sss_crypto_generic(req, ALGO_TDES, CIPH_ECB, ENCRYPT);
+}
+
+static int sss_tdes_ecb_decrypt(struct ablkcipher_request *req)
+{
+    return sss_crypto_generic(req, ALGO_TDES, CIPH_ECB, DECRYPT);
+}
+
+static int sss_tdes_cbc_encrypt(struct ablkcipher_request *req)
+{
+    return sss_crypto_generic(req, ALGO_TDES, CIPH_CBC, ENCRYPT);
+}
+
+static int sss_tdes_cbc_decrypt(struct ablkcipher_request *req)
+{
+    return sss_crypto_generic(req, ALGO_TDES, CIPH_CBC, DECRYPT);
+}
+
+static struct sss_algo_template {
+    char                 *alg_name;
+    char                 *blk_ciph_name;
+    int                 blk_size;
+    struct ablkcipher_alg          ablkcipher;
+
+    struct sss_crypto_wrapper         *alg;
+} sss_algos[] = {
+    /* AES ECB/CBC/CTR */
+    {
+        .alg_name = "aes",
+        .blk_ciph_name = "ecb",
+        .blk_size = AES_BLOCK_SIZE,
+        .ablkcipher = {
+            .min_keysize    =    AES_MIN_KEY_SIZE,
+            .max_keysize    =    AES_MAX_KEY_SIZE,
+            .setkey        =    sss_aes_setkey,
+            .encrypt    =    sss_aes_ecb_encrypt,
+            .decrypt    =    sss_aes_ecb_decrypt,
+        },
+    },
+    {
+        .alg_name = "aes",
+        .blk_ciph_name = "cbc",
+        .blk_size = AES_BLOCK_SIZE,
+        .ablkcipher = {
+            .ivsize        =    AES_BLOCK_SIZE,
+            .min_keysize    =    AES_MIN_KEY_SIZE,
+            .max_keysize    =    AES_MAX_KEY_SIZE,
+            .setkey        =    sss_aes_setkey,
+            .encrypt    =    sss_aes_cbc_encrypt,
+            .decrypt    =    sss_aes_cbc_decrypt,
+        },
+    },
+    {
+        .alg_name = "aes",
+        .blk_ciph_name = "ctr",
+        .blk_size = AES_BLOCK_SIZE,
+        .ablkcipher = {
+            .ivsize        =    CTR_RFC3686_IV_SIZE,
+            .min_keysize    =    AES_MIN_KEY_SIZE,
+            .max_keysize    =    AES_MAX_KEY_SIZE,
+            .setkey        =    sss_aes_setkey,
+            .encrypt    =    sss_aes_ctr_encrypt,
+            .decrypt    =    sss_aes_ctr_decrypt,
+        },
+    },
+    /* DES CBC/ECB */
+    {
+        .alg_name = "des",
+        .blk_ciph_name = "cbc",
+        .blk_size = DES_BLOCK_SIZE,
+        .ablkcipher = {
+            .ivsize        =    DES_BLOCK_SIZE,
+            .min_keysize    =    DES_KEY_SIZE,
+            .max_keysize    =    DES_KEY_SIZE,
+            .setkey        =    sss_des_setkey,
+            .encrypt    =    sss_des_cbc_encrypt,
+            .decrypt    =    sss_des_cbc_decrypt,
+        },
+    },
+    {
+        .alg_name = "des",
+        .blk_ciph_name = "ecb",
+        .blk_size = DES_BLOCK_SIZE,
+        .ablkcipher = {
+            .min_keysize    =    DES_KEY_SIZE,
+            .max_keysize    =    DES_KEY_SIZE,
+            .setkey        =    sss_des_setkey,
+            .encrypt    =    sss_des_ecb_encrypt,
+            .decrypt    =    sss_des_ecb_decrypt,
+        },
+    },
+    /* TDES CBC/ECB */
+    {
+        .alg_name = "des3_ede",
+        .blk_ciph_name = "cbc",
+        .blk_size = DES3_EDE_BLOCK_SIZE,
+        .ablkcipher = {
+            .ivsize        =    DES3_EDE_BLOCK_SIZE,
+            .min_keysize    =    DES3_EDE_KEY_SIZE,
+            .max_keysize    =    DES3_EDE_KEY_SIZE,
+            .setkey        =    sss_des_setkey,
+            .encrypt    =    sss_tdes_cbc_encrypt,
+            .decrypt    =    sss_tdes_cbc_decrypt,
+        },
+    },
+    {
+        .alg_name = "des3_ede",
+        .blk_ciph_name = "ecb",
+        .blk_size = DES3_EDE_BLOCK_SIZE,
+        .ablkcipher = {
+            .min_keysize    =    DES3_EDE_KEY_SIZE,
+            .max_keysize    =    DES3_EDE_KEY_SIZE,
+            .setkey        =    sss_des_setkey,
+            .encrypt    =    sss_tdes_ecb_encrypt,
+            .decrypt    =    sss_tdes_ecb_decrypt,
+        },
+    },
+};
+
+static int sss_init_template(struct platform_device *pdev,
+                 struct sss_algo_template *templ)
+{
+    struct s3c_sss *sss = platform_get_drvdata(pdev);
+    struct sss_crypto_wrapper *alg;
+
+    alg = kzalloc(sizeof(struct sss_crypto_wrapper), GFP_KERNEL);
+    if (!alg)
+        return -ENOMEM;
+
+    alg->dev = sss;
+
+    snprintf(alg->alg.cra_name, CRYPTO_MAX_ALG_NAME, "%s(%s)",
+         templ->blk_ciph_name, templ->alg_name);
+    snprintf(alg->alg.cra_driver_name, CRYPTO_MAX_ALG_NAME, "%s-%s-%s",
+         pdev->name, templ->alg_name, templ->blk_ciph_name);
+
+    dev_info(sss->dev, "crypto acceleration for %s", alg->alg.cra_name);
+
+    alg->alg.cra_ablkcipher = templ->ablkcipher;
+    alg->alg.cra_alignmask    = 0;
+    alg->alg.cra_blocksize    = templ->blk_size;
+    alg->alg.cra_ctxsize    = sizeof(struct sss_context);
+    alg->alg.cra_flags    = CRYPTO_ALG_TYPE_ABLKCIPHER |
+                  CRYPTO_ALG_ASYNC;
+    alg->alg.cra_init    = sss_cra_init;
+    alg->alg.cra_module    = THIS_MODULE;
+    alg->alg.cra_priority    = SSS_CRA_PRIORITY;
+    alg->alg.cra_type    = &crypto_ablkcipher_type;
+
+    templ->alg = alg;
+
+    return 0;
+}
+
+#if 0
+static struct ahash_alg sss_sha1_alg = {
+    .init       =     padlock_sha_init,
+    .update     =    padlock_sha_update,
+    .final      =    padlock_sha1_final,
+    .digest        =    padlock_sha1_final,
+    .halg        =    {
+        .digestsize        =    SHA1_DIGEST_SIZE,
+        .statesize        =    sizeof(struct sha1_state),
+        .base            =    {
+            .cra_name        =    "sha1",
+            .cra_driver_name    =    "s3c-sss-sha1",
+            .cra_priority        =    SSS_CRA_PRIORITY,
+            .cra_flags        =    CRYPTO_ALG_TYPE_AHASH |
+                            CRYPTO_ALG_ASYNC,
+            .cra_blocksize        =    SHA1_BLOCK_SIZE,
+            .cra_ctxsize        =    sizeof(struct sss_context),
+            .cra_type        =    &crypto_ahash_type,
+            .cra_module        =    THIS_MODULE,
+        }
+    },
+};
+#endif
+
+static void sss_unregister_algos(void)
+{
+    struct sss_crypto_wrapper *alg;
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(sss_algos); i++) {
+        alg = sss_algos[i].alg;
+
+        if (alg) {
+            crypto_unregister_alg(&alg->alg);
+            kfree(alg);
+
+            sss_algos[i].alg = NULL;
+        }
+    }
+
+    //crypto_unregister_ahash(sss_sha1_alg);
+}
+
+static int sss_register_algos(struct platform_device *pdev)
+{
+    int i, ret;
+
+    for (i = 0; i < ARRAY_SIZE(sss_algos); i++) {
+        ret = sss_init_template(pdev, &sss_algos[i]);
+        if (ret)
+            goto exit;
+
+        ret = crypto_register_alg(&sss_algos[i].alg->alg);
+        if (ret)
+            goto exit;
+    }
+
+    //ret = crypto_register_ahash(sss_sha1_alg);
+    if (ret)
+        goto exit;
+
+    return 0;
+
+exit:
+    sss_unregister_algos();
+    return ret;
+}
+
+static int __devinit sss_probe(struct platform_device *pdev)
+{
+    struct device *dev = &pdev->dev;
+    struct resource *res;
+    struct s3c_sss *sss;
+    int ret;
+
+    sss = kzalloc(sizeof(struct s3c_sss), GFP_KERNEL);
+    if (!sss) {
+        dev_err(dev, "cannot allocate memory\n");
+        return -ENOMEM;
+    }
+
+    spin_lock_init(&sss->lock);
+    crypto_init_queue(&sss->queue, 50);
+    tasklet_init(&sss->tasklet, sss_tasklet_callback, (unsigned long)sss);
+    setup_timer(&sss->timer, sss_timer_callback, (unsigned long)sss);
+
+    sss->dev = dev;
+    sss->dma_client.name = (char*) pdev->name;
+    platform_set_drvdata(pdev, sss);
+
+    res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+    if (!res) {
+        dev_err(dev, "cannot find register resource\n");
+        ret = -EINVAL;
+        goto exit_dev;
+    }
+
+    sss->regs_res = request_mem_region(res->start, resource_size(res),
+                       dev_name(dev));
+    if (!sss->regs_res) {
+        dev_err(dev, "cannot request register resource\n");
+        ret = -ENOENT;
+        goto exit_dev;
+    }
+
+    sss->regs_phys = (void __iomem*) res->start;
+
+    sss->regs = ioremap(res->start, resource_size(res));
+    if (!sss->regs) {
+        dev_err(dev, "cannot map registers\n");
+        ret = -ENXIO;
+        goto exit_resource;
+    }
+
+    ret = platform_get_irq(pdev, 0);
+    if (ret < 0 || ret == NO_IRQ) {
+        dev_err(dev, "cannot find IRQ\n");
+        goto exit_regs_remap;
+    }
+
+    sss->irq = ret;
+
+    ret = request_irq(sss->irq, sss_irq, 0, dev_name(dev), sss);
+    if (ret < 0) {
+        dev_err(dev, "cannot claim IRQ\n");
+        goto exit_regs_remap;
+    }
+
+    sss->clock = clk_get(dev, "secur");
+    if (!sss->clock) {
+        dev_err(dev, "cannot find clock\n");
+        ret = -ENXIO;
+        goto exit_irq;
+    }
+
+    ret = clk_enable(sss->clock);
+    if (ret) {
+        dev_err(dev, "cannot enable clock\n");
+        goto exit_clock;
+    }
+
+    if (sss_dma_enabled()) {
+        ret = sss_setup_dma(sss, DMACH_SECURITY_RX);
+        if (ret < 0) {
+            dev_err(dev, "cannot setup SECURITY_RX DMA channel\n");
+            goto exit_clock_dis;
+        }
+
+        ret = sss_setup_dma(sss, DMACH_SECURITY_TX);
+        if (ret < 0) {
+            dev_err(dev, "cannot setup SECURITY_TX DMA channel\n");
+            goto exit_free_dma_rx;
+        }
+    }
+
+    ret = sss_register_algos(pdev);
+    if (ret) {
+        dev_err(dev, "cannot register algos\n");
+        goto exit_free_dma_tx;
+    }
+
+    //clk_disable(sss->clock);
+
+    return 0;
+
+exit_free_dma_tx:
+    if (sss_dma_enabled())
+        s3c2410_dma_free(DMACH_SECURITY_TX, &sss->dma_client);
+exit_free_dma_rx:
+    if (sss_dma_enabled())
+        s3c2410_dma_free(DMACH_SECURITY_RX, &sss->dma_client);
+exit_clock_dis:
+    clk_disable(sss->clock);
+exit_clock:
+    clk_put(sss->clock);
+exit_irq:
+    free_irq(sss->irq, sss);
+exit_regs_remap:
+    iounmap(sss->regs);
+exit_resource:
+    release_resource(sss->regs_res);
+    kfree(sss->regs_res);
+exit_dev:
+    tasklet_kill(&sss->tasklet);
+    kfree(sss);
+
+    return ret;
+}
+
+static int __devexit sss_remove(struct platform_device *pdev)
+{
+    struct s3c_sss *sss = platform_get_drvdata(pdev);
+
+    if (timer_pending(&sss->timer))
+        del_timer(&sss->timer);
+
+    if (sss_dma_enabled()) {
+        s3c2410_dma_free(DMACH_SECURITY_TX, &sss->dma_client);
+        s3c2410_dma_free(DMACH_SECURITY_RX, &sss->dma_client);
+    }
+
+    clk_disable(sss->clock); /*REMOVEME*/
+    sss_unregister_algos();
+    clk_put(sss->clock);
+    free_irq(sss->irq, sss);
+    iounmap(sss->regs);
+    release_resource(sss->regs_res);
+    kfree(sss->regs_res);
+    tasklet_kill(&sss->tasklet);
+    kfree(sss);
+
+    return 0;
+}
+
+static struct platform_driver sss_crypto = {
+    .driver        = {
+        .name    = "s3c-sss",
+        .owner    = THIS_MODULE,
+    },
+    .probe        = sss_probe,
+    .remove        = __devexit_p(sss_remove),
+};
+
+static int __init sss_crypto_init(void)
+{
+    return platform_driver_register(&sss_crypto);
+}
+module_init(sss_crypto_init);
+
+static void __exit sss_crypto_exit(void)
+{
+    platform_driver_unregister(&sss_crypto);
+}
+module_exit(sss_crypto_exit);
+
+MODULE_AUTHOR("Maurus Cuelenaere <mcuelenaere@gmail.com>");
+MODULE_DESCRIPTION("Support for Samsung's Security Sub-Systems");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:sss_crypto");
