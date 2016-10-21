From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 20 Oct 2016 23:11:33 -0200
Subject: [PATCH] ARM: imx: gpc: Initialize all power domains
In-Reply-To: <CAOMZO5CORjf_86-XBy+STd4sEhcus8y1G4B-n58h3KNyuVyEew@mail.gmail.com>
References: <1476208413-11286-1-git-send-email-fabio.estevam@nxp.com>
 <20161019141556.GA18806@tiger>
 <CAOMZO5CORjf_86-XBy+STd4sEhcus8y1G4B-n58h3KNyuVyEew@mail.gmail.com>
Message-ID: <CAOMZO5Dusa0TdVtv4CrXcYe=80zhkFZRp9Y2d9PZTARq_3=1+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 20, 2016 at 3:29 PM, Fabio Estevam <festevam@gmail.com> wrote:
> Hi Shawn,
>
> On Wed, Oct 19, 2016 at 12:15 PM, Shawn Guo <shawnguo@kernel.org> wrote:
>
>> It's not clear to me why this is only with multi_v7_defconfig, not
>> imx_v6_v7_defconfig.  Also, is it a regression or long-standing issue?
>
> Investigated this a bit further and the problem seems to be in the
> power domain driver.
>
> The change below fixes the problem on mx6:
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index e023066..461d03c 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1572,8 +1572,6 @@ int of_genpd_add_provider_onecell(struct device_node *np,
>         for (i = 0; i < data->num_domains; i++) {
>                 if (!data->domains[i])
>                         continue;
> -               if (!pm_genpd_present(data->domains[i]))
> -                       goto error;
>
>                 data->domains[i]->provider = &np->fwnode;
>                 data->domains[i]->has_provider = true;
>
> , will submit this to the power domain folks.

Actually the above change would go against:

Author: Jon Hunter <jonathanh@nvidia.com>
Date:   Mon Sep 12 12:01:10 2016 +0100

    PM / Domains: Verify the PM domain is present when adding a provider

    When a PM domain provider is added, there is currently no way to tell if
    any PM domains associated with the provider are present. Naturally, the
    PM domain provider should not be registered if the PM domains have not
    been added. Nonetheless, verify that the PM domain(s) associated with a
    provider are present when registering the PM domain provider.

    This change adds a dependency on the function pm_genpd_present() when
    CONFIG_PM_GENERIC_DOMAINS_OF is enabled and so ensure this function is
    available when CONFIG_PM_GENERIC_DOMAINS_OF selected.

    Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
    Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
    Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

,so it seems the original patch in this thread is correct.

I will update the commit log and submit a v2.
