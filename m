From: jamie@jamieiles.com (Jamie Iles)
Date: Mon,  1 Aug 2011 13:31:08 +0100
Subject: [PATCH 7/9] tegra: make __arch_ioremap() with 0 size return NULL
In-Reply-To: <1312201870-12921-1-git-send-email-jamie@jamieiles.com>
References: <1312201870-12921-1-git-send-email-jamie@jamieiles.com>
Message-ID: <1312201870-12921-7-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without __arch_ioremap(), __get_vm_area_node() with a zero size will
return a NULL pointer.  Make the arch specific ioremap() do the same
thing.

Cc: Colin Cross <ccross@android.com>
Cc: Erik Gilling <konkers@android.com>
Cc: Olof Johansson <olof@lixom.net>
Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 arch/arm/mach-tegra/io.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-tegra/io.c b/arch/arm/mach-tegra/io.c
index ea50fe2..4f8d68c 100644
--- a/arch/arm/mach-tegra/io.c
+++ b/arch/arm/mach-tegra/io.c
@@ -67,6 +67,10 @@ void __init tegra_map_common_io(void)
 void __iomem *tegra_ioremap(unsigned long p, size_t size, unsigned int type)
 {
 	void __iomem *v = IO_ADDRESS(p);
+
+	if (!size)
+		return NULL;
+
 	if (v == NULL)
 		v = __arm_ioremap(p, size, type);
 	return v;
-- 
1.7.4.1
