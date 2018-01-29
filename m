From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 29 Jan 2018 10:03:47 +0000
Subject: [PATCH 13/14] firmware/psci: Expose SMCCC version through psci_ops
In-Reply-To: <20180126142847.31240-14-marc.zyngier@arm.com>
References: <20180126142847.31240-1-marc.zyngier@arm.com>
 <20180126142847.31240-14-marc.zyngier@arm.com>
Message-ID: <CAKv+Gu8g0k=gr7_7gDbo2rt7t3iD5+_ENrQ3Zv2JAFE2ZrGGaw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 January 2018 at 14:28, Marc Zyngier <marc.zyngier@arm.com> wrote:
> Since PSCI 1.0 allows the SMCCC version to be (indirectly) probed,
> let's do that at boot time, and expose the version of the calling
> convention as part of the psci_ops structure.
>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  drivers/firmware/psci.c | 22 ++++++++++++++++++++++
>  include/linux/psci.h    |  6 ++++++
>  2 files changed, 28 insertions(+)
>
> diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
> index 570187e5d084..b260bbf637a2 100644
> --- a/drivers/firmware/psci.c
> +++ b/drivers/firmware/psci.c
> @@ -509,6 +509,27 @@ static void __init psci_init_migrate(void)
>         pr_info("Trusted OS resident on physical CPU 0x%lx\n", cpuid);
>  }
>
> +static void __init psci_init_smccc(u32 ver)
> +{
> +       int feature = PSCI_RET_NOT_SUPPORTED;
> +
> +       if (PSCI_VERSION_MAJOR(ver) > 1 ||
> +           (PSCI_VERSION_MAJOR(ver) == 1 && PSCI_VERSION_MINOR(ver) >= 0))

'PSCI_VERSION_MAJOR(ver) >= 1' should be sufficient here, no?

> +               feature = psci_features(ARM_SMCCC_VERSION_FUNC_ID);
> +
> +       if (feature == PSCI_RET_NOT_SUPPORTED) {
> +               psci_ops.variant = SMCCC_VARIANT_1_0;
> +       } else {
> +               ver = invoke_psci_fn(ARM_SMCCC_VERSION_FUNC_ID, 0, 0, 0);
> +               if (ver != ARM_SMCCC_VERSION_1_1)
> +                       psci_ops.variant = SMCCC_VARIANT_1_0;
> +               else
> +                       psci_ops.variant = SMCCC_VARIANT_1_1;
> +       }
> +
> +       pr_info("SMC Calling Convention v1.%d\n", psci_ops.variant);
> +}
> +
>  static void __init psci_0_2_set_functions(void)
>  {
>         pr_info("Using standard PSCI v0.2 function IDs\n");
> @@ -555,6 +576,7 @@ static int __init psci_probe(void)
>         psci_0_2_set_functions();
>
>         psci_init_migrate();
> +       psci_init_smccc(ver);
>
>         if (PSCI_VERSION_MAJOR(ver) >= 1) {
>                 psci_init_cpu_suspend();
> diff --git a/include/linux/psci.h b/include/linux/psci.h
> index f2679e5faa4f..83fd16a37be3 100644
> --- a/include/linux/psci.h
> +++ b/include/linux/psci.h
> @@ -31,6 +31,11 @@ enum psci_conduit {
>         PSCI_CONDUIT_HVC,
>  };
>
> +enum smccc_variant {
> +       SMCCC_VARIANT_1_0,
> +       SMCCC_VARIANT_1_1,
> +};
> +
>  struct psci_operations {
>         u32 (*get_version)(void);
>         int (*cpu_suspend)(u32 state, unsigned long entry_point);
> @@ -41,6 +46,7 @@ struct psci_operations {
>                         unsigned long lowest_affinity_level);
>         int (*migrate_info_type)(void);
>         enum psci_conduit conduit;
> +       enum smccc_variant variant;
>  };
>
>  extern struct psci_operations psci_ops;
> --
> 2.14.2
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
