From: hsweeten@visionengravers.com (H Hartley Sweeten)
Date: Tue, 21 Feb 2017 11:15:26 -0700
Subject: [PATCH 1/4] ARM: ep93xx: switch to SPARSEMEM
In-Reply-To: <20170221181529.6780-1-hsweeten@visionengravers.com>
References: <20170221181529.6780-1-hsweeten@visionengravers.com>
Message-ID: <20170221181529.6780-2-hsweeten@visionengravers.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The EP93xx has four chip selects that can be used for the SDRAM memory.
These chip selects are decoded to specify an address domain:

  SDCS3  0x00000000-0x0fffffff with Boot Option ASDO=1
  SDCS0  0xc0000000-0xcfffffff
  SDCS1  0xd0000000-0xdfffffff
  SDCS2  0xe0000000-x0efffffff
  SDCS3  0xf0000000-0xffffffff with Boot Option ASDO=0

Because of the row/column/bank architecture of SDRAM, the mapping of
these memories into the processor's memory space is discontiguous.

Most ep93xx systems only use one of the chip selects. For these systems,
ARCH_HAS_HOLES_MEMORYMODEL has worked fine to handle the discontiguous
memory.

But, some of the TS-72xx boards use multiple chip selects. The TS-7300 in
particular uses SDCS3 (with ASDO=1) and SDCS2. On that system with
ARCH_HAS_HOLES_MEMORYMODEL the SDCS2 memory does not get handled correctly
and results in the system not booting.

Change the EP93xx to ARCH_SPARSEMEM_ENABLE. This handles the discontiguous
memory for all configurations.

This has been tested on the following ep93xx platforms:

EDB9307A with 64 MiB on SDCS0
Vision EP9307 with 64 MiB on SDCS0
TS-7300 with 64 MiB on SDCS3 (with ASDO=1) and 64 MiB on SDCS2
sim.one with 64 MiB on SDCS0

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Tested-by: Linus Walleij <linus.walleij@linaro.org>
Cc: Russell King <linux@armlinux.org.uk>
---
 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 71cea9e..cc8a88f 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -383,7 +383,7 @@ config ARCH_EBSA110
 
 config ARCH_EP93XX
 	bool "EP93xx-based"
-	select ARCH_HAS_HOLES_MEMORYMODEL
+	select ARCH_SPARSEMEM_ENABLE
 	select ARM_AMBA
 	select ARM_PATCH_PHYS_VIRT
 	select ARM_VIC
-- 
2.10.0
