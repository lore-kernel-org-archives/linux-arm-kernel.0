From: rob.herring@linaro.org (Rob Herring)
Date: Fri, 28 Mar 2014 08:54:03 -0500
Subject: [PATCH v3 1/3] PSCI: Add initial support for PSCIv0.2 functions
In-Reply-To: <1395955430-26050-2-git-send-email-ashwin.chaugule@linaro.org>
References: <1395955430-26050-1-git-send-email-ashwin.chaugule@linaro.org>
 <1395955430-26050-2-git-send-email-ashwin.chaugule@linaro.org>
Message-ID: <CABGGisyMn6uuFOwcS3AfBX3c85fwore_TeBq68opmJqQPyR7wQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 27, 2014 at 4:23 PM, Ashwin Chaugule
<ashwin.chaugule@linaro.org> wrote:
> The PSCIv0.2 spec defines standard values of function IDs
> and introduces a few new functions. Detect version of PSCI
> and appropriately select the right PSCI functions.

Looks pretty good. A few minor things below.

[snip]

> @@ -110,6 +109,21 @@ static noinline int __invoke_psci_fn_smc(u32 function_id, u32 arg0, u32 arg1,
>         return function_id;
>  }
>
> +#define PSCI_VER_MAJOR_MASK            0xffff0000
> +#define PSCI_VER_MINOR_MASK            0x0000ffff
> +#define PSCI_VER_MAJOR_SHIFT   16
> +#define PSCI_VER_MAJOR(ver)            \
> +       ((ver & PSCI_VER_MAJOR_MASK) >> PSCI_VER_MAJOR_SHIFT)
> +#define PSCI_VER_MINOR(ver)            (ver & PSCI_VER_MINOR_MASK)

This can go in the header.

[snip]

> +       ver = psci_get_version();
> +
> +       pr_info("PSCIv%d.%d detected in firmware.\n", PSCI_VER_MAJOR(ver),
> +                       PSCI_VER_MINOR(ver));
> +
> +       if (PSCI_VER_MAJOR(ver) == 0 && PSCI_VER_MINOR(ver) < 2) {

So we want to allow 0.3, but not 1.x? I think we want to allow any
later version. Later versions either have to be backward's compatible
with 0.2 or have to not have "arm,psci-0.2" compatible string.

Does this work if ver is an error value? We may have implementations
that failed to implement this function (which should not be ignored
for now).

>                 err = -EINVAL;
> +               pr_err("Conflicting PSCI version detected.\n");
>                 goto out_put_node;
>         }

[snip]

> diff --git a/include/uapi/linux/psci.h b/include/uapi/linux/psci.h
> new file mode 100644
> index 0000000..c523051
> --- /dev/null
> +++ b/include/uapi/linux/psci.h
> @@ -0,0 +1,40 @@
> +/*
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
> + *     Copyright (C) 2014, Ashwin Chaugule <ashwin.chaugule@linaro.org>

I believe this should be:

Copyright (C) 2014 Linaro Ltd.
Author: Ashwin Chaugule <ashwin.chaugule@linaro.org>

And typically the copyright is placed above the license.

> + */
> +
> +#ifndef _UAPI_LINUX_PSCI_H
> +#define _UAPI_LINUX_PSCI_H
> +
> +/* PSCI Function IDs as per PSCI spec v0.2 */
> +#define PSCI_ID_VERSION                                        0x84000000
> +#define PSCI_ID_CPU_SUSPEND_32                 0x84000001
> +#define PSCI_ID_CPU_SUSPEND_64                 0xc4000001
> +#define PSCI_ID_CPU_OFF                                        0x84000002
> +#define PSCI_ID_CPU_ON_32                              0x84000003
> +#define PSCI_ID_CPU_ON_64                              0xC4000003
> +#define PSCI_ID_AFFINITY_INFO_32               0x84000004
> +#define PSCI_ID_AFFINITY_INFO_64               0xC4000004
> +#define PSCI_ID_CPU_MIGRATE_32                 0x84000005
> +#define PSCI_ID_CPU_MIGRATE_64                 0xc4000005
> +#define PSCI_ID_MIGRATE_INFO_TYPE              0x84000006
> +#define PSCI_ID_MIGRATE_INFO_UP_CPU_32 0x84000007
> +#define PSCI_ID_MIGRATE_INFO_UP_CPU_64 0xc4000007
> +#define PSCI_ID_SYSTEM_OFF                             0x84000008
> +#define PSCI_ID_SYSTEM_RESET                   0x84000009
> +
> +#define PSCI_RET_SUCCESS               0
> +#define PSCI_RET_EOPNOTSUPP            -1
> +#define PSCI_RET_EINVAL                        -2
> +#define PSCI_RET_EPERM                 -3

Please fill out all error codes.

> +
> +#endif /* _UAPI_LINUX_PSCI_H */
> --
> 1.8.3.2
>
