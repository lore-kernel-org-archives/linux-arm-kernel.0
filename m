From: viresh.kumar@st.com (Viresh KUMAR)
Date: Fri,  1 Oct 2010 17:26:03 +0530
Subject: [PATCH V2 43/69] GIC: Added dummy handlers for Power Management
	Suspend Resume
In-Reply-To: <cover.1285933331.git.viresh.kumar@st.com>
References: <cover.1285933331.git.viresh.kumar@st.com>
Message-ID: <fa5bfc17c18f3849a7835d8b952380f17455d71d.1285933332.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Deepak Sikri <deepak.sikri@st.com>

enable_irq_wake() has a callback for interrupt controllers.
But since gic handler did not had this call back associated, it was always
returning -ENXIO, which was breaking the existing drivers. This patch
adds dummy handlers in gic in order to avoid breaking of existing drivers.

Signed-off-by: Deepak Sikri <deepak.sikri@st.com>
Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/common/gic.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
index 7dfa9a8..e816ef1 100644
--- a/arch/arm/common/gic.c
+++ b/arch/arm/common/gic.c
@@ -201,6 +201,18 @@ static void gic_handle_cascade_irq(unsigned int irq, struct irq_desc *desc)
 	chip->unmask(irq);
 }
 
+#ifdef CONFIG_PM
+
+static int gic_set_wake(unsigned int irq, unsigned int on)
+{
+	return 0;
+}
+
+#else
+
+#define gic_set_wake NULL
+#endif
+
 static struct irq_chip gic_chip = {
 	.name		= "GIC",
 	.ack		= gic_ack_irq,
@@ -210,6 +222,7 @@ static struct irq_chip gic_chip = {
 #ifdef CONFIG_SMP
 	.set_affinity	= gic_set_cpu,
 #endif
+	.set_wake	= gic_set_wake,
 };
 
 void __init gic_cascade_irq(unsigned int gic_nr, unsigned int irq)
-- 
1.7.2.2
