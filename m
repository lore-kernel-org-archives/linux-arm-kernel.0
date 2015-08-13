From: robherring2@gmail.com (Rob Herring)
Date: Thu, 13 Aug 2015 12:29:35 -0500
Subject: [PATCH v2 1/2] ARM: common: Introduce PM domains for CPUs/clusters
In-Reply-To: <1439406024-41893-1-git-send-email-lina.iyer@linaro.org>
References: <CAL_JsqLhHy5gO=usm1HLf8h6iz_5FguCDo-Qz2Km+XEwaCODUA@mail.gmail.com>
 <1439406024-41893-1-git-send-email-lina.iyer@linaro.org>
Message-ID: <CAL_JsqLcSs79bnj4ELN0uiwJ6gxt46PghxvuGQ7prkq-4gLKhg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 12, 2015 at 2:00 PM, Lina Iyer <lina.iyer@linaro.org> wrote:
> Define and add Generic PM domains (genpd) for CPU clusters. Many new
> SoCs group CPUs as clusters. Clusters share common resources like GIC,
> power rail, caches, VFP, Coresight etc. When all CPUs in the cluster are
> idle, these shared resources may also be put in their idle state.
>
> The idle time between the last CPU entering idle and a CPU resuming
> execution is an opportunity for these shared resources to be powered
> down. Generic PM domain provides a framework for defining such power
> domains and attach devices to the domain. When the devices in the domain
> are idle at runtime, the domain would also be suspended and resumed
> before the first of the devices resume execution.
>
> We define a generic PM domain for each cluster and attach CPU devices in
> the cluster to that PM domain. The DT definitions for the SoC describe
> this relationship. Genpd callbacks for power_on and power_off can then
> be used to power up/down the shared resources for the domain.
>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: Kevin Hilman <khilman@linaro.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Kevin Hilman <khilman@linaro.org>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> ---
> Changes since v1:
>
> - Function name changes and split out common code
> - Use cpu,pd for now. Removed references to ARM. Open to recommendations.
> - Still located in arch/arm/common/. May move to a more appropriate location.
> - Platform drivers can directly call of_init_cpu_domain() without using
>   compatibles.
> - Now maintains a list of CPU PM domains.

[...]

> +static int __init of_pm_domain_attach_cpus(void)
> +{
> +       int cpuid, ret;
> +
> +       /* Find any CPU nodes with a phandle to this power domain */
> +       for_each_possible_cpu(cpuid) {
> +               struct device *cpu_dev;
> +               struct of_phandle_args pd_args;
> +
> +               cpu_dev = get_cpu_device(cpuid);
> +               if (!cpu_dev) {
> +                       pr_warn("%s: Unable to get device for CPU%d\n",
> +                                       __func__, cpuid);
> +                       return -ENODEV;
> +               }
> +
> +               /*
> +                * We are only interested in CPUs that can be attached to
> +                * PM domains that are cpu,pd compatible.
> +                */

Under what conditions would the power domain for a cpu not be cpu,pd compatible?

Why can't the driver handling the power domain register with gen_pd
and the cpu_pd as the driver is going to be aware of which domains are
for cpus. While there could be h/w such that all power domains within
a chip have a nice uniform programming model, I'd guess that is the
exception, not the rule. First, chips I have worked on were not that
way. CPU related and peripheral related domains are handled quite
differently. Second, often the actions on the CPU power domains don't
take effect until a WFI, so you end up with a different programming
sequence.

Rob
