From: mturquette@baylibre.com (Michael Turquette)
Date: Wed, 30 Dec 2015 16:18:59 -0800
Subject: [PATCH v2 1/3] clk: bcm2835: Add bindings for the auxiliary
 peripheral clock gates.
In-Reply-To: <1477432.fTm0GUZ57A@wuerfel>
References: <1450222559-22461-1-git-send-email-eric@anholt.net>
 <20151228223935.25842.28675@quark.deferred.io>
 <CAL_JsqLu7=66jEuaezesEuoPsBBhRAT0UQcLVNOLVwkEvQacRA@mail.gmail.com>
 <1477432.fTm0GUZ57A@wuerfel>
Message-ID: <20151231001859.19557.99512@quark.deferred.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Quoting Arnd Bergmann (2015-12-30 01:29:02)
> On Tuesday 29 December 2015 16:15:09 Rob Herring wrote:
> > On Mon, Dec 28, 2015 at 4:39 PM, Michael Turquette
> > <mturquette@baylibre.com> wrote:
> > > Quoting Eric Anholt (2015-12-24 15:45:15)
> > >> Michael Turquette <mturquette@baylibre.com> writes:
> > >> I would *love* to do that, but I've previously been told that having the
> > >> bindings patch reference a header file not present as of the bindings
> > >> patch is not acceptable and made to change it.
> > >
> > > Ugh, that is annoying. I would think that having code compile properly
> > > would trump the desire to have all of the documentation merged as one
> > > patch.
> > 
> > What about compiling the dts?

Oops, good point Rob.

> > 
> > > On the other hand, I've been asked to not take binding descriptions
> > > through the clk tree. That is a policy that I'm happy to comply with,
> > > but it is at odds with the recommendation for the header and the binding
> > > description to be merged together.
> > 
> > By who? Any bindings in a series I always expect the subsystem
> > maintainers to take the whole series. That doesn't solve the problem
> > though as there is still a dependency between a subsystem tree and
> > arm-soc typically.
> 
> I don't care too much which tree the binding description goes through either,
> as long as it is kept in sync.

OK, I'm happy to merge the whole enchilada.

> 
> > > DT folks, what is the right way to do this? An immutable, shared branch
> > > just for a single header file solves the problem, but also feels very
> > > cumbersome for such a trivial issue.
> > 
> > Arnd and Olof have been complaining about this problem which is worse
> > when it is a binding, driver and dts.
> > 
> > I'm open to maintaining a branch for this purpose if that helps. That
> > or staggering merging of bindings and drivers/dts are the only ideas
> > I've come up with.
> 
> 
> > > How about allowing binding descriptions to be merged without the header
> > > file, so long as it is merged through another tree?
> > 
> > I think that is wrong if we have the goal to separate bindings from
> > the kernel and the bindings should stand on their own. However, if it
> > greatly simplifies things, i'd be okay with that.
> 
> The header file is really the main issue we need to worry about. My preferred
> way of doing this would be to give it an extra merge window: add the binding
> document and the header file in one merge window, and then add the dts files
> and the driver one release later.

I'd prefer not to stagger, as it just adds unnecessary delay to getting
things upstream. And the code being merged first (the binding doc +
header) is fairly useless on its own.

> I've seen a lot of header files added for
> no good reason at all, and at least that way we can get people to think about
> the dependency more.

Do you mean you prefer to declare the magic numbers in the binding
description directly instead of using a header and relying on the C code
to stay in sync?

Or do you mean that there is no reason to declare the constants/magic
numbers in a shared way at all?

> 
> It's also ok to merge the header file and binding with either the dts file
> changes or the driver and then do the other part the following release.
> 
> In the past, we've worked around the issue by merging the driver through
> arm-soc, or by merging the dts changes through a driver tree, with the
> appropriate Acks in each case. Both of those approaches work of course,
> but the former always feels awkward to me as we are not using the right
> maintainer path, and the latter approach tends to cause merge conflicts,
> especially when multiple headers for different subsystems get added or
> the dts files are added at the same time.
> 
> Having a shared branch for the header file is another way to do it, and
> we can do that in some cases, but I'd prefer not to make it the default.

Well, I'm thinking that an immutable branch isn't such a bad idea given
that both you and Rob are OK with subsystems merging headers and binding
descriptions.

A while back Stephen Boyd and I started to use topic branches for every
driver, all based on -rc1 and merging those into clk-next. This makes it
trivial for us to push a shareable branch with minimal dependencies.

So at least for the clk tree, how do you feel about us merging driver +
header + binding description and then sharing our topic branch as-needed
with arm-soc? We could even push our topic branches by default to cut
down on coordinating over email back-and-forth.

As an example, patch #1 from the Hi3519 series[0] includes the clk
driver, binding description and a shared header. Any objection to me
taking that patch as-is, based on -rc1, and pushing out that topic
branch as clk-hi3519 to the clk git tree with the expectation that
you'll just merge that if you need to?

You can let me know if you've pulled it in, and then I won't rebase
without consulting with the arm-soc folks first.

Does this workflow agreement Solve All the Problems?

(Note that the patch I referenced is still under review so the branch
name I mentioned above doesn't exist yet. It is just an example)

[0] http://lkml.kernel.org/r/<1451439832-13927-2-git-send-email-xuejiancheng@huawei.com>

Regards,
Mike

> 
>         Arnd
