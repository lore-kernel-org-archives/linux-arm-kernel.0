From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sat, 28 Jun 2014 18:52:54 +0200
Subject: [PATCH RFCv2 1/5] ARM: use write allocate by default on ARMv6+
In-Reply-To: <20140628163413.GI32514@n2100.arm.linux.org.uk>
References: <20140528112450.GH3693@n2100.arm.linux.org.uk>
 <20140530100819.1208149f@free-electrons.com>
 <20140530092044.GO3693@n2100.arm.linux.org.uk>
 <20140613121121.7e7dc8e6@free-electrons.com>
 <20140613102019.GQ23430@n2100.arm.linux.org.uk>
 <20140613133437.1a85f287@free-electrons.com>
 <20140613155139.05e2393c@free-electrons.com>
 <20140617104854.7393c14c@free-electrons.com>
 <20140617112624.GI23430@n2100.arm.linux.org.uk>
 <20140628173955.7d105d3a@free-electrons.com>
 <20140628163413.GI32514@n2100.arm.linux.org.uk>
Message-ID: <20140628185254.19bd5b9c@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

On Sat, 28 Jun 2014 17:34:13 +0100, Russell King - ARM Linux wrote:

> > I surely understand that it sometimes takes a lot of time to get some
> > feedback from maintainers, I also had similar troubles with the
> > maintainers of certain subsystems.
> 
> Yes, it takes /months/.  The typical way things work is you send a
> patch set of any size.  You get a number of minor comments on it.  You
> address those comments.  You get another set of minor comments on a
> different selection of patches.  You address those.  So the loop
> continues, wasting lots of time updating the patches and re-posting
> them.

Right, but that's the process we all go through. It indeed takes time,
but I believe it's the price to pay for a project that big with so many
people involved. On the other hand, I agree that some maintainers that
no longer have enough time to maintain their subsystem/area should
probably try harder to pass the role to some other developers.

> That means that the maintainers who are trying to push those patches
> are consumed with this process trying to deal with these other people
> rather than working on the area that they're supposed to be maintaining.

True, but as I said earlier, the process you're going through is the
one every kernel developer is going through, and I'm not sure why the
process should be different for a kernel maintainer or a random
kernel developer.

> I still have a significant quantity of patches (slightly more than
> when I sent my reply on the 17th of June) with only a relatively small
> amount of movement towards getting some of them accepted by maintainers.
> 
> I'm not talking about patches which I've only just created - I'm talking
> about patches which are more than /six/ months old.

I'd say that after a few months without any useful feedback or answer,
patches should get merged by the maintainer. Inaction is terrible, as
it de-motivates developers. But I'm sure not everybody would agree with
such a proposal :)

> > However, I'd really like to see the hardware I/O coherency issue make
> > some progress: it's currently completely broken on Armada 370, causing
> > random corruptions, and the only solution is to be able to properly
> > enable write-allocate. Your patch series makes that partially possible,
> > but there are some remaining problems, which I summarized at
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2014-June/263524.html.
> 
> Yes, I'm aware that there are still some remaining problems, but I don't
> have a solution for it yet.
> 
> What we really need for your case is someway to detect your SoCs in the
> early assembly code - and right now I don't have any idea how to do that.

Well, I'd like to *first* solve the Armada 370 issue, and the Armada
370 is using a specific ARM core, so it can definitely be detected
early on in the assembly code.

So for the Armada 370 most of the problems are solved thanks to your
previous patch, the only remaining problem is the TTB_FLAGS problem I
highlighted in
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-June/263524.html.

It's entirely solvable in the early assembly code, I just need your
input on what you think is the right direction to solve this: currently
TTB_FLAGS are defined globally, with one value for UP and one value for
SMP. I would need to make those TTB_FLAGS part of the proc_info
structure, so that Armada 370 and Armada XP (which use special ARM
cores and therefore have separate proc_info structures).

Would you agree with such a change?

Of course this is only needed if the TTB_FLAGS need to match the cache
policy used in the PMD_FLAGS, but I believe Catalin once said that it
was the case. Maybe Catalin, Will or Albin from ARM could
confirm/infirm?

> The reason we need to do that is because we must have the write-allocate
> cache mode and the shared bits set appropriately from the initial page
> table setup in the early assembly code, because we can't just overwrite
> the existing page tables with differing cache attributes without polluting
> the TLB with those differing cache attributes (which can lead to
> unpredictable behaviour.)
> 
> The Armada 37x/38x problem is a very difficult one to solve... really
> I wish that those spins of the SoC had been chucked in the trash, because
> working around this properly is going to take a lot of time and effort.
> That would've been /far/ better for us.

What about simply making write-allocate + shared attribute the default
on all SMP-capable Cortex-A9 ?

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
