From: will.deacon@arm.com (Will Deacon)
Date: Mon, 26 Nov 2018 14:21:54 +0000
Subject: [PATCH 03/10] arm64: add <asm/export.h>
In-Reply-To: <20181105130649.29429-4-mark.rutland@arm.com>
References: <20181105130649.29429-1-mark.rutland@arm.com>
 <20181105130649.29429-4-mark.rutland@arm.com>
Message-ID: <20181126142154.GB29684@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 05, 2018 at 01:06:42PM +0000, Mark Rutland wrote:
> So that we can export symbols directly from assembly files, let's make
> use of the generic <asm/export.h>. We have a few symbols that we'll want
> to conditionally export for !KASAN kernel builds, so we add a helepr for
> that.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/include/asm/export.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>  create mode 100644 arch/arm64/include/asm/export.h
> 
> diff --git a/arch/arm64/include/asm/export.h b/arch/arm64/include/asm/export.h
> new file mode 100644
> index 000000000000..d7a82246816e
> --- /dev/null
> +++ b/arch/arm64/include/asm/export.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef __ASM_EXPORT_H
> +#define __ASM_EXPORT_H
> +#include <asm-generic/export.h>
> +
> +#ifdef CONFIG_KASAN
> +#define EXPORT_SYMBOL_NOKASAN(name)
> +#else
> +#define EXPORT_SYMBOL_NOKASAN(name)	EXPORT_SYMBOL(name)
> +#endif
> +
> +#endif /* __ASM_EXPORT_H */

It feels a bit OTT to create a new arch header for this. Could we either
put it in the core code, or move it into asm/assembler.h instead?

Will
