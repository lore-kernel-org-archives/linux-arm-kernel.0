From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 10 Apr 2012 18:56:41 +0100
Subject: [PATCH 2/2] ARM: DT: do not add a zero-sized memory property
In-Reply-To: <1334080601-14339-1-git-send-email-marc.zyngier@arm.com>
References: <1334080601-14339-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1334080601-14339-2-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some bootloaders are broken enough to expose an ATAG_MEM with
a null size. Converting such tag to a memory node leads to
an unbootable system.

Skip over zero sized ATAG_MEM to avoid this situation.

Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/boot/compressed/atags_to_fdt.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/compressed/atags_to_fdt.c b/arch/arm/boot/compressed/atags_to_fdt.c
index 6ce11c4..797f04b 100644
--- a/arch/arm/boot/compressed/atags_to_fdt.c
+++ b/arch/arm/boot/compressed/atags_to_fdt.c
@@ -77,6 +77,8 @@ int atags_to_fdt(void *atag_list, void *fdt, int total_space)
 		} else if (atag->hdr.tag == ATAG_MEM) {
 			if (memcount >= sizeof(mem_reg_property)/4)
 				continue;
+			if (!atag->u.mem.size)
+				continue;
 			mem_reg_property[memcount++] = cpu_to_fdt32(atag->u.mem.start);
 			mem_reg_property[memcount++] = cpu_to_fdt32(atag->u.mem.size);
 		} else if (atag->hdr.tag == ATAG_INITRD2) {
-- 
1.7.7.1
