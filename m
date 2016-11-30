From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 30 Nov 2016 16:27:22 +0000
Subject: [sample] A sample program for MRS emulation
In-Reply-To: <1480518901-18544-11-git-send-email-suzuki.poulose@arm.com>
References: <1480518901-18544-1-git-send-email-suzuki.poulose@arm.com>
 <1480518901-18544-11-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20161130162720.GN1574@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 30, 2016 at 03:15:01PM +0000, Suzuki K Poulose wrote:
> Here is a sample program which demonstrates how to use mrs
> emulation to fetch the ID registers.

Are we planning to add this in Documentation/?  If so, we might want
some tweaks (noted below).

> 
> ----8>----
> /*
>  * Sample program to demonstrate the MRS emulation
>  * ABI.

overwrapped?

>  * Copyright (C) 2015-2016, ARM Ltd
>  *
>  * Author: Suzuki K Poulose <suzuki.poulose@arm.com>
>  *
>  * This program is free software; you can redistribute it and/or modify
>  * it under the terms of the GNU General Public License version 2 as
>  * published by the Free Software Foundation.
>  *
>  * This program is distributed in the hope that it will be useful,
>  * but WITHOUT ANY WARRANTY; without even the implied warranty of
>  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>  * GNU General Public License for more details.
>  * This program is free software; you can redistribute it and/or modify
>  * it under the terms of the GNU General Public License version 2 as
>  * published by the Free Software Foundation.
>  *
>  * This program is distributed in the hope that it will be useful,
>  * but WITHOUT ANY WARRANTY; without even the implied warranty of
>  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>  * GNU General Public License for more details.
>  */
> 
> #include <stdio.h>
> 
> #define get_cpu_ftr(id) ({					\
> 		unsigned long long __val;			\
> 		asm("mrs %0, "#id : "=r" (__val));		\
> 		printf("%-20s: 0x%016lx\n", #id, __val);	\
> 	})
> 
> int main()

(void)

> {

We don't wan't people using the MRS emulation without checking for its
availability first.

Something like this may work (untested), with the caveat that getauxval()
is a GNU libc extension, and other environments may require a different
mechanism to obtain the hwcaps.

--8<--

#include <sys/auxv.h>
#include <asm/hwcap.h>

/* ... */

	if (!getauxval(AT_HWCAP) & HWCAP_CPUID) {
		fputs("CPUID registers unavailable\n", stderr);
		return 1;
	}

-->8--

Cheers
---Dave

> 
> 	get_cpu_ftr(ID_AA64ISAR0_EL1);
> 	get_cpu_ftr(ID_AA64ISAR1_EL1);
> 	get_cpu_ftr(ID_AA64MMFR0_EL1);
> 	get_cpu_ftr(ID_AA64MMFR1_EL1);
> 	get_cpu_ftr(ID_AA64PFR0_EL1);
> 	get_cpu_ftr(ID_AA64PFR1_EL1);
> 	get_cpu_ftr(ID_AA64DFR0_EL1);
> 	get_cpu_ftr(ID_AA64DFR1_EL1);
> 
> 	get_cpu_ftr(MIDR_EL1);
> 	get_cpu_ftr(MPIDR_EL1);
> 	get_cpu_ftr(REVIDR_EL1);
> 	return 0;
> }
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
