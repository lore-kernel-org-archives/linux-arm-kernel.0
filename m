From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Fri, 13 May 2016 11:49:07 +0100
Subject: [PATCH 3/3] ARM: get rid of horrible *(unsigned int *)(regs + 1)
In-Reply-To: <20160513104802.GU19428@n2100.arm.linux.org.uk>
References: <20160513104802.GU19428@n2100.arm.linux.org.uk>
Message-ID: <E1b1AeZ-0005DQ-9o@rmk-PC.arm.linux.org.uk>
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
index 4adfb46e3ee9..05a5e44721a0 100644
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
