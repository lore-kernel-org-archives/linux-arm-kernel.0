From: robherring2@gmail.com (Rob Herring)
Date: Wed, 25 Jun 2014 08:06:27 -0500
Subject: [PATCH] ARM: integrator: fix OF-related regression
In-Reply-To: <1403611687-23512-1-git-send-email-linus.walleij@linaro.org>
References: <1403611687-23512-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <CAL_Jsq+Us51c-6+kP5Y+aML-HPV-=9SooPepD6u13xyrvDfcKw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 24, 2014 at 7:08 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> Commit 07e461cd7e73a84f0e3757932b93cc80976fd749
> "of: Ensure unique names without sacrificing determinism"
> caused a boot failure regression on the Integrator machines.
>
> The problem is probably caused by fiddling too much with
> the device tree population in the OF init function, such
> as passing the SoC bus device as parent when populating
> the device tree.
>
> This patch fixes the problem by:
>
> - Avoiding to explicitly look up the tree root
> - Look up devices needed before device population from
>   the match only, passing NULL as root
> - Passing NULL as root and parent when calling
>   of_platform_populate()

Just curious, I don't see how this fixes booting for Integrator. Where
exactly does boot fail?

Rob

>
> After this the Integrators boot again. Tested on
> Integrator/AP and Integrator/CP.
>
> Cc: Grant Likely <grant.likely@linaro.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ARM SoC maintainers: if you're happy with this fix, please
> apply it directly for fixes in the ARM SoC tree, thanks.
> ---
>  arch/arm/mach-integrator/integrator_ap.c | 26 +++++++-------------------
>  arch/arm/mach-integrator/integrator_cp.c | 23 ++++++-----------------
>  2 files changed, 13 insertions(+), 36 deletions(-)
>
> diff --git a/arch/arm/mach-integrator/integrator_ap.c b/arch/arm/mach-integrator/integrator_ap.c
> index dd0cc677d596..660ca6feff40 100644
> --- a/arch/arm/mach-integrator/integrator_ap.c
> +++ b/arch/arm/mach-integrator/integrator_ap.c
> @@ -480,25 +480,18 @@ static const struct of_device_id ebi_match[] = {
>  static void __init ap_init_of(void)
>  {
>         unsigned long sc_dec;
> -       struct device_node *root;
>         struct device_node *syscon;
>         struct device_node *ebi;
>         struct device *parent;
>         struct soc_device *soc_dev;
>         struct soc_device_attribute *soc_dev_attr;
>         u32 ap_sc_id;
> -       int err;
>         int i;
>
> -       /* Here we create an SoC device for the root node */
> -       root = of_find_node_by_path("/");
> -       if (!root)
> -               return;
> -
> -       syscon = of_find_matching_node(root, ap_syscon_match);
> +       syscon = of_find_matching_node(NULL, ap_syscon_match);
>         if (!syscon)
>                 return;
> -       ebi = of_find_matching_node(root, ebi_match);
> +       ebi = of_find_matching_node(NULL, ebi_match);
>         if (!ebi)
>                 return;
>
> @@ -509,19 +502,17 @@ static void __init ap_init_of(void)
>         if (!ebi_base)
>                 return;
>
> +       of_platform_populate(NULL, of_default_bus_match_table,
> +                       ap_auxdata_lookup, NULL);
> +
>         ap_sc_id = readl(ap_syscon_base);
>
>         soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
>         if (!soc_dev_attr)
>                 return;
>
> -       err = of_property_read_string(root, "compatible",
> -                                     &soc_dev_attr->soc_id);
> -       if (err)
> -               return;
> -       err = of_property_read_string(root, "model", &soc_dev_attr->machine);
> -       if (err)
> -               return;
> +       soc_dev_attr->soc_id = "XVC";
> +       soc_dev_attr->machine = "Integrator/AP";
>         soc_dev_attr->family = "Integrator";
>         soc_dev_attr->revision = kasprintf(GFP_KERNEL, "%c",
>                                            'A' + (ap_sc_id & 0x0f));
> @@ -536,9 +527,6 @@ static void __init ap_init_of(void)
>         parent = soc_device_to_device(soc_dev);
>         integrator_init_sysfs(parent, ap_sc_id);
>
> -       of_platform_populate(root, of_default_bus_match_table,
> -                       ap_auxdata_lookup, parent);
> -
>         sc_dec = readl(ap_syscon_base + INTEGRATOR_SC_DEC_OFFSET);
>         for (i = 0; i < 4; i++) {
>                 struct lm_device *lmdev;
> diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
> index a938242b0c95..0e57f8f820a5 100644
> --- a/arch/arm/mach-integrator/integrator_cp.c
> +++ b/arch/arm/mach-integrator/integrator_cp.c
> @@ -279,20 +279,13 @@ static const struct of_device_id intcp_syscon_match[] = {
>
>  static void __init intcp_init_of(void)
>  {
> -       struct device_node *root;
>         struct device_node *cpcon;
>         struct device *parent;
>         struct soc_device *soc_dev;
>         struct soc_device_attribute *soc_dev_attr;
>         u32 intcp_sc_id;
> -       int err;
>
> -       /* Here we create an SoC device for the root node */
> -       root = of_find_node_by_path("/");
> -       if (!root)
> -               return;
> -
> -       cpcon = of_find_matching_node(root, intcp_syscon_match);
> +       cpcon = of_find_matching_node(NULL, intcp_syscon_match);
>         if (!cpcon)
>                 return;
>
> @@ -300,19 +293,17 @@ static void __init intcp_init_of(void)
>         if (!intcp_con_base)
>                 return;
>
> +       of_platform_populate(NULL, of_default_bus_match_table,
> +                            intcp_auxdata_lookup, NULL);
> +
>         intcp_sc_id = readl(intcp_con_base);
>
>         soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
>         if (!soc_dev_attr)
>                 return;
>
> -       err = of_property_read_string(root, "compatible",
> -                                     &soc_dev_attr->soc_id);
> -       if (err)
> -               return;
> -       err = of_property_read_string(root, "model", &soc_dev_attr->machine);
> -       if (err)
> -               return;
> +       soc_dev_attr->soc_id = "XCV";
> +       soc_dev_attr->machine = "Integrator/CP";
>         soc_dev_attr->family = "Integrator";
>         soc_dev_attr->revision = kasprintf(GFP_KERNEL, "%c",
>                                            'A' + (intcp_sc_id & 0x0f));
> @@ -326,8 +317,6 @@ static void __init intcp_init_of(void)
>
>         parent = soc_device_to_device(soc_dev);
>         integrator_init_sysfs(parent, intcp_sc_id);
> -       of_platform_populate(root, of_default_bus_match_table,
> -                       intcp_auxdata_lookup, parent);
>  }
>
>  static const char * intcp_dt_board_compat[] = {
> --
> 1.9.3
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
