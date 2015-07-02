From: mark.rutland@arm.com (Mark Rutland)
Date: Thu,  2 Jul 2015 18:12:33 +0100
Subject: [PATCHv4 1/5] ARM: psci: boot_secondary: replace __pa with
 virt_to_idmap
In-Reply-To: <1435857157-24952-1-git-send-email-mark.rutland@arm.com>
References: <1435857157-24952-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1435857157-24952-2-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Grygorii Strashko <grygorii.strashko@ti.com>

On some PAE systems (e.g. TI Keystone), memory is above the 32-bit
addressable limit, and the interconnect provides an aliased view of
parts of physical memory in the 32-bit addressable space. This alias
is strictly for boot time usage, and is not otherwise usable because
of coherency limitations.

In this case, virt_to_phys(secondary_startup) would return the
physical address of the secondary CPU boot entry point, but on such
systems, this would be above the 4GB limit.

A separate function, virt_to_idmap(), has been provided to return a
usable physical address for functions in the identity mapping, and
this must be used in preference to virt_to_phys() or __pa() to find
the physical entry point for functions in the identity mapping range.

For other systems, virt_to_idmap() and virt_to_phys() return identical
physical addresses.

Cc: Russell King <linux@arm.linux.org.uk>
Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
Acked-by: Nicolas Pitre <nico@linaro.org>
Tested-by Vitaly Andrianov <vitalya@ti.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
[Mark: apply rmk's suggested rewording]
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm/kernel/psci_smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/psci_smp.c b/arch/arm/kernel/psci_smp.c
index 28a1db4..244aadd 100644
--- a/arch/arm/kernel/psci_smp.c
+++ b/arch/arm/kernel/psci_smp.c
@@ -51,7 +51,7 @@ static int psci_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
 	if (psci_ops.cpu_on)
 		return psci_ops.cpu_on(cpu_logical_map(cpu),
-				       __pa(secondary_startup));
+					virt_to_idmap(&secondary_startup));
 	return -ENODEV;
 }
 
-- 
1.9.1
