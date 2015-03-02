From: will.deacon@arm.com (Will Deacon)
Date: Mon, 2 Mar 2015 17:29:39 +0000
Subject: [PATCH v3 8/9] ACPI: arm64: use an arch-specific ACPI _OSI
 method and ACPI blacklist
In-Reply-To: <1424824585-6405-9-git-send-email-al.stone@linaro.org>
References: <1424824585-6405-1-git-send-email-al.stone@linaro.org>
 <1424824585-6405-9-git-send-email-al.stone@linaro.org>
Message-ID: <20150302172939.GC7919@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Al,

On Wed, Feb 25, 2015 at 12:36:24AM +0000, al.stone at linaro.org wrote:
> diff --git a/arch/arm64/kernel/acpi-blacklist.c b/arch/arm64/kernel/acpi-blacklist.c
> new file mode 100644
> index 0000000..1be6a56
> --- /dev/null
> +++ b/arch/arm64/kernel/acpi-blacklist.c
> @@ -0,0 +1,20 @@
> +/*
> + *  ARM64 Specific ACPI Blacklist Support
> + *
> + *  Copyright (C) 2015, Linaro Ltd.
> + *	Author: Al Stone <al.stone@linaro.org>
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License version 2 as
> + *  published by the Free Software Foundation.
> + */
> +
> +#define pr_fmt(fmt) "ACPI: " fmt
> +
> +#include <linux/acpi.h>
> +
> +/* The arm64 ACPI blacklist is currently empty.  */
> +int __init acpi_blacklisted(void)
> +{
> +	return 0;
> +}
> diff --git a/arch/arm64/kernel/acpi-osi.c b/arch/arm64/kernel/acpi-osi.c
> new file mode 100644
> index 0000000..bb351f4
> --- /dev/null
> +++ b/arch/arm64/kernel/acpi-osi.c
> @@ -0,0 +1,25 @@
> +/*
> + *  ARM64 Specific ACPI _OSI Support
> + *
> + *  Copyright (C) 2015, Linaro Ltd.
> + *	Author: Al Stone <al.stone@linaro.org>
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License version 2 as
> + *  published by the Free Software Foundation.
> + */
> +
> +#define pr_fmt(fmt) "ACPI: " fmt
> +
> +#include <linux/acpi.h>
> +
> +/*
> + * Consensus is to deprecate _OSI for all new ACPI-supported architectures.
> + * So, for arm64, reduce _OSI to a warning message, and tell the firmware
> + * nothing of value.
> + */
> +u32 acpi_osi_handler(acpi_string interface, u32 supported)
> +{
> +	pr_warn("_OSI was called, but is deprecated for this architecture.\n");
> +	return false;
> +}

This kinda feels backwards to me. If _OSI is going away, then the default
should be "the architecture doesn't need to do anything", rather than have
new architectures defining a bunch of empty, useless stub code.

Anyway we could make this the default in core code and have architectures
that *do* want _OSI override that behaviour, instead of the other way around?

Cheers,

Will
