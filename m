From: steve.capper@linaro.org (Steve Capper)
Date: Thu, 27 Mar 2014 10:01:24 +0000
Subject: [PATCH V2 0/3] PTE fixes for arm and arm64
In-Reply-To: <20140326134803.GA7528@n2100.arm.linux.org.uk>
References: <1393328334-27285-1-git-send-email-steve.capper@linaro.org>
 <20140326102317.GA26040@linaro.org>
 <20140326110141.GY7528@n2100.arm.linux.org.uk>
 <20140326132318.GA30750@linaro.org>
 <20140326134803.GA7528@n2100.arm.linux.org.uk>
Message-ID: <20140327100123.GA28156@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 26, 2014 at 01:48:03PM +0000, Russell King - ARM Linux wrote:
> On Wed, Mar 26, 2014 at 01:23:19PM +0000, Steve Capper wrote:
> > On Wed, Mar 26, 2014 at 11:01:41AM +0000, Russell King - ARM Linux wrote:
> > > On Wed, Mar 26, 2014 at 10:23:19AM +0000, Steve Capper wrote:
> > > > If there are no objections, I was going to put the following into
> > > > Russell's patch system:
> > > > 	arm: mm: Double logical invert for pte accessors
> > > > 	arm: mm: Switch back to L_PTE_WRITE
> > > 
> > > I'm not all that happy with double inversions - I think they just serve
> > > to cause confusion (and it was confusing, which is why I removed it.)
> > > I'll only take them if you have a really good reason why you want to
> > > bring it back.
> > 
> > Hi Russell,
> > The problem I'm trying to solve is for LPAE, where we have flags in the
> > upper 32 bits of a page table entry that are tested for with a bitwise
> > and, then subsequently downcast by a store to 32-bit integer:
> > 
> > 	gather_stats(page, md, pte_dirty(*pte), 1);
> > and,
> > 
> > 	static inline unsigned long huge_pte_write(pte_t pte)
> > 	{
> > 		return pte_write(pte);
> > 	}
> > 
> > (and other cases that may arise in future).
> 
> I think I have already said that these cases should be dealt with by
> ensuring that they return sensible values in such cases.  The official
> return type for pte_write() and pte_dirty() if they aren't a macro is
> "int", and that makes a 64-bit AND operation returning a bit set in
> the high 32-bits incorrect behaviour.
> 
> So, the return value from all these functions must fit within "int" and
> be of the appropriate true/false indication according to C rules depending
> on the test.
> 
> While we can use the shortcut of doing a 32-bit AND to test a bit in the
> 32-bit case, we can't use this with LPAE nor 64-bit PTEs where "int" is
> not 64-bit - in that case, these functions must adjust the value
> appropriately.
> 
> > I had tried to create a helper macro, pte_isset, but this didn't attract
> > any positive comments:
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2014-February/235380.html
> 
> It imposes overhead for _everyone_ whether they need that overhead or not.
> 
> The problem with !!value is that the compiler has to generate more code
> to convert "value" into a one-or-zero in /every/ case, because by doing
> that, you've told the compiler not "I want a true/false" value but "I
> want a one or zero value".  So, what you end up with in the 32-bit case
> is:
> 
> 	load pte
> 	test pte bit
> 	set another register to 0 if test was zero
> 	set register to 1 if test was non-zero
> 	test register for zero or non-zero
> 	... do something ...
> 
> which is rather inefficient when you're doing that lots of times.  As I
> say, we only need this if the bit being tested is not representable
> within 32-bit.
> 
> So, rather than:
> 
> +#define pte_isset(pte, val)    (!!(pte_val(pte) & (val)))
> 
> maybe:
> 
> #define pte_isset(pte, val) ((u32)(val) == (val) ? pte_val(pte) & (val) : !!(pte_val(pte) & (val)))
> 
> What this says is, if the bit fits within 32-bit, use our existing logic,
> otherwise use the new logic.  Since "val" will always be a constant, the
> compiler should be able to optimise this, completely eliminating one or
> other branches.  It would be worth checking the assembly from the above
> on 32-bit LPAE, because the compiler will probably do a 64-bit test even
> for values which fit in 32-bit - this may create even better code:
> 
> #define pte_isset(pte, val) ((u32)(val) == (val) ? (u32)pte_val(pte) & (u32)(val) : !!(pte_val(pte) & (val)))
> 
> but again, it needs the assembly read to work out how it behaves.
> 
> Also, it may be worth considering a pte_isclear() macro, since we don't
> need the logic in that case - it can just be a plain and simple:
> 
> #define pte_isclear(pte, val) (!(pte_val(pte) & (val)))
> 
> since we always need the negation.  Again, as per the above, it may be
> better on 32-bit LPAE whether a similar trick here would be worth it -
> there's no point testing both halves of a 64-bit register pair when you
> know that one half is always zero.

Thanks Russell,
I will get a pte_isset and pte_isclear coded up and will look at the
codegen for 32/64 bit ptes.

Cheers,
-- 
Steve
