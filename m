From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 29 Nov 2012 16:06:44 +0000
Subject: [PATCH v2] ARM: implement optimized percpu variable access
In-Reply-To: <alpine.LFD.2.02.1211291059320.4576@xanadu.home>
References: <1354200764-23751-1-git-send-email-robherring2@gmail.com>
 <alpine.LFD.2.02.1211291039060.4576@xanadu.home>
 <20121129155303.GL19440@n2100.arm.linux.org.uk>
 <alpine.LFD.2.02.1211291059320.4576@xanadu.home>
Message-ID: <20121129160643.GM19440@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 29, 2012 at 11:02:39AM -0500, Nicolas Pitre wrote:
> On Thu, 29 Nov 2012, Russell King - ARM Linux wrote:
> 
> > On Thu, Nov 29, 2012 at 10:45:50AM -0500, Nicolas Pitre wrote:
> > > On Thu, 29 Nov 2012, Rob Herring wrote:
> > > > Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> > > > Acked-by: Will Deacon <will.deacon@arm.com>
> > > 
> > > With the above, and moving the call to cpu_init() after the call to 
> > > cpu_switch_mm(mm->pgd, mm) to fix Will's concerns (personally I'd put it 
> > > right after local_flush_tlb_all())... 
> > 
> > You're confused.  We were suggesting before the printk().
> > 
> > The reasoning is: printk() is not guaranteed not to access per-cpu
> > variables, so it needs to be before the first printk.  It can't be
> > before cpu_switch_mm(), and putting it before the TLB flush does
> > _not_ guarantee that TLB/MMU isn't going to still be seeing the
> > strongly-ordered attribute - so it _must_ be after the TLB flush.
> 
> But isn't that what I wrote above?  I said "personally I'd put it right 
> after local_flush_tlb_all()".

No it isn't.  No one was suggesting putting it after cpu_switch_mm() in
this thread other than your statement above.  _That_ is what provoked
me into replying because it was wrong and needed to be corrected before
we got a patch doing exactly that.
