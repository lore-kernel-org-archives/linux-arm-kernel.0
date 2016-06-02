From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Thu, 02 Jun 2016 15:09:45 +0100
Subject: [PATCH 3/3] ARM: get rid of horrible *(unsigned int *)(regs + 1)
Message-ID: <E1b8TJh-0007zy-C7@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Get rid of the horrible "*(unsigned int *)(regs + 1)" to get at the
parent context domain access register value, instead using the newly
introduced svc_pt_regs structure.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/include/asm/ptrace.h | 2 ++
 arch/arm/kernel/process.c     | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/ptrace.h b/arch/arm/include/asm/ptrace.h
index 5194cf79c90f..0ef0093800f2 100644
--- a/arch/arm/include/asm/ptrace.h
+++ b/arch/arm/include/asm/ptrace.h
@@ -25,6 +25,8 @@ struct svc_pt_regs {
 	u32 unused;
 };
 
+#define to_svc_pt_regs(r) container_of(r, struct svc_pt_regs, regs)
+
 #define user_mode(regs)	\
 	(((regs)->ARM_cpsr & 0xf) == 0)
 
diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 4a803c5a1ff7..f1c720c0d568 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -106,7 +106,7 @@ void __show_regs(struct pt_regs *regs)
 	if (user_mode(regs))
 		domain = DACR_UACCESS_ENABLE;
 	else
-		domain = *(unsigned int *)(regs + 1);
+		domain = to_svc_pt_regs(regs)->dacr;
 #else
 	domain = get_domain();
 #endif
-- 
2.1.0
