From: peterhuewe@gmx.de (Peter Huewe)
Date: Mon, 15 Aug 2011 17:31:20 +0200
Subject: [PATCH] arm: footbridge: Netwinder: Add KConfig select CLKEVT_I8253
	to fix build failure
Message-ID: <1313422280-21942-1-git-send-email-peterhuewe@gmx.de>
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

Signed-off-by: Peter Huewe <peterhuewe@gmx.de>
---
 arch/arm/mach-footbridge/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-footbridge/Kconfig b/arch/arm/mach-footbridge/Kconfig
index dc26fff..c8e7afc 100644
--- a/arch/arm/mach-footbridge/Kconfig
+++ b/arch/arm/mach-footbridge/Kconfig
@@ -62,6 +62,7 @@ config ARCH_EBSA285_HOST
 config ARCH_NETWINDER
 	bool "NetWinder"
 	select CLKSRC_I8253
+	select CLKEVT_I8253
 	select FOOTBRIDGE_HOST
 	select ISA
 	select ISA_DMA
-- 
1.7.3.4
