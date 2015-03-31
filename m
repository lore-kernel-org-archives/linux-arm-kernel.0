From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 31 Mar 2015 14:46:43 -0400 (EDT)
Subject: [RFC PATCH 2/2] Kbuild: avoid partial linking of
 drivers/built-in.o
In-Reply-To: <20150331163459.GU24899@n2100.arm.linux.org.uk>
References: <1427716167-25078-1-git-send-email-ard.biesheuvel@linaro.org>
 <1427716167-25078-3-git-send-email-ard.biesheuvel@linaro.org>
 <551943CB.3010303@suse.cz> <20150330132617.GI24899@n2100.arm.linux.org.uk>
 <CAKv+Gu8-4XR5D-0_JnVfS2LNkH_Uvcc5txe4wJhwZogc5hZ-1w@mail.gmail.com>
 <551959F1.4030704@suse.cz>
 <CAKv+Gu-gRuf8L+NKtez4Jm9Mqe1HeeufH9MPqRztLcD+NTo+sA@mail.gmail.com>
 <alpine.LFD.2.11.1503311115300.25806@knanqh.ubzr>
 <20150331161026.GA17480@e103592.cambridge.arm.com>
 <20150331163459.GU24899@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.11.1503311443360.25806@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 31 Mar 2015, Russell King - ARM Linux wrote:

> On Tue, Mar 31, 2015 at 05:27:22PM +0100, Dave Martin wrote:
> > On Tue, Mar 31, 2015 at 11:22:29AM -0400, Nicolas Pitre wrote:
> > > I'm using -ffunction-sections as well for the kernel size reduction work 
> > > I'm currently doing.  The linker script has to be adapted so .text.* is 
> > > specified along .text otherwise those functions end up appended at the 
> > > end of the binary.
> > 
> > Interesting ... do you also mean using --gc-sections at link time?
> > We'd need to avoid pruning needed code that has no explicit caller,
> > and functions that are part of the kernel/module ABI but not used
> > within vmlinux.
> > 
> > The GCC docs suggest that -ffunction-sections may impact performance
> > and/or increase code size, but I don't know by how much.  Maybe it
> > interferes with inling.
> 
> I've mentioned these options over the course of the last couple of
> months.  David Woodhouse replied in February, so it's worth reading
> up on that work.

Yup, I did.

> David Woodhouse wrote:
> | In many kernel configurations there are actually quite a lot of
> | functions that are never called, and I was quite surprised the first
> | time I played with this stuff.
> | 
> | There are a few ways of dealing with it. One is to use
> | -ffunction-section -fdata-sections --gc-sections as you noted. I once
> | also played with using GCC's --combine during the brief period that it
> | was supported and not *entirely* broken, with similar effects:
> | https://lwn.net/Articles/197097/
> | 
> | These days, the better answer is probably LTO. We could potentially
> | still look at --gc-sections, but I suspect we're better off using LTO
> | and just filing toolchain bugs until everything that --gc-sections
> | *would* have dropped is also dropped from the LTO build :)
> | 
> | Unless --gc-sections actually speeds up the build in a significant way;
> | a full LTO link of the kernel takes insane amounts of memory IIRC.

LTO indirectly achieve the same effect (and more), however it is 
frigging heavy and unwieldy for kernel builds.  And it has many subtle 
issues of its own that --gc-sections doesn't have.  I'm therefore 
looking at both in parallel.


Nicolas
