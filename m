From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 23 Nov 2015 12:15:15 +0000
Subject: [PATCH] [PATCH] arm64: Boot failure on m400 with new cont PTEs
In-Reply-To: <20151120195243.GC14942@leverpostej>
References: <1447858999-26665-1-git-send-email-jeremy.linton@arm.com>
 <20151118152044.GD10644@leverpostej> <564CA29A.9050905@arm.com>
 <20151118162932.GA13355@leverpostej> <564CB1DA.4090304@arm.com>
 <20151118180434.GB13355@leverpostej> <564CD206.9040402@arm.com>
 <20151119112923.GA24570@leverpostej>
 <20151120195243.GC14942@leverpostej>
Message-ID: <20151123121514.GB32300@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 20, 2015 at 07:52:44PM +0000, Mark Rutland wrote:
> On Thu, Nov 19, 2015 at 11:31:34AM +0000, Mark Rutland wrote:
> > I think that if we need to do something more drastic to account for the
> > other issues above (e.g. by ensuring that we can never allocate
> > conflicting TLB entries in the first place), and that said strategy
> > would also fix this problem, that would be preferable, given that we're
> > going to have to do that eventually anyway.
> 
> Having looked into this further, we also have the same issue with the
> kasan init code.

I don't think the kasan_init() problem is that bad. We are preserving
the same size mappings (PAGE_SIZE) and just changing the physical
address they point at without a break-before-make (just a TTBR1 switch).
I don't know how clear the ARM ARM is around this but at least so far we
haven't hit any problems.

The problem with the contiguous bit is that we switch from e.g. a 4KB
mapping to a 64KB one and it's very likely that we would get a TLB
conflict.

With CONFIG_DEBUG_RODATA, we go from bigger block to a smaller one, so
less chance of a TLB conflict but still present. I need to read the ARM
ARM some more in this area (and maybe ask for clarification).

> I believe that the issue is restricted to one-off init code, as I don't
> think that we do anything at runtime which would be problematic. If
> anyone knows of a counter-example, please let me know!
> 
> Given that, we can restrict the problem to an early UP environment, and
> it won't matter if therre's some large(ish) fixed cost associated with
> updating the kernel page tables. I think that we can avoid the issue
> entirely by modifying a copy of the kernel page tables, which we can
> later install via some idmap code (going via a reserved table to clear
> the TLBs).
> 
> I'm working on patches to implement the above, which I'll try to get
> somewhere with next week.

That's a complete fix indeed but it would require some more testing and
I don't think it's feasible for 4.4-rc. In the meantime, I propose that
we revert the contiguous PTE patches and push them again once we fix the
TLB conflict problems.

-- 
Catalin
