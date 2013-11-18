From: olof@lixom.net (Olof Johansson)
Date: Mon, 18 Nov 2013 11:09:29 -0800
Subject: ACPI vs DT at runtime
In-Reply-To: <5289A356.4060004@jonmasters.org>
References: <CAOesGMjKeRb=fFJM0MabDihbEiCGM4EqW9D5i_6-RFxTnpB4Qw@mail.gmail.com>
 <20131115095717.GC1709@e106331-lin.cambridge.arm.com>
 <5289A356.4060004@jonmasters.org>
Message-ID: <20131118190929.GA5886@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jon,

On Mon, Nov 18, 2013 at 12:19:18AM -0500, Jon Masters wrote:
> Olof, thanks for starting this thread. Mark, thanks for the followup.

Your mailer is dropping all ccs to your emails, so I didn't get a copy of this
in my inbox. You might want to check the configuration at your end.

I've added back the cc recipients.

> Comments on both inline, below. But before I reply to the specific
> points, let me add that this is clearly an emotional topic for many.

I'm sorry that it's so emotional. Let's keep to technical arguments.

> There are a great many companies involved in ARMv8 on servers, and a
> great many have yet to say anything in public. I am trying to strike a
> balance constantly by being fair to those who have announced and those
> who have yet to do so. But regardless, we have one chance here to make a
> good server platform that can challenge the incumbent architectures. If
> I weren't utterly convinced of that, and of the need for such standards
> as UEFI and ACPI, then I wouldn't be so vocal about it. Given who is
> involved in this space, regardless of a decision to adopt ACPI now or
> later, it is coming. It can be done right now, or not.

And what I am saying here is that "not right now" is the right answer
for the linux kernel. For technical reasons.

> I (and others) pushed 3 years ago for the adoption of ACPI. Dong, and
> others instigated the legal processes that resulted in the movement of
> ACPI under UEFI Forum recently, to become a fully open standard that can
> be shaped - both by the Linux community, and by others. ACPI.next will
> benefit from the same development process that has shaped UEFI standards
> over the past few years, and most people here can easily get involved in
> shaping that standard - as they can on x86 as well now.
> 
> I am pushing for a few other things to become public that will help to
> explain why ACPI is being adopted and provide a standardized description
> of the ways in which it will be used/consumed.

Which in turn is DoS:ing linux development. Now we need to sign up for
a third party committee to set the direction for the kernel? Sorry,
that's not the way we do things around here.

> On 11/15/2013 04:57 AM, Mark Rutland wrote:
> > On Fri, Nov 15, 2013 at 01:44:10AM +0000, Olof Johansson wrote:
> >> The more I start to see early UEFI/ACPI code, the more I am certain
> >> that we want none of that crap in the kernel. It's making things
> >> considerably messier, while we're already very busy trying to convert
> >> everything over and enable DT -- we'll be preempting that effort just
> >> to add even more boilerplate everywhere and total progress will be
> >> hurt.
> 
> Firstly, I would note that I don't expect DeviceTree to go away. Only on
> server class systems.  I expect all server class ARMv8 systems in the
> Enterprise/Cloud environment to boot using UEFI and ACPI. This is
> certainly the case of most future design starts already underway. These
> can either be supported properly, or not, but ignoring the impending
> ACPI systems isn't practical.

Trust me, we're not going to ignore them, we want them supported.

> Translation won't work reliably either.

Nothing is going to work reliably with ACPI right now, period. It's a
completely immature technology on ARM, and if we lock in hard to the
current implementaitons we're all going to lose. Big. You have yet to
address that part of the argument in any of your replies.

It's taken us years to sort out device tree, and we've been able to cope
with it by the fact that we have been able to change both sides of the
border (both the DTB and the kernel). With ACPI, we're entering a hard
lock-in on day one.  Meanwhile the very first patches look considerably
worse than any of the first device-tree ones did, and vendors are clearly
not getting help from you.

> For the record, I did suggest to Applied that the first posting of that
> SATA driver not have the ACPI bits in (since we know it needs cleaning
> up to use the key/value approaches already discussed, and so on), but
> after chatting with Loc about it, it seemed reasonable to use the
> opportunity to start a discussion - which seems to be on cue here.

Nice.

> > I'm of the opinion that the only way we should support ACPI is as a
> > first-class citizen.
> 
> There really isn't another way to do it in my opinion.

There is. Apple, IBM and Sun obviously figured out how to ship enterprise
systems without ACPI, didn't they?

> > We don't need to modify every driver and subsystem
> > to support ACPI, only those necessary to support the minimal set of
> > platforms using ACPI. ACPI is new in the arm space, and we can enforce
> > quality standards on ACPI _now_ above what we're allowing for DT, and
> > avoid future problems.
> 
> This is key. It's not going to be ACPI everywhere. It's going to be ACPI
> on server class systems. And later, maybe some client systems. But the
> big push is from the server crowd.

Market segment is irrellevant to the discussion at hand.

> We need to build systems that in 5-10
> years time can still boot an older kernel. This can't be done without a
> standardized/versioned enumeration/discovery mechanism like ACPI that
> has an API enshrined in stone as far as compatibility. Device Tree is
> wonderful, anyone can make a binding and use it. Or change the binding
> in the next kernel release.

Clearly you haven't been following any of the recent development w.r.t. device
tree and the policy changes on backwards compatibility.

What makes you so sure that vendors won't do crazy custom stuff on
top of ACPI? You seem confident that they'll be able to sort it out
themselves. Initial data on the subject indicates the polar opposite.

