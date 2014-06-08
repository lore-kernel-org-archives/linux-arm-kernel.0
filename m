From: olof@lixom.net (Olof Johansson)
Date: Sat, 7 Jun 2014 19:52:30 -0700
Subject: Problems booting exynos5420 with >1 CPU
In-Reply-To: <20140608001942.GM23430@n2100.arm.linux.org.uk>
References: <539145B4.5000200@gmail.com>
 <CAD=FV=XqwEQNJmij-4Gh62OY+B66AjdQjZC0=f_6tbot3UfQaA@mail.gmail.com>
 <CAM4voaknx3+X4O8MUwaruUFPyquY8Opq61ucKX08xTrv8PqfLg@mail.gmail.com>
 <alpine.LFD.2.11.1406061740280.25775@knanqh.ubzr>
 <CAM4voam5KDicwLAt3EA1UC7M+EciGccrnMUKxoR-5c8xT8-zSQ@mail.gmail.com>
 <alpine.LFD.2.11.1406062340480.25775@knanqh.ubzr>
 <20140607175618.GA25068@e102568-lin.cambridge.arm.com>
 <alpine.LFD.2.11.1406071431490.25775@knanqh.ubzr>
 <20140607223614.GA26641@e102568-lin.cambridge.arm.com>
 <CAOesGMj+itYr-daqxfX=J3Ss+7YdWhUUzBWTW3FqVEH8tXqt-A@mail.gmail.com>
 <20140608001942.GM23430@n2100.arm.linux.org.uk>
Message-ID: <CAOesGMiGrNiGfj4tRNutTB6PDF7_tLspHd-SgF9zuNa3Ln0Ytw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 7, 2014 at 5:19 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sat, Jun 07, 2014 at 04:53:34PM -0700, Olof Johansson wrote:
>> You do realize that you have absolutely zero leverage over us on this,
>> right? Our product is already shipped with kernel code that fixes
>> this.
>
> That is never a justification for forcing /any/ code into the kernel.

I'm not looking to force code in, I'm just making it clear that we
have limited chance to motivate rework of this since the primary
objective of the platform has already been met: We've shipped a
product with it.

I also don't think it's really in anyone's best interest to have to
open up their device, remove write protect, download and build a
mainline u-boot and try flashing that onto the system to get it to a
state where they can use a mainline kernel. There's too much risk of
bricking your hardware if you get it wrong, and you void your
warranty.

> We've been here before with the iPAQs, where there were all sorts of
> horrid hacks that were in the code for that device, and we said no to
> it, and we kept it out of the mainline kernel, and stopped those hacks
> polluting elsewhere (because people got to know on the whole that if
> they used those hacks, it would bar them from mainline participation.)

Unfortunately, very few companies actually care about mainline
participation today to the point where I don't think they care much
any set examples. :(

> There's many other instances.  Think about it - if we allowed this as
> an acceptance criteria, then all that vendors have to do to get their
> code into the kernel is change their development cycle: develop
> product, ship product, force code into mainline as a done deal not
> accepting any review comments back.

That is of course not a suitable way of working either. Unfortunately
what is mostly happening today is that vendors are doing this: develop
product, ship product. The last step never happens. Finding a middle
ground where we can pick up some of the platform quirks without making
the kernel a big ball of hacks is of course the tricky part.

In this specific case, we're not ignoring review feedback, and the
comments we've gotten we will absolutely make sure are fixed in the
next generation of product (if/when we do another big.LITTLE platform,
etc). There's just no room to fix it for the current generation. In
hindsight, of course what should have happened is that we should have
pushed the vendor to upstream the code sooner, and we're working on
making that better in the future too.


Since we're talking about upstreaming of platform support, this is
something I'm quite passionate about so I'll rant a bit:

Looking at the general case more than just this specific instance of
Samsung Chromebooks, I think we should in general work hard (where
vendors are willing to cooperate) to make sure that we can fully
enable support for platforms to the point where they can just run
unmodified upstream. Too many of the products today aren't shipping
kernels anywhere near what's mainline: It's usually a kernel that is a
couple of years old with a few thousand patches on top. It means that
bugfixes for the platforms (and much other useful code) doesn't find
its way into the kernel, and we have a long (or nonexistent) cycle of
feedback due to it. Drivers are in some cases completely broken
because nobody actually uses the upstream versions, people post
building-but-broken code because they can't actually run and test the
patch on any existing hardware with mainline so they just forward-port
what they have in the product tree and hope for the best. Etc.

I would really like to reach a state where we have several substantial
and popular platforms that work well enough with mainline that people
can use some of the mainline-near distros to run on the machine.
Cubox-i is a great example, even though there are still some pieces
left there as well. The new Chromebooks have hardware specs that are
quite suitable to use as native development platforms (good CPUs, 4GB
ram, and micro-SD card to expand beyond the basic 16GB eMMC), so I
think it makes sense to try to enable them and pick up a minimal set
of the less than ideal code snippets for that. We'll end up with a
better supported and more solid kernel if we can get distros such as
Fedora and Debian to ship with these upstream kernels instead of the
vendor tree (which is 3.8 based in this case, and won't ever move
forward).


-Olof
