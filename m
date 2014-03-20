From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Thu, 20 Mar 2014 14:36:03 +1100
Subject: linux-next: manual merge of the tip tree with the arm-soc tree
Message-ID: <20140320143603.a2f82d77be61c09a7852cfe9@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the tip tree got a conflict in
arch/arm/mach-imx/pm-imx6q.c between commit 9cdde7217e92 ("ARM: imx6:
rename pm-imx6q.c to pm-imx6.c") from the arm-soc tree and commit
8435cf757632 ("arm: Replace various irq_desc accesses") from the tip tree.

I fixed it up (by applying the tip tree patch to the renamed file -
arch/arm/mach-imx/pm-imx6.c - see patch below) and can carry the fix as
necessary (no action is required).

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 20 Mar 2014 14:33:26 +1100
Subject: [PATCH] arm: Replace various irq_desc accesses fix for file move

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/arm/mach-imx/pm-imx6.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-imx/pm-imx6.c b/arch/arm/mach-imx/pm-imx6.c
index 16f0d249f6a7..9392a8f4ef24 100644
--- a/arch/arm/mach-imx/pm-imx6.c
+++ b/arch/arm/mach-imx/pm-imx6.c
@@ -241,7 +241,7 @@ static void imx6q_enable_wb(bool enable)
 
 int imx6q_set_lpm(enum mxc_cpu_pwr_mode mode)
 {
-	struct irq_desc *iomuxc_irq_desc;
+	struct irq_data *iomuxc_irq_data = irq_get_irq_data(32);
 	u32 val = readl_relaxed(ccm_base + CLPCR);
 
 	val &= ~BM_CLPCR_LPM;
@@ -288,10 +288,9 @@ int imx6q_set_lpm(enum mxc_cpu_pwr_mode mode)
 	 * 3) Software should mask IRQ #32 right after CCM Low-Power mode
 	 *    is set (set bits 0-1 of CCM_CLPCR).
 	 */
-	iomuxc_irq_desc = irq_to_desc(32);
-	imx_gpc_irq_unmask(&iomuxc_irq_desc->irq_data);
+	imx_gpc_irq_unmask(iomuxc_irq_data);
 	writel_relaxed(val, ccm_base + CLPCR);
-	imx_gpc_irq_mask(&iomuxc_irq_desc->irq_data);
+	imx_gpc_irq_mask(iomuxc_irq_data);
 
 	return 0;
 }
-- 
1.9.0

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140320/111e4ace/attachment-0001.sig>
