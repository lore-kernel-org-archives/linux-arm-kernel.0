From: viresh.kumar@st.com (Viresh KUMAR)
Date: Mon, 30 Aug 2010 16:09:09 +0530
Subject: [PATCH 45/74] SPEAr : SEV Send event to secondary CPUs
In-Reply-To: <cover.1283161023.git.viresh.kumar@st.com>
References: <cover.1283161023.git.viresh.kumar@st.com>
Message-ID: <861ddbfab51ade4893ef92df4bcfa9b203844a9c.1283161023.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vipin Kumar <vipin.kumar@st.com>

The secondary CPUs have been put in a WFE(Wait for Event) state. Using SEV
instruction sends an event to all CPUs.

Signed-off-by: Vipin Kumar <vipin.kumar@st.com>
Signed-off-by: shiraz hashim <shiraz.hashim@st.com>
Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/mach-spear13xx/include/mach/smp.h |    6 ++++++
 arch/arm/mach-spear13xx/platsmp.c          |    5 +++++
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-spear13xx/include/mach/smp.h b/arch/arm/mach-spear13xx/include/mach/smp.h
index 6e028a1..e2e55fc 100644
--- a/arch/arm/mach-spear13xx/include/mach/smp.h
+++ b/arch/arm/mach-spear13xx/include/mach/smp.h
@@ -24,6 +24,12 @@
 		cpunum &= 0x0F;				\
 	})
 
+/*
+ * set_event() is used to wake up secondary core from wfe using sev. Booting
+ * code puts the second core into wfe(standby).
+ */
+#define set_event()	__asm__ __volatile__ ("sev" : : : "memory")
+
 /* We use IRQ1 as the IPI */
 static inline void smp_cross_call(const struct cpumask *mask)
 {
diff --git a/arch/arm/mach-spear13xx/platsmp.c b/arch/arm/mach-spear13xx/platsmp.c
index 8b75d1b..73fbcdb 100644
--- a/arch/arm/mach-spear13xx/platsmp.c
+++ b/arch/arm/mach-spear13xx/platsmp.c
@@ -133,6 +133,11 @@ static void __init poke_milo(void)
 			__io_address(SPEAR13XX_SYS_LOCATION));
 
 	mb();
+
+	/*
+	 * Send a 'sev' to wake the secondary core from WFE.
+	 */
+	set_event();
 }
 
 /*
-- 
1.7.2.2
