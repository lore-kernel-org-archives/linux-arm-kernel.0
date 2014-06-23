From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 23 Jun 2014 12:17:19 +0100
Subject: [PATCH V4 2/2] arm: mm: Switch back to L_PTE_WRITE
In-Reply-To: <20140620181748.GW32514@n2100.arm.linux.org.uk>
References: <1402929159-11028-1-git-send-email-steve.capper@linaro.org>
 <1402929159-11028-3-git-send-email-steve.capper@linaro.org>
 <20140620181748.GW32514@n2100.arm.linux.org.uk>
Message-ID: <20140623111719.GD15907@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 20, 2014 at 07:17:48PM +0100, Russell King - ARM Linux wrote:
> On Mon, Jun 16, 2014 at 03:32:39PM +0100, Steve Capper wrote:
> > For LPAE, we have the following means for encoding writable or dirty
> > ptes:
> >                               L_PTE_DIRTY       L_PTE_RDONLY
> >     !pte_dirty && !pte_write        0               1
> >     !pte_dirty && pte_write         0               1
> >     pte_dirty && !pte_write         1               1
> >     pte_dirty && pte_write          1               0
> > 
> > So we can't distinguish between writable clean ptes and read only
> > ptes. This can cause problems with ptes being incorrectly flagged as
> > read only when they are writable but not dirty.
> > 
> > This patch re-introduces the L_PTE_WRITE bit for both short descriptors
> > and long descriptors, by reverting
> >   36bb94b ARM: pgtable: provide RDONLY page table bit rather than WRITE bit

[...]

> So, what I say is why not, for the troublesome 3-level case:
> 
> - Assign bit 58 for L_PTE_RDONLY
> - Convert the state of bit 58 and L_PTE_DIRTY to the AP[2] bit:
> 
> 	ubfx	ip, rh, #(58 - 32)		@ L_PTE_RDONLY
> 	bfi	rl, ip, #7, #1			@ PTE_AP2
>         tst     rh, #1 << (55 - 32)             @ L_PTE_DIRTY
>         orreq   rl, #PTE_AP2
> 
> This means we keep the read-only terminology, which is much more
> understandable when reading the assembly code than what we had when
> we used the write terminology.

Good idea. This seems to be even better resulting in a simpler patch.

-- 
Catalin
