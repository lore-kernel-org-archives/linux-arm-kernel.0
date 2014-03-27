From: rob.herring@linaro.org (Rob Herring)
Date: Thu, 27 Mar 2014 11:41:04 -0500
Subject: [PATCH v2 1/3] PSCI: Use DT Function ID values only for old
 versions of spec
In-Reply-To: <1395934715-31348-1-git-send-email-ashwin.chaugule@linaro.org>
References: <1395934715-31348-1-git-send-email-ashwin.chaugule@linaro.org>
Message-ID: <CABGGisybEQC1BPE6efAP+8CW+DFiQAKB-bvJu6psY7C1E8bQtg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 27, 2014 at 10:38 AM, Ashwin Chaugule
<ashwin.chaugule@linaro.org> wrote:
> PSCI v0.2+ spec mandates specific values of Function IDs
> for ARM32 and ARM64. Use DT bindings of Function IDs only
> when using older versions. Use standard values otherwise.

The subject line is a bit out of date.

> Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
> ---
>  arch/arm/include/asm/psci.h |   7 +-
>  arch/arm/kernel/psci.c      | 155 ++++++++++++++++++++++++++++++++++++++++----
>  arch/arm64/kernel/psci.c    | 154 +++++++++++++++++++++++++++++++++++++++----
>  include/uapi/linux/psci.h   |  45 +++++++++++++
>  4 files changed, 334 insertions(+), 27 deletions(-)
>  create mode 100644 include/uapi/linux/psci.h
>
> diff --git a/arch/arm/include/asm/psci.h b/arch/arm/include/asm/psci.h
> index c4ae171..f867633 100644
> --- a/arch/arm/include/asm/psci.h
> +++ b/arch/arm/include/asm/psci.h
> @@ -29,16 +29,19 @@ struct psci_operations {
>         int (*cpu_off)(struct psci_power_state state);
>         int (*cpu_on)(unsigned long cpuid, unsigned long entry_point);
>         int (*migrate)(unsigned long cpuid);
> +       int (*affinity_info)(unsigned long target_affinity,
> +                       unsigned long lowest_affinity_level);
> +       int (*migrate_info_type)(void);
>  };
>
>  extern struct psci_operations psci_ops;
>  extern struct smp_operations psci_smp_ops;
>
>  #ifdef CONFIG_ARM_PSCI
> -void psci_init(void);
> +int psci_init(void);
>  bool psci_smp_available(void);
>  #else
> -static inline void psci_init(void) { }
> +static inline init psci_init(void) { }
>  static inline bool psci_smp_available(void) { return false; }
>  #endif
>
> diff --git a/arch/arm/kernel/psci.c b/arch/arm/kernel/psci.c
> index 4693188..77e6968 100644
> --- a/arch/arm/kernel/psci.c
> +++ b/arch/arm/kernel/psci.c
> @@ -17,6 +17,7 @@
>
>  #include <linux/init.h>
>  #include <linux/of.h>
> +#include <uapi/linux/psci.h>
>
>  #include <asm/compiler.h>
>  #include <asm/errno.h>
> @@ -27,12 +28,15 @@
>  struct psci_operations psci_ops;
>
>  static int (*invoke_psci_fn)(u32, u32, u32, u32);
> +typedef int (*psci_initcall_t)(const struct device_node *);
>
>  enum psci_function {
>         PSCI_FN_CPU_SUSPEND,
>         PSCI_FN_CPU_ON,
>         PSCI_FN_CPU_OFF,
>         PSCI_FN_MIGRATE,
> +       PSCI_FN_AFFINITY_INFO,
> +       PSCI_FN_MIGRATE_INFO_TYPE,
>         PSCI_FN_MAX,
>  };
>
> @@ -110,6 +114,18 @@ static noinline int __invoke_psci_fn_smc(u32 function_id, u32 arg0, u32 arg1,
>         return function_id;
>  }
>
> +#define PSCI_VER_MAJOR_MASK            0xffff0000
> +#define PSCI_VER_MINOR_MASK            0x0000ffff
> +#define PSCI_VER_MAJOR_SHIFT   16
> +
> +static int psci_get_version(void)
> +{
> +       int err;
> +
> +       err = invoke_psci_fn(PSCI_ID_VERSION, 0, 0, 0);
> +       return err;
> +}
> +
>  static int psci_cpu_suspend(struct psci_power_state state,
>                             unsigned long entry_point)
>  {
> @@ -153,25 +169,100 @@ static int psci_migrate(unsigned long cpuid)
>         return psci_to_linux_errno(err);
>  }
>
> -static const struct of_device_id psci_of_match[] __initconst = {
> -       { .compatible = "arm,psci",     },
> -       {},
> -};
> +static int psci_affinity_info(unsigned long target_affinity,
> +               unsigned long lowest_affinity_level)
> +{
> +       int err;
> +       u32 fn;
> +
> +       fn = psci_function_id[PSCI_FN_AFFINITY_INFO];
> +       err = invoke_psci_fn(fn, target_affinity, lowest_affinity_level, 0);
> +       return err;
> +}
>
> -void __init psci_init(void)
> +static int psci_migrate_info_type(void)
> +{
> +       int err;
> +       u32 fn;
> +
> +       fn = psci_function_id[PSCI_FN_MIGRATE_INFO_TYPE];
> +       err = invoke_psci_fn(fn, 0, 0, 0);
> +       return err;
> +}
> +
> +/*
> + * PSCI Function IDs for v0.2+ are well defined so use
> + * standard values.
> + */
> +static int psci_static_init(struct device_node *np)
>  {
> -       struct device_node *np;
>         const char *method;
> -       u32 id;
> +       int err = 0;
> +       int ver = 0;

Initialization not needed.

>
> -       np = of_find_matching_node(NULL, psci_of_match);
> -       if (!np)
> -               return;
> +       pr_info("probing for conduit method from DT.\n");
> +
> +       if (of_property_read_string(np, "method", &method)) {
> +               pr_warn("missing \"method\" property\n");
> +               err = -ENXIO;
> +               goto out_put_node;
> +       }
> +
> +       if (!strcmp("hvc", method)) {
> +               invoke_psci_fn = __invoke_psci_fn_hvc;
> +       } else if (!strcmp("smc", method)) {
> +               invoke_psci_fn = __invoke_psci_fn_smc;
> +       } else {
> +               pr_warn("invalid \"method\" property: %s\n", method);
> +               err = -EINVAL;
> +               goto out_put_node;
> +       }

This should all be common setup.

> +
> +       ver = psci_get_version();
> +
> +       pr_info("PSCIv%d.%d detected in firmware.\n",
> +                       (ver & PSCI_VER_MAJOR_MASK) >> PSCI_VER_MAJOR_SHIFT,
> +                       (ver & PSCI_VER_MINOR_MASK));

If it doesn't report 0.2, then we should probably bail (possibly
falling back to 0.1).

