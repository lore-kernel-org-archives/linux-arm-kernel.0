From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 14 Mar 2014 10:16:11 +0000
Subject: [PATCH] arm64: Add ARCH_HAS_SG_CHAIN
In-Reply-To: <53225261.7080608@codeaurora.org>
References: <1394732963-12174-1-git-send-email-lauraa@codeaurora.org>
 <20140313180105.GG25472@mudshark.cambridge.arm.com>
 <53225261.7080608@codeaurora.org>
Message-ID: <20140314101608.GA18126@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 14, 2014 at 12:50:41AM +0000, Laura Abbott wrote:
> On 3/13/2014 11:01 AM, Will Deacon wrote:
> > On Thu, Mar 13, 2014 at 05:49:23PM +0000, Laura Abbott wrote:
> >> It's useful to be able to chain scatterlists together for very large
> >> scatter allocations. Define ARCH_HAS_SG_CHAIN to let this happen.
> >>
> >> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
> >> ---
> >>   arch/arm64/include/asm/scatterlist.h | 21 +++++++++++++++++++++
> >>   1 file changed, 21 insertions(+)
> >>   create mode 100644 arch/arm64/include/asm/scatterlist.h
> >>
> >> diff --git a/arch/arm64/include/asm/scatterlist.h b/arch/arm64/include/asm/scatterlist.h
> >> new file mode 100644
> >> index 0000000..7b2602a
> >> --- /dev/null
> >> +++ b/arch/arm64/include/asm/scatterlist.h
> >> @@ -0,0 +1,21 @@
> >> +/*
> >> + * Copyright (c) 2014, The Linux Foundation. All rights reserved.
> >> + *
> >> + * This program is free software; you can redistribute it and/or modify
> >> + * it under the terms of the GNU General Public License version 2 and
> >> + * only version 2 as published by the Free Software Foundation.
> >> + *
> >> + * This program is distributed in the hope that it will be useful,
> >> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> >> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> >> + * GNU General Public License for more details.
> >> + */
> >> +
> >> +#ifndef __ASM_SCATTERLIST_H
> >> +#define __ASM_SCATTERLIST_H
> >> +
> >> +#include <asm-generic/scatterlist.h>
> >> +
> >> +#define ARCH_HAS_SG_CHAIN
> >
> > Hmm, I wonder if this should be a Kconfig option instead, to avoid the need
> > for the dummy header?
> 
> Yeah, it does seem non-standard at this point. Something like the
> following perhaps?
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 1594945..8122294 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -82,6 +82,7 @@ config ARM
>   	  <http://www.arm.linux.org.uk/>.
> 
>   config ARM_HAS_SG_CHAIN
> +	select ARCH_HAS_SG_CHAIN
>   	bool
> 
>   config NEED_SG_DMA_LENGTH
> diff --git a/arch/arm/include/asm/scatterlist.h 
> b/arch/arm/include/asm/scatterlist.h
> index cefdb8f..2f87870 100644
> --- a/arch/arm/include/asm/scatterlist.h
> +++ b/arch/arm/include/asm/scatterlist.h
> @@ -1,10 +1,6 @@
>   #ifndef _ASMARM_SCATTERLIST_H
>   #define _ASMARM_SCATTERLIST_H
> 
> -#ifdef CONFIG_ARM_HAS_SG_CHAIN
> -#define ARCH_HAS_SG_CHAIN
> -#endif
> -
>   #include <asm/memory.h>
>   #include <asm/types.h>
>   #include <asm-generic/scatterlist.h>

For most architectures, you can remove this file entirely and place

generic-y += scatterlist.h

in arch/*/include/asm/Kbuild.

It would result in some nice negative diffstat.

> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 27bbcfc..f2f95f4 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -2,6 +2,7 @@ config ARM64
>   	def_bool y
>   	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
>   	select ARCH_USE_CMPXCHG_LOCKREF
> +	select ARCH_HAS_SG_CHAIN
>   	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
>   	select ARCH_WANT_OPTIONAL_GPIOLIB
>   	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION

This would be a new feature in a clean-up patch. I don't mind if they go
together, you can add my ack for the arm64 part.

-- 
Catalin
