From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 19 Jan 2012 15:34:47 +0000
Subject: [PATCH 07/11] ARM: fix a section mismatch warning with our use of
 memblock
In-Reply-To: <20120119153149.GB1068@n2100.arm.linux.org.uk>
References: <20120119153149.GB1068@n2100.arm.linux.org.uk>
Message-ID: <E1Rnu0l-0002pj-70@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 716a3dc2008 (ARM: Add arm_memblock_steal() to allocate memory
away from the kernel) added a function which calls memblock_alloc().
This causes a section conflict:

WARNING: vmlinux.o(.text+0xc614): Section mismatch in reference from the function arm_memblock_steal() to the function .init.text:memblock_alloc()
The function arm_memblock_steal() references
the function __init memblock_alloc().

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/init.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 6ec1226..5dc7d12 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -310,7 +310,7 @@ static void arm_memory_present(void)
 
 static bool arm_memblock_steal_permitted = true;
 
-phys_addr_t arm_memblock_steal(phys_addr_t size, phys_addr_t align)
+phys_addr_t __init arm_memblock_steal(phys_addr_t size, phys_addr_t align)
 {
 	phys_addr_t phys;
 
-- 
1.7.4.4
