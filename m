From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 7 Feb 2013 20:58:03 +0800
Subject: mx28evk does not boot with linux-next 20130207
In-Reply-To: <CAOMZO5Ar1T3Lg2KRvSLK-gjNAaAFAf39f6KqaYeF03w5bNj6EQ@mail.gmail.com>
References: <CAOMZO5Ar1T3Lg2KRvSLK-gjNAaAFAf39f6KqaYeF03w5bNj6EQ@mail.gmail.com>
Message-ID: <20130207125801.GA19091@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 07, 2013 at 09:47:58AM -0200, Fabio Estevam wrote:
> Hi,
> 
> When booting linux-next 20130207 I get no kernel console output on a
> mx28evk. After selecting earlyprintk and CONFIG_DEBUG_LL=y support I
> get:
> 
>   LD      vmlinux
>   SORTEX  vmlinux
> sort done marker at 514bcc
>   SYSMAP  System.map
>   OBJCOPY arch/arm/boot/Image
>   Kernel: arch/arm/boot/Image is ready
>   GZIP    arch/arm/boot/compressed/piggy.gzip
>   AS      arch/arm/boot/compressed/debug.o
> arch/arm/boot/compressed/debug.S: Assembler messages:
> arch/arm/boot/compressed/debug.S:6: Error: garbage following
> instruction -- `ldr
> r2,=IOMEM((0xf4000000+((((0x80000000+0x074000))&0x80000000)>>7)+((((0x80000000+0x074000))&0x000fffff))))'
> 
> Is this a known issue?
> 
Yes.  The following change should fix the problem.

Shawn

diff --git a/arch/arm/boot/compressed/debug.S
b/arch/arm/boot/compressed/debug.S
index bdb0e25..6e8382d 100644
--- a/arch/arm/boot/compressed/debug.S
+++ b/arch/arm/boot/compressed/debug.S
@@ -1,4 +1,5 @@
 #include <linux/linkage.h>
+#include <asm/assembler.h>

 #include CONFIG_DEBUG_LL_INCLUDE
