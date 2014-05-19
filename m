From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 19 May 2014 11:31:09 +0200
Subject: [RFC PATCHv1 0/7] ARM core support for hardware I/O coherency
 in non-SMP platforms
In-Reply-To: <CAL_JsqKO5j-rTQVwo9AJA=WYF_oSfdvbM-LjF7QNox3SPGuAkg@mail.gmail.com>
References: <1400082641-23871-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <CAL_JsqJy=dYpVFbgjGVRHrgwfaB7dkJVGazpfjf9qf7Z9poJuw@mail.gmail.com>
 <20140515120152.7b0beb37@free-electrons.com>
 <CAL_JsqKO5j-rTQVwo9AJA=WYF_oSfdvbM-LjF7QNox3SPGuAkg@mail.gmail.com>
Message-ID: <20140519113109.07264028@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Rob Herring,

On Thu, 15 May 2014 09:44:11 -0500, Rob Herring wrote:

> >> >    - The pages must be set as shareable.
> >>
> >> What is the impact of setting shareable bit for !SMP? I would think it
> >> would be a don't care for true UP systems. Does the 370 actually not
> >> work with shareable pages? AMP systems could have an issue though.
> >
> > No, the Armada 370 doesn't work with shareable pages. See my cover
> > letter that details the requirements for the different SoCs, and I've
> > only mentioned shareable pages as part of the requirements for Armada
> > XP, Armada 375 and Armada 38x.
> 
> I asked because you only mentioned platforms requiring shared pages.

Nope. See again the cover letter text. It does clearly states that
Armada 370 does *not* want shareable pages, and that Armada XP, Armada
375 and Armada 38x *do* want shareable pages.

Armada 370 cannot work with shareable pages. Armada XP, 375 and 38x
cannot have I/O coherency working without shareable pages.

> > No. It's done by the kernel for the SMP case, there's no reason it
> > should be done in the bootloader for the !SMP I/O coherent case. Or, we
> > remove the SMP and TLB broadcast bit fiddling in the kernel
> > *completely* and make it part of the ARM boot protocol that the
> > bootloader is required to do that.
> 
> No, it depends on the A9 configuration. The TLB broadcast is not
> modifiable in non-secure mode. You can control non-secure access to
> the SMP bit, but it can work with it enabled by secure world. This is
> what highbank does.

So I'm not sure what your suggestion is here. Again, if the kernel does
it in the CONFIG_SMP case, why couldn't it also do it in
the !CONFIG_SMP case when needed?

> > See above. It's not only about having issues to get the vendor to fix
> > the firmware. It's also about:
> >
> >  * Having a consistent strategy with regard to what the kernel does and
> >    what the bootloader does. Why would the kernel set the SMP and TLB
> >    broadcast bit when CONFIG_SMP is set and the processor is SMP, but
> >    not when CONFIG_SMP is disabled and the system is I/O coherent?
> 
> It is not that simple. The SMP bit has different meanings depending on
> the core, but is more related to cache usage than running multi-core
> or not. On the A15 for example, IIRC, the SMP bit basically means
> disable cache lookups while the C bit only means disable cache
> allocations (i.e. cache hits can occur with the "cache disabled").

Hum, right, and?

> >  * User support issues. Having gazillions of bootloader updates every
> >    time a piece of configuration settings is rejected by the kernel
> >    maintainers is going to be a nightmare for users.
> 
> It's an artifact of trying to upstream the kernel after shipping
> rather than before. If these issues were fixed in the bootloader at
> the same time as someone decided to just hack up the vendor kernel,
> then probably none of us would even know about the issue.

Sorry, but that just doesn't work. The time it takes to mainline things
is *way* longer than the time it takes for the SoC vendor to start
providing early SoC releases and development boards with bootloaders to
customers. There will also be some bootloader pushed out to customers
before the code is mainlined in Linux.

> As long as upstream is not a requirement, you are not in a position
> you can win.

Have you seen the number of patches we have sent over the last two
years for these platforms? You must have missed them, or otherwise I
don't understand how you manage to conclude that upstream is not a
requirement.

