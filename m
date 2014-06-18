From: will.deacon@arm.com (Will Deacon)
Date: Wed, 18 Jun 2014 18:15:20 +0100
Subject: [PATCHv2 2/4] arm64: cpuinfo: print info for all CPUs
In-Reply-To: <1403024674-25108-3-git-send-email-mark.rutland@arm.com>
References: <1403024674-25108-1-git-send-email-mark.rutland@arm.com>
 <1403024674-25108-3-git-send-email-mark.rutland@arm.com>
Message-ID: <20140618171519.GF17851@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 17, 2014 at 06:04:32PM +0100, Mark Rutland wrote:
> Currently reading /proc/cpuinfo will result in information being read
> out of the MIDR_EL1 of the current CPU, and the information is not
> associated with any particular logical CPU number.
> 
> This is problematic for systems with heterogeneous CPUs (i.e.
> big.LITTLE) where fields will vary across CPUs, and the output will
> differ depending on the executing CPU. Additionally the output is
> different in format to the 32-bit ARM Linux port, where information is
> printed out for each CPU.
> 
> This patch adds the necessary infrastructure to log the relevant
> registers (currently just MIDR_EL1) and print out the logged
> information.

[...]

> diff --git a/arch/arm64/include/asm/cpu.h b/arch/arm64/include/asm/cpu.h
> new file mode 100644
> index 0000000..74bf9bb
> --- /dev/null
> +++ b/arch/arm64/include/asm/cpu.h
> @@ -0,0 +1,30 @@
> +/*
> + *  arch/arm/include/asm/cpu.h
> + *
> + *  Copyright (C) 2004-2014 ARM Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#ifndef __ASM_ARM64_CPU_H
> +#define __ASM_ARM64_CPU_H

We're trying to have a consistent style for these guards, so please use
__ASM_CPU_H here instead. That said, does this actually need to be in a
header file? If you move cpuinfo_store_cpu into setup.c, this structure can
be private to that file, no?

Will
