From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 29 Apr 2015 15:40:32 +0100
Subject: [PATCH v7 1/5] arm64: Enable EDAC on ARM64
In-Reply-To: <1430259045-19012-2-git-send-email-lho@apm.com>
References: <1430259045-19012-1-git-send-email-lho@apm.com>
 <1430259045-19012-2-git-send-email-lho@apm.com>
Message-ID: <20150429144031.GB18867@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 28, 2015 at 04:10:41PM -0600, Loc Ho wrote:
> --- /dev/null
> +++ b/arch/arm64/include/asm/edac.h
> @@ -0,0 +1,31 @@
> +/*
> + * ARM64 EDAC Header File 
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +#ifndef ASM_EDAC_H
> +#define ASM_EDAC_H

For consistency, please use __ASM_EDAC_H.

> +/*
> + * ECC atomic, DMA, SMP and interrupt safe scrub function.
> + * Implements the per arch atomic_scrub() that EDAC use for software
> + * ECC scrubbing.  It reads memory and then writes back the original
> + * value, allowing the hardware to detect and correct memory errors.
> + */

The comment here is misleading since the function doesn't do anything.

> +static inline void atomic_scrub(void *va, u32 size)
> +{
> +	/* Stub function for now until an ARM64 HW has a way to test it. */
> +}

Can we have a WARN_ONCE() here?

We had some discussions last year, restarted this year and the
conclusion was to leave this function as a no-op since it is not safe in
the presence of KVM or non-coherent DMA:

http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/326986.html

-- 
Catalin
