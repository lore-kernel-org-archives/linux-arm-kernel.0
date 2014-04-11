From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 11 Apr 2014 16:30:41 +0100
Subject: [RFC PATCH] uprobes: copy to user-space xol page with proper
 cache flushing
In-Reply-To: <20140411152207.GA28188@redhat.com>
References: <20140409184507.GA1058@redhat.com>
 <CAA3XUr3w_9318mT2_9+J-nf3wDv5bic+v0H4nVfsYof7wWZs9Q@mail.gmail.com>
 <5347655B.3080307@linaro.org>
 <20140411.003636.272212797007496394.davem@davemloft.net>
 <20140411145625.GA27493@redhat.com> <20140411152207.GA28188@redhat.com>
Message-ID: <20140411153041.GQ16119@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 11, 2014 at 05:22:07PM +0200, Oleg Nesterov wrote:
> On 04/11, Oleg Nesterov wrote:
> >
> > Can't we do _something_
> > like below?
> 
> If not, I'd propose the patch below.
> 
> I can be easily wrong, but it seems that arch/arm can reimplement
> arch_uprobe_flush_xol_icache() and do flush_ptrace_access()-like
> code. It needs kaddr, but this is not a problem.
> 
> Btw. From arch/arm/include/asm/cacheflush.h
> 
> 	#define flush_icache_user_range(vma,page,addr,len) \
> 		flush_dcache_page(page)
> 
> but it has no users?

I wonder whether you've read this yet:

	http://lkml.iu.edu//hypermail/linux/kernel/1404.1/00725.html

where I proposed removing flush_icache_user_range() since it's not used
on a great many architectures.

> And I am just curious, why arm's copy_to_user_page() disables premption
> before memcpy?

flush_ptrace_access() needs to run on the CPU which ended up with the
dirty cache line(s) to cope with those which do not have hardware
broadcasting of cache maintanence operations.

This is why the hacks that you're doing are just that - they're hacks
and are all broken in some way.

So, let me re-quote what I asked in a previous thread:

| Given that we've already solved that problem, wouldn't it be a good idea
| if the tracing code would stop trying to reinvent broken solutions to
| problems we have already solved?

I fail to see what your problem is with keeping the vma around, and
using that infrastructure.  If it needs optimisation for uprobes, then
let's optimise it.  Let's not go inventing a whole new interface
solving the same problem.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
