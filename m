From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Thu, 16 Sep 2010 09:36:08 +0900
Subject: [PATCH 4/5] ARM: S5PV210: Add support CPUFREQ
In-Reply-To: <1284537162-3129-5-git-send-email-jc.lee@samsung.com>
References: <1284537162-3129-1-git-send-email-jc.lee@samsung.com>
	<1284537162-3129-5-git-send-email-jc.lee@samsung.com>
Message-ID: <AANLkTinq0m7fJCaSZ0Gbq-kEE-P8SojO1x7Lgof-6umB@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, Sep 15, 2010 at 4:52 PM, Jaecheol Lee <jc.lee@samsung.com> wrote:
> This patch adds CPUFREQ driver for supporting DFS(Dynamic Frequency Scaling).
>
> Signed-off-by: Jaecheol Lee <jc.lee@samsung.com>
> ---
> ?arch/arm/mach-s5pv210/cpufreq.c | ?415 +++++++++++++++++++++++++++++++++++++++
> ?1 files changed, 415 insertions(+), 0 deletions(-)
> ?create mode 100644 arch/arm/mach-s5pv210/cpufreq.c
>
> diff --git a/arch/arm/mach-s5pv210/cpufreq.c b/arch/arm/mach-s5pv210/cpufreq.c
> new file mode 100644
> index 0000000..aa39c2e

(snip)

