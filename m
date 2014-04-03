From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 3 Apr 2014 19:52:16 +0100
Subject: [PATCH 73/75] ARM: l2c: move L2 cache register saving to a
 more sensible location
In-Reply-To: <533C633C.9070100@wwwdotorg.org>
References: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
 <E1WTYaF-0007Hv-Nv@rmk-PC.arm.linux.org.uk> <533B0BC1.6080608@wwwdotorg.org>
 <533B0D6D.1080803@wwwdotorg.org>
 <20140401230924.GE7528@n2100.arm.linux.org.uk>
 <533C633C.9070100@wwwdotorg.org>
Message-ID: <20140403185216.GS7528@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 02, 2014 at 01:21:32PM -0600, Stephen Warren wrote:
> On 04/01/2014 05:09 PM, Russell King - ARM Linux wrote:
> > On Tue, Apr 01, 2014 at 01:03:09PM -0600, Stephen Warren wrote:
> >> On 04/01/2014 12:56 PM, Stephen Warren wrote:
> >>> On 03/28/2014 09:20 AM, Russell King wrote:
> >>>> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> >>>
> >>> EXCEPT this one patch, the series,
> >>> Tested-by: Stephen Warren <swarren@nvidia.com>
> >>> (on Tegra20/Toshiba AC100 and Tegra30/Beaver)
> >>>
> >>> And any part which touches Tegra code,
> >>> Acked-by: Stephen Warren <swarren@nvidia.com>
> >>>
> >>> However, this one patch causes boot failures on the Toshiba AC100,
> >>> Springbank/Seaboard, and I would assume any Tegra20 system. I haven't
> >>> investigated what the problem is; do you need me to and/or have any clues?
> >>
> >> Ah, disabling CONFIG_CPU_IDLE "fixes" this.
> > 
> > Still brings up the question of what's going on here.  Another thing
> > could be that enabling BRESP is causing you problems.  You could
> > try disabling that code too, though why that would happen only with
> > CPU IDLE I'm not sure.
> 
> The problem also affects suspend/resume. Disabling CPU_IDLE simply
> removes one case where the CPUs gets power-cycled, but doesn't solve the
> suspend/resume issue.
> 
> Anyway, this patch removes the following code:
> 
> 	/* Save the value for resuming. */
> 	l2x0_saved_regs.aux_ctrl = aux;
> 
> Was that intentional? Perhaps the call to data->save() should do this now?

Good catch.

It should... this is a nice illustration why I consider the existing code
to be unmaintainable - some "save" implementations save the aux control
register themselves, others do not.

Yes, making everyone save it is the most logical solution, because then
we have a hook which does what it says it does, rather than having that
functionality spread across several separate functions.

This is my preferred solution (patch on top of this series.)  Will be
merged into the series shortly.  Thanks for finding this.

 arch/arm/mm/cache-l2x0.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index f718032cf9a0..e2f1ad674647 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -250,6 +250,11 @@ static void l2x0_disable(void)
 	raw_spin_unlock_irqrestore(&l2x0_lock, flags);
 }
 
+static void l2c_save(void __iomem *base)
+{
+	l2x0_saved_regs.aux_ctrl = readl_relaxed(l2x0_base + L2X0_AUX_CTRL);
+}
+
 /*
  * L2C-210 specific code.
  *
@@ -357,6 +362,7 @@ static const struct l2c_init_data l2c210_data __initconst = {
 	.way_size_0 = SZ_8K,
 	.num_lock = 1,
 	.enable = l2c_enable,
+	.save = l2c_save,
 	.outer_cache = {
 		.inv_range = l2c210_inv_range,
 		.clean_range = l2c210_clean_range,
@@ -501,6 +507,7 @@ static const struct l2c_init_data l2c220_data = {
 	.way_size_0 = SZ_8K,
 	.num_lock = 1,
 	.enable = l2c_enable,
+	.save = l2c_save,
 	.outer_cache = {
 		.inv_range = l2c220_inv_range,
 		.clean_range = l2c220_clean_range,
@@ -638,6 +645,8 @@ static void __init l2c310_save(void __iomem *base)
 {
 	unsigned revision;
 
+	l2c_save(base);
+
 	l2x0_saved_regs.tag_latency = readl_relaxed(base +
 		L310_TAG_LATENCY_CTRL);
 	l2x0_saved_regs.data_latency = readl_relaxed(base +
@@ -1010,6 +1019,7 @@ static const struct l2c_init_data of_l2c210_data __initconst = {
 	.num_lock = 1,
 	.of_parse = l2x0_of_parse,
 	.enable = l2c_enable,
+	.save = l2c_save,
 	.outer_cache = {
 		.inv_range   = l2c210_inv_range,
 		.clean_range = l2c210_clean_range,
@@ -1027,6 +1037,7 @@ static const struct l2c_init_data of_l2c220_data __initconst = {
 	.num_lock = 1,
 	.of_parse = l2x0_of_parse,
 	.enable = l2c_enable,
+	.save = l2c_save,
 	.outer_cache = {
 		.inv_range   = l2c220_inv_range,
 		.clean_range = l2c220_clean_range,
@@ -1440,6 +1451,8 @@ static const struct l2c_init_data of_bcm_l2x0_data __initconst = {
 
 static void __init tauros3_save(void __iomem *base)
 {
+	l2c_save(base);
+
 	l2x0_saved_regs.aux2_ctrl =
 		readl_relaxed(base + TAUROS3_AUX2_CTRL);
 	l2x0_saved_regs.prefetch_ctrl =


-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
