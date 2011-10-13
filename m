From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 13 Oct 2011 19:14:15 +0100
Subject: [PATCH v4 0/4] genirq: handling GIC per-cpu interrupts
In-Reply-To: <1317661446-2876-1-git-send-email-marc.zyngier@arm.com>
References: <1317661446-2876-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20111013181415.GM21648@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 03, 2011 at 06:04:02PM +0100, Marc Zyngier wrote:
> The current GIC per-cpu interrupts (aka PPIs) suffer from a number of
> problems:
> 
> - They use a completely separate scheme to handle the interrupts,
>   mostly because the PPI concept doesn't really match the kernel view
>   of an interrupt.
> - PPIs can only be used by the timer code, unless we add more low-level
>   assembly code.
> - The local timer code can only be used by devices generating PPIs,
>   and not SPIs.
> - At least one platform (msm) has started implementing its own
>   alternative scheme.
> - Some low-level code gets duplicated, as usual...
> 
> The proposed solution is to handle the PPIs using the same path as
> SPIs. A new core API is added to deal with per-cpu interrupts in a
> less awkward way. The local timer code is updated to reflect these
> changes.
> 
> The core API changes are based on an initial idea by Thomas Gleixner.
> 
> Tested on ARM Versatile Express (Cortex A15), ARM RealView PB11MP,
> OMAP4 (Panda) and Tegra (Harmony). Patch series against next-20110930.
> 
> The two first patches can also be found in Thomas' tree:
> 
> 	git://tesla.tglx.de/git/linux-2.6-tip irq/core

So, how do we deal with merging this without ending up with some
problematical inter-tree dependencies?

It looks like I'll see conflicts with:
arch/arm/common/gic.c
arch/arm/kernel/smp.c
arch/arm/include/asm/localtimer.h

and possibly:
arch/arm/include/asm/smp.h
arch/arm/kernel/irq.c

as well.  I've not checked with patch 4, so there may be some more too.

Some of this is probably because of 7123/1 and 7124/1.
