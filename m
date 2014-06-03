From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 3 Jun 2014 16:11:38 +0200
Subject: TASK_SIZE for !MMU
In-Reply-To: <538DBC3F.9060207@uclinux.org>
References: <20140429100028.GH28564@pengutronix.de>
 <20140602085150.GA31147@pengutronix.de>
 <538DBC3F.9060207@uclinux.org>
Message-ID: <20140603141138.GH16741@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Greg,

thanks for your reply.

On Tue, Jun 03, 2014 at 10:14:55PM +1000, Greg Ungerer wrote:
> >>I think it would be OK to define TASK_SIZE to 0xffffffff for !MMU.
> >>blackfin, frv and m68k also do this. c6x does define it to 0xFFFFF000 to
> >>leave space for error codes.
> 
> I did that same change for m68k in commit cc24c40 ("m68knommu: remove
> size limit on non-MMU TASK_SIZE"). For similar reasons as you need to
> now.
ok.
 
> >>Thoughts?
> >The problem is that current linus/master (and also next) doesn't boot on
> >my ARM-nommu machine because the user string functions (strnlen_user,
> >strncpy_from_user et al.) refuse to work on strings above TASK_SIZE
> >which in my case also includes the XIP kernel image.
> 
> I seem to recall that we were not considering flash or anything else
> other than RAM when defining that original TASK_SIZE (back many, many
> years ago). Some of the address checks you list above made some sense
> if you had everything in RAM (though only upper bounds are checked).
> The thinking was some checking is better than none I suppose.
What is the actual meaning of TASK_SIZE? The maximal value of a valid
userspace address?

> Setting a hard coded memory size in CONFIG_DRAM_SIZE is not all that
> fantastic either...
Not sure what you mean? Having CONFIG_DRAM_SIZE at all or use it for
boundary checking?

CONFIG_DRAM_SIZE is hardly used apart from defining TASK_SIZE:

 - #define END_MEM (UL(CONFIG_DRAM_BASE) + CONFIG_DRAM_SIZE)
   which is only used to define MODULES_END. Ap
 - Some memory configuration using cp15 registers in
   arch/arm/mm/proc-arm{740,940,946}.S

For the former I'd say better use 0xffffffff, too. For the latter I
wonder if we should just drop CPU_ARM740T, CPU_ARM940T and CPU_ARM946E.
These are only selectable if ARCH_INTEGRATOR and are not selected by
other symbols. As ARCH_INTEGRATOR selects ARM_PATCH_PHYS_VIRT since
commit fe9891454473 (ARM: integrator: Default enable
ARM_PATCH_PHYS_VIRT, AUTO_ZRELADDR) for Linux 3.13 and
ARM_PATCH_PHYS_VIRT depends on MMU the Integrator-noMMU targets are
broken anyhow.

I will prepare a patch series with some cleanups.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
