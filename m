From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 15 Oct 2010 21:53:35 -0600
Subject: [PATCH 00/08] ARM: Dynamic IRQ demux support
In-Reply-To: <AANLkTikRTNKb=EkYOa_8K3jv2Y8ZpwRJAhka=fhLqZY_@mail.gmail.com>
References: <20101006071731.28048.89938.sendpatchset@t400s>
	<AANLkTi=So8SAY+TRRP1xjxzoYGxZjk0PzLHDhR_qKGUc@mail.gmail.com>
	<AANLkTimAjypE8jTEymyO-0FucXrT8voQ7jVxiZxHF==d@mail.gmail.com>
	<AANLkTinM0JCKkps2XvEZgY5OcYQ-3ivMthmqixWwgzk0@mail.gmail.com>
	<AANLkTikRTNKb=EkYOa_8K3jv2Y8ZpwRJAhka=fhLqZY_@mail.gmail.com>
Message-ID: <20101016035335.GF21170@angua.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 14, 2010 at 07:50:28PM +0900, Magnus Damm wrote:
> On Fri, Oct 8, 2010 at 4:09 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
> > On Thu, Oct 7, 2010 at 2:39 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
> >> On Wed, Oct 6, 2010 at 10:06 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
> >>> On Wed, Oct 6, 2010 at 3:17 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
> >>>> ARM: Dynamic IRQ demux support
> >>
> >>> Just FYI, I had a patch months ago for this:
> >>>
> >>> http://www.spinics.net/linux/lists/arm-kernel/msg92836.html
> >>>
> >>> Do you think that's a simpler way to go?
> >>
> >> Thanks for the pointer. I wasn't aware of your patch, but the fact
> >> that both of us came up with similar solutions to the same problem
> >> clearly shows that there is a need for this feature.
> >>
> >> Your patch is much less intrusive compared to what i came up with. I
> >> like the simplicity. I guess it is natural that the simplicity comes
> >> with a bit of overhead. I'm thinking of the extra branches and
> >> whatever potential cache misses coming from the code and callback
> >> being located in different cache lines compared to the rest of the
> >> code in __irq_svc and __irq_usr.
> >>
> >> My patches keeps the handlers in the same cache lines as before, but
> >> this comes with the cost of more serious rearrangement of the code.
> >> Also, my alignment_trap patch may decrease performance, not sure how
> >> to deal with that in a good way.
> >
> > Yeah, I was thinking of the performance degradation at that time as well.
> > What worried me most is actually the long jump. However, we do have
> > a long jump to asm_do_IRQ anyway.
> >
> > And the optimizations like get_irqnr_preamble and get_irqnr_and_base
> > can be carried out in C code as well, or if that's tricky enough, inline
> > assembly code can also help.
> 
> Sure, I agree.
> 
> >> I don't mind so much which patch that gets merged, but I'm a little
> >> bit concerned about code duplication. My patch moves macros into a
> >> header file that each demux instance can make use of to minimize the
> >> amount of duplicated code. I'm not sure how you are planning on
> >> implementing each demux instance. If possible I'd like to see the
> >> irq_handler macro in a header file somewhere so we don't have to
> >> duplicate that code.
> >
> > Machines will have to specify their IRQ demux handler, which could be
> > same among a group of machines which share common demux code, and
> > thus duplication can be avoided.
> 
> Right, I agree. I'm thinking of SMP-specific interrupts for IPIs and
> local timers that most likely want to be shared across multiple
> machines. I can for instance imagine a wide range of Cortex-A9 based
> SoCs that all need to deal with SMP interrupts.
> 
> >> On top of that I'd also like to break out the GIC demux code and put
> >> it in a central location, but that's a separate issue.
> >
> > I think we can make a common function call for all the IRQ demux handler
> > for GIC then.
> 
> Sure, as long as we can point out the SoC-specific base address then
> we should be ok.
> 
> >> Any thoughts? Shall I try to move the irq_handler macro to some header file?
> >>
> >
> > Your patch is excellent, I don't mind either which gets in. What I'm a
> > bit concerned is the effort to keep up with the mostly optimized code.
> > I was thinking of a bit (not that much significant I guess) performance loss
> > when multiple IRQ demux handler is required for the sake of simplicity
> > and less intrusiveness, while still able to use the original optimized path
> > when that's not required (i.e. turning CONFIG_.... off).
> >
> > Thoughts?
> 
> I feel that the current abstraction with the macros in entry-macros.S
> is pretty nice and familiar. I think your solution with abstracting at
> the irq_handler level is simple from the mach-programmers point of
> view, but it does come with some performance penalty. I'm also not so
> sure how to deal with the code duplication. Like you say, the code
> could be shared between machines, but exactly how I don't know.
> 
> Did you hear anything back from Russell? If he's ok with your patch
> then problem solved. Perhaps it's already in the tracker? =)
> 
> If not, how about picking out the best part of our patches? I think my
> main benefit is the performance - hooking in the per-mach handlers
> below the vector_stub comes with little or no additional cost. Your
> strength is the simplicity and the nice use of the machine_desc.
> Perhaps we can put the __irq_usr and __irq_svc callbacks in struct
> machine_desc?
> 
> Does anyone else care? =)

I care, but I haven't been able to dig into the details.  The way
things are going, I probably won't be able to either until after Linux
Plumbers is over.

g.
