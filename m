From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 20 Jun 2014 19:17:48 +0100
Subject: [PATCH V4 2/2] arm: mm: Switch back to L_PTE_WRITE
In-Reply-To: <1402929159-11028-3-git-send-email-steve.capper@linaro.org>
References: <1402929159-11028-1-git-send-email-steve.capper@linaro.org>
 <1402929159-11028-3-git-send-email-steve.capper@linaro.org>
Message-ID: <20140620181748.GW32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 16, 2014 at 03:32:39PM +0100, Steve Capper wrote:
> For LPAE, we have the following means for encoding writable or dirty
> ptes:
>                               L_PTE_DIRTY       L_PTE_RDONLY
>     !pte_dirty && !pte_write        0               1
>     !pte_dirty && pte_write         0               1
>     pte_dirty && !pte_write         1               1
>     pte_dirty && pte_write          1               0
> 
> So we can't distinguish between writable clean ptes and read only
> ptes. This can cause problems with ptes being incorrectly flagged as
> read only when they are writable but not dirty.
> 
> This patch re-introduces the L_PTE_WRITE bit for both short descriptors
> and long descriptors, by reverting
>   36bb94b ARM: pgtable: provide RDONLY page table bit rather than WRITE bit

Why are we still going about this in this over complicated manner?
I'm not happy with this.  I thought after fixing the problem with
using bits above bit 32 that we could drop this silly conversion
which makes the code harder to read.

Right, let's get down to the detail.  LPAE has it's existing bit
which tells it that the mapping is read only.  This is bit 7, which
is the AP[2] bit.

At present, AP[2] is mapped to L_PTE_RDONLY.  When a PTE is set, the
3-level page table code in proc-v7-3level.S checks the L_PTE_DIRTY
bit, and if that is clear, it sets L_PTE_RDONLY.  *This* is the
problem you're trying to solve.

You are solving that by adding L_PTE_WRITE as bit 58 on LPAE, and
then translating bit 58 _and_ the L_PTE_DIRTY state down to a
read-only status for the hardware in AP[2], and rolling the change
to make L_PTE_WRITE apply everywhere.

Now, in patch 1, we solve the problem that using high bits in the
PTE result in the return value being down-cast to zero.  So, with
patch 1 in place, we can use *any* bit in the PTE to correspond
with any of the L_PTE_* flags.  Remember this very important point:
L_PTE_* flags are the *Linux* representation of the page table state,
which may not necessarily be the state of the hardware (it isn't on
2-level systems - there's a translation that this stuff goes through.)

So, what I say is why not, for the troublesome 3-level case:

- Assign bit 58 for L_PTE_RDONLY
- Convert the state of bit 58 and L_PTE_DIRTY to the AP[2] bit:

	ubfx	ip, rh, #(58 - 32)		@ L_PTE_RDONLY
	bfi	rl, ip, #7, #1			@ PTE_AP2
        tst     rh, #1 << (55 - 32)             @ L_PTE_DIRTY
        orreq   rl, #PTE_AP2

This means we keep the read-only terminology, which is much more
understandable when reading the assembly code than what we had when
we used the write terminology.

-- 
FTTC broadband for 0.8mile line: now@9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
