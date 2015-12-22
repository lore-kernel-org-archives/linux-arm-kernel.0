From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 22 Dec 2015 17:08:06 +0000
Subject: [PATCH v6 17/20] arm64: ilp32: introduce ilp32-specific handlers
 for sigframe
In-Reply-To: <1450215766-14765-18-git-send-email-ynorov@caviumnetworks.com>
References: <1450215766-14765-1-git-send-email-ynorov@caviumnetworks.com>
 <1450215766-14765-18-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <20151222170806.GC1302@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 16, 2015 at 12:42:43AM +0300, Yury Norov wrote:
> diff --git a/arch/arm64/kernel/entry_ilp32.S b/arch/arm64/kernel/entry_ilp32.S
> new file mode 100644
> index 0000000..424060f
> --- /dev/null
> +++ b/arch/arm64/kernel/entry_ilp32.S
> @@ -0,0 +1,32 @@
> +/*
> + * ILP32 system call wrappers
> + *
> + * Copyright (C) 2015 Cavium Networks.
> + * Author: Yury Norov <ynorov@caviumnetworks.com>
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
> +#include <linux/linkage.h>
> +#include <linux/const.h>
> +
> +#include <asm/assembler.h>
> +#include <asm/asm-offsets.h>
> +#include <asm/errno.h>
> +#include <asm/page.h>
> +
> +ENTRY(ilp32_sys_rt_sigreturn_wrapper)
> +	mov	x0, sp
> +	b	ilp32_sys_rt_sigreturn
> +ENDPROC(ilp32_sys_rt_sigreturn_wrapper)

Do you need all these header includes?

> diff --git a/arch/arm64/kernel/signal_ilp32.c b/arch/arm64/kernel/signal_ilp32.c
> new file mode 100644
> index 0000000..d38434b
> --- /dev/null
> +++ b/arch/arm64/kernel/signal_ilp32.c
> @@ -0,0 +1,126 @@
> +/*
> + * Based on arch/arm/kernel/signal.c
> + *
> + * Copyright (C) 2015 Cavium Networks.

And missing extra copyright lines.

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
> +{
> +	struct ilp32_rt_sigframe __user *frame;
> +
> +	/* Always make any pending restarted system calls return -EINTR */
> +	current->restart_block.fn = do_no_restart_syscall;
> +
> +	/*
> +	 * Since we stacked the signal on a 64-bit boundary,
> +	 * then 'sp' should be word aligned here.  If it's
> +	 * not, then the user is trying to mess with us.
> +	 */

The stack alignment is still 128-bit even with ILP32 (architecture
requirement).

> +	if (regs->sp & 15)
> +		goto badframe;

The check here is correct though.

-- 
Catalin
