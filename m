From: leo.yan@linaro.org (Leo Yan)
Date: Tue, 19 Jan 2016 23:13:00 +0800
Subject: [PATCH 1/4] arm64: dts: Reserve memory regions for hi6220
In-Reply-To: <20160118154258.GP21067@leverpostej>
References: <CAL_Jsq+TrsS39L4nsRgqszTxKHyc00fLUf+BmftHnn=EV0PxhA@mail.gmail.com>
 <20151009142034.GB528@leoy-linaro>
 <CAL_JsqLhu03B_ADYvCYdduH2d38kajOyc=9eX_FHy4QYYhZGxQ@mail.gmail.com>
 <20151029083301.GB16063@leoy-linaro>
 <20151105135449.GD27192@leoy-linaro>
 <20151105161315.GE32247@leverpostej>
 <20151106011937.GA5960@leoy-linaro>
 <20160111154027.GC30974@leoy-linaro>
 <CAL_Jsq+BRua=RetZUH9vxCo4WpY436k1vxpp4jZDv=ZjPK42_w@mail.gmail.com>
 <20160118154258.GP21067@leverpostej>
Message-ID: <20160119151300.GE5337@leoy-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Victor as well.

On Mon, Jan 18, 2016 at 03:42:59PM +0000, Mark Rutland wrote:

[...]

> > While I still think regions should be marked as reserved rather than
> > carving up the memory node, it's not really worth holding up this
> > platform further. The kernel can support either way.
> > 
> > However, Mark's argument AIUI was regions that are never accessed
> > should be done the way you have done it. I don't think the mailbox
> > region falls in this category. I'm not sure about OP-TEE, but we
> > should have consistency for it if the OP-TEE driver needs to find its
> > memory region. Cc'ing Joakim for comment.
> 
> My understanding was that the OP-TEE memory was that reserved for use by
> the secure side (rather than a shared region). To avoid (non-secure)
> speculative accesses triggering aborts from some trustzone controller,
> and other issues, no memory reserved for secure side use should be
> mapped by the non-secure side, and hence a memreserve is insufficient.
> Hopefully Joakim can shed light on that.

I checked with Victor and OP-TEE memory region is reserved for below
purpose:

3f00,0000 - 3fff,ffff: OP-TEE's execution region
3ef0,0000 - 3eff,ffff: OP-TEE's shared memory, so this region will be
                       mapped both for secure world and normal world.
3e00,0000 - 3eef,ffff: Reserved for future using...

Not sure if this is same with ARM's Juno/TC2 platform? will leave
to Joakim for confirmation.

Here just wander if can directly carve out whole region at one time?
Or should distinguish the regions will be accessed by kernel later and
use different way to reserve them? Especially readed below Mark
brought cache alias issue, the most safe way is totally to avoid
linear mapping.

Thanks,
Leo Yan

> There is a general problem with memreserve in that it is currently
> ill-defined for arm and arm64, and its implications are not well
> understood (by the nature of the ARM cache architecture, and problems
> like mismatched aliases being not well understood). Due to this, I think
> that its use should be avoided unless strictly necessary.
> 
> Having an alias as part of the linear mapping creates a number of
> problems which are avoided most simply by never having that alias (i.e.
> not describing the region as memory at all). Establishing that pattern
> now saves us pain in future.
> 
> One major reason for memreserve being used was to allow the linear
> mapping to be used to access objects. Practically every case has moved
> over to using a dynamic mapping (fixmap, or {io,mem}remap), as that's
> required to handle a number of edge cases.
> 
> For data structures (e.g. the DTB) that are only expected to be accessed
> by the kernel, a memreserve is fine provided sufficient cache
> maintenance has been performed already. For everything else (e.g.
> anything shared with or owned by another agent), its use is questionable
> at best (and I think the spin-table story is an unfortunate mistake that
> we have to live with).
> 
> Thanks,
> Mark.
