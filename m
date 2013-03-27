From: will.deacon@arm.com (Will Deacon)
Date: Wed, 27 Mar 2013 12:43:52 +0000
Subject: [PATCH 2/3] ARM: cacheflush: don't bother rounding to nearest vma
In-Reply-To: <20130327122159.GE1603@MacBook-Pro.local>
References: <1364235486-17738-1-git-send-email-will.deacon@arm.com>
 <1364235486-17738-3-git-send-email-will.deacon@arm.com>
 <20130327110938.GG801@MacBook-Pro.local>
 <20130327121512.GC17185@mudshark.cambridge.arm.com>
 <20130327122159.GE1603@MacBook-Pro.local>
Message-ID: <20130327124352.GC18429@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 27, 2013 at 12:21:59PM +0000, Catalin Marinas wrote:
> On Wed, Mar 27, 2013 at 12:15:12PM +0000, Will Deacon wrote:
> > On Wed, Mar 27, 2013 at 11:09:38AM +0000, Catalin Marinas wrote:
> > > While this would work, it introduces a possibility of DoS where an
> > > application passes bigger valid range (kernel linear mapping) and the
> > > kernel code would not be preempted (CONFIG_PREEMPT disabled). IIRC,
> > > that's why Russell reject such patch a while back.
> > 
> > Hmm, I'm not sure I buy that argument. Firstly, you can't just pass a kernel
> > linear mapping address -- we'll fault straight away because it's not a
> > userspace address.
> 
> Fault where?

I was expecting something like an access_ok check, but you're right, we
don't have one (and I guess that's not strictly needed given that flushing
isn't destructive). I still find it a bit scary that we allow userspace to
pass kernel addresses through though -- especially if there's something like
a DMA or CPU suspend operation running on another core.

> > Secondly, what's to stop an application from mmaping a large area into
> > a single VMA and giving rise to the same situation? Finally,
> > interrupts are enabled during this operation, so I don't understand
> > how you can trigger a DoS, irrespective of the preempt configuration.
> 
> You can prevent context switching to other threads. But I agree, with a
> large vma (which is already faulted in), you can get similar behaviour.

So the easy fix is to split the range up into chunks and call cond_resched
after processing each one.

Will
