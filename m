From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 14 Mar 2017 12:36:09 +0100
Subject: [PATCH V5 4/9] PM / cpu_domains: Setup PM domains for
 CPUs/clusters
In-Reply-To: <1488573695-106680-5-git-send-email-lina.iyer@linaro.org>
References: <1488573695-106680-1-git-send-email-lina.iyer@linaro.org>
 <1488573695-106680-5-git-send-email-lina.iyer@linaro.org>
Message-ID: <CAPDyKFpB-nZwkcs3ZEsFA+9UYmu1Z+qhAK4FeDSpMRmwjTbVDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 March 2017 at 21:41, Lina Iyer <lina.iyer@linaro.org> wrote:
> Define and add Generic PM domains (genpd) for CPU clusters. Many new
> SoCs group CPUs as clusters. Clusters share common resources like power
> rails, caches, VFP, Coresight etc. When all CPUs in the cluster are
> idle, these shared resources may also be put in their idle state.
>
> CPUs may be associated with their domain providers. The domains in
> turn may be associated with their providers. This is clean way to model
> the cluster hierarchy like that of ARM's big.little architecture.
>
> Platform drivers may initialize generic PM domains and setup the CPU PM
> domains for the genpd and attach CPUs to the domain. In the following
> patches, the CPUs are hooked up to runtime PM framework which helps
> power down the domain, when all the CPUs in the domain are idle.
>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Suggested-by: Kevin Hilman <khilman@kernel.org>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> ---
>  drivers/base/power/Makefile      |   2 +-
>  drivers/base/power/cpu_domains.c | 192 +++++++++++++++++++++++++++++++++++++++
>  include/linux/cpu_domains.h      |  48 ++++++++++
>  3 files changed, 241 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/base/power/cpu_domains.c
>  create mode 100644 include/linux/cpu_domains.h
>
> diff --git a/drivers/base/power/Makefile b/drivers/base/power/Makefile
> index 5998c53..ee383f1 100644
> --- a/drivers/base/power/Makefile
> +++ b/drivers/base/power/Makefile
> @@ -2,7 +2,7 @@ obj-$(CONFIG_PM)        += sysfs.o generic_ops.o common.o qos.o runtime.o wakeirq.o
>  obj-$(CONFIG_PM_SLEEP) += main.o wakeup.o
>  obj-$(CONFIG_PM_TRACE_RTC)     += trace.o
>  obj-$(CONFIG_PM_OPP)   += opp/
> -obj-$(CONFIG_PM_GENERIC_DOMAINS)       +=  domain.o domain_governor.o
> +obj-$(CONFIG_PM_GENERIC_DOMAINS)       += domain.o domain_governor.o cpu_domains.o

One more thing that I wonder about.

Isn't cpu_domains relying on CONFIG_PM_GENERIC_DOMAINS_OF to work?
Perhaps it's just better to build for that case?

[...]

Kind regards
Uffe
