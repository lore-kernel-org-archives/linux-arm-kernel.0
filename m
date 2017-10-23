From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 23 Oct 2017 11:50:46 +0100
Subject: [PATCH] ARM: Fix zImage file size not aligned with
 CONFIG_EFI_STUB enabled
In-Reply-To: <59EDC34C.40109@rock-chips.com>
References: <20171018050108.10352-1-jeffy.chen@rock-chips.com>
 <CAKv+Gu9ReBC+rLxaD-+Mp+aWRDfsYECAeOZo9CYU3big2nPw0w@mail.gmail.com>
 <20171022124757.GL20805@n2100.armlinux.org.uk>
 <CAKv+Gu9cgt0sjW_pnaXN6J8j8BXAb7z+gLhDY3oMaKwK5vcO-Q@mail.gmail.com>
 <59ED6179.5020301@rock-chips.com>
 <20171023085006.GM20805@n2100.armlinux.org.uk>
 <59EDC34C.40109@rock-chips.com>
Message-ID: <20171023105046.GT20805@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 23, 2017 at 06:24:12PM +0800, jeffy wrote:
> Hi Russell,
> 
> Thanks for your reply.
> 
> On 10/23/2017 04:50 PM, Russell King - ARM Linux wrote:
> >>>
> >>>hmm, right, didn't notice the data is already aligned...
> >>>so it's indeed caused by the ksym:
> >>>
> >>>   [ 9] .data             PROGBITS        006ce000 6d6000 000200 00  WA  0
> >>>0 4096
> >>>   [10] ___ksymtab+sort   PROGBITS        006ce200 6d6200 000008 00  WA  0
> >>>0  4
> >>>   [11] .bss              NOBITS          006ce208 6d6208 00001c 00  WA  0
> >>>0  4
> >It's earlier - look for __ksymtab_strings.
> 
> the problem i meet is the appended dtb code found dtb invalid. i thought
> that is because of unaligned zImage size, but i was wrong...

Hmm, you really ought not to be using the appended dtb code for modern
systems - the appended dtb system is there for old boot loaders that
are incapable of dealing with a dtb.  As is said in the option's help
text:

  This is meant as a backward compatibility convenience for those
  systems with a bootloader that can't be upgraded to accommodate
  the documented boot protocol using a device tree.

  Beware that there is very little in terms of protection against
  this option being confused by leftover garbage in memory that might
  look like a DTB header after a reboot if no actual DTB is appended
  to zImage.  Do not leave this option active in a production kernel
  if you don't intend to always append a DTB.  Proper passing of the
  location into r2 of a bootloader provided DTB is always preferable
  to this option.

If you rely on it, and you have something that looks like a dtb after
the image, then things will go wrong, so it's better _not_ to use it
and to keep it disabled.

That aside, thanks for doing a more in-depth analysis of what is going
on, which helps to understand /why/ Ard's fix works (whereas before
it was rather nebulous.)

I wonder whether we ought to tell the linker to discard any unknown
sections by adding at the bottom:

	/DISCARD/ { *(*) }

but I do think we need to document this, specifically that _edata must
point to the first byte after the binary file, and that the only
sections after it are allowed to be the .bss and stack sections.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
