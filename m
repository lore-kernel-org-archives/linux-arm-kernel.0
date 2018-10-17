From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 17 Oct 2018 10:23:17 -0400 (EDT)
Subject: [PATCH 1/2] ARM: copypage-fa: add kto and kfrom to input operands
 list
In-Reply-To: <CAK8P3a3XUdkBmrnMUn2TePEBAh49=QvvxRiOk_+JnSp1fSwXJg@mail.gmail.com>
References: <20181015221629.13924-1-stefan@agner.ch>
 <CACRpkdaVGKLtE-whhK3oFgY+4xoy1JqWkcBW4UO0-hJs2B-QGg@mail.gmail.com>
 <20181016084416.GF30658@n2100.armlinux.org.uk>
 <nycvar.YSQ.7.76.1810161357580.1498@knanqh.ubzr>
 <CAK8P3a3XUdkBmrnMUn2TePEBAh49=QvvxRiOk_+JnSp1fSwXJg@mail.gmail.com>
Message-ID: <nycvar.YSQ.7.76.1810171009560.1498@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 17 Oct 2018, Arnd Bergmann wrote:

> On Tue, Oct 16, 2018 at 10:43 PM Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> > On Tue, 16 Oct 2018, Russell King - ARM Linux wrote:
> > > On Tue, Oct 16, 2018 at 10:00:19AM +0200, Linus Walleij wrote:
> > > > On Tue, Oct 16, 2018 at 12:16 AM Stefan Agner <stefan@agner.ch> wrote:
> > > It's not obvious yet whether this is right - it contradicts the GCC
> > > manual, but then we have evidence that it's required for some GCC
> > > versions where GCC may clone the function, or if the function is
> > > used within the same file.
> >
> > Why not getting rid of __naked altogether? Here's what I suggest:
> >
> > ----- >8
> > Subject: [PATCH] ARM: remove naked function usage
> >
> > Convert page copy functions not to rely on the naked function attribute.
> >
> > This attribute is known to confuse some gcc versions when function
> > arguments aren't explicitly listed as inline assembly operands despite
> > the gcc documentation. That resulted in commit 9a40ac86152c ("ARM:
> > 6164/1: Add kto and kfrom to input operands list.").
> 
> It's probably worth noting that the minimum gcc version for compiling
> the kernel is now gcc-4.6, which I think does not suffer from the gcc-4.5
> bug that triggered the change. See in particular commits 9c695203a7dd
> ("compiler-gcc.h: gcc-4.5 needs noclone and noinline on __naked functions")
> and d124b44f09ca ("Compiler Attributes: naked was fixed in gcc 4.6").
> 
> The first one made sure we don't inline these functions, so gcc-4.5
> no longer runs into the problem even in the absence of the workaround,
> and the second patch reverts that again, noting that gcc-4.6 is fixed.
> 
> I don't see anything wrong with converting the functions to not
> use __naked at all, but I think we can also just revert the original
> commit 9a40ac86152c to get it to build with clang. When I last
> played with clang on arm32, that's what I did. I'll reply with the
> patch I have in my randconfig tree.

The __naked attribute has idiosyncrasies of its own, regardless of any 
potential bugs, that sometimes makes it harder to maintain and prevent 
extra optimizations that the compiler could otherwise take care of. So I 
think that this is a good thing to get rid of __naked when its usage 
isn't necessary, like the instances in this patch.

The remaining instances are cases where there is simply no stack 
available making __naked necessary in those cases.


Nicolas
