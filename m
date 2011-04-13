From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 12 Apr 2011 23:31:16 -0400 (EDT)
Subject: MT_HIGH_VECTOR mapping set read-only creating illegal access
In-Reply-To: <4DA4F170.4020009@codeaurora.org>
References: <4DA4F170.4020009@codeaurora.org>
Message-ID: <alpine.LFD.2.00.1104122308400.28032@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 12 Apr 2011, Michael Bohan wrote:

> Hi,
> 
> In arch/arm/kernel/traps.c:set_tls() and arch/arm/include/asm/tls.h, some
> configurations allow for a assignment of address 0xffff0ff0. This address
> falls within the MT_HIGH_VECTORS mapping setup in devicemaps_init(). That
> mapping is explicitly made read-only. Thus, the kernel takes a segfault when
> writing in set_tls().

If set_tls() writes to 0xffff0ff0 in your case, then you must have an 
ARM core which is prior ARMv6k.

> It looks like this disparity may have been introduced in this commit:
> 
> commit 36bb94ba36f332de767cfaa3af6a5136435a3a9c
> Author: Russell King <rmk+kernel@arm.linux.org.uk>
> Date:   Tue Nov 16 08:40:36 2010 +0000
> 
>     ARM: pgtable: provide RDONLY page table bit rather than WRITE bit
> 
>     Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> Is there a reason this mapping must be read-only?

It is read-only for user space to prevent user space from messing with 
the vector table.

In the kernel, it is read-only _only_ when CONFIG_CPU_USE_DOMAINS is not 
enabled which may happen with ARMv6k and above.  Otherwise, if you are 
pre ARMv6k, you do use domains, and then the vector page is read-write 
for the kernel.

> Perhaps we could apply write
> access for these special cases only?

I'd rather suggest you investigate what changes you did to your kernel 
tree that would explain the apparent inconsistency in your kernel 
config.


Nicolas
