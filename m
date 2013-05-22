From: peterz@infradead.org (Peter Zijlstra)
Date: Wed, 22 May 2013 12:16:10 +0200
Subject: [PATCH v2 10/10] kernel: might_fault does not imply might_sleep
In-Reply-To: <20130522094709.GA26451@redhat.com>
References: <cover.1368702323.git.mst@redhat.com>
 <1f85dc8e6a0149677563a2dfb4cef9a9c7eaa391.1368702323.git.mst@redhat.com>
 <20130516184041.GP19669@dyad.programming.kicks-ass.net>
 <20130519093526.GD19883@redhat.com>
 <20130521115734.GA9554@twins.programming.kicks-ass.net>
 <20130522094709.GA26451@redhat.com>
Message-ID: <20130522101610.GL18810@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 22, 2013 at 12:47:09PM +0300, Michael S. Tsirkin wrote:
> >  
> > +static inline bool __can_fault(void)
> > +{
> > +	/*
> > +	 * Some code (nfs/sunrpc) uses socket ops on kernel memory while
> > +	 * holding the mmap_sem, this is safe because kernel memory doesn't
> > +	 * get paged out, therefore we'll never actually fault, and the
> > +	 * below annotations will generate false positives.
> > +	 */
> > +	if (segment_eq(get_fs(), KERNEL_DS))
> > +		return false;
> > +
> > +	if (in_atomic() /* || pagefault_disabled() */)
> 
> One question here: I'm guessing you put this comment here
> for illustrative purposes, implying code that will
> be enabled in -rt?
> We don't want it upstream I think, right?

Right, and as a reminder that when we do this we need to add a patch to
-rt. But yeah, we should have a look and see if its worth pulling those
patches from -rt into mainline in some way shape or form. They're big
but trivial IIRC.

I'm fine with you leaving that comment out though.. 