> +
> +       pr_info("Using standard PSCI v0.2 function IDs\n");
> +       psci_function_id[PSCI_FN_CPU_SUSPEND] = PSCI_ID_CPU_SUSPEND;
> +       psci_ops.cpu_suspend = psci_cpu_suspend;
> +
> +       psci_function_id[PSCI_FN_CPU_OFF] = PSCI_ID_CPU_OFF;
> +       psci_ops.cpu_off = psci_cpu_off;
> +
> +       psci_function_id[PSCI_FN_CPU_ON] = PSCI_ID_CPU_ON;
> +       psci_ops.cpu_on = psci_cpu_on;
> +
> +       psci_function_id[PSCI_FN_MIGRATE] = PSCI_ID_CPU_MIGRATE;
> +       psci_ops.migrate = psci_migrate;
> +
> +       psci_function_id[PSCI_FN_AFFINITY_INFO] = PSCI_ID_AFFINITY_INFO;
> +       psci_ops.affinity_info = psci_affinity_info;
> +
> +       psci_function_id[PSCI_FN_MIGRATE_INFO_TYPE] = PSCI_ID_MIGRATE_INFO_TYPE;
> +       psci_ops.migrate_info_type = psci_migrate_info_type;
> +
> +out_put_node:
> +       of_node_put(np);
> +       return err;
> +}
> +
> +/*
> + * PSCI < v0.2 can override PSCI function IDs via DT.
> + */
> +static int psci_of_init(struct device_node *np)
> +{
> +       const char *method;
> +       u32 id;
> +       int err = 0;
> +       int ver = 0;
>
>         pr_info("probing function IDs from device-tree\n");
>
>         if (of_property_read_string(np, "method", &method)) {
> -               pr_warning("missing \"method\" property\n");
> +               pr_warn("missing \"method\" property\n");
> +               err = -EINVAL;
>                 goto out_put_node;
>         }
>
> @@ -180,10 +271,17 @@ void __init psci_init(void)
>         } else if (!strcmp("smc", method)) {
>                 invoke_psci_fn = __invoke_psci_fn_smc;
>         } else {
> -               pr_warning("invalid \"method\" property: %s\n", method);
> +               pr_warn("invalid \"method\" property: %s\n", method);
> +               err = -ENXIO;
>                 goto out_put_node;
>         }
>
> +       ver = psci_get_version();

