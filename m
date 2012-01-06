From: jamie@jamieiles.com (Jamie Iles)
Date: Fri,  6 Jan 2012 16:39:57 +0000
Subject: [PATCH] versatile: don't generate a duplicate IRQ domain
Message-ID: <1325867997-20761-1-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the VIC driver handles the irqdomain natively we don't need to
generate one in the versatile core code.  Longer term we should move the
initialisation of both IRQ controllers to using of_irq_init() but
that'll need a little more work.

Cc: Russell King <linux@arm.linux.org.uk>
Cc: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---

I don't have a versatile platform so I can't run-test this, but I
suspect that when booting with device tree without this patch it'll warn
with "error: irq_desc already assigned to a domain".

I don't think this can be converted to of_irq_init() straight away
without having all of the devices using IRQ's from DT and not relying on
static IRQ numbers and without the hardware to test it I don't have
enough confidence to do that.

 arch/arm/mach-versatile/core.c |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
index cbcda61..e716fa4 100644
--- a/arch/arm/mach-versatile/core.c
+++ b/arch/arm/mach-versatile/core.c
@@ -86,12 +86,6 @@ static struct fpga_irq_data sic_irq = {
 #define PIC_MASK	0
 #endif
 
-/* Lookup table for finding a DT node that represents the vic instance */
-static const struct of_device_id vic_of_match[] __initconst = {
-	{ .compatible = "arm,versatile-vic", },
-	{}
-};
-
 static const struct of_device_id sic_of_match[] __initconst = {
 	{ .compatible = "arm,versatile-sic", },
 	{}
@@ -100,7 +94,6 @@ static const struct of_device_id sic_of_match[] __initconst = {
 void __init versatile_init_irq(void)
 {
 	vic_init(VA_VIC_BASE, IRQ_VIC_START, ~0, 0);
-	irq_domain_generate_simple(vic_of_match, VERSATILE_VIC_BASE, IRQ_VIC_START);
 
 	writel(~0, VA_SIC_BASE + SIC_IRQ_ENABLE_CLEAR);
 
-- 
1.7.5.4
