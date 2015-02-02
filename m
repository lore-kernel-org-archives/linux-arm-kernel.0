From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Mon,  2 Feb 2015 20:45:30 +0800
Subject: [PATCH v8 02/21] acpi: fix acpi_os_ioremap for arm64
In-Reply-To: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>
References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <1422881149-8177-3-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Salter <msalter@redhat.com>

The acpi_os_ioremap() function may be used to map normal RAM or IO
regions. The current implementation simply uses ioremap_cache(). This
will work for some architectures, but arm64 ioremap_cache() cannot be
used to map IO regions which don't support caching. So for arm64, use
ioremap() for non-RAM regions.

CC: Rafael J Wysocki <rjw@rjwysocki.net>
Signed-off-by: Mark Salter <msalter@redhat.com>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 include/acpi/acpi_io.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/acpi/acpi_io.h b/include/acpi/acpi_io.h
index 444671e..9d573db 100644
--- a/include/acpi/acpi_io.h
+++ b/include/acpi/acpi_io.h
@@ -1,11 +1,17 @@
 #ifndef _ACPI_IO_H_
 #define _ACPI_IO_H_
 
+#include <linux/mm.h>
 #include <linux/io.h>
 
 static inline void __iomem *acpi_os_ioremap(acpi_physical_address phys,
 					    acpi_size size)
 {
+#ifdef CONFIG_ARM64
+	if (!page_is_ram(phys >> PAGE_SHIFT))
+		return ioremap(phys, size);
+#endif
+
        return ioremap_cache(phys, size);
 }
 
-- 
1.9.1