> You can never keep up with someone that has the freedom
> to just go and change whatever they want without having to deal with
> those annoying kernel maintainers. You fix these issues, there will
> just be other reasons why mainline is not usable (Do they still have
> the random one line deletion of a goto statement in the scheduler).
> 
> Speaking from experience rebasing i.MX vendor kernels, nothing
> upstream is easier to update than partially upstream if you try to
> build upon what is upstream. Generally speaking, vendors don't care
> what their delta against upstream is any more than they care about
> upstream being production quality.
> 
> Obviously, Marvell does care about mainline to some extent or I
> wouldn't be talking to you. But how do we get them to care enough to
> make mainline production quality? Part of the problem is we have
> distro's willing to take your money and vendor kernel (they are also
> willing to take your money and upstream kernel as well).

Could you be more specific about what Marvell isn't doing today to be
mainline production ready? As I said, we've been working hard since two
years to push to mainline the support for their SoCs. Our patches can
certainly be criticized, but the end result is clear: their Armada 370,
XP and now 375/38x platforms are quite well supported in mainline. And
since the patches have been merged, they surely have matched the
mainline kernel quality requirements, no?

> >> > All of these requirements are met when the kernel is configured with
> >> > CONFIG_SMP *and* when the processor is actually a multiple core
> >> > processors (otherwise, due to the CONFIG_SMP_ON_UP logic, is_smp()
> >> > returns false, and most of the requirements above are not met).
> >>
> >> I think there are some other problems here with is_smp(). For example,
> >> there are several cases where it is used for determining to read the
> >> MPIDR register. For things such as matching MPIDR to DT cpu nodes, we
> >> need that to work for !SMP kernels.
> >
> > Could you point more specifically where this is happening?
> 
> Just grep for is_smp. IIRC, the DT cpu parsing code spews a warning
> when running a !SMP kernel on an MP system. It may only be when the
> MPIDR is not 0 like highbank which has 0x900.

I'll have a look at the other is_smp() call sites.

> > In fact, another possible solution would be to make is_smp() returns
> > "true" when the system is !SMP but has I/O coherency enabled. However,
> > I have the issue that Armada 370 does *not* want shareable pages, while
> > Armada XP/375/38x *require* that.
> 
> We'd need to look more closely at how is_smp is used to redefine it's
> meaning. We probably need to be able to describe "I have MP
> extensions", "I'm MP on SMP kernel" and "I'm UP running an SMP
> kernel".

Right.

> >> > Basically, the patch series goes like this:
> >> >
> >> >  * PATCH 1 adds a 'flags' field to 'struct machine_desc' so that each
> >> >    platform can tell the ARM kernel core some of its requirements. We
> >> >    maybe could have used the Device Tree as well, but accessing the
> >> >    Device Tree as early as in paging_init() is a bit problematic as
> >> >    far as I understand.
> >> >
> >> >    Two flags are defined: MACHINE_NEEDS_CPOLICY_WRITEALLOC and
> >> >    MACHINE_NEEDS_SHAREABLE_PAGES. We need separate flags because
> >> >    Armada 370 cannot have the shareable attribute on page tables.
> >>
> >> I think these are too specific. We used to have arch_is_coherent()
> >> which somewhat does what you need, but it was not multi-platform
> >> friendly. I think you need something like "is_io_coherent" and/or
> >> "is_mp".
> >
> > I agree the flags are very specific, but unfortunately I haven't found
> > a better way of describing things. The main problem here is that the
> > different platforms have different requirements: Armada XP/375/38x
> > require shareable pages, but Armada 370 does not want them. So a single
> > "is_io_coherent" flag was not sufficient, because each platform has its
> > own requirements. I'm really open to suggestions on this, but a single
> > is_io_coherent flag doesn't work, unfortunately.
> 
> With the write-allocate change, you only have a single flag so it is
> really just a question of name and how to control the flag.

Correct. Though I'm not sure how to name this flag. Let's say we name
is "is_io_coherent" and it controls whether shareable pages must be
enabled or not. Then this flag would have to be "false" on Armada 370
(because we do *not* want shareable pages on Armada 370), even though
the platform is I/O coherent.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
