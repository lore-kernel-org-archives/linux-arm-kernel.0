From: broonie@kernel.org (Mark Brown)
Date: Tue, 6 Mar 2018 21:31:29 +0000
Subject: [PATCH 0/29] arm meltdown fix backporting review for lts 4.9
In-Reply-To: <20180306172525.GA6618@kroah.com>
References: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
 <20180301152450.GA4061@kroah.com>
 <5cf40379-9098-da02-a471-8abd7d8f0be8@linaro.org>
 <20180302165415.GB8704@kroah.com>
 <20180305124638.GG8588@sirena.org.uk>
 <20180305130859.GB17802@kroah.com>
 <20180306142634.GC13586@sirena.org.uk>
 <20180306172525.GA6618@kroah.com>
Message-ID: <20180306213129.GG13586@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 06, 2018 at 09:25:25AM -0800, Greg KH wrote:
> On Tue, Mar 06, 2018 at 02:26:34PM +0000, Mark Brown wrote:

> > I'm not far enough into the details to comment on the specifics here;
> > there's other people in the CCs who are.  Let's let people look at the
> > code and see if they think some of the fixes are useful in LTS.  The
> > Android tree does have things beyond what's in LTS and there's been more
> > time for analysis since the changes were made there.

> I suggest looking at the backports in the android-common tree that are
> needed for this "feature" to work properly, and pull them out and test
> them if you really want it in your Linaro trees.  If you think some of

This isn't about getting anything into Linaro specific trees, this is
about getting things into the LTS so that people who are doing the
responsible thing and keeping up to date with LTS get the fixes.  

> them should be added to the LTS kernels, I'll be glad to consider them,
> but don't do a hack to try to work around the lack of these features,
> otherwise you will not be happy in the long-run.

> Again, look at the mess we have for x86 in 4.4.y and 4.9.y.  You do not
> want that for ARM for the simple reason that ARM systems usually last
> "longer" with those old kernels than the x86 systems do.

Like I say let's let the architecture people review.

> > > So that's why I keep pointing people at the android trees.  Look at what
> > > they did there.  There's nothing stoping anyone who is really insistant
> > > on staying on these old kernel versions from pulling from those branches
> > > to get these bugfixes in a known stable, and tested, implementation.

> > I think there's enough stuff going on in the Android tree to make that
> > unpalatable for a good segment of users.

> Really?  Like what?  Last I looked it's only about 300 or so patches.
> Something like less than .5% of the normal SoC backport size for any ARM
> system recently.  There were some numbers published a few months ago
> about the real count, I can dig them up if you are curious.

Really.  

The Android tree is making non-trivial modifications adding new features
in core bits of the kernel like the scheduler - that's got an impact
which will have follow on validation costs if it's not introduced early
on in the process.

As I have been saying not all the ARM world is the mobile SoCs you are
focused on.  Take for example Atmel who's tree I happen to have to hand
right now, their diff in their v4.9 tree[1] is ballpark similar to the
Android tree in terms of size, smaller than the v4.9 and a similar size
to the v4.14 one.  It's only about 50k lines, about 20k of which is
wholesale removal of a staging driver, another 7k is new DTs for new
boards/SoCs and the bulk of the rest is things like new drivers with few
core changes (spot checks suggest that much of what's added is either
already upstream or on the way).

You can quite happily use many of their parts without ever taking any of
these changes, and it's not just them either.  Personally I've got a NAS
running a standard Debian kernel (which has very few board support
backports) on a sunxi board, works perfectly well and has never had
anything else running on it as long as I've owned it.

> > Yes, there are some people who are stuck with enormous out of tree patch
> > sets on most architectures (just look at the enterprise distros!) - but
> > there are also people who are at or very close to vanilla and just
> > trying to control their validation costs by not changing too much when
> > they don't need to.

> Great, then move to 4.14.y :)

> And before someone says "but it takes more to validate a new kernel
> version than it does to just validate a core backport for the
> architecture code", well...

Like it or not that's the reality of the situation.  It's not that
responsible testing of such changes is trivial but it does really help
people direct their testing and manage their risk.  It's essentially the
same discussion as with the enterprise kernels, and it's about as likely
that people will change their views in the short term.

[1] git://github.com/linux4sam/linux-at91 linux-4.9-at91
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180306/35681f3a/attachment.sig>