> Or...this doesn't work in the server space.
> Server platforms aren't vertically welded shut like in the embedded
> space, where DeviceTree has brought all kinds of benefits for those
> building with a single kernel for many different targets, but has also
> seen a huge amount of churn from one kernel to the next. If I counted
> the number of times I've been told "just update your dtb"...then I would
> be shivering in the corner a sadden wreck. You can't "just update your
> dtb" on a server class system. You shouldn't.

You know why you've been asked to update the device trees? Because
everyone is trying to figure out how to make this all work in a good way.

With ACPI, there's _no way_ to do any of that. And you think that's a
good thing? It's not, because the alternative is to start littering the
kernel with lots and lots of quirks and fixups.

> But anyway, emotional plea aside, a very large number of ACPI systems
> are coming. Yes, I've been pushing to get existing players to switch,
> but that's because I know what is coming. And if you want certain other
> players to appear in this space, you'll need to have ACPI for them, too.

I think what concerns me the most about the current situation is
exactly this.  You've been scheming for several years now, and now
when push comes to shove, it's obvious that the vendors have no idea
what they're doing with ACPI. Whenever there's a discussion about it,
we get thrown these kind of vague "oh you'll see what's coming" arguments.

Sure, we will, but until we see these promised awesome things in public,
we're going to base things on what we know and see. And what we've
seen so far is not promising. It's looking like in the short to medium
term, locking ourselves to ACPI, on any platforms, is going to be a
huge mistake.

ACPI long-term might be a great thing, once vendors have gone through a
couple of product generations and everybody has learned how to use ACPI
properly. Until then we're building up a huge technical debt that we'll
have to carry forever.

Implement ACPI if you want, but while all those things are sorted out,
we'll continue shipping device tree. If you look at the Calxeda DT sources,
they've been completely table for quite a while now. It can, and will, be done.

> > There may even be things which we don't have to deal with at all on ACPI
> > systems as used in servers (e.g. clock management), but perhaps we will
> > if people see value in those elements.
> > 
> >> The server guys really want UEFI for their boot protocols,
> >> installation managers, etc, etc. That's fine, let them do that, but
> >> that doesn't mean we need to bring the same APIs all the way into the
> >> kernel.
> >>
> >> So, I'm strongly urging that whatever the server guys try to do, it
> >> will in the end result in the ACPI data being translated into DT
> >> equivalents, such that the kernel _only_ needs to handle data via DT.
> > 
> > I'm not sure that translating ACPI tables to dt makes any sense. If AML
> > is used (even sparingly), I do not believe that we can do any sensible
> > conversion to device tree. My understanding is that AML includes
> > functionality for modifying ACPI tables, and I don't see how we can
> > possibly support that without having to add a lot of boilerplate to all
> > the code handling AML to add a device tree backend...
> 
> AML includes code that is runtime interpreted, for things like power
> button emulation and the like. You can't just translate this. This comes
> up every few years - it's impractical. You'll end up having to ship both
> DTB and ACPI tables for a system. Which means two tables for a platform
> vendor to get right. 

Nobody is talking about removing the AML pieces here. Keep them around, but
bring them over to the DT implementation if you have to.

> You know what will happen - only one table with be
> correct. Perhaps it seems that it will be the DTB that is more correct,
> and this might be true this week, but by 2016 I *guarantee* you that the
> ACPI table will be the one winning.

Actually, that's an excellent approach to the problem at hand and pretty
the ideal outcome as far as I am concerned. Focus on DT now, enable
ACPI as much as possible but it won't be right yet so don't rely on
it. In a few years, when ACPI looks like it's sorted out and reliable,
we can switch over to it.

> > I think that trying to shoe-horn ACPI-derived information into device
> > tree is fundamentally the wrong approach. I don't think it encourages
> > best practices, and I don't think it's beneficial to the long term
> > health of Linux or the ecosystem as a whole.
> 
> It's going to be a messy thing to even attempt. Look, I wish we had a
> time machine and could have done this whole thing years ago, but I'm not
> sure it would have gone differently. ACPI is something a lot of people
> emotionally hate.

Again, I am not approaching this emotionally.

I'm looking at the quality of the initial submissions (very poor and
confused), the readiness of the kernel in general (none so far),
the way the involved parties are doing development (away from the
community and in their own little world). I also look at some of the
bottlenecks we've had with device tree (reviewer bandwidth, slow-moving
consensus/standards-driven approval process) and how it compares to the
ACPI counterparts (standards forum).

The conclusion is that we're about to embark onto something that isn't
going to be done right in the short to medium term. It just isn't. The
sooner we own up to that, the sooner we can course-correct and get back
to something that's likely to work.

The alternative is signing onto a setup that _will_ stumble right out
of the door, which in turn will mean that the high-end ARM play will be
off to a rough start instead of running as smoothly as possible.

> In the Enterprise space myself and others *need* it
> (along with UEFI) to have a scalable solution that doesn't result in an
> onslaught of customer support calls, which a non-standards body backed
> moving target of DTB will do. And besides all of the big boys are going
> to be using ACPI whether it's liked much or not.

I'm glad you've found your home with the big boys. Meanwhile, us low-lifes
working on the kernel have a job to do, which is to make sure the lower parts
of the stack will be successful on these new environments long-term,
which might have short-term difficult trade-offs. ACPI is not realistic
today, for all the reasons explained above.


-Olof
