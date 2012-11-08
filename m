From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 8 Nov 2012 14:05:23 +0000
Subject: [GIT PULL] vexpress: fixes for v3.8
In-Reply-To: <1350580125.4984.23.camel@hornet>
References: <1350580125.4984.23.camel@hornet>
Message-ID: <201211081405.23202.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 18 October 2012, Pawel Moll wrote:

> ----------------------------------------------------------------
> Pawel Moll (1):
>       ARM: vexpress: Make the debug UART detection more specific
> 

Building allyesconfig in linux-next now gives me:

arch/arm/kernel/debug.S: Assembler messages:
arch/arm/kernel/debug.S:81: Error: selected processor does not support ARM mode `movw r2,#0xc 091'
arch/arm/kernel/debug.S:81: Error: selected processor does not support ARM mode `movt r2,#0x4 10f'
arch/arm/kernel/debug.S:97: Error: selected processor does not support ARM mode `movw r2,#0xc 091'
arch/arm/kernel/debug.S:97: Error: selected processor does not support ARM mode `movt r2,#0x4 10f'
arch/arm/kernel/debug.S:104: Error: selected processor does not support ARM mode `movw r3,#0x c091'
arch/arm/kernel/debug.S:104: Error: selected processor does not support ARM mode `movt r3,#0x 410f'

The patch below fixes this. Do you think it's appropriate?

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/arm/include/debug/vexpress.S b/arch/arm/include/debug/vexpress.S
index 0c6abbf..dc8e882 100644
--- a/arch/arm/include/debug/vexpress.S
+++ b/arch/arm/include/debug/vexpress.S
@@ -21,6 +21,7 @@
 #if defined(CONFIG_DEBUG_VEXPRESS_UART0_DETECT)
 
 		.macro	addruart,rp,rv,tmp
+		.arch   armv7-a
 
 		@ Make an educated guess regarding the memory map:
 		@ - the original A9 core tile (based on ARM Cortex-A9 r0p1)
