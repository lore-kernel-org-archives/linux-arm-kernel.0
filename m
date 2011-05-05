From: notasas@gmail.com (Grazvydas Ignotas)
Date: Thu, 5 May 2011 16:34:06 +0300
Subject: [PATCH 19/22] OMAP: hsmmc: implement clock switcher
In-Reply-To: <1304596282-4095-20-git-send-email-adrian.hunter@nokia.com>
References: <1304596282-4095-1-git-send-email-adrian.hunter@nokia.com>
	<1304596282-4095-20-git-send-email-adrian.hunter@nokia.com>
Message-ID: <BANLkTin7iMibEZihx6nCHibB1GLiuJzCDA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 5, 2011 at 2:51 PM, Adrian Hunter <adrian.hunter@nokia.com> wrote:
> From: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
>
> There are 3 new platform data methods which should help us to do a clock
> switching when notification is happened or request is started.
>
> The purpose of the patch is to avoid high frequency of MMC controller on low
> OPPs due to an HW bug in OMAP 3630.
>
> The algorithm:
> ?- the PM governor switches the clock of L3 (and therefore L4) bus on demand
> ?- the MMC controller clock should follow the change
>
> We have considered two OPPs for L3/L4 bus. Thus, we have corresponding flow:
> ?- OPP1 -> OPP2 (in case of abort - OPP1)
> ?- OPP2 -> OPP1 (in case of abort - OPP2)
>
> During idle the MMC gates functional clock and we don't care about the
> frequency. Most important to get proper solution when notification comes during
> request. Then:
> ?- in case of OPP1 -> OPP2 we update frequency limit and it will be used for
> ? new coming requests (it assumes the current frequency of the controller is
> ? lower then new one)
> ?- otherwise we wait until no device has used higher frequency then upcoming
> ? one
>
> Known issues and limitations:
> ?- originally a clock notifier was used for the core L4 iclk but for upstream
> ? Adrian changed to a cpufreq notifier where we assume OPP1 below 400MHz and
> ? OPP2 above 400MHz
>
> Signed-off-by: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
> Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
> ---
> ?arch/arm/mach-omap2/hsmmc.c ? ? ? ? ? | ?180 ++++++++++++++++++++++++++++++++-
> ?arch/arm/plat-omap/include/plat/mmc.h | ? ?8 ++
> ?2 files changed, 187 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
> index 6b97fae..34cba89 100644
> --- a/arch/arm/mach-omap2/hsmmc.c
> +++ b/arch/arm/mach-omap2/hsmmc.c

<snip>

> +
> +static int hsmmc_clk_notifier(struct notifier_block *nb, unsigned long event,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? void *data)
> +{
> + ? ? ? struct cpufreq_freqs *freqs = data;
> + ? ? ? unsigned int threshold = 400000; /* between opp1 and opp2 */
> +
> + ? ? ? switch (event) {
> + ? ? ? case CPUFREQ_PRECHANGE:
> + ? ? ? ? ? ? ? if (freqs->new < threshold && freqs->old > threshold) {

What if we go from 400000 to, say, 200000?

> + ? ? ? ? ? ? ? ? ? ? ? /* opp2 -> opp1 */
> + ? ? ? ? ? ? ? ? ? ? ? hsmmc_max_freq = HSMMC_MAX_FREQ >> 1;
> +
> + ? ? ? ? ? ? ? ? ? ? ? /* Timeout is 1 sec */
> + ? ? ? ? ? ? ? ? ? ? ? if (!wait_event_timeout(hsmmc_max_freq_wq,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? hsmmc_max_freq_ok(),
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? msecs_to_jiffies(1000)))
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? pr_err("MMC violates maximum frequency "
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?"constraint\n");
> + ? ? ? ? ? ? ? }
> + ? ? ? ? ? ? ? break;
> + ? ? ? case CPUFREQ_POSTCHANGE:
> + ? ? ? ? ? ? ? if (freqs->old < threshold && freqs->new > threshold) {

Same here, you could go from 200000 to 400000 and then 600000 and code
would never notice it.

> + ? ? ? ? ? ? ? ? ? ? ? /* opp1 -> opp2 */
> + ? ? ? ? ? ? ? ? ? ? ? hsmmc_max_freq = HSMMC_MAX_FREQ;
> + ? ? ? ? ? ? ? }
