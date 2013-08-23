From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Fri, 23 Aug 2013 10:19:35 -0700
Subject: [RFC 17/17] clk: zynq: remove call to of_clk_init
In-Reply-To: <52172BAA.7020009@gmail.com>
References: <1376964271-22715-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1376964271-22715-18-git-send-email-sebastian.hesselbarth@gmail.com>
 <d17acba9-85f9-40cd-a176-2005e3e924f8@CO1EHSMHS002.ehs.local>
 <c4d10bdf-6506-4edc-92cc-2acc67b86602@VA3EHSMHS032.ehs.local>
 <52172BAA.7020009@gmail.com>
Message-ID: <bfd173dc-3be5-421c-b7f7-af181bfb7032@DB8EHSMHS026.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sebastian, Steffen,

On Fri, Aug 23, 2013 at 11:30:18AM +0200, Sebastian Hesselbarth wrote:
> On 08/23/13 02:59, S?ren Brinkmann wrote:
> >On Thu, Aug 22, 2013 at 05:26:47PM -0700, S?ren Brinkmann wrote:
> >>On Tue, Aug 20, 2013 at 04:04:31AM +0200, Sebastian Hesselbarth wrote:
> >>>With arch/arm calling of_clk_init(NULL) from time_init(), we can now
> >>>remove it from corresponding drivers/clk code.
> >>
> >>I think that would break Zynq.
> >>If I see this correctly you call of_clk_init() from common code,
> >>_before_ the SOC specific time init function is called.
> >>The problem is, that we have code setting up a global pointer which is
> >>required by zynq_clk_setup() which is triggered when of_clk_init() is
> >>called.
[ ... ]
> thanks for looking into this. I also had a look at the files in
> question. Based on Steffen's proposal, I prepared a diff that should do
> the trick. It moves zynq_slcr_init() to early_init, instead of reusing
> another hook that has magic cow powers (it calls irqchip_init that zynq
> also wants sooner or later).
> 
> Also, it removes zynq_clock_init() and let zynq_clk_setup() map the
> register itself by finding the node and use of_iomap(). I realized that
> clock registers are quite separated within slcr, so you can consider
> to have your own node for the clk-provider. As Steffen is proposing
> this but mentioned incompatible DT changes, I chose that intermediate
> step above.
> 
> It would be great, if you test the diff and prepare a patch out of
> it, that I pick-up in the patch set. That way, we also have your
> Signed-off on it.

I looked into this. Looks like init_early() happens to early. I suspect
slab is missing to make zynq_slcr_init() work. So, I moved it into
init_irq(). Is there any init_call() type which is called at the correct
time?

I looked briefly into syscon and regmap, and that does actually look
promising and to really fix this mess, I guess we have to wait a little
until Steffen finishes his work on it.

To facilitate Sebastian's series I came up with the patch below.
The problem I have is, I do not really want the clkc to map the
registers. They are in the SLCR and the SLCR driver is doing it, hence
we should work with what that driver provides - which ideally would be
based on regmap and syscon, but we're not there yet. Hence I somehow
need to pass the SLCR pointer to the clkc. To avoid accessing the global
pointer directly I kept the zynq_clock_init() routine which is called
from zynq_slcr_init().

That is the best I could come up with quickly and w/o investing a lot of
time to figure out the regmap and syscon stuff, which seems to be handled
by Steffen already, anyway.
It is essentially a stripped down version of Sebastian's proposal.

	S?ren

-----8<--------------------8<-------------------8<-------------------

>From bb7a02dad9cc578caf1e21a1b7f45ed602676bfa Mon Sep 17 00:00:00 2001
From: Soren Brinkmann <soren.brinkmann@xilinx.com>
Date: Fri, 23 Aug 2013 09:27:11 -0700
Subject: [PATCH RFC] arm: zynq: Don't call of_clk_init()

of_clk_init() has been moved to be called from common code, therefore
remove it from Zynq's clock init routine.
Since the Zynq's clock setup routine relies on an initialized SLCR,
zynq_slcr_init() is moved to init_irq() (note: it must be before
init_time() but after slab is available, hence init_early() does not
work).

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
 arch/arm/mach-zynq/common.c | 9 ++++-----
 drivers/clk/zynq/clkc.c     | 4 +++-
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
index 5f25256..f28046e 100644
--- a/arch/arm/mach-zynq/common.c
+++ b/arch/arm/mach-zynq/common.c
@@ -19,10 +19,9 @@
 #include <linux/cpumask.h>
 #include <linux/platform_device.h>
 #include <linux/clk.h>
-#include <linux/clk/zynq.h>
-#include <linux/clocksource.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
+#include <linux/irqchip.h>
 #include <linux/of_platform.h>
 #include <linux/of.h>
 
@@ -58,10 +57,10 @@ static void __init zynq_init_machine(void)
 	of_platform_bus_probe(NULL, zynq_of_bus_ids, NULL);
 }
 
-static void __init zynq_timer_init(void)
+static void __init zynq_init_irq(void)
 {
+	irqchip_init();
 	zynq_slcr_init();
-	clocksource_of_init();
 }
 
 static struct map_desc zynq_cortex_a9_scu_map __initdata = {
@@ -104,8 +103,8 @@ static const char * const zynq_dt_match[] = {
 DT_MACHINE_START(XILINX_EP107, "Xilinx Zynq Platform")
 	.smp		= smp_ops(zynq_smp_ops),
 	.map_io		= zynq_map_io,
+	.init_irq	= zynq_init_irq,
 	.init_machine	= zynq_init_machine,
-	.init_time	= zynq_timer_init,
 	.dt_compat	= zynq_dt_match,
 	.restart	= zynq_system_reset,
 MACHINE_END
diff --git a/drivers/clk/zynq/clkc.c b/drivers/clk/zynq/clkc.c
index 089d3e3..53b851e 100644
--- a/drivers/clk/zynq/clkc.c
+++ b/drivers/clk/zynq/clkc.c
@@ -206,6 +206,9 @@ static void __init zynq_clk_setup(struct device_node *np)
 
 	pr_info("Zynq clock init\n");
 
+	if (WARN_ON(!zynq_slcr_base_priv))
+		return;
+
 	/* get clock output names from DT */
 	for (i = 0; i < clk_max; i++) {
 		if (of_property_read_string_index(np, "clock-output-names",
@@ -532,5 +535,4 @@ CLK_OF_DECLARE(zynq_clkc, "xlnx,ps7-clkc", zynq_clk_setup);
 void __init zynq_clock_init(void __iomem *slcr_base)
 {
 	zynq_slcr_base_priv = slcr_base;
-	of_clk_init(NULL);
 }
-- 
1.8.3.4
