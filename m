From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 12 Sep 2016 17:56:37 +0100
Subject: ARM, SoC: About the use DT-defined properties by 3rd-party drivers
In-Reply-To: <57D6D2A9.3010006@laposte.net>
References: <57BDAF2E.10502@laposte.net>
 <CAOZdJXVjsR3NTWiJX33yT3jYk=FU65raWoMooTLD7OMN3sqP-A@mail.gmail.com>
 <57D69FB1.2020801@laposte.net> <20160912123809.GB13741@leverpostej>
 <57D6AA54.6000208@laposte.net> <20160912135549.GA14165@leverpostej>
 <57D6D2A9.3010006@laposte.net>
Message-ID: <20160912165637.GF14165@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 12, 2016 at 06:07:05PM +0200, Sebastian Frias wrote:
> On 09/12/2016 04:01 PM, Mark Rutland wrote:
> > Few devices these says are entirely independent, and most devices can be
> > instantiated multiple times (even if there happens to only be a single
> > instance in practice). For the example of a userspace driver there are
> > very real ABI concerns, such as how the device(s) are discovered, how
> > any related components like regulators and clocks are controlled, etc.
> > 
> > There are ramifications here, and it's a dangerous over simplification
> > to say that this doesn't matter because we're not changing kernel code.
> > 
> >> Besides, what "makes sense now" may "not make sense tomorrow" depending on
> >> how the HW is modified.
> > 
> > That's always the case when a new generation of hardware comes out, so I
> > don't think that's relevant to the topic at hand.
> 
> Exactly, that's why to I'm having trouble to understand why there is so much
> insistence on "getting the DT 100% right", since a HW change could imply
> that what made 100% sense yesterday, does not today.
> Since that is a possibility we have to live with, then the "100% right" goal
> is most likely unachievable.
> That's different from "backwards compatibility" for which some technique,
> like alternate descriptions, can be put in place.

I'm not on about "100% right", but more "a reasonable chance of being
good enough". The latter is extremely difficult to judge when you just
get a binding document with little or no additional context.

Backwards compatibility is with regards to new software supporting old
bindings. If new HW comes out, we can create new bindings. Old bindings
should remain supported regardless.

> >> Actually, I think it would encourage more SoC manufacturers to use DT as a way
> >> to document their HW, which is a good thing.
> > 
> > Writing and reviewing bindings is a very tricky topic, as it can require
> > fairly intimate knowledge of a piece of hardware. I've repeatedly found
> > that binding descriptions did not match the realities of the hardware,
> > and I've only managed to do so by looking at accompanying driver code.
> > 
> > Given that manuals and other information on devices are often not freely
> > available (if they exist at all), the proposal effectively limits myself
> > and others to spot common (anti)patterns, which is far less than ideal,
> > and will result in more mistakes.
> > 
> > As it stands, the proposal asks for effort for the community (in terms
> > of review and maintenance of bindings), with no benefit to the kernel
> > community, and a number of pitfalls that we would rather avoid.
> 
> Could you be more precise on those two issues? Namely:
> "the effort" and the "lack of benefit for the community"?

As above, reviewing is tricky. One has to spend the time gaining an
understanding of a particular piece of hardware, the class of hardware
it falls in, and also the bigger picture that it fits in. Once you have
that, you have to review the binding in that context, and that takes
time and effort.

As things evolve, perhaps mistakes or inconsistencies are found, or new
ways to generalise things. As that occurs, there is a maintenance burden
for existing bindings.

All of that takes time and effort.

If, at the end of that, a proprietary vendor driver is using a different
version of the binding anyway, because "there's no backward
compatibility to guarantee", then there is no benefit to the document.

Even if that proprietary driver does remain stable, the Linux community
will have done work that only benefits the authors of that driver. We
would prefer that the results of our efforts are open, and benefit all.

> I can understand the effort it takes to review a binding and some
> driver, but if there's no driver, why would it matter if the DT binding is
> 100% right? Hence, why would it take more effort?
> Furthermore, if there's no driver, there's no backward compatibility to
> guarantee. Shouldn't it require less effort?

I don't follow. If there's no compatibility to guarantee, why do you
want a binding?

A binding is a form of contract -- if you describe the HW this way, then
some software will understand it. You can extend a binding over time,
certainly, but if the baseline of that binding is a moving target, that
benefits nobody.

[...]

> >> But if I understood correctly your comment, you are basically saying that
> >> without an example is hard to say.
> >> Since the question seems understood, do you have an example of other SoC's
> >> doing something similar?
> > 
> > I do not have an example. I know that others are using DT for data
> > beyond what Linux or another OS requires, but it's my understanding that
> > that is typically in a separate DTB.
> 
> I see, although I don't understand how accepting such solution (i.e.: having the
> information in a different DT) benefits the open-source community, since it
> basically means that the open-source community settles for less information.

As with all things, it depends on context. If someone's using a DT to
describe details of the secure world of a platform with trustzone to a
secure OS, then not all of that information is relevant to Linux.
Likewise if configuration details specific to FW are embedded.

If there's information relevant to a general purpose OS, then I would
expect it to be described. By the same token, I would expect a general
purpose OS to actually be making use of the information. In practice,
we've used Linux as the benchmark for that. That needn't necessarily be
the case if another OS can demonstrate that the binding is worthwhile --
ideally we'd have multiple OSs using bindings so as to "keep us honest"
and free from implementation details.

As I mentioned before, an example would help. The theoretical envelope
is very large and likely far beyond what you envisage. We need something
to focus on, or we're arguing about what we conceive differently.

Thanks,
Mark.
