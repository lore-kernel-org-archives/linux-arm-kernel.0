From: cdall@linaro.org (Christoffer Dall)
Date: Wed, 2 Aug 2017 14:48:04 +0200
Subject: [PATCH 3/6] kvm: arm64: Convert kvm_set_s2pte_readonly() from
 inline asm to cmpxchg()
In-Reply-To: <20170802091536.xqhy7vcsamoa46ah@armageddon.cambridge.arm.com>
References: <20170725135308.18173-1-catalin.marinas@arm.com>
 <20170725135308.18173-4-catalin.marinas@arm.com>
 <20170801111618.GC5176@cbox>
 <20170802091536.xqhy7vcsamoa46ah@armageddon.cambridge.arm.com>
Message-ID: <20170802124804.GL5176@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 02, 2017 at 10:15:36AM +0100, Catalin Marinas wrote:
> Hi Christoffer,
> 
> On Tue, Aug 01, 2017 at 01:16:18PM +0200, Christoffer Dall wrote:
> > On Tue, Jul 25, 2017 at 02:53:05PM +0100, Catalin Marinas wrote:
> > > +	pteval_t old_pteval, pteval;
> > > +
> > > +	do {
> > > +		pteval = old_pteval = READ_ONCE(pte_val(*pte));
> > > +		pteval &= ~PTE_S2_RDWR;
> > > +		pteval |= PTE_S2_RDONLY;
> > > +	} while (cmpxchg_relaxed(&pte_val(*pte), old_pteval, pteval) !=
> > > +		 old_pteval);
> > 
> > I'm wondering if the READ_ONCE for old_pteval is strictly necessary, or
> > if that's really for the pteval.  Actually, I'm a little unsure whether
> > this is equivalent to
> > 
> > 	old_pteval = READ_ONCE(pte_val(*pte));
> > 	pteval = old_pteval;
> > 
> > or
> > 
> > 	old_pteval = READ_ONCE(pte_val(*pte));
> > 	pteval = READ_ONCE(pte_val(*pte));
> > 
> > I think it's the former, which I also think is correct,
> 
> I think so too.
> 
> > but the reason
> > I'm going down this road is that we have a use of cmpxchg() in the VGIC
> > code, which doesn't use READ_ONCE for the old value (~
> > vgic-mmio-v3.c:404), and I also found other occurences of this in the
> > kernel, so I'm wondering if the VGIC code is broken or we're being
> > overly careful here, or if this is necessary because hardware can update
> > the value behind our backs in this case?
> 
> We use it because the compiler may decide it's short on registers and
> instead of saving old_pteval on the stack it reads it again from memory
> just before cmpxchg, so we would miss any update to *pte done by the
> hardware. In practice, I've never seen (on arm64) gcc generating two
> loads to *pte without READ_ONCE but maybe I haven't tried hard enough.
> 
> We should probably fix the VGIC code as well as a precaution, just in
> case the compiler tries to get smarter in the future.
> 

Sounds like a plan, I'll cook up a patch.

Thanks,
-Christoffer
