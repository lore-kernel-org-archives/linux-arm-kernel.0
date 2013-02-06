From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 6 Feb 2013 12:33:07 +0000
Subject: [PATCH v4] ARM: LPAE: Fix mapping in alloc_init_pte for
 unaligned addresses
In-Reply-To: <20130206122213.GF17833@n2100.arm.linux.org.uk>
References: <1359472036-7613-1-git-send-email-r.sricharan@ti.com>
 <20130201162631.GG5151@arm.com>
 <CANOGCgOp=kSatDu8fL7grk+bXLQ2pgKAEvEK6LoG8Ba4mqUH=w@mail.gmail.com>
 <20130201163722.GH5151@arm.com>
 <CANOGCgMbzEWpJQE8PH2nS9_wa0DP_14E4=whGgKxWGJ_HpwomQ@mail.gmail.com>
 <20130201174246.GJ5151@arm.com> <510F3BA8.8070700@ti.com>
 <510F3CA3.7080604@ti.com> <20130206121523.GD26454@arm.com>
 <20130206122213.GF17833@n2100.arm.linux.org.uk>
Message-ID: <20130206123307.GE26454@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 06, 2013 at 12:22:13PM +0000, Russell King - ARM Linux wrote:
> On Wed, Feb 06, 2013 at 12:15:23PM +0000, Catalin Marinas wrote:
> > The problem with the classic MMU is that if we have a 1MB range we can
> > end up with just page mappings. The code is currently buggy since if we
> > have create_mapping() for a 1MB range and later create_mapping() for a
> > 4KB in the next MB, the first 1MB is removed.
> 
> And that is where we rely on people calling create_mapping() - who
> will be the SoC porters - not to be idiotic and do that kind of thing.
> That's worked fine for the last 10+ years so there's no need to make
> the code any more complex by trying to fix something that really isn't
> a problem.
> 
> I wouldn't be surprised if we have some mappings which are created by
> 4K page tables, and then one half of the page table is overwritten by
> a section mapping - so trying to fix this _may_ be risky.

If the 4K is called first, it should be fine. But some WARN_ON() calls
wouldn't hurt, just to be sure. It's not a fast path anyway.

-- 
Catalin
