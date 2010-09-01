From: robert.richter@amd.com (Robert Richter)
Date: Wed, 1 Sep 2010 14:50:50 +0200
Subject: [PATCH] oprofile, x86: fix init_sysfs() function stub
Message-ID: <mailman.216.1283347789.27306.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The use of the return value of init_sysfs() with commit

 10f0412 oprofile, x86: fix init_sysfs error handling

discovered the following build error for !CONFIG_PM:

 .../linux/arch/x86/oprofile/nmi_int.c: In function =E2=80=98op_nmi_init=E2=
=80=99:
 .../linux/arch/x86/oprofile/nmi_int.c:784: error: expected expression be=
fore =E2=80=98do=E2=80=99
 make[2]: *** [arch/x86/oprofile/nmi_int.o] Error 1
 make[1]: *** [arch/x86/oprofile] Error 2

This patch fixes this.

Reported-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Robert Richter <robert.richter@amd.com>
---
 arch/x86/oprofile/nmi_int.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/oprofile/nmi_int.c b/arch/x86/oprofile/nmi_int.c
index 73a41d3..cfe4faa 100644
--- a/arch/x86/oprofile/nmi_int.c
+++ b/arch/x86/oprofile/nmi_int.c
@@ -585,8 +585,10 @@ static void exit_sysfs(void)
 }
=20
 #else
-#define init_sysfs() do { } while (0)
-#define exit_sysfs() do { } while (0)
+
+static inline int  init_sysfs(void) { return 0; }
+static inline void exit_sysfs(void) { }
+
 #endif /* CONFIG_PM */
=20
 static int __init p4_init(char **cpu_type)
--=20
1.7.1.1


--=20
Advanced Micro Devices, Inc.
Operating System Research Center
