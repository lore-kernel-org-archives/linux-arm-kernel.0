From: robherring2@gmail.com (Rob Herring)
Date: Mon,  1 Apr 2013 15:58:33 -0500
Subject: [PATCH v2 2/3] ARM: make sched_clock just call a function pointer
In-Reply-To: <1364849914-26420-1-git-send-email-robherring2@gmail.com>
References: <1364849914-26420-1-git-send-email-robherring2@gmail.com>
Message-ID: <1364849914-26420-3-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

This converts sched_clock to simply a call to a function pointer in order
to allow overriding it. This will allow for use with 64-bit counters where
overflow handling is not needed.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/include/asm/sched_clock.h |    2 ++
 arch/arm/kernel/sched_clock.c      |    9 ++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/sched_clock.h b/arch/arm/include/asm/sched_clock.h
index e3f7572..3d520dd 100644
--- a/arch/arm/include/asm/sched_clock.h
+++ b/arch/arm/include/asm/sched_clock.h
@@ -11,4 +11,6 @@
 extern void sched_clock_postinit(void);
 extern void setup_sched_clock(u32 (*read)(void), int bits, unsigned long rate);
 
+extern unsigned long long (*sched_clock_func)(void);
+
 #endif
diff --git a/arch/arm/kernel/sched_clock.c b/arch/arm/kernel/sched_clock.c
index 040168e..8805848 100644
--- a/arch/arm/kernel/sched_clock.c
+++ b/arch/arm/kernel/sched_clock.c
@@ -165,12 +165,19 @@ void __init setup_sched_clock(u32 (*read)(void), int bits, unsigned long rate)
 	pr_debug("Registered %pF as sched_clock source\n", read);
 }
 
-unsigned long long notrace sched_clock(void)
+static unsigned long long notrace sched_clock_32(void)
 {
 	u32 cyc = read_sched_clock();
 	return cyc_to_sched_clock(cyc, sched_clock_mask);
 }
 
+unsigned long long __read_mostly (*sched_clock_func)(void) = sched_clock_32;
+
+unsigned long long notrace sched_clock(void)
+{
+	return sched_clock_func();
+}
+
 void __init sched_clock_postinit(void)
 {
 	/*
-- 
1.7.10.4
