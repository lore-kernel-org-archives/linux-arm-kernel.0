From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sun, 29 Apr 2018 14:05:07 +0100
Subject: [PATCH] arm64: vgic-v2: Fix proxying of cpuif access
In-Reply-To: <20180429123432.GA7512@C02W217FHV2R.local>
References: <20180427145102.5645-1-marc.zyngier@arm.com>
 <20180429123432.GA7512@C02W217FHV2R.local>
Message-ID: <20180429140507.60bfe2dc@why.wild-wind.fr.eu.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 29 Apr 2018 14:34:32 +0200
Christoffer Dall <christoffer.dall@arm.com> wrote:

> On Fri, Apr 27, 2018 at 03:51:02PM +0100, Marc Zyngier wrote:
> > Proxying the cpuif accesses at EL2 makes use of vcpu_data_guest_to_host
> > and co, which check the endianness, which call into vcpu_read_sys_reg...
> > which isn't mapped at EL2 (it was inlined before, and got moved OoL
> > with the VHE optimizations).  
> 
> I thought we relied on static inline functions to always be inlined, but
> apparently not?  Does this mean we have potential other bugs looming
> depending on the mood of the compiler, or was there something special
> that went wrong here?

We do rely on that behaviour. And that was the case until you moved
vcpu_read_sys_reg() to be entirely out of line (see d47533dab9f5).

At that point, kvm_vcpu_is_be() becomes a death trap.

We missed it for two reasons:
- It was only indirectly called, making it quite hard to notice the
  potential breakage
- Nobody gives a damn about 64k pages, specially on something like Juno

What we'd need is a way to find cross-section calls (text -> hyp-text
should allowed, but not the reverse). We already have similar things in
the kernel, it is probably only a matter of reusing the infrastructure
for our own purpose.

> > The result is of course a nice panic. Let's add some specialized
> > cruft to keep the broken platforms that require this hack alive.
> > I'd rather kill BE support, but hey, just in case...
> > 
> > Fixes: d47533dab9f5 ("KVM: arm64: Introduce framework for accessing deferred sysregs")
> > Reported-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> > Tested-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> > Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>  
> 
> Otherwise:
> 
> Reviewed-by: Christoffer Dall <christoffer.dall@arm.com>

Thanks,

	M.
-- 
Without deviation from the norm, progress is not possible.
