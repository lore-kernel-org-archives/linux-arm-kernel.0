From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 28 Apr 2016 10:28:09 +0100
Subject: [PATCH 05/12] ARM: kdump: advertise boot aliased crash kernel resource
In-Reply-To: <20160428092644.GX19428@n2100.arm.linux.org.uk>
References: <20160428092644.GX19428@n2100.arm.linux.org.uk>
Message-ID: <E1aviEz-0000j7-Gk@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Advertise a resource which describes where the crash kernel is located
in the boot view of RAM.  This allows kexec-tools to have this vital
information.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/setup.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index d9317eec1eba..19b25ad61385 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -1003,9 +1003,25 @@ static void __init reserve_crashkernel(void)
 		(unsigned long)(crash_base >> 20),
 		(unsigned long)(total_mem >> 20));
 
+	/* The crashk resource must always be located in normal mem */
 	crashk_res.start = crash_base;
 	crashk_res.end = crash_base + crash_size - 1;
 	insert_resource(&iomem_resource, &crashk_res);
+
+	if (arm_has_idmap_alias()) {
+		/*
+		 * If we have a special RAM alias for use at boot, we
+		 * need to advertise to kexec tools where the alias is.
+		 */
+		static struct resource crashk_boot_res = {
+			.name = "Crash kernel (boot alias)",
+			.flags = IORESOURCE_BUSY | IORESOURCE_MEM,
+		};
+
+		crashk_boot_res.start = phys_to_idmap(crash_base);
+		crashk_boot_res.end = crashk_boot_res.start + crash_size - 1;
+		insert_resource(&iomem_resource, &crashk_boot_res);
+	}
 }
 #else
 static inline void reserve_crashkernel(void) {}
-- 
2.1.0
