From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 12 Sep 2016 15:01:40 +0100
Subject: ARM, SoC: About the use DT-defined properties by 3rd-party drivers
In-Reply-To: <57D6AA54.6000208@laposte.net>
References: <57BDAF2E.10502@laposte.net>
 <CAOZdJXVjsR3NTWiJX33yT3jYk=FU65raWoMooTLD7OMN3sqP-A@mail.gmail.com>
 <57D69FB1.2020801@laposte.net> <20160912123809.GB13741@leverpostej>
 <57D6AA54.6000208@laposte.net>
Message-ID: <20160912135549.GA14165@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Sep 12, 2016 at 03:15:00PM +0200, Sebastian Frias wrote:
> On 09/12/2016 02:38 PM, Mark Rutland wrote:
> >>
> >> 3rd party users of said SoC could then write kernel modules for such HW
> >> blocks using the DT description. The DT would thus become the authoritative
> >> source of information regarding register programming for the SoC.
> > 
> > I don't follow this part entirely. Why are you expecting thrid parties
> > to write a driver for those blocks rather than upstreaming a driver for
> > them?
> 
> 3rd parties could choose to write a driver (as opposed to use say, a user-mode
> library) if it fits their programming model better, if they think they would
> have better performance, or other reasons.

A vendor can always choose to "add value" in this manner. The general
expectation of *some* driver being upstreamed remains.

> > I would generally agree that the hardware should be described in DT.
> > The difficulty is that without a 'real' user it's not always possible to
> > tell if we're describing the thing correctly.
> 
> That may be true, but so far we are not discussing changing DT's API so it
> should not have big ramifications.

You're not changing the code, but you are creating a binding. Bindings
are intended to be stable (i.e. a working DTB from today should continue
to work in future), and thus there are ramifications.

Few devices these says are entirely independent, and most devices can be
instantiated multiple times (even if there happens to only be a single
instance in practice). For the example of a userspace driver there are
very real ABI concerns, such as how the device(s) are discovered, how
any related components like regulators and clocks are controlled, etc.

There are ramifications here, and it's a dangerous over simplification
to say that this doesn't matter because we're not changing kernel code.

> Besides, what "makes sense now" may "not make sense tomorrow" depending on
> how the HW is modified.

That's always the case when a new generation of hardware comes out, so I
don't think that's relevant to the topic at hand.

> We have somehow learned the hard-way that "le mieux est l'ennemi du bien"
> (the better is the enemy of the good) and we are trying to take a more
> practical (and flexible) approach.
> 
> > Putting smoething together that's only sufficient to support some
> > out-of-tree driver with implicit assumptions that we are not aware of is
> > far from fantastic.
> 
> That does not seem very positive and it is not the case anyway, otherwise we
> would not be consulting here :-)
> Agreed, right now this whole thing seems like a really hypothetical question,
> but the intention is good.
> 
> Actually, I think it would encourage more SoC manufacturers to use DT as a way
> to document their HW, which is a good thing.

Writing and reviewing bindings is a very tricky topic, as it can require
fairly intimate knowledge of a piece of hardware. I've repeatedly found
that binding descriptions did not match the realities of the hardware,
and I've only managed to do so by looking at accompanying driver code.

Given that manuals and other information on devices are often not freely
available (if they exist at all), the proposal effectively limits myself
and others to spot common (anti)patterns, which is far less than ideal,
and will result in more mistakes.

As it stands, the proposal asks for effort for the community (in terms
of review and maintenance of bindings), with no benefit to the kernel
community, and a number of pitfalls that we would rather avoid.

In an ideal world, writing and reviewing bindings would be a simple
affair, and this could happen separately from work on any particular OS.
In practice, things are sufficiently complicated that you need *some*
demonstration that a binding is suitable, which is what I'm personally
after when I ask for a Linux driver.

> >> However, after discussing over IRC, it looks like there was no guidance on
> >> this. Some people think submitting DT properties/nodes without a corresponding
> >> Linux driver is frowned upon, while others thought it was an odd limitation
> >> and suggested asking here.
> > 
> > Unfortunately, I think that the area is sufficiently vague that there
> > simply is no clear and general answer.
> > 
> > For the sake of discussion, an example of a particular block, along with
> > what you expect/need to describe would be helpful.
> 
> I don't have a more concrete example now.

For this discussion to go somewhere, we need an example. Otherwise we're
all coming at this with differing implicit assumptions and no clear
evidence for any assertions.

> As I stated, right now HW description is not centralised, and thus different
> bits of information are cherry-picked by hand from HW description into DT for
> bootloader, DT for Linux, Documentation/headers for 3rd-parties, etc.
> 
> But if I understood correctly your comment, you are basically saying that
> without an example is hard to say.
> Since the question seems understood, do you have an example of other SoC's
> doing something similar?

I do not have an example. I know that others are using DT for data
beyond what Linux or another OS requires, but it's my understanding that
that is typically in a separate DTB.

Thanks,
Mark.
