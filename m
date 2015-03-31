From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 31 Mar 2015 14:42:24 -0400 (EDT)
Subject: [RFC PATCH 2/2] Kbuild: avoid partial linking of
 drivers/built-in.o
In-Reply-To: <20150331161026.GA17480@e103592.cambridge.arm.com>
References: <1427716167-25078-1-git-send-email-ard.biesheuvel@linaro.org>
 <1427716167-25078-3-git-send-email-ard.biesheuvel@linaro.org>
 <551943CB.3010303@suse.cz> <20150330132617.GI24899@n2100.arm.linux.org.uk>
 <CAKv+Gu8-4XR5D-0_JnVfS2LNkH_Uvcc5txe4wJhwZogc5hZ-1w@mail.gmail.com>
 <551959F1.4030704@suse.cz>
 <CAKv+Gu-gRuf8L+NKtez4Jm9Mqe1HeeufH9MPqRztLcD+NTo+sA@mail.gmail.com>
 <alpine.LFD.2.11.1503311115300.25806@knanqh.ubzr>
 <20150331161026.GA17480@e103592.cambridge.arm.com>
Message-ID: <alpine.LFD.2.11.1503311429240.25806@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 31 Mar 2015, Dave Martin wrote:

> On Tue, Mar 31, 2015 at 11:22:29AM -0400, Nicolas Pitre wrote:
> > On Mon, 30 Mar 2015, Ard Biesheuvel wrote:
> > 
> > > On 30 March 2015 at 16:13, Michal Marek <mmarek@suse.cz> wrote:
> 
> [...]
> 
> > > > What you could do is to add a Kconfig option to arch/arm/Kconfig adding
> > > > -ffunction-sections to the compiler flags. Then allyesconfig would
> > > > select it and work around the problem in a somewhat elegant way.
> > > >
> > > 
> > > Excellent idea! Arnd hasn't chimed in yet, but he is the one doing
> > > lots and lots of randconfig builds and other test builds, so I will
> > > wait for him to confirm that this is a useful thing to have.
> > 
> > I'm using -ffunction-sections as well for the kernel size reduction work 
> > I'm currently doing.  The linker script has to be adapted so .text.* is 
> > specified along .text otherwise those functions end up appended at the 
> > end of the binary.
> 
> Interesting ... do you also mean using --gc-sections at link time?

Yes.

> We'd need to avoid pruning needed code that has no explicit caller,
> and functions that are part of the kernel/module ABI but not used
> within vmlinux.

Those are usually located in special sections, like the initcall table, 
the CPU entry table, etc. The linker allows for those sections to be 
marked with KEEP() not to prune them.

> The GCC docs suggest that -ffunction-sections may impact performance
> and/or increase code size, but I don't know by how much.  Maybe it
> interferes with inling.

It doesn't interfere with inlining. However it impose a section 
alignment on every function. That still can be overriden though. Also, I 
suppose that gcc may not assume that calls to a global function that 
happens to be located in the same C file will be close by anymore, 
however I don't see this having any impact on ARM code generation.


Nicolas
