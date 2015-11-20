From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 20 Nov 2015 19:52:44 +0000
Subject: [PATCH] [PATCH] arm64: Boot failure on m400 with new cont PTEs
In-Reply-To: <20151119112923.GA24570@leverpostej>
References: <1447858999-26665-1-git-send-email-jeremy.linton@arm.com>
 <20151118152044.GD10644@leverpostej> <564CA29A.9050905@arm.com>
 <20151118162932.GA13355@leverpostej> <564CB1DA.4090304@arm.com>
 <20151118180434.GB13355@leverpostej> <564CD206.9040402@arm.com>
 <20151119112923.GA24570@leverpostej>
Message-ID: <20151120195243.GC14942@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 19, 2015 at 11:31:34AM +0000, Mark Rutland wrote:
> On Wed, Nov 18, 2015 at 01:31:18PM -0600, Jeremy Linton wrote:
> > On 11/18/2015 12:04 PM, Mark Rutland wrote:
> > 
> > >You're racing against other parts of the CPU (the page table walker(s),
> > >I-caches, etc). The flushing only minimises the window for a race, and
> > >does not prevent the race from being possible.
> > >
> > >Given that the envelope is constantly pushing forward w.r.t. how
> > >aggressive CPUs may be in this area, we need to fix the issue by
> > >reasoning against what the architecture guarantees us.
> > 	Its also not suppose to fault on speculative access, and to me that
> > means page table walks/etc that are the result of speculative
> > access.
> 
> I was under the impression that TLB conflict abort could be delivered
> for asynchronous events (e.g. speculative I-cache fetches rather than
> for speculative execution of already fetched instructions).
> 
> Having looked at the ARM ARM, I appear to have been mistaken. As you
> say, it appears that TLB conflict aborts are always delivered
> synchronously.
> 
> > Which AFAIK, closes the window significantly. I would only
> > really worry about interrupt activity, and updates to the memory
> > containing the PTE's themselves. Either way the simple change
> > (rather than rewriting the whole code path) is probably to flag the
> > fault handler to simply resume from these kinds of faults during
> > create_mapping_late().

> > 	But that isn't what is happening here AFAIK, the faults are long
> > after the PTE's have been updated, and are the result of failure to
> > flush the TLB..

> I think that if we need to do something more drastic to account for the
> other issues above (e.g. by ensuring that we can never allocate
> conflicting TLB entries in the first place), and that said strategy
> would also fix this problem, that would be preferable, given that we're
> going to have to do that eventually anyway.

Having looked into this further, we also have the same issue with the
kasan init code.

I believe that the issue is restricted to one-off init code, as I don't
think that we do anything at runtime which would be problematic. If
anyone knows of a counter-example, please let me know!

Given that, we can restrict the problem to an early UP environment, and
it won't matter if therre's some large(ish) fixed cost associated with
updating the kernel page tables. I think that we can avoid the issue
entirely by modifying a copy of the kernel page tables, which we can
later install via some idmap code (going via a reserved table to clear
the TLBs).

I'm working on patches to implement the above, which I'll try to get
somewhere with next week.

Thanks,
Mark
