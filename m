From: joel.schopp@amd.com (Joel Schopp)
Date: Mon, 22 Sep 2014 10:56:58 -0500
Subject: [PATCH v6] arm64: fix VTTBR_BADDR_MASK
In-Reply-To: <20140919172846.GA12331@e104818-lin.cambridge.arm.com>
References: <20140908230852.2118.97400.stgit@joelaarch64.amd.com>
 <20140919152853.GH2295@e104818-lin.cambridge.arm.com>
 <20140919172846.GA12331@e104818-lin.cambridge.arm.com>
Message-ID: <542046CA.1060508@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


>>> -#define VTTBR_BADDR_SHIFT (VTTBR_X - 1)
>>> -#define VTTBR_BADDR_MASK  (((1LLU << (40 - VTTBR_X)) - 1) << VTTBR_BADDR_SHIFT)
> Actually, after some more thinking, why don't we just make the upper
> limit of this mask 48-bit always or even 64-bit. That's a physical mask
> for checking whether the pgd pointer in vttbr is aligned as per the
> architecture requirements. Given that the pointer is allocated from the
> platform memory, it's clear that it is within the PA range. So basically
> you just need a mask to check the bottom alignment based on
> VTCR_EL2.T0SZ (which should be independent from the PA range). I guess
> it should be enough as:
This sounds fine to me.  I would say that there is no harm in
re-checking the upper bits, but I agree it is unnecessary.

>
> #define VTTBR_BADDR_MASK  (~0ULL << VTTBR_BADDR_SHIFT)
>
> without any other changes to T0SZ.
>
> The TCR_EL2.PS setting should be done based on the ID_A64MMFR0_EL1
> but you can do this in __do_hyp_init (it looks like this function
> handles VTCR_EL2.PS already, not sure why it does do it for TCR_EL2 as
> well).
>
> So IMO you only need about a few lines patch.
>
My original patch to fix this problem was one line, so I'm perfectly
happy with simplification.  But it would be nice if the other reviewers
could agree with this approach.  With six versions that each addressed
all the comments from reviewers I'd like it if the v7 that throws away
most of that feedback didn't result in a v8 that puts it all back again.
