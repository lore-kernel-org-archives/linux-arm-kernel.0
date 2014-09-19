From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 19 Sep 2014 18:28:48 +0100
Subject: [PATCH v6] arm64: fix VTTBR_BADDR_MASK
In-Reply-To: <20140919152853.GH2295@e104818-lin.cambridge.arm.com>
References: <20140908230852.2118.97400.stgit@joelaarch64.amd.com>
 <20140919152853.GH2295@e104818-lin.cambridge.arm.com>
Message-ID: <20140919172846.GA12331@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 19, 2014 at 04:28:54PM +0100, Catalin Marinas wrote:
> On Tue, Sep 09, 2014 at 12:08:52AM +0100, Joel Schopp wrote:
> > The current VTTBR_BADDR_MASK only masks 39 bits, which is broken on current
> > systems.  Rather than just add a bit it seems like a good time to also set
> > things at run-time instead of compile time to accomodate more hardware.
> > 
> > This patch sets TCR_EL2.PS, VTCR_EL2.T0SZ and vttbr_baddr_mask in runtime,
> > not compile time.
> > 
> > In ARMv8, EL2 physical address size (TCR_EL2.PS) and stage2 input address
> > size (VTCR_EL2.T0SZE) cannot be determined in compile time since they
> > depend on hardware capability.
> > 
> > According to Table D4-23 and Table D4-25 in ARM DDI 0487A.b document,
> > vttbr_x is calculated using different fixed values with consideration
> > of T0SZ, granule size and the level of translation tables. Therefore,
> > vttbr_baddr_mask should be determined dynamically.
> 
> So I agree with vttbr_baddr_mask being determined dynamically. I also
> agree with setting TCR_EL2.PS at run-time but the VTCR_EL2.T0SZ
> determines the input of the stage 2 translation. That's a KVM
> configuration about what IPA size it provides to the guests (and
> platform model it intends to support) and it doesn't need to be the same
> as the physical address range.
[...]
> > -#define VTTBR_BADDR_SHIFT (VTTBR_X - 1)
> > -#define VTTBR_BADDR_MASK  (((1LLU << (40 - VTTBR_X)) - 1) << VTTBR_BADDR_SHIFT)

Actually, after some more thinking, why don't we just make the upper
limit of this mask 48-bit always or even 64-bit. That's a physical mask
for checking whether the pgd pointer in vttbr is aligned as per the
architecture requirements. Given that the pointer is allocated from the
platform memory, it's clear that it is within the PA range. So basically
you just need a mask to check the bottom alignment based on
VTCR_EL2.T0SZ (which should be independent from the PA range). I guess
it should be enough as:

#define VTTBR_BADDR_MASK  (~0ULL << VTTBR_BADDR_SHIFT)

without any other changes to T0SZ.

The TCR_EL2.PS setting should be done based on the ID_A64MMFR0_EL1
but you can do this in __do_hyp_init (it looks like this function
handles VTCR_EL2.PS already, not sure why it does do it for TCR_EL2 as
well).

So IMO you only need about a few lines patch.

-- 
Catalin
