From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 31 Mar 2015 17:34:59 +0100
Subject: [RFC PATCH 2/2] Kbuild: avoid partial linking of
 drivers/built-in.o
In-Reply-To: <20150331161026.GA17480@e103592.cambridge.arm.com>
References: <1427716167-25078-1-git-send-email-ard.biesheuvel@linaro.org>
 <1427716167-25078-3-git-send-email-ard.biesheuvel@linaro.org>
 <551943CB.3010303@suse.cz>
 <20150330132617.GI24899@n2100.arm.linux.org.uk>
 <CAKv+Gu8-4XR5D-0_JnVfS2LNkH_Uvcc5txe4wJhwZogc5hZ-1w@mail.gmail.com>
 <551959F1.4030704@suse.cz>
 <CAKv+Gu-gRuf8L+NKtez4Jm9Mqe1HeeufH9MPqRztLcD+NTo+sA@mail.gmail.com>
 <alpine.LFD.2.11.1503311115300.25806@knanqh.ubzr>
 <20150331161026.GA17480@e103592.cambridge.arm.com>
Message-ID: <20150331163459.GU24899@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 31, 2015 at 05:27:22PM +0100, Dave Martin wrote:
> On Tue, Mar 31, 2015 at 11:22:29AM -0400, Nicolas Pitre wrote:
> > I'm using -ffunction-sections as well for the kernel size reduction work 
> > I'm currently doing.  The linker script has to be adapted so .text.* is 
> > specified along .text otherwise those functions end up appended at the 
> > end of the binary.
> 
> Interesting ... do you also mean using --gc-sections at link time?
> We'd need to avoid pruning needed code that has no explicit caller,
> and functions that are part of the kernel/module ABI but not used
> within vmlinux.
> 
> The GCC docs suggest that -ffunction-sections may impact performance
> and/or increase code size, but I don't know by how much.  Maybe it
> interferes with inling.

I've mentioned these options over the course of the last couple of
months.  David Woodhouse replied in February, so it's worth reading
up on that work.

David Woodhouse wrote:
| In many kernel configurations there are actually quite a lot of
| functions that are never called, and I was quite surprised the first
| time I played with this stuff.
| 
| There are a few ways of dealing with it. One is to use
| -ffunction-section -fdata-sections --gc-sections as you noted. I once
| also played with using GCC's --combine during the brief period that it
| was supported and not *entirely* broken, with similar effects:
| https://lwn.net/Articles/197097/
| 
| These days, the better answer is probably LTO. We could potentially
| still look at --gc-sections, but I suspect we're better off using LTO
| and just filing toolchain bugs until everything that --gc-sections
| *would* have dropped is also dropped from the LTO build :)
| 
| Unless --gc-sections actually speeds up the build in a significant way;
| a full LTO link of the kernel takes insane amounts of memory IIRC.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
