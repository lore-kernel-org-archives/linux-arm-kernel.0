From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 31 May 2013 19:42:07 -0300
Subject: [PATCH v2 2/2] ARM: mxs: Pass the system revision
In-Reply-To: <1370040127-15072-1-git-send-email-festevam@gmail.com>
References: <1370040127-15072-1-git-send-email-festevam@gmail.com>
Message-ID: <1370040127-15072-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Some mxs userspace tools, such as multimedia plugins and kobs-ng (tool used to 
burn boot images to NAND) rely on the 'Revision' field reported by 
'/proc/cpuinfo'.

Provide a mechanism to pass such information, so that now we can get:

$ cat /proc/cpuinfo                                             
processor       : 0                                                             
model name      : ARM926EJ-S rev 5 (v5l)                                        
BogoMIPS        : 226.09                                                        
Features        : swp half fastmult edsp java                                   
CPU implementer : 0x41                                                          
CPU architecture: 5TEJ                                                          
CPU variant     : 0x0                                                           
CPU part        : 0x926                                                         
CPU revision    : 5                                                             
                                                                                
Hardware        : Freescale i.MX28 Evaluation Kit                               
Revision        : 28012                                                         
Serial          : 0000000000000000 

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com> 
---
Changes since v1:
- No changes

 arch/arm/mach-mxs/mach-mxs.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
index 462fa14..0d7e1eb 100644
--- a/arch/arm/mach-mxs/mach-mxs.c
+++ b/arch/arm/mach-mxs/mach-mxs.c
@@ -29,6 +29,7 @@
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
 #include <asm/system_misc.h>
+#include <asm/system_info.h>
 
 #include "pm.h"
 
@@ -442,12 +443,26 @@ static void mxs_print_silicon_rev(const char *cpu, int srev)
 				cpu, (srev >> 4) & 0xf, srev & 0xf);
 }
 
+static void mxs_pass_sysrev(void)
+{
+	int cputype = 0;
+
+	if (strcmp(mxs_get_cpu_type(), "MX23"))
+		cputype = 0x23000;
+
+	if (strcmp(mxs_get_cpu_type(), "MX28"))
+		cputype = 0x28000;
+
+	system_rev = (cputype | mxs_get_cpu_rev());
+}
+
 static void __init mxs_machine_init(void)
 {
 	const char *cpu_char = mxs_get_cpu_type();
 	int cpu_rev = mxs_get_cpu_rev();
 
 	mxs_print_silicon_rev(cpu_char, cpu_rev);
+	mxs_pass_sysrev();
 
 	if (of_machine_is_compatible("fsl,imx28-evk"))
 		imx28_evk_init();
-- 
1.8.1.2
