From: will.deacon@arm.com (Will Deacon)
Date: Wed, 8 Jun 2011 21:23:23 +0100
Subject: [PATCH] ARM: mm: ensure TTBR0 is restored when changing ASID
	on rollover
In-Reply-To: <20110608200106.GA13151@n2100.arm.linux.org.uk>
References: <1307443118-11573-1-git-send-email-will.deacon@arm.com>
	<20110608200106.GA13151@n2100.arm.linux.org.uk>
Message-ID: <20110608202323.GA4430@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Thanks for replying to this.

On Wed, Jun 08, 2011 at 09:01:06PM +0100, Russell King - ARM Linux wrote:
> On Tue, Jun 07, 2011 at 11:38:38AM +0100, Will Deacon wrote:
> > Russell - I've reposted this to the list because it somehow got lost in
> > the archive and you've expressed some concerns over the code via the
> > patch system. I think the only opportunity for a race is when a CPU
> > doing switch_mm is interrupted by a rollover event occurring on another
> > core, but this is something that exists in the current code anyway and
> > is not affected by this patch.
> 
> However, these patches are introducing a brand new race between the
> switch_mm code and the reset_context code.
> 
> With the new switch_mm() code, we switch TTBR0 to be the same as TTBR1.
> If we then receive an IPI for reset_context(), we will change TTBR0
> to point at a set of page tables which don't contain just global mappings.
> 
> After returning from reset_context(), we will resume switch_mm(), and
> change the ASID value with the page tables pointing to non-global
> mappings, violating the whole reason for the switch_mm() change.

Whilst this is a new race condition, it is analagous to the one we have already
and could be fixed at the same time.

> The only way around this is to make reset_context() preserve the TTBR0
> value across itself, by reading it initially and then restoring before
> returning.

I don't think this is safe. The reset_context() broadcast could interrupt us
at a time where current_mm has been updated during context switch, but TTBR0
still contains the page tables of the previous mm. If we blindly save and
restore the value from the hardware, we could end up setting the wrong ASID and
then we're back to square one.

> So, even though the current code is broken, I'm not applying this patch
> as it isn't anywhere near right - and we can do right quite easily here.

I think the easiest fix is to go with my original proposal of disabling
interrupts during switch_mm. Then this patch will work as intended and we'll
eliminate the original race too. Since the interrupts need only be disabled for
SMP systems, it won't affect any platforms with VIVT D-caches, where interupts
should be left enabled while the cache is flushed.

Any ideas?

Will
