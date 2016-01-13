From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Wed, 13 Jan 2016 08:47:28 +0100
Subject: mtd: pxa3xx_nand: issue with command time out
In-Reply-To: <5695CEF0.1080100@alliedtelesis.co.nz> (Michael Wang's message of
 "Wed, 13 Jan 2016 04:13:37 +0000")
References: <5695CEF0.1080100@alliedtelesis.co.nz>
Message-ID: <87a8o9ex9r.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Michael Wang <Michael.Wang@alliedtelesis.co.nz> writes:

> Hi Robert,
>
> I am currently working with Marvell 98DX4251 switchchip with control and
> management subsystem SOC based on ARMADA XP, and after upgrading kernel from
...zip...

> 3.16.7 to 4.3, the nand controller command have a high chance of timing out.
> -#define        CHIP_DELAY_TIMEOUT      msecs_to_jiffies(200)
> +#define        CHIP_DELAY_TIMEOUT      msecs_to_jiffies(300)
>   #define NAND_STOP_DELAY                msecs_to_jiffies(40)
>   #define PAGE_CHUNK_SIZE                (2048)
>
> So I guess my question is whether the CHIP_DELAY_TIMEOUT should be increased
> for 98DX4251, or is this likely to be caused by some other issue?

Hi Michael,

> Any suggestion, help or hint will be very much appreciated.
Actually I have one.
Before we change the timeout, I'd like to see the sequence of register accesses.

As I owe a patch to Brian on this topic, I'd like to have you as a tester. In
return, I'll analyse the output of debug traces it generates for you.

The patch is at the bottom of this mail, and a "git am" on the mail should apply
it to your kernel. It leaves up to you to add the "#define VERBOSE_DEBUG 1" in
pxa3xx-nand.c, recompile, and take the traces.

Once I have the traces, I will be able to compare with my traces on pxa3xx
platforms and spot if there is a difference. Then we'll be able to see if
increasing the timeout is the only option.

Cheers.

-- 
Robert

--->8---
>From 2ab54517c4162e0041d11dd9ae376818d9a3a3e3 Mon Sep 17 00:00:00 2001
From: Robert Jarzmik <robert.jarzmik@free.fr>
Date: Tue, 11 Aug 2015 21:54:11 +0200
Subject: [PATCH v2] mtd: nand: pxa3xx_nand: add register access debug

Add verbose debug for register accesses. This enables easier debugging
by following where and how hardware is stimulated, and how it answers.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 drivers/mtd/nand/pxa3xx_nand.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index e453ae9a17fa..0845d09e14c1 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -136,11 +136,23 @@
 #define READ_ID_BYTES		7
 
 /* macros for registers read/write */
-#define nand_writel(info, off, val)	\
-	writel_relaxed((val), (info)->mmio_base + (off))
-
-#define nand_readl(info, off)		\
-	readl_relaxed((info)->mmio_base + (off))
+#define nand_writel(info, off, val)					\
+	do {								\
+		dev_vdbg(&info->pdev->dev,				\
+			 "%s():%d nand_writel(0x%x, 0x%04x)\n",		\
+			 __func__, __LINE__, (val), (off));		\
+		writel_relaxed((val), (info)->mmio_base + (off));	\
+	} while (0)
+
+#define nand_readl(info, off)						\
+	({								\
+		unsigned int _v;					\
+		_v = readl_relaxed((info)->mmio_base + (off));		\
+		dev_vdbg(&info->pdev->dev,				\
+			 "%s():%d nand_readl(0x%04x): 0x%x\n",		\
+			 __func__, __LINE__, (off), _v);		\
+		_v;							\
+	})
 
 /* error code and state */
 enum {
-- 
2.1.4