This may not be safe to do on 0.1 as the call didn't exist.

> +
> +       pr_info("PSCIv%d.%d detected in firmware.\n",
> +                       (ver & PSCI_VER_MAJOR_MASK) >> PSCI_VER_MAJOR_SHIFT,
> +                       (ver & PSCI_VER_MINOR_MASK));
> +
>         if (!of_property_read_u32(np, "cpu_suspend", &id)) {
>                 psci_function_id[PSCI_FN_CPU_SUSPEND] = id;
>                 psci_ops.cpu_suspend = psci_cpu_suspend;
> @@ -204,7 +302,38 @@ void __init psci_init(void)
>                 psci_ops.migrate = psci_migrate;
>         }
>
> +       if (!of_property_read_u32(np, "affinity_info", &id)) {
> +               psci_function_id[PSCI_FN_AFFINITY_INFO] = PSCI_ID_AFFINITY_INFO;
> +               psci_ops.affinity_info = psci_affinity_info;
> +       }
> +
> +       if (!of_property_read_u32(np, "migrate_info_type", &id)) {
> +               psci_function_id[PSCI_FN_MIGRATE_INFO_TYPE]
> +                       = PSCI_ID_MIGRATE_INFO_TYPE;
> +               psci_ops.migrate_info_type = psci_migrate_info_type;
> +       }

These 2 functions don't exist for 0.1.

> +
>  out_put_node:
>         of_node_put(np);
> -       return;
> +       return err;
> +}
> +
> +static const struct of_device_id psci_of_match[] __initconst = {
> +       { .compatible = "arm,psci", .data = psci_of_init},
> +       { .compatible = "arm,psci-0.2", .data = psci_static_init},

"of" and "static" don't really describe the difference here. Use
something like psci_init_0_1 and psci_init_0_2.

> +       {},
> +};
> +
> +int __init psci_init(void)
> +{
> +       struct device_node *np;
> +       const struct of_device_id *matched_np;
> +       psci_initcall_t init_fn;
> +
> +       np = of_find_matching_node_and_match(NULL, psci_of_match, &matched_np);
> +       if (!np)
> +               return -ENODEV;
> +
> +       init_fn = (psci_initcall_t)matched_np->data;
> +       return init_fn(np);
>  }
> diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
> index 4f97db3..61b7871 100644
> --- a/arch/arm64/kernel/psci.c
> +++ b/arch/arm64/kernel/psci.c

