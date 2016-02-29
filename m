From: schwab@suse.de (Andreas Schwab)
Date: Mon, 29 Feb 2016 09:27:43 +0100
Subject: [PATCH v6 17/21] arm64: ilp32: introduce ilp32-specific handlers
 for sigframe
In-Reply-To: <1452792198-10718-18-git-send-email-ynorov@caviumnetworks.com>
 (Yury Norov's message of "Thu, 14 Jan 2016 20:23:14 +0300")
References: <1452792198-10718-1-git-send-email-ynorov@caviumnetworks.com>
 <1452792198-10718-18-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <mvmoaazudj4.fsf@hawking.suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Yury Norov <ynorov@caviumnetworks.com> writes:

> diff --git a/arch/arm64/kernel/signal_ilp32.c b/arch/arm64/kernel/signal_ilp32.c
> new file mode 100644
> index 0000000..b635a21
> --- /dev/null
> +++ b/arch/arm64/kernel/signal_ilp32.c
> @@ -0,0 +1,128 @@
> +/*
> + * Based on arch/arm/kernel/signal.c
> + *
> + * Copyright (C) 1995-2009 Russell King
> + * Copyright (C) 2012 ARM Ltd.
> + * Copyright (C) 2016 Cavium Networks.
> + * Yury Norov <ynorov@caviumnetworks.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include <linux/compat.h>
> +#include <linux/signal.h>
> +#include <linux/syscalls.h>
> +#include <linux/ratelimit.h>
> +
> +#include <asm/esr.h>
> +#include <asm/fpsimd.h>
> +#include <asm/signal32_common.h>
> +#include <asm/signal_common.h>
> +#include <asm/uaccess.h>
> +#include <asm/unistd.h>
> +#include <asm/ucontext.h>
> +
> +struct ilp32_rt_sigframe {
> +	struct compat_siginfo info;
> +	struct sigframe sig;
> +};
> +
> +asmlinkage int ilp32_sys_rt_sigreturn(struct pt_regs *regs)

This function must be defined to return long, lest you truncate the
return value of the interrupted syscall.

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab at suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
