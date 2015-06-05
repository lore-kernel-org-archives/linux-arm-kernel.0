From: gregory.0xf0@gmail.com (Gregory Fong)
Date: Thu,  4 Jun 2015 18:58:38 -0700
Subject: [PATCH 3/3] ARM: Allow either FLATMEM or SPARSEMEM on the
 multiplatform build
In-Reply-To: <1433469518-8472-1-git-send-email-gregory.0xf0@gmail.com>
References: <1433469518-8472-1-git-send-email-gregory.0xf0@gmail.com>
Message-ID: <1433469518-8472-4-git-send-email-gregory.0xf0@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARMv7 chips with LPAE can often benefit from SPARSEMEM, as portions of
system memory can be located deep in the 36-bit address space.  Allow
FLATMEM or SPARSEMEM to be selectable at compile time; FLATMEM remains
the default.

This is based on Kevin's "[PATCH 3/3] ARM: Allow either FLATMEM or
SPARSEMEM on the multi-v7 build" from [1] and shamelessly rips off his
commit message text above.  As Arnd pointed out at [2] there doesn't
seem to be any reason to tie this specifically to ARMv7, so this has
been changed to apply to all multiplatform kernels.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-September/286837.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-October/298950.html

Cc: Kevin Cernekee <cernekee@gmail.com>
Signed-off-by: Gregory Fong <gregory.0xf0@gmail.com>
---
I don't have any platforms other than armv7 handily set up to test SPARSEMEM,
so any testing would be appreciated.  FLATMEM is still the default so at least
nobody will see anything change unless they deliberately switch.

 arch/arm/Kconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 5998b53..21e25bd 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -317,6 +317,8 @@ choice
 config ARCH_MULTIPLATFORM
 	bool "Allow multiple platforms to be selected"
 	depends on MMU
+	select ARCH_FLATMEM_ENABLE
+	select ARCH_SPARSEMEM_ENABLE
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_HAS_SG_CHAIN
 	select ARM_PATCH_PHYS_VIRT
@@ -1625,6 +1627,9 @@ config OABI_COMPAT
 config ARCH_HAS_HOLES_MEMORYMODEL
 	bool
 
+config ARCH_FLATMEM_ENABLE
+	bool
+
 config ARCH_SPARSEMEM_ENABLE
 	bool
 
-- 
1.9.1
