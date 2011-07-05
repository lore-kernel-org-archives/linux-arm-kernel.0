From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 5 Jul 2011 10:11:35 +0800
Subject: [PATCH v3] ARM: l2x0: Add OF based initialization
In-Reply-To: <1309810556-6224-1-git-send-email-robherring2@gmail.com>
References: <1309810556-6224-1-git-send-email-robherring2@gmail.com>
Message-ID: <CAGsJ_4xTiyoOP+bqk2gajzfMRBFkSJ_xzumWY=9F=90JBp4-aw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/7/5 Rob Herring <robherring2@gmail.com>:
> From: Rob Herring <rob.herring@calxeda.com>
>
> This adds probing for ARM L2x0 cache controllers via device tree. Support
> includes the L210, L220, and PL310 controllers. The binding allows setting
> up cache RAM latencies and filter addresses (PL310 only).
>
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> ---
> I've tested this version and fixed some issues from the one I sent to the
> CSR platform thread.
>
> Changes in v3:
> - Allow platforms to set aux ctrl reg with aux_value and aux_mask.
> - Add RAM latency and filter address bindings based on CSR's platform needs.

Rob, Thanks a lot for adding support for CSR's plarform. RAM latency
has been an issue for exynos4, tegra, realview, vexpress and CSR.
filter address is only in CSR by now.