Same comments apply to this file.

> @@ -18,6 +18,7 @@
>  #include <linux/init.h>
>  #include <linux/of.h>
>  #include <linux/smp.h>
> +#include <uapi/linux/psci.h>
>
>  #include <asm/compiler.h>
>  #include <asm/cpu_ops.h>
> @@ -40,17 +41,23 @@ struct psci_operations {
>         int (*cpu_off)(struct psci_power_state state);
>         int (*cpu_on)(unsigned long cpuid, unsigned long entry_point);
>         int (*migrate)(unsigned long cpuid);
> +       int (*affinity_info)(unsigned long target_affinity,
> +                       unsigned long lowest_affinity_level);
> +       int (*migrate_info_type)(void);
>  };
>
>  static struct psci_operations psci_ops;
>
>  static int (*invoke_psci_fn)(u64, u64, u64, u64);
> +typedef int (*psci_initcall_t)(const struct device_node *);
>
>  enum psci_function {
>         PSCI_FN_CPU_SUSPEND,
>         PSCI_FN_CPU_ON,
>         PSCI_FN_CPU_OFF,
>         PSCI_FN_MIGRATE,
> +       PSCI_FN_AFFINITY_INFO,
> +       PSCI_FN_MIGRATE_INFO_TYPE,
>         PSCI_FN_MAX,
>  };
>
> @@ -128,6 +135,18 @@ static noinline int __invoke_psci_fn_smc(u64 function_id, u64 arg0, u64 arg1,
>         return function_id;
>  }
>
> +#define PSCI_VER_MAJOR_MASK            0xffff0000
> +#define PSCI_VER_MINOR_MASK            0x0000ffff
> +#define PSCI_VER_MAJOR_SHIFT   16
> +
> +static int psci_get_version(void)
> +{
> +       int err;
> +
> +       err = invoke_psci_fn(PSCI_ID_VERSION, 0, 0, 0);
> +       return err;
> +}
> +
>  static int psci_cpu_suspend(struct psci_power_state state,
>                             unsigned long entry_point)
>  {
> @@ -171,26 +190,99 @@ static int psci_migrate(unsigned long cpuid)
>         return psci_to_linux_errno(err);
>  }
>
> -static const struct of_device_id psci_of_match[] __initconst = {
> -       { .compatible = "arm,psci",     },
> -       {},
> -};
> +static int psci_affinity_info(unsigned long target_affinity,
> +               unsigned long lowest_affinity_level)
> +{
> +       int err;
> +       u32 fn;
>
> -int __init psci_init(void)
> +       fn = psci_function_id[PSCI_FN_AFFINITY_INFO];
> +       err = invoke_psci_fn(fn, target_affinity, lowest_affinity_level, 0);
> +       return err;
> +}
> +
> +static int psci_migrate_info_type(void)
> +{
> +       int err;
> +       u32 fn;
> +
> +       fn = psci_function_id[PSCI_FN_MIGRATE_INFO_TYPE];
> +       err = invoke_psci_fn(fn, 0, 0, 0);
> +       return err;
> +}
> +
> +/*
> + * PSCI Function IDs for v0.2+ are well defined so use
> + * standard values.
> + */
> +static int psci_static_init(struct device_node *np)
>  {
> -       struct device_node *np;
>         const char *method;
> -       u32 id;
>         int err = 0;
> +       int ver = 0;
>
> -       np = of_find_matching_node(NULL, psci_of_match);
> -       if (!np)
> -               return -ENODEV;
> +       pr_info("probing for conduit method from DT.\n");
> +
> +       if (of_property_read_string(np, "method", &method)) {
> +               pr_warn("missing \"method\" property\n");
> +               err = -ENXIO;
> +               goto out_put_node;
> +       }
> +
> +       if (!strcmp("hvc", method)) {
> +               invoke_psci_fn = __invoke_psci_fn_hvc;
> +       } else if (!strcmp("smc", method)) {
> +               invoke_psci_fn = __invoke_psci_fn_smc;
> +       } else {
> +               pr_warn("invalid \"method\" property: %s\n", method);
> +               err = -EINVAL;
> +               goto out_put_node;
> +       }
> +
> +       ver = psci_get_version();
> +
> +       pr_info("PSCIv%d.%d detected in firmware.\n",
> +                       (ver & PSCI_VER_MAJOR_MASK) >> PSCI_VER_MAJOR_SHIFT,
> +                       (ver & PSCI_VER_MINOR_MASK));
> +
> +       pr_info("Using standard PSCI v0.2 function IDs\n");
> +       psci_function_id[PSCI_FN_CPU_SUSPEND] = PSCI_ID_CPU_SUSPEND;
> +       psci_ops.cpu_suspend = psci_cpu_suspend;
> +
> +       psci_function_id[PSCI_FN_CPU_OFF] = PSCI_ID_CPU_OFF;
> +       psci_ops.cpu_off = psci_cpu_off;
> +
> +       psci_function_id[PSCI_FN_CPU_ON] = PSCI_ID_CPU_ON;
> +       psci_ops.cpu_on = psci_cpu_on;
> +
> +       psci_function_id[PSCI_FN_MIGRATE] = PSCI_ID_CPU_MIGRATE;
> +       psci_ops.migrate = psci_migrate;
> +
> +       psci_function_id[PSCI_FN_AFFINITY_INFO] = PSCI_ID_AFFINITY_INFO;
> +       psci_ops.affinity_info = psci_affinity_info;
> +
> +       psci_function_id[PSCI_FN_MIGRATE_INFO_TYPE] = PSCI_ID_MIGRATE_INFO_TYPE;
> +       psci_ops.migrate_info_type = psci_migrate_info_type;
> +
> +out_put_node:
> +       of_node_put(np);
> +       return err;
> +}
> +
> +/*
> + * PSCI < v0.2 can override PSCI function IDs via DT.
> + */
> +static int psci_of_init(struct device_node *np)
> +{
> +       const char *method;
> +       u32 id;
> +       int err = 0;
> +       int ver = 0;
>
>         pr_info("probing function IDs from device-tree\n");
>
>         if (of_property_read_string(np, "method", &method)) {
> -               pr_warning("missing \"method\" property\n");
> +               pr_warn("missing \"method\" property\n");
>                 err = -ENXIO;
>                 goto out_put_node;
>         }
> @@ -200,11 +292,17 @@ int __init psci_init(void)
>         } else if (!strcmp("smc", method)) {
>                 invoke_psci_fn = __invoke_psci_fn_smc;
>         } else {
> -               pr_warning("invalid \"method\" property: %s\n", method);
> +               pr_warn("invalid \"method\" property: %s\n", method);
>                 err = -EINVAL;
>                 goto out_put_node;
>         }
>
> +       ver = psci_get_version();
> +
> +       pr_info("PSCIv%d.%d detected in firmware.\n",
> +                       (ver & PSCI_VER_MAJOR_MASK) >> PSCI_VER_MAJOR_SHIFT,
> +                       (ver & PSCI_VER_MINOR_MASK));
> +
>         if (!of_property_read_u32(np, "cpu_suspend", &id)) {
>                 psci_function_id[PSCI_FN_CPU_SUSPEND] = id;
>                 psci_ops.cpu_suspend = psci_cpu_suspend;
> @@ -225,11 +323,43 @@ int __init psci_init(void)
>                 psci_ops.migrate = psci_migrate;
>         }
>
> +       if (!of_property_read_u32(np, "affinity_info", &id)) {
> +               psci_function_id[PSCI_FN_AFFINITY_INFO] = PSCI_ID_AFFINITY_INFO;
> +               psci_ops.affinity_info = psci_affinity_info;
> +       }
> +
> +       if (!of_property_read_u32(np, "migrate_info_type", &id)) {
> +               psci_function_id[PSCI_FN_MIGRATE_INFO_TYPE]
> +                       = PSCI_ID_MIGRATE_INFO_TYPE;
> +               psci_ops.migrate_info_type = psci_migrate_info_type;
> +       }
> +
>  out_put_node:
>         of_node_put(np);
>         return err;
>  }
>
> +static const struct of_device_id psci_of_match[] __initconst = {
> +       { .compatible = "arm,psci",     .data = psci_of_init},
> +       { .compatible = "arm,psci-0.2", .data = psci_static_init},
> +       {},
> +};
> +
> +int __init psci_init(void)
> +{
> +       struct device_node *np;
> +       const struct of_device_id *matched_np;
> +       psci_initcall_t init_fn;
> +
> +       np = of_find_matching_node_and_match(NULL, psci_of_match, &matched_np);
> +
> +       if (!np)
> +               return -ENODEV;
> +
> +       init_fn = (psci_initcall_t)matched_np->data;
> +       return init_fn(np);
> +}
> +
>  #ifdef CONFIG_SMP
>
>  static int __init cpu_psci_cpu_init(struct device_node *dn, unsigned int cpu)
> diff --git a/include/uapi/linux/psci.h b/include/uapi/linux/psci.h
> new file mode 100644
> index 0000000..b271e9a
> --- /dev/null
> +++ b/include/uapi/linux/psci.h
> @@ -0,0 +1,45 @@
> +/*

Linaro copyright?

> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + */
> +
> +#ifndef _UAPI_LINUX_PSCI_H
> +#define _UAPI_LINUX_PSCI_H
> +
> +/* PSCI Function IDs for ARM32 as per PSCI spec v0.2 */
> +#ifdef CONFIG_ARM_PSCI
> +#define PSCI_ID_VERSION                                0x84000000
> +#define PSCI_ID_CPU_SUSPEND                    0x84000001
> +#define PSCI_ID_CPU_OFF                                0x84000002
> +#define PSCI_ID_CPU_ON                         0x84000003
> +#define PSCI_ID_AFFINITY_INFO          0x84000004
> +#define PSCI_ID_CPU_MIGRATE                    0x84000005
> +#define PSCI_ID_MIGRATE_INFO_TYPE      0x84000006
> +#define PSCI_ID_MIGRATE_INFO_UP_CPU    0x84000007
> +#define PSCI_ID_SYSTEM_OFF                     0x84000008
> +#define PSCI_ID_SYSTEM_RESET           0x84000009
> +#endif
> +
> +/* PSCI Function IDs for ARM64 as per PSCI spec v0.2 */
> +#ifdef CONFIG_ARM64

You don't need ifdefs here. The 32-bit calls are valid on arm64 as
that is what 32-bit guests will use. Just do something like this:

#define PSCI_ID_VERSION                                0x84000000
#define PSCI_ID_CPU_SUSPEND_32                    0x84000001
#define PSCI_ID_CPU_SUSPEND_64                    0xc4000001


> +#define PSCI_ID_VERSION                                0x84000000
> +#define PSCI_ID_CPU_SUSPEND                    0xc4000001
> +#define PSCI_ID_CPU_OFF                                0x84000002
> +#define PSCI_ID_CPU_ON                         0xc4000003
> +#define PSCI_ID_AFFINITY_INFO          0xc4000004
> +#define PSCI_ID_CPU_MIGRATE                    0xc4000005
> +#define PSCI_ID_MIGRATE_INFO_TYPE      0x84000006
> +#define PSCI_ID_MIGRATE_INFO_UP_CPU    0xc4000007
> +#define PSCI_ID_SYSTEM_OFF                     0x84000008
> +#define PSCI_ID_SYSTEM_RESET           0x84000009
> +#endif
> +
> +#endif /* _UAPI_LINUX_PSCI_H */
> --
> 1.8.3.2
>
