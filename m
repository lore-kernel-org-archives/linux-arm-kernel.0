From: christoffer.dall@arm.com (Christoffer Dall)
Date: Sun, 29 Apr 2018 16:00:28 +0200
Subject: [PATCH] arm64: vgic-v2: Fix proxying of cpuif access
In-Reply-To: <20180429140507.60bfe2dc@why.wild-wind.fr.eu.org>
References: <20180427145102.5645-1-marc.zyngier@arm.com>
 <20180429123432.GA7512@C02W217FHV2R.local>
 <20180429140507.60bfe2dc@why.wild-wind.fr.eu.org>
Message-ID: <20180429140028.GA7760@C02W217FHV2R.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 29, 2018 at 02:05:07PM +0100, Marc Zyngier wrote:
> On Sun, 29 Apr 2018 14:34:32 +0200
> Christoffer Dall <christoffer.dall@arm.com> wrote:
> 
> > On Fri, Apr 27, 2018 at 03:51:02PM +0100, Marc Zyngier wrote:
> > > Proxying the cpuif accesses at EL2 makes use of vcpu_data_guest_to_host
> > > and co, which check the endianness, which call into vcpu_read_sys_reg...
> > > which isn't mapped at EL2 (it was inlined before, and got moved OoL
> > > with the VHE optimizations).  
> > 
> > I thought we relied on static inline functions to always be inlined, but
> > apparently not?  Does this mean we have potential other bugs looming
> > depending on the mood of the compiler, or was there something special
> > that went wrong here?
> 
> We do rely on that behaviour. And that was the case until you moved
> vcpu_read_sys_reg() to be entirely out of line (see d47533dab9f5).

ah, now I see, kvm_vcpu_is_be() calls vcpu_read_sys_reg(), I somehow
missed this even though you spelled it out in the commit message.
Sorry.

> 
> At that point, kvm_vcpu_is_be() becomes a death trap.
> 
> We missed it for two reasons:
> - It was only indirectly called, making it quite hard to notice the
>   potential breakage
> - Nobody gives a damn about 64k pages, specially on something like Juno
> 
> What we'd need is a way to find cross-section calls (text -> hyp-text
> should allowed, but not the reverse). We already have similar things in
> the kernel, it is probably only a matter of reusing the infrastructure
> for our own purpose.
> 

That would be good indeed...

Thanks for the further explanation.
-Christoffer
