From: will.deacon@arm.com (Will Deacon)
Date: Wed, 27 Mar 2013 12:15:12 +0000
Subject: [PATCH 2/3] ARM: cacheflush: don't bother rounding to nearest vma
In-Reply-To: <20130327110938.GG801@MacBook-Pro.local>
References: <1364235486-17738-1-git-send-email-will.deacon@arm.com>
 <1364235486-17738-3-git-send-email-will.deacon@arm.com>
 <20130327110938.GG801@MacBook-Pro.local>
Message-ID: <20130327121512.GC17185@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, Mar 27, 2013 at 11:09:38AM +0000, Catalin Marinas wrote:
> On Mon, Mar 25, 2013 at 06:18:05PM +0000, Will Deacon wrote:
> > diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
> > index 1c08911..da5e268 100644
> > --- a/arch/arm/kernel/traps.c
> > +++ b/arch/arm/kernel/traps.c
> > @@ -509,25 +509,10 @@ static int bad_syscall(int n, struct pt_regs *regs)
> >  static inline int
> >  do_cache_op(unsigned long start, unsigned long end, int flags)
> >  {
> > -	struct mm_struct *mm = current->active_mm;
> > -	struct vm_area_struct *vma;
> > -
> >  	if (end < start || flags)
> >  		return -EINVAL;
> >  
> > -	down_read(&mm->mmap_sem);
> > -	vma = find_vma(mm, start);
> > -	if (vma && vma->vm_start < end) {
> > -		if (start < vma->vm_start)
> > -			start = vma->vm_start;
> > -		if (end > vma->vm_end)
> > -			end = vma->vm_end;
> > -
> > -		up_read(&mm->mmap_sem);
> > -		return flush_cache_user_range(start, end);
> > -	}
> > -	up_read(&mm->mmap_sem);
> > -	return -EINVAL;
> > +	return flush_cache_user_range(start, end);
> 
> While this would work, it introduces a possibility of DoS where an
> application passes bigger valid range (kernel linear mapping) and the
> kernel code would not be preempted (CONFIG_PREEMPT disabled). IIRC,
> that's why Russell reject such patch a while back.

Hmm, I'm not sure I buy that argument. Firstly, you can't just pass a kernel
linear mapping address -- we'll fault straight away because it's not a
userspace address. Secondly, what's to stop an application from mmaping a
large area into a single VMA and giving rise to the same situation? Finally,
interrupts are enabled during this operation, so I don't understand how you
can trigger a DoS, irrespective of the preempt configuration.

Is there an old thread I can refer to with more details about this? It may
be that some of the assumptions there no longer hold with subsequent changes
to the fault handling on this path.

Will
