From: rob.herring@linaro.org (Rob Herring)
Date: Tue, 1 Apr 2014 23:22:22 -0500
Subject: [PATCH v6 02/12] ARM/ARM64: KVM: Add common header for PSCI
 related defines
In-Reply-To: <1396262773-7723-3-git-send-email-anup.patel@linaro.org>
References: <1396262773-7723-1-git-send-email-anup.patel@linaro.org>
 <1396262773-7723-3-git-send-email-anup.patel@linaro.org>
Message-ID: <CABGGisyGCCCfd4jC5nDyG3-8FKm2pxwLB_E+_UOz0E0itxaiHQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 31, 2014 at 5:46 AM, Anup Patel <anup.patel@linaro.org> wrote:
> We need a common place to share PSCI related defines among ARM kernel,
> ARM64 kernel, KVM ARM/ARM64 PSCI emulation, and user space.
>
> We introduce uapi/linux/psci.h for this purpose. This newly added
> header will be first used by KVM ARM/ARM64 in-kernel PSCI emulation
> and user space (i.e. QEMU or KVMTOOL).
>
> Signed-off-by: Anup Patel <anup.patel@linaro.org>
> Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
> ---
>  include/uapi/linux/Kbuild |    1 +
>  include/uapi/linux/psci.h |   55 +++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 56 insertions(+)
>  create mode 100644 include/uapi/linux/psci.h
>
> diff --git a/include/uapi/linux/Kbuild b/include/uapi/linux/Kbuild
> index 6929571..24e9033 100644
> --- a/include/uapi/linux/Kbuild
> +++ b/include/uapi/linux/Kbuild
> @@ -317,6 +317,7 @@ header-y += ppp-ioctl.h
>  header-y += ppp_defs.h
>  header-y += pps.h
>  header-y += prctl.h
> +header-y += psci.h
>  header-y += ptp_clock.h
>  header-y += ptrace.h
>  header-y += qnx4_fs.h
> diff --git a/include/uapi/linux/psci.h b/include/uapi/linux/psci.h
> new file mode 100644
> index 0000000..41f727e
> --- /dev/null
> +++ b/include/uapi/linux/psci.h
> @@ -0,0 +1,55 @@
> +/*
> + * ARM Power State and Coordination Interface (PSCI) header
> + *
> + * This header holds common PSCI defines and macros shared by:
> + * ARM kernel, ARM64 kernel, KVM ARM/ARM64 and user space.
> + *
> + * Copyright (C) 2014   Anup Patel <anup.patel@linaro.org>

Like I told Ashwin, fix the copyright. You can be the author, but
Linaro is the copyright holder.

> + */
> +
> +#ifndef _UAPI_LINUX_PSCI_H
> +#define _UAPI_LINUX_PSCI_H
> +
> +/* PSCI v0.1 interface */
> +#define PSCI_FN(base, n)                       ((base) + (n))
> +
> +#define PSCI_FN_CPU_SUSPEND(base)              PSCI_FN(base, 0)
> +#define PSCI_FN_CPU_OFF(base)                  PSCI_FN(base, 1)
> +#define PSCI_FN_CPU_ON(base)                   PSCI_FN(base, 2)
> +#define PSCI_FN_MIGRATE(base)                  PSCI_FN(base, 3)
> +
> +/* PSCI v0.2 interface */
> +#define PSCI_0_2_FN_BASE                       0x84000000
> +#define PSCI_0_2_FN(n)                         (PSCI_0_2_FN_BASE + (n))
> +#define PSCI_0_2_FN64_BASE                     0xC4000000
> +#define PSCI_0_2_FN64(n)                       (PSCI_0_2_FN64_BASE + (n))

This could be something like:

#define PSCI_0_2_64BIT       0x40000000
#define PSCI_0_2_FN64(n)    (PSCI_0_2_FN_BASE + PSCI_0_2_64BIT + (n))

It's also useful as you may want to be able to check for 64-bit calls.

> +
> +#define PSCI_0_2_FN_PSCI_VERSION               PSCI_0_2_FN(0)
> +#define PSCI_0_2_FN_CPU_SUSPEND                        PSCI_0_2_FN(1)
> +#define PSCI_0_2_FN_CPU_OFF                    PSCI_0_2_FN(2)
> +#define PSCI_0_2_FN_CPU_ON                     PSCI_0_2_FN(3)
> +#define PSCI_0_2_FN_AFFINITY_INFO              PSCI_0_2_FN(4)
> +#define PSCI_0_2_FN_MIGRATE                    PSCI_0_2_FN(5)
> +#define PSCI_0_2_FN_MIGRATE_INFO_TYPE          PSCI_0_2_FN(6)
> +#define PSCI_0_2_FN_MIGRATE_INFO_UP_CPU                PSCI_0_2_FN(7)
> +#define PSCI_0_2_FN_SYSTEM_OFF                 PSCI_0_2_FN(8)
> +#define PSCI_0_2_FN_SYSTEM_RESET               PSCI_0_2_FN(9)
> +
> +#define PSCI_0_2_FN64_CPU_SUSPEND              PSCI_0_2_FN64(1)
> +#define PSCI_0_2_FN64_CPU_ON                   PSCI_0_2_FN64(3)
> +#define PSCI_0_2_FN64_AFFINITY_INFO            PSCI_0_2_FN64(4)
> +#define PSCI_0_2_FN64_MIGRATE                  PSCI_0_2_FN64(5)
> +#define PSCI_0_2_FN64_MIGRATE_INFO_UP_CPU      PSCI_0_2_FN64(7)
> +
> +/* PSCI return values */
> +#define PSCI_RET_SUCCESS                       0
> +#define PSCI_RET_NOT_SUPPORTED                 ((unsigned long)-1)
> +#define PSCI_RET_INVALID_PARAMS                        ((unsigned long)-2)
> +#define PSCI_RET_DENIED                                ((unsigned long)-3)
> +#define PSCI_RET_ALREADY_ON                    ((unsigned long)-4)
> +#define PSCI_RET_ON_PENDING                    ((unsigned long)-5)
> +#define PSCI_RET_INTERNAL_FAILURE              ((unsigned long)-6)
> +#define PSCI_RET_NOT_PRESENT                   ((unsigned long)-7)
> +#define PSCI_RET_DISABLED                      ((unsigned long)-8)

These should not be cast. The return values are defined to be int32
independent of 64-bit or 32-bit calls.

Rob
