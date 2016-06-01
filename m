From: shijie.huang@arm.com (Huang Shijie)
Date: Wed, 1 Jun 2016 11:01:35 +0800
Subject: [PATCH 1/2] arm64: mm: dump: make page table dumping reusable
In-Reply-To: <1464702542-24394-2-git-send-email-mark.rutland@arm.com>
References: <1464702542-24394-1-git-send-email-mark.rutland@arm.com>
 <1464702542-24394-2-git-send-email-mark.rutland@arm.com>
Message-ID: <20160601030133.GB14411@sha-win-210.asiapac.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 31, 2016 at 02:49:01PM +0100, Mark Rutland wrote:
> For debugging purposes, it would be nice if we could export page tables
> other than the swapper_pg_dir to userspace. To enable this, this patch
> refactors the arm64 page table dumping code such that multiple tables
> may be registered with the framework, and exported under debugfs.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Laura Abbott <labbott@fedoraproject.org>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/include/asm/ptdump.h | 44 +++++++++++++++++++++++++++++++++++++++++
>  arch/arm64/mm/dump.c            | 32 +++++++++++++++++++-----------
>  2 files changed, 64 insertions(+), 12 deletions(-)
>  create mode 100644 arch/arm64/include/asm/ptdump.h
>
> diff --git a/arch/arm64/include/asm/ptdump.h b/arch/arm64/include/asm/ptdump.h
> new file mode 100644
> index 0000000..07b8ed0
> --- /dev/null
> +++ b/arch/arm64/include/asm/ptdump.h
> @@ -0,0 +1,44 @@
> +/*
> + * Copyright (C) 2014 ARM Ltd.
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
> +#ifndef __ASM_PTDUMP_H
> +#define __ASM_PTDUMP_H
> +
> +#ifdef CONFIG_ARM64_PTDUMP
> +
> +#include <linux/mm_types.h>
> +
> +struct addr_marker {
> +     unsigned long start_address;
> +     char *name;
> +};
> +
> +struct ptdump_info {
> +     struct mm_struct                *mm;
> +     const struct addr_marker        *markers;
> +     unsigned long                   base_addr;
> +     unsigned long                   max_addr;
> +};
> +
> +int ptdump_register(struct ptdump_info *info, const char *name);
Since we export this to other page tables,  I guess the @base_addr in the ptdump_info{} may not equal to
the VA_START. But the current dump.c does _NOT_ use the @start address been
passed in, it use the 0 as the start address for the walk_pgd/walk_pud/walk_pmd/walk_pte.
It is wrong in logic, since the start address is VA_START, the code gets
the right result coincidentally.

thanks
Huang Shijie
IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