>
> ?Documentation/devicetree/bindings/arm/l2cc.txt | ? 40 ++++++++
> ?arch/arm/include/asm/hardware/cache-l2x0.h ? ? | ? 17 ++++
> ?arch/arm/mm/cache-l2x0.c ? ? ? ? ? ? ? ? ? ? ? | ?120 ++++++++++++++++++++++++
> ?3 files changed, 177 insertions(+), 0 deletions(-)
> ?create mode 100644 Documentation/devicetree/bindings/arm/l2cc.txt
>
> diff --git a/Documentation/devicetree/bindings/arm/l2cc.txt b/Documentation/devicetree/bindings/arm/l2cc.txt
> new file mode 100644
> index 0000000..79e66fb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/l2cc.txt
> @@ -0,0 +1,40 @@
> +* ARM L2 Cache Controller
> +
> +ARM cores often have a separate level 2 cache controller. There are various
> +implementations of the L2 cache controller with compatible programming models.
> +The ARM L2 cache representation in the device tree should be done as under:-
> +
> +Required properties:
> +
> +- compatible : should be one of
> + ? ? ? "arm,pl310-cache"
> + ? ? ? "arm,l220-cache"
> + ? ? ? "arm,l210-cache"
> +- cache-unified : Specifies the cache is a unified cache.
> +- cache-level : Should be set to 2 for a level 2 cache.
> +- reg : Physical base address and size of cache controller's memory mapped
> + ?registers.
> +
> +Optional properties:
> +
> +- data-latency : Cycles of latency for Data RAM accesses. Specifies 3 cells of
> + ?read, write and setup latencies. Controllers without setup latency control
> + ?should use 0.
> +- tag-latency : Cycles of latency for Tag RAM accesses. Specifies 3 cells of
> + ?read, write and setup latencies. Controllers without setup latency control
> + ?should use 0.
> +- dirty-latency : Cycles of latency for reads of Dirty RAMs. This is a single
> + ?cell.t
> +- filter-ranges : <start end> Address range the
> +
> +Example:
> +
> +L2: l2-cache {
> + ? ? ? ?compatible = "arm,pl310-cache", "cache";
> + ? ? ? ?reg = <0xfff12000 0x1000>;
> + ? ? ? ?data-latency = <1 1 1>;
> + ? ? ? ?tag-latency = <2 2 2>;
> + ? ? ? ?cache-unified;
> + ? ? ? ?cache-level = <2>;
> +};
> +
> diff --git a/arch/arm/include/asm/hardware/cache-l2x0.h b/arch/arm/include/asm/hardware/cache-l2x0.h
> index 16bd480..8fe149f 100644
> --- a/arch/arm/include/asm/hardware/cache-l2x0.h
> +++ b/arch/arm/include/asm/hardware/cache-l2x0.h
> @@ -47,6 +47,8 @@
> ?#define L2X0_CLEAN_INV_WAY ? ? ? ? ? ? 0x7FC
> ?#define L2X0_LOCKDOWN_WAY_D ? ? ? ? ? ?0x900
> ?#define L2X0_LOCKDOWN_WAY_I ? ? ? ? ? ?0x904
> +#define L2X0_ADDR_FILTER_START ? ? ? ? 0xC00
> +#define L2X0_ADDR_FILTER_END ? ? ? ? ? 0xC04
> ?#define L2X0_TEST_OPERATION ? ? ? ? ? ?0xF00
> ?#define L2X0_LINE_DATA ? ? ? ? ? ? ? ? 0xF10
> ?#define L2X0_LINE_TAG ? ? ? ? ? ? ? ? ?0xF30
> @@ -62,6 +64,14 @@
> ?#define L2X0_CACHE_ID_PART_L310 ? ? ? ? ? ? ? ?(3 << 6)
>
> ?#define L2X0_AUX_CTRL_MASK ? ? ? ? ? ? ? ? ? ? 0xc0000fff
> +#define L2X0_AUX_CTRL_DATA_RD_LATENCY_SHIFT ? ?0
> +#define L2X0_AUX_CTRL_DATA_RD_LATENCY_MASK ? ? 0x7
> +#define L2X0_AUX_CTRL_DATA_WR_LATENCY_SHIFT ? ?3
> +#define L2X0_AUX_CTRL_DATA_WR_LATENCY_MASK ? ? (0x7 << 3)
> +#define L2X0_AUX_CTRL_TAG_LATENCY_SHIFT ? ? ? ? ? ? ? ?6
> +#define L2X0_AUX_CTRL_TAG_LATENCY_MASK ? ? ? ? (0x7 << 6)
> +#define L2X0_AUX_CTRL_DIRTY_LATENCY_SHIFT ? ? ?9
> +#define L2X0_AUX_CTRL_DIRTY_LATENCY_MASK ? ? ? (0x7 << 9)
> ?#define L2X0_AUX_CTRL_ASSOCIATIVITY_SHIFT ? ? ?16
> ?#define L2X0_AUX_CTRL_WAY_SIZE_SHIFT ? ? ? ? ? 17
> ?#define L2X0_AUX_CTRL_WAY_SIZE_MASK ? ? ? ? ? ?(0x3 << 17)
> @@ -72,8 +82,15 @@
> ?#define L2X0_AUX_CTRL_INSTR_PREFETCH_SHIFT ? ? 29
> ?#define L2X0_AUX_CTRL_EARLY_BRESP_SHIFT ? ? ? ? ? ? ? ?30
>
> +#define L2X0_LATENCY_CTRL_SETUP_SHIFT ?0
> +#define L2X0_LATENCY_CTRL_RD_SHIFT ? ? 4
> +#define L2X0_LATENCY_CTRL_WR_SHIFT ? ? 8
> +
> +#define L2X0_ADDR_FILTER_EN ? ? ? ? ? ?1
> +
> ?#ifndef __ASSEMBLY__
> ?extern void __init l2x0_init(void __iomem *base, __u32 aux_val, __u32 aux_mask);
> +extern int l2x0_of_init(__u32 aux_val, __u32 aux_mask);
> ?#endif
>
> ?#endif
> diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
> index ef59099..649be84 100644
> --- a/arch/arm/mm/cache-l2x0.c
> +++ b/arch/arm/mm/cache-l2x0.c
> @@ -16,9 +16,12 @@
> ?* along with this program; if not, write to the Free Software
> ?* Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
> ?*/
> +#include <linux/err.h>
> ?#include <linux/init.h>
> ?#include <linux/spinlock.h>
> ?#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
>
> ?#include <asm/cacheflush.h>
> ?#include <asm/hardware/cache-l2x0.h>
> @@ -344,3 +347,120 @@ void __init l2x0_init(void __iomem *base, __u32 aux_val, __u32 aux_mask)
> ? ? ? ?printk(KERN_INFO "l2x0: %d ways, CACHE_ID 0x%08x, AUX_CTRL 0x%08x, Cache size: %d B\n",
> ? ? ? ? ? ? ? ? ? ? ? ?ways, cache_id, aux, l2x0_size);
> ?}
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id l2x0_ids[] __initconst = {
> + ? ? ? { .compatible = "arm,pl310-cache" },
> + ? ? ? { .compatible = "arm,l220-cache" },
> + ? ? ? { .compatible = "arm,l210-cache" },
> + ? ? ? {}
> +};
> +
> +static void __init l2x0_of_set_address_filter(const struct device_node *np)
> +{
> + ? ? ? u32 start, end;
> + ? ? ? const u32 *prop;
> + ? ? ? int len;
> + ? ? ? int is_pl310 = of_device_is_compatible(np, "arm,pl310-cache");
> +
> + ? ? ? if (!is_pl310 || (readl_relaxed(l2x0_base + L2X0_CTRL) & 1))
> + ? ? ? ? ? ? ? return;
> +
> + ? ? ? prop = of_get_property(np, "filter-ranges", &len);
> + ? ? ? if (!prop || (len != (2 * sizeof(prop))))
> + ? ? ? ? ? ? ? return;
> +
> + ? ? ? start = be32_to_cpup(prop++) | L2X0_ADDR_FILTER_EN;
> + ? ? ? end = be32_to_cpup(prop++);
> + ? ? ? writel_relaxed(end, l2x0_base + L2X0_ADDR_FILTER_END);
> + ? ? ? writel_relaxed(start, l2x0_base + L2X0_ADDR_FILTER_START);
> +}
> +
> +static void __init l2x0_of_set_ram_timings(const struct device_node *np,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? __u32 *aux_val, __u32 *aux_mask)
> +{
> + ? ? ? u32 data_rd = 0, data_wr = 0, data_setup = 0;
> + ? ? ? u32 tag_rd = 0, tag_wr = 0, tag_setup = 0;
> + ? ? ? u32 dirty = 0;
> + ? ? ? const u32 *prop;
> + ? ? ? int len;
> + ? ? ? int is_pl310 = of_device_is_compatible(np, "arm,pl310-cache");
> +
> + ? ? ? if (readl_relaxed(l2x0_base + L2X0_CTRL) & 1)
> + ? ? ? ? ? ? ? return;
> +
> + ? ? ? prop = of_get_property(np, "data-latency", &len);
> + ? ? ? if (prop && (len == (3 * sizeof(prop)))) {
> + ? ? ? ? ? ? ? data_rd = be32_to_cpup(prop++);
> + ? ? ? ? ? ? ? data_wr = be32_to_cpup(prop++);
> + ? ? ? ? ? ? ? data_setup = be32_to_cpup(prop);
> + ? ? ? }
> +
> + ? ? ? prop = of_get_property(np, "tag-latency", &len);
> + ? ? ? if (prop && (len == (3 * sizeof(prop)))) {
> + ? ? ? ? ? ? ? tag_rd = be32_to_cpup(prop++);
> + ? ? ? ? ? ? ? tag_wr = be32_to_cpup(prop++);
> + ? ? ? ? ? ? ? tag_setup = be32_to_cpup(prop);
> + ? ? ? }
> +
> + ? ? ? prop = of_get_property(np, "dirty-latency", &len);
> + ? ? ? if (prop && (len == sizeof(prop)))
> + ? ? ? ? ? ? ? dirty = be32_to_cpup(prop);
> +
> + ? ? ? if (is_pl310 && tag_wr && tag_rd && tag_setup)
> + ? ? ? ? ? ? ? writel_relaxed(
> + ? ? ? ? ? ? ? ? ? ? ? (--tag_wr << L2X0_LATENCY_CTRL_WR_SHIFT) |
> + ? ? ? ? ? ? ? ? ? ? ? (--tag_rd << L2X0_LATENCY_CTRL_RD_SHIFT) |
> + ? ? ? ? ? ? ? ? ? ? ? (--tag_setup << L2X0_LATENCY_CTRL_SETUP_SHIFT),
> + ? ? ? ? ? ? ? ? ? ? ? l2x0_base + L2X0_TAG_LATENCY_CTRL);
> +
> + ? ? ? if (is_pl310 && data_wr && data_rd && data_setup)
> + ? ? ? ? ? ? ? writel_relaxed(
> + ? ? ? ? ? ? ? ? ? ? ? (--data_wr << L2X0_LATENCY_CTRL_WR_SHIFT) |
> + ? ? ? ? ? ? ? ? ? ? ? (--data_rd << L2X0_LATENCY_CTRL_RD_SHIFT) |
> + ? ? ? ? ? ? ? ? ? ? ? (--data_setup << L2X0_LATENCY_CTRL_SETUP_SHIFT),
> + ? ? ? ? ? ? ? ? ? ? ? l2x0_base + L2X0_TAG_LATENCY_CTRL);
> +
> + ? ? ? if (!is_pl310 && tag_rd) {
> + ? ? ? ? ? ? ? *aux_val &= ~L2X0_AUX_CTRL_TAG_LATENCY_MASK;
> + ? ? ? ? ? ? ? *aux_val |= --tag_rd << L2X0_AUX_CTRL_TAG_LATENCY_SHIFT;
> + ? ? ? ? ? ? ? *aux_mask &= ~L2X0_AUX_CTRL_TAG_LATENCY_MASK;
> + ? ? ? }
> +
> + ? ? ? if (!is_pl310 && data_rd) {
> + ? ? ? ? ? ? ? *aux_val &= ~L2X0_AUX_CTRL_DATA_RD_LATENCY_MASK;
> + ? ? ? ? ? ? ? *aux_val |= --data_rd << L2X0_AUX_CTRL_DATA_RD_LATENCY_SHIFT;
> + ? ? ? ? ? ? ? *aux_mask &= ~L2X0_AUX_CTRL_DATA_RD_LATENCY_MASK;
> + ? ? ? }
> +
> + ? ? ? if (!is_pl310 && data_wr) {
> + ? ? ? ? ? ? ? *aux_val &= ~L2X0_AUX_CTRL_DATA_WR_LATENCY_MASK;
> + ? ? ? ? ? ? ? *aux_val |= --data_wr << L2X0_AUX_CTRL_DATA_WR_LATENCY_SHIFT;
> + ? ? ? ? ? ? ? *aux_mask &= ~L2X0_AUX_CTRL_DATA_WR_LATENCY_MASK;
> + ? ? ? }
> +
> + ? ? ? if (!is_pl310 && dirty) {
> + ? ? ? ? ? ? ? *aux_val &= ~L2X0_AUX_CTRL_DIRTY_LATENCY_MASK;
> + ? ? ? ? ? ? ? *aux_val |= --dirty << L2X0_AUX_CTRL_DIRTY_LATENCY_SHIFT;
> + ? ? ? ? ? ? ? *aux_mask &= ~L2X0_AUX_CTRL_DIRTY_LATENCY_MASK;
> + ? ? ? }
> +}
> +
> +int __init l2x0_of_init(__u32 aux_val, __u32 aux_mask)
> +{
> + ? ? ? struct device_node *np;
> + ? ? ? void __iomem *l2_base;
> +
> + ? ? ? np = of_find_matching_node(NULL, l2x0_ids);
> + ? ? ? if (!np)
> + ? ? ? ? ? ? ? return -ENODEV;
> + ? ? ? l2_base = of_iomap(np, 0);
> + ? ? ? if (!l2_base)
> + ? ? ? ? ? ? ? return -ENOMEM;
> +
> + ? ? ? l2x0_of_set_address_filter(np);
> + ? ? ? l2x0_of_set_ram_timings(np, &aux_val, &aux_mask);
> + ? ? ? l2x0_init(l2_base, aux_val, aux_mask);
> + ? ? ? return 0;
> +}
> +#endif
> --
> 1.7.4.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
