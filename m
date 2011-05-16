From: frank.hofmann@tomtom.com (Frank Hofmann)
Date: Mon, 16 May 2011 10:19:56 +0100 (BST)
Subject: [PATCH 1/1] ARM: thumb: Fix thumb mode compilation problems.
In-Reply-To: <mailman.25075.1305321854.1534.linux-arm-kernel@lists.infradead.org>
References: <mailman.25075.1305321854.1534.linux-arm-kernel@lists.infradead.org>
Message-ID: <alpine.DEB.2.00.1105161007520.7161@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Message: 2
> Date: Fri, 13 May 2011 12:58:58 -0700 (PDT)
> From: vbendeb at google.com (Vadim Bendebury)
> To: linux-arm-kernel at lists.infradead.org
> Subject: [PATCH 1/1] ARM: thumb: Fix thumb mode compilation problems.
> Message-ID: <20110513195858.3C00140CD1@eskimo.mtv.corp.google.com>
>
> ARM: thumb: Fix thumb mode compilation problems.
>
> This change has not been tested in this tree (other than
> verifying compilation/linking success in both Thumb2 and regular
> modes).
>
> It was however tested in a Chromium OS tree
> (http://www.chromium.org/chromium-os). The latest fiq.c version
> of the Chromium OS is the same as arm.linux.org.uk, so the patch
> applies as is, headsmp.S is different, but the patch applies the
> same.
>
> Signed-off-by: Vadim Bendebury <vbendeb@chromium.org>
> ---
[ ... ]
> diff --git a/arch/arm/mach-tegra/headsmp.S b/arch/arm/mach-tegra/headsmp.S
> index b5349b2..bcbfbab 100644
> --- a/arch/arm/mach-tegra/headsmp.S
> +++ b/arch/arm/mach-tegra/headsmp.S
> @@ -48,7 +48,8 @@ ENTRY(v7_invalidate_l1)
> ENDPROC(v7_invalidate_l1)
>
> ENTRY(tegra_secondary_startup)
> -	msr	cpsr_fsxc, #0xd3
> +	mov     r0, #0xd3
> +	msr     cpsr_fsxc, r0
>         bl      v7_invalidate_l1
> 	mrc	p15, 0, r0, c0, c0, 5
>         and	r0, r0, #15

Just a nit:
Hardcoded hex for CPSR contents ... can't this be made readable:

 	#include <asm/ptrace.h>
 	...
 	mov	r0, #(MODE_SVC | PSR_F_BIT | PSR_I_BIT)
 	...

Or are there very specifiy restrictions for headsmp.S that prevent the use 
of include files ?

FrankH.
