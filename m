From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 18 Feb 2016 15:01:54 +0100
Subject: [PATCH 2/9] ARM: change NR_IPIS to 8
In-Reply-To: <1455804123-2526139-1-git-send-email-arnd@arndb.de>
References: <1455804123-2526139-1-git-send-email-arnd@arndb.de>
Message-ID: <1455804123-2526139-3-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When function tracing for IPIs is enabled, we get a warning for an
overflow of the ipi_types array with the IPI_CPU_BACKTRACE type
as triggered by raise_nmi():

arch/arm/kernel/smp.c: In function 'raise_nmi':
arch/arm/kernel/smp.c:489:2: error: array subscript is above array bounds [-Werror=array-bounds]
  trace_ipi_raise(target, ipi_types[ipinr]);

This is a correct warning as we actually overflow the array here.
To make the tracing work correctly, this extends the array by one
entry and increases NR_IPI accordingly.

This only works after patch e7273ff49acf ("ARM: 8488/1: Make
IPI_CPU_BACKTRACE a "non-secure" SGI"), which changed the number
assignment from '15' to '8'. If we decide to backport this patch
to stable kernels, we probably need to backport e7273ff49acf
as well.

As far as I can tell, the problem has existed since the tracepoints
were originally added, but it only triggered a gcc warning with the
later change to NR_IPIS.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: e7273ff49acf ("ARM: 8488/1: Make IPI_CPU_BACKTRACE a "non-secure" SGI")
Fixes: 365ec7b17327 ("ARM: add IPI tracepoints") # v3.17
---
 arch/arm/include/asm/hardirq.h | 2 +-
 arch/arm/kernel/smp.c          | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/hardirq.h b/arch/arm/include/asm/hardirq.h
index 3d7351c844aa..fe3ea776dc34 100644
--- a/arch/arm/include/asm/hardirq.h
+++ b/arch/arm/include/asm/hardirq.h
@@ -5,7 +5,7 @@
 #include <linux/threads.h>
 #include <asm/irq.h>
 
-#define NR_IPI	7
+#define NR_IPI	8
 
 typedef struct {
 	unsigned int __softirq_pending;
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index b4048e370730..d021566d71c2 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -482,6 +482,7 @@ static const char *ipi_types[NR_IPI] __tracepoint_string = {
 	S(IPI_CPU_STOP, "CPU stop interrupts"),
 	S(IPI_IRQ_WORK, "IRQ work interrupts"),
 	S(IPI_COMPLETION, "completion interrupts"),
+	S(IPI_CPU_BACKTRACE, "CPU backtrace"),
 };
 
 static void smp_cross_call(const struct cpumask *target, unsigned int ipinr)
-- 
2.7.0
