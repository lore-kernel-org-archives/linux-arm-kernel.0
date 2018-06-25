From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 25 Jun 2018 16:06:22 +0200
Subject: [PATCH 11/15] soc: renesas: rcar-sysc: Provide helpers to power
 up/down CPUs
In-Reply-To: <cover.1529934908.git.horms+renesas@verge.net.au>
References: <cover.1529934908.git.horms+renesas@verge.net.au>
Message-ID: <f2b1d2f94af887c91bb8a0cfb495e546331bc5ed.1529934908.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Provide helpers to control CPU power areas from platform code, taking
just a CPU index.  This will avoid having to pass full CPU power area
parameter blocks, and thus duplicating information already provided by
SoC-specific SYSC drivers.

This will be used on R-Car H1 only.
Later R-Car generations rely on APMU/RST for CPU power area control.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/soc/renesas/rcar-sysc.c       | 40 +++++++++++++++++++++++++++++++++++
 include/linux/soc/renesas/rcar-sysc.h |  2 ++
 2 files changed, 42 insertions(+)

diff --git a/drivers/soc/renesas/rcar-sysc.c b/drivers/soc/renesas/rcar-sysc.c
index 95120acc4d80..4ad6dcd19420 100644
--- a/drivers/soc/renesas/rcar-sysc.c
+++ b/drivers/soc/renesas/rcar-sysc.c
@@ -310,6 +310,8 @@ struct rcar_pm_domains {
 	struct generic_pm_domain *domains[RCAR_PD_ALWAYS_ON + 1];
 };
 
+static struct genpd_onecell_data *rcar_sysc_onecell_data;
+
 static int __init rcar_sysc_pd_init(void)
 {
 	const struct rcar_sysc_info *info;
@@ -356,6 +358,7 @@ static int __init rcar_sysc_pd_init(void)
 
 	domains->onecell_data.domains = domains->domains;
 	domains->onecell_data.num_domains = ARRAY_SIZE(domains->domains);
+	rcar_sysc_onecell_data = &domains->onecell_data;
 
 	for (i = 0, syscier = 0; i < info->num_areas; i++)
 		syscier |= BIT(info->areas[i].isr_bit);
@@ -449,3 +452,40 @@ void __init rcar_sysc_init(phys_addr_t base, u32 syscier)
 	pr_debug("%s: syscier = 0x%08x\n", __func__, syscier);
 	iowrite32(syscier, rcar_sysc_base + SYSCIER);
 }
+
+#ifdef CONFIG_ARCH_R8A7779
+static int rcar_sysc_power_cpu(unsigned int idx, bool on)
+{
+	struct generic_pm_domain *genpd;
+	struct rcar_sysc_pd *pd;
+	unsigned int i;
+
+	if (!rcar_sysc_onecell_data)
+		return -ENODEV;
+
+	for (i = 0; i < rcar_sysc_onecell_data->num_domains; i++) {
+		genpd = rcar_sysc_onecell_data->domains[i];
+		if (!genpd)
+			continue;
+
+		pd = to_rcar_pd(genpd);
+		if (!(pd->flags & PD_CPU) || pd->ch.chan_bit != idx)
+			continue;
+
+		return on ? rcar_sysc_power_up(&pd->ch)
+			  : rcar_sysc_power_down(&pd->ch);
+	}
+
+	return -ENOENT;
+}
+
+int rcar_sysc_power_down_cpu(unsigned int cpu)
+{
+	return rcar_sysc_power_cpu(cpu, false);
+}
+
+int rcar_sysc_power_up_cpu(unsigned int cpu)
+{
+	return rcar_sysc_power_cpu(cpu, true);
+}
+#endif /* CONFIG_ARCH_R8A7779 */
diff --git a/include/linux/soc/renesas/rcar-sysc.h b/include/linux/soc/renesas/rcar-sysc.h
index 8a6086d2e9c3..9020da2111fd 100644
--- a/include/linux/soc/renesas/rcar-sysc.h
+++ b/include/linux/soc/renesas/rcar-sysc.h
@@ -13,5 +13,7 @@ struct rcar_sysc_ch {
 int rcar_sysc_power_down(const struct rcar_sysc_ch *sysc_ch);
 int rcar_sysc_power_up(const struct rcar_sysc_ch *sysc_ch);
 void rcar_sysc_init(phys_addr_t base, u32 syscier);
+int rcar_sysc_power_down_cpu(unsigned int cpu);
+int rcar_sysc_power_up_cpu(unsigned int cpu);
 
 #endif /* __LINUX_SOC_RENESAS_RCAR_SYSC_H__ */
-- 
2.11.0