> +static int s5pv210_target(struct cpufreq_policy *policy,
> + ? ? ? ? ? ? ? ? ? ? ? ? unsigned int target_freq,
> + ? ? ? ? ? ? ? ? ? ? ? ? unsigned int relation)
> +{
> + ? ? ? unsigned long reg;
> + ? ? ? unsigned int index, priv_index;
> + ? ? ? unsigned int pll_changing = 0;
> + ? ? ? unsigned int bus_speed_changing = 0;
> +
> + ? ? ? freqs.old = s5pv210_getspeed(0);
> +
> + ? ? ? if (cpufreq_frequency_table_target(policy, s5pv210_freq_table,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?target_freq, relation, &index))
> + ? ? ? ? ? ? ? return -EINVAL;
> +
> + ? ? ? freqs.new = s5pv210_freq_table[index].frequency;
> + ? ? ? freqs.cpu = 0;
> +
> + ? ? ? if (freqs.new == freqs.old)
> + ? ? ? ? ? ? ? return 0;
> +
> + ? ? ? /* Finding current running level index */
> + ? ? ? if (cpufreq_frequency_table_target(policy, s5pv210_freq_table,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?freqs.old, relation, &priv_index))
> + ? ? ? ? ? ? ? return -EINVAL;
> +
> + ? ? ? cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
> +
> + ? ? ? if (freqs.new > freqs.old) {
> + ? ? ? ? ? ? ? /* Voltage up: will be implemented */

This could be crucial to the system stability. It is usually not optional.

> + ? ? ? }
> +
> + ? ? ? /* Check if there need to change PLL */
> + ? ? ? if ((index == L0) || (priv_index == L0))
> + ? ? ? ? ? ? ? pll_changing = 1;
> +
> + ? ? ? /* Check if there need to change System bus clock */
> + ? ? ? if ((index == L4) || (priv_index == L4))
> + ? ? ? ? ? ? ? bus_speed_changing = 1;
> +
> + ? ? ? if (bus_speed_changing) {
> + ? ? ? ? ? ? ? /*
> + ? ? ? ? ? ? ? ?* Reconfigure DRAM refresh counter value for minimum
> + ? ? ? ? ? ? ? ?* temporary clock while changing divider.
> + ? ? ? ? ? ? ? ?* expected clock is 83Mhz : 7.8usec/(1/83Mhz) = 0x287
> + ? ? ? ? ? ? ? ?*/
> + ? ? ? ? ? ? ? if (pll_changing)
> + ? ? ? ? ? ? ? ? ? ? ? __raw_writel(0x287, S5P_VA_DMC1 + 0x30);
> + ? ? ? ? ? ? ? else
> + ? ? ? ? ? ? ? ? ? ? ? __raw_writel(0x30c, S5P_VA_DMC1 + 0x30);
> +
> + ? ? ? ? ? ? ? __raw_writel(0x287, S5P_VA_DMC0 + 0x30);

It'd be better to set values based on the real MPLL, APLL clock
speeds, not hard-coding them.

> + ? ? ? }
> +

(snip)

> +
> + ? ? ? /*
> + ? ? ? ?* L4 level need to change memory bus speed, hence onedram clock divier
> + ? ? ? ?* and memory refresh parameter should be changed
> + ? ? ? ?*/
> + ? ? ? if (bus_speed_changing) {
> + ? ? ? ? ? ? ? reg = __raw_readl(S5P_CLK_DIV6);
> + ? ? ? ? ? ? ? reg &= ~S5P_CLKDIV6_ONEDRAM_MASK;
> + ? ? ? ? ? ? ? reg |= (clkdiv_val[index][8] << S5P_CLKDIV6_ONEDRAM_SHIFT);
> + ? ? ? ? ? ? ? __raw_writel(reg, S5P_CLK_DIV6);
> +
> + ? ? ? ? ? ? ? do {
> + ? ? ? ? ? ? ? ? ? ? ? reg = __raw_readl(S5P_CLKDIV_STAT1);
> + ? ? ? ? ? ? ? } while (reg & (1 << 15));
> +
> + ? ? ? ? ? ? ? /* Reconfigure DRAM refresh counter value */
> + ? ? ? ? ? ? ? if (index != L4) {
> + ? ? ? ? ? ? ? ? ? ? ? /*
> + ? ? ? ? ? ? ? ? ? ? ? ?* DMC0 : 166Mhz
> + ? ? ? ? ? ? ? ? ? ? ? ?* DMC1 : 200Mhz
> + ? ? ? ? ? ? ? ? ? ? ? ?*/
> + ? ? ? ? ? ? ? ? ? ? ? __raw_writel(0x618, S5P_VA_DMC1 + 0x30);
> + ? ? ? ? ? ? ? ? ? ? ? __raw_writel(0x50e, S5P_VA_DMC0 + 0x30);
> + ? ? ? ? ? ? ? } else {
> + ? ? ? ? ? ? ? ? ? ? ? /*
> + ? ? ? ? ? ? ? ? ? ? ? ?* DMC0 : 83Mhz
> + ? ? ? ? ? ? ? ? ? ? ? ?* DMC1 : 100Mhz
> + ? ? ? ? ? ? ? ? ? ? ? ?*/
> + ? ? ? ? ? ? ? ? ? ? ? __raw_writel(0x30c, S5P_VA_DMC1 + 0x30);
> + ? ? ? ? ? ? ? ? ? ? ? __raw_writel(0x287, S5P_VA_DMC0 + 0x30);
> + ? ? ? ? ? ? ? }

Same here. It'd better not be hard coded. We can't sure about the
clock speeds for different boards.

> + ? ? ? }
> +
> + ? ? ? if (freqs.new < freqs.old) {
> + ? ? ? ? ? ? ? /* Voltage down: will be implemented */
> + ? ? ? }
> +
> + ? ? ? cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
> +
> + ? ? ? printk(KERN_INFO "Perf changed[L%d]\n", index);

This may incur too many clutters.

> +
> + ? ? ? return 0;
> +}
> +
(snip)

>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>

Overall, this patch appears to be subset of the previous "[PATCH v7
6/6] ARM: S5PV210: Initial CPUFREQ Support" and things omitted (and
should be added) are already implemented there.



-- 
MyungJoo Ham, Ph.D.
Mobile Software Platform Lab,
Digital Media and Communications (DMC) Business
Samsung Electronics
cell: 82-10-6714-2858
