From: steve.capper@linaro.org (Steve Capper)
Date: Wed, 26 Mar 2014 13:23:19 +0000
Subject: [PATCH V2 0/3] PTE fixes for arm and arm64
In-Reply-To: <20140326110141.GY7528@n2100.arm.linux.org.uk>
References: <1393328334-27285-1-git-send-email-steve.capper@linaro.org>
 <20140326102317.GA26040@linaro.org>
 <20140326110141.GY7528@n2100.arm.linux.org.uk>
Message-ID: <20140326132318.GA30750@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 26, 2014 at 11:01:41AM +0000, Russell King - ARM Linux wrote:
> On Wed, Mar 26, 2014 at 10:23:19AM +0000, Steve Capper wrote:
> > If there are no objections, I was going to put the following into
> > Russell's patch system:
> > 	arm: mm: Double logical invert for pte accessors
> > 	arm: mm: Switch back to L_PTE_WRITE
> 
> I'm not all that happy with double inversions - I think they just serve
> to cause confusion (and it was confusing, which is why I removed it.)
> I'll only take them if you have a really good reason why you want to
> bring it back.

Hi Russell,
The problem I'm trying to solve is for LPAE, where we have flags in the
upper 32 bits of a page table entry that are tested for with a bitwise
and, then subsequently downcast by a store to 32-bit integer:

	gather_stats(page, md, pte_dirty(*pte), 1);
and,

	static inline unsigned long huge_pte_write(pte_t pte)
	{
		return pte_write(pte);
	}

(and other cases that may arise in future).

We erroneously get false returned in situations where we shouldn't, and
it's tricky to track this down.

My reasoning was that applying double logical inverts to all the pte
accessors that don't already have one ensures that we get values that
are safe to downcast, and this is safe for cases where new accessors
are added and the convention is followed and for where bit layouts are
changed.

I agree that this is confusing (and does look rather ugly), and I would
happily try alternatives.

I had tried to create a helper macro, pte_isset, but this didn't attract
any positive comments:
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-February/235380.html

I tried bool types, but it looked a little too cumbersome to me.

Would the double logical invert be more acceptable if it were better
commented?

Cheers,
-- 
Steve
