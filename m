From: peterhuewe@gmx.de (Peter Huewe)
Date: Mon, 15 Aug 2011 17:40:10 +0200
Subject: [PATCH v2] arm: footbridge: Netwinder: Add KConfig select
	CLKEVT_I8253 to fix build failure
In-Reply-To: <20110815153338.GA525@n2100.arm.linux.org.uk>
References: <20110815153338.GA525@n2100.arm.linux.org.uk>
Message-ID: <1313422810-28916-1-git-send-email-peterhuewe@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes a build failure for the netwinder_defconfig by adding
the necessary select CLKEVT_I8253 statement to the KCONFIG option.

Without this patch the build fails with this linker error:
isa-rtc.c:(.init.text+0x11d4): undefined reference to
`clockevent_i8253_init'
isa-rtc.c:(.init.text+0x11dc): undefined reference to `i8253_clockevent'
arch/arm/mach-footbridge/built-in.o:(.data+0x18c): undefined reference
to `i8253_clockevent'

This is because the functions are guarded by a #ifdef
CONFIG_CLKEVT_I8253

KernelVersion: Linux-next 20110812
but this is also present in Linus' current tree since July 1st.
(since commit e6220bd "i8253: Create common clockevent implementation")

v2:
Added the option in the right alphabetical order.
I also adjusted the alphabetical order for ARCH_CATS so both are
similar

Signed-off-by: Peter Huewe <peterhuewe@gmx.de>
---
 arch/arm/mach-footbridge/Kconfig |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-footbridge/Kconfig b/arch/arm/mach-footbridge/Kconfig
index dc26fff..f643ef8 100644
--- a/arch/arm/mach-footbridge/Kconfig
+++ b/arch/arm/mach-footbridge/Kconfig
@@ -4,8 +4,8 @@ menu "Footbridge Implementations"
 
 config ARCH_CATS
 	bool "CATS"
-	select CLKSRC_I8253
 	select CLKEVT_I8253
+	select CLKSRC_I8253
 	select FOOTBRIDGE_HOST
 	select ISA
 	select ISA_DMA
@@ -61,6 +61,7 @@ config ARCH_EBSA285_HOST
 
 config ARCH_NETWINDER
 	bool "NetWinder"
+	select CLKEVT_I8253
 	select CLKSRC_I8253
 	select FOOTBRIDGE_HOST
 	select ISA
-- 
1.7.3.4
