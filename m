From: will.deacon@arm.com (Will Deacon)
Date: Tue, 24 Apr 2018 14:34:49 +0100
Subject: [PATCH] arm64: export tishift functions to modules
In-Reply-To: <20180415160416.28161-1-Jason@zx2c4.com>
References: <20180415160416.28161-1-Jason@zx2c4.com>
Message-ID: <20180424133449.GA24599@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason,

On Sun, Apr 15, 2018 at 06:04:16PM +0200, Jason A. Donenfeld wrote:
> Otherwise modules that use these arithmetic operations will fail to
> link. We accomplish this with EXPORT_SYMBOL in the .S file, but because
> of symbol versioning, we actually need to have a declaration of these
> too in C. So, we introduce asm-prototypes.h, which is the same file name
> and technique used for similar reasons in the m68k arch tree.
> 
> While we're at it, we also fix this up to use SPDX, and I personally
> choose to relicense this as GPL2||BSD so that these symbols don't need
> to be export_symbol_gpl, so all modules can use the routines, since
> these are important general purpose compiler-generated function calls.
> 
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> Reported-by: PaX Team <pageexec@freemail.hu>
> Cc: stable at vger.kernel.org
> ---
>  arch/arm64/include/asm/asm-prototypes.h | 11 +++++++++++
>  arch/arm64/lib/tishift.S                | 19 ++++++-------------
>  2 files changed, 17 insertions(+), 13 deletions(-)
>  create mode 100644 arch/arm64/include/asm/asm-prototypes.h

I've not run into any build issues here -- is this specifically with some
out-of-tree module?

> diff --git a/arch/arm64/include/asm/asm-prototypes.h b/arch/arm64/include/asm/asm-prototypes.h
> new file mode 100644
> index 000000000000..8f1919e44f51
> --- /dev/null
> +++ b/arch/arm64/include/asm/asm-prototypes.h

It would be better not to introduce a new header file just for this, I
think. How about compiler.h instead?

> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
> + *
> + * Copyright (C) 2017-2018 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
> + */
> +
> +/* These functions are defined in lib/tishift.S, but need to be declared
> + * here so that symbol versioning picks them up.
> + */
> +extern long long __ashlti3(long long a, int b);
> +extern long long __ashrti3(long long a, int b);
> +extern long long __lshrti3(long long a, int b);
> diff --git a/arch/arm64/lib/tishift.S b/arch/arm64/lib/tishift.S
> index d3db9b2cd479..3bca433973cb 100644
> --- a/arch/arm64/lib/tishift.S
> +++ b/arch/arm64/lib/tishift.S
> @@ -1,20 +1,10 @@
> -/*
> - * Copyright (C) 2017 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
> +/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
>   *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + * Copyright (C) 2017-2018 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
>   */
>  
>  #include <linux/linkage.h>
> +#include <asm-generic/export.h>
>  
>  ENTRY(__ashlti3)
>  	cbz	x2, 1f
> @@ -36,6 +26,7 @@ ENTRY(__ashlti3)
>  	mov	x0, x2
>  	ret
>  ENDPROC(__ashlti3)
> +EXPORT_SYMBOL(__ashlti3)

We normally export asm symbols via arm64ksyms.c. In fact, would doing that
remove the need for the explicit declarations completely?

Will
