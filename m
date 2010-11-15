From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 15 Nov 2010 17:40:27 +0000
Subject: [PATCH v3 18/20] ARM: LPAE: use phys_addr_t for physical start
	address in early_mem
In-Reply-To: <1289842829-3027-1-git-send-email-catalin.marinas@arm.com>
References: <1289842829-3027-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <1289842829-3027-19-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Will Deacon <will.deacon@arm.com>

The physical start address of memory may be > 4GB and therefore
unrepresentable using an unsigned long.

This patch changes early_mem and arm_add_memory to use phys_addr_t
instead of unsigned long for the start address.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/kernel/setup.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 81ab007..eaa87d4 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -442,7 +442,7 @@ static struct machine_desc * __init setup_machine(unsigned int nr)
 	return list;
 }
 
-static int __init arm_add_memory(unsigned long start, unsigned long size)
+static int __init arm_add_memory(phys_addr_t start, unsigned long size)
 {
 	struct membank *bank = &meminfo.bank[meminfo.nr_banks];
 
@@ -478,7 +478,8 @@ static int __init arm_add_memory(unsigned long start, unsigned long size)
 static int __init early_mem(char *p)
 {
 	static int usermem __initdata = 0;
-	unsigned long size, start;
+	unsigned long size;
+	phys_addr_t start;
 	char *endp;
 
 	/*
