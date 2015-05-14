From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 14 May 2015 17:30:27 +0100
Subject: [PATCH v2] ARM: l2c: add options to overwrite prefetching behavior
In-Reply-To: <20150514161526.GB2067@n2100.arm.linux.org.uk>
References: <1431620035-7183-1-git-send-email-hauke@hauke-m.de>
 <20150514161526.GB2067@n2100.arm.linux.org.uk>
Message-ID: <20150514163027.GC2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 14, 2015 at 05:15:26PM +0100, Russell King - ARM Linux wrote:
> On Thu, May 14, 2015 at 06:13:55PM +0200, Hauke Mehrtens wrote:
> > These options make it possible to overwrites the data and instruction
> > prefetching behavior of the arm pl310 cache controller.
> > 
> > We have to set these values in the aux and the prefetch register,
> > because these two bits in the aux registers are mapped to the prefetch
> > register. If only the prefetch register is changed there is an
> > inconsistence in the state in this driver.
> 
> No there isn't.  Just set the bits in the prefetch register.
> 
> Writing to the prefetch register changes the state of the bits in the
> auxiliary control register at the same time.

I see what you're getting at now.  I think we ought to fix that in the
driver, so that the auxiliary control register is always written first,
before the prefetch control register.  This also makes l2c_configure()
reflect the structure of the rest of the driver.

 arch/arm/mm/cache-l2x0.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index e309c8f35af5..46427d1a5946 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -110,14 +110,6 @@ static inline void l2c_unlock(void __iomem *base, unsigned num)
 
 static void l2c_configure(void __iomem *base)
 {
-	if (outer_cache.configure) {
-		outer_cache.configure(&l2x0_saved_regs);
-		return;
-	}
-
-	if (l2x0_data->configure)
-		l2x0_data->configure(base);
-
 	l2c_write_sec(l2x0_saved_regs.aux_ctrl, base, L2X0_AUX_CTRL);
 }
 
@@ -134,7 +126,11 @@ static void l2c_enable(void __iomem *base, u32 aux, unsigned num_lock)
 		return;
 
 	l2x0_saved_regs.aux_ctrl = aux;
-	l2c_configure(base);
+
+	if (outer_cache.configure)
+		outer_cache.configure(&l2x0_saved_regs);
+	else
+		l2x0_data->configure(base);
 
 	l2c_unlock(base, num_lock);
 
@@ -252,6 +248,7 @@ static const struct l2c_init_data l2c210_data __initconst = {
 	.num_lock = 1,
 	.enable = l2c_enable,
 	.save = l2c_save,
+	.configure = l2c_configure,
 	.outer_cache = {
 		.inv_range = l2c210_inv_range,
 		.clean_range = l2c210_clean_range,
@@ -409,6 +406,7 @@ static const struct l2c_init_data l2c220_data = {
 	.num_lock = 1,
 	.enable = l2c220_enable,
 	.save = l2c_save,
+	.configure = l2c_configure,
 	.outer_cache = {
 		.inv_range = l2c220_inv_range,
 		.clean_range = l2c220_clean_range,
@@ -569,6 +567,8 @@ static void l2c310_configure(void __iomem *base)
 {
 	unsigned revision;
 
+	l2c_configure(base);
+
 	/* restore pl310 setup */
 	l2c_write_sec(l2x0_saved_regs.tag_latency, base,
 		      L310_TAG_LATENCY_CTRL);
@@ -1066,6 +1066,7 @@ static const struct l2c_init_data of_l2c210_data __initconst = {
 	.of_parse = l2x0_of_parse,
 	.enable = l2c_enable,
 	.save = l2c_save,
+	.configure = l2c_configure,
 	.outer_cache = {
 		.inv_range   = l2c210_inv_range,
 		.clean_range = l2c210_clean_range,
@@ -1084,6 +1085,7 @@ static const struct l2c_init_data of_l2c220_data __initconst = {
 	.of_parse = l2x0_of_parse,
 	.enable = l2c220_enable,
 	.save = l2c_save,
+	.configure = l2c_configure,
 	.outer_cache = {
 		.inv_range   = l2c220_inv_range,
 		.clean_range = l2c220_clean_range,
@@ -1416,6 +1418,7 @@ static const struct l2c_init_data of_aurora_with_outer_data __initconst = {
 	.enable = l2c_enable,
 	.fixup = aurora_fixup,
 	.save  = aurora_save,
+	.configure = l2c_configure,
 	.outer_cache = {
 		.inv_range   = aurora_inv_range,
 		.clean_range = aurora_clean_range,
@@ -1435,6 +1438,7 @@ static const struct l2c_init_data of_aurora_no_outer_data __initconst = {
 	.enable = aurora_enable_no_outer,
 	.fixup = aurora_fixup,
 	.save  = aurora_save,
+	.configure = l2c_configure,
 	.outer_cache = {
 		.resume      = l2c_resume,
 	},
@@ -1608,6 +1612,7 @@ static void __init tauros3_save(void __iomem *base)
 
 static void tauros3_configure(void __iomem *base)
 {
+	l2c_configure(base);
 	writel_relaxed(l2x0_saved_regs.aux2_ctrl,
 		       base + TAUROS3_AUX2_CTRL);
 	writel_relaxed(l2x0_saved_regs.prefetch_ctrl,

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
