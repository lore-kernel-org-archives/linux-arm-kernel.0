From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 19 Oct 2018 12:15:43 +0100
Subject: [PATCH v5 07/17] arm64: add basic pointer authentication support
In-Reply-To: <20181005084754.20950-8-kristina.martsenko@arm.com>
References: <20181005084754.20950-1-kristina.martsenko@arm.com>
 <20181005084754.20950-8-kristina.martsenko@arm.com>
Message-ID: <20181019111542.6wrvjguirglzg7vg@mbp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 05, 2018 at 09:47:44AM +0100, Kristina Martsenko wrote:
> diff --git a/arch/arm64/include/asm/pointer_auth.h b/arch/arm64/include/asm/pointer_auth.h
> new file mode 100644
> index 000000000000..2aefedc31d9e
> --- /dev/null
> +++ b/arch/arm64/include/asm/pointer_auth.h
> @@ -0,0 +1,63 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#ifndef __ASM_POINTER_AUTH_H
> +#define __ASM_POINTER_AUTH_H
> +
> +#include <linux/random.h>
> +
> +#include <asm/cpufeature.h>
> +#include <asm/sysreg.h>
> +
> +#ifdef CONFIG_ARM64_PTR_AUTH
> +/*
> + * Each key is a 128-bit quantity which is split across a pair of 64-bit
> + * registers (Lo and Hi).
> + */
> +struct ptrauth_key {
> +	unsigned long lo, hi;
> +};
> +
> +/*
> + * We give each process its own instruction A key (APIAKey), which is shared by
> + * all threads. This is inherited upon fork(), and reinitialised upon exec*().
> + * All other keys are currently unused, with APIBKey, APDAKey, and APBAKey
> + * instructions behaving as NOPs.
> + */

I don't remember the past discussions but I assume the tools guys are ok
with a single key shared by multiple threads. Ramana, could you ack this
part, FTR?

(and it would help if someone from the Android and Chrome camps can
confirm)

Thanks.

-- 
Catalin
