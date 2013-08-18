From: msalter@redhat.com (Mark Salter)
Date: Sun, 18 Aug 2013 12:22:50 -0400
Subject: [PATCH] arm64: add screen_info for console support
Message-ID: <1376842970.11104.11.camel@t520.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The arm64 port doesn't provide a screen_info struct for console support
which leads to a build failure with some configurations:

  drivers/video/console/vgacon.c:820: undefined reference to `screen_info'

This patch adds an empty declaration of screen_info to fix the build
problem. Some additional runtime code is needed to actually make it
useful.

Signed-off-by: Mark Salter <msalter@redhat.com>
---
 arch/arm64/kernel/setup.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index add6ea6..eb9f93a 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -64,6 +64,10 @@ static const char *cpu_name;
 static const char *machine_name;
 phys_addr_t __fdt_pointer __initdata;
 
+#if defined(CONFIG_VGA_CONSOLE) || defined(CONFIG_DUMMY_CONSOLE)                                               
+struct screen_info screen_info;                                                                                
+#endif                                                                                                         
+
 /*
  * Standard memory resources
  */
-- 
1.8.1.4
