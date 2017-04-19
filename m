From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 19 Apr 2017 16:58:02 +0100
Subject: LDM/STM alignment fixups on arm64
In-Reply-To: <58F75D02.1030104@codeaurora.org>
References: <58F704D6.6000301@codeaurora.org>
 <20170419095830.GK17774@n2100.armlinux.org.uk>
 <58F75D02.1030104@codeaurora.org>
Message-ID: <20170419155801.GC3238@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 19, 2017 at 06:20:10PM +0530, Srinivas Ramana wrote:
> On 04/19/2017 03:28 PM, Russell King - ARM Linux wrote:
> >On Wed, Apr 19, 2017 at 12:03:58PM +0530, Srinivas Ramana wrote:
> >>While understanding how the alignment are handled on arm and arm64, we came
> >>across the fixups for LDM/LDRD/STM on arm where as these fixups are not
> >>present on arm64.
> >>
> >>There may be some specific reason why these fixups are not ported to arm64.
> >>Can you please help us understand this?
> >>
> >>With this difference in how kernel handles 32-bit apps on arm and arm64,
> >>there can be apps which are working without abort on arm, but fail on arm64
> >>(SIGBUS). We have tried to get some history on web, but not successful.
> >>
> >>If this is indeed missing on arm64, do you see any issue if its ported (does
> >>it fail any guidance)?
> >
> >Do you have an application that fails because of this?  Your email makes
> >it sound very theoretical.
> 
> I don't have any application with me right now. But i just tried passing an
> intentional misaligned address in a test program. When i say intentional,
> please note this code is buggy and should be fixed.
> 
> So, my question is when arm has such fixups to handle such cases and do
> gracefully, is there any reason why those fixups are not ported to arm64?

As Russell said, until we find some application in the wild I wouldn't
rush to provide such emulation. Such code is either broken or relying on
undefined C behaviour so they should rather be fixed. As with the
deprecated/obsolete ARMv7 instructions (SWP, CP15 barriers), we
initially decided not to implement the emulation in the arm64 kernel,
though we eventually accepted it. But in those cases the instructions
were once real and used correctly. The unaligned LDM/STM or LDRD/STRD
have never been supported by the ARM architecture. They were added to
cope with some unaligned accesses in the Linux kernel network stack (in
hindsight, they should have not been provided to user but maybe there
were good reasons, I don't know the full history here).

> Again, I do agree that apps has to fix these instances, but we do have
> fixups in arch/arm.

I also think the default on arch/arm should be SIGBUS for these
instructions on ARMv7 but this was discussed before on the list.

> I do see that the compiler can detect (if its not intentionally induced)
> such cases and avoiding to generate LDM/STM and generates multiple LDR/STR.
> So, I just want to know if it is safe to assume that the compiler would take
> care of all such misaligned addresses passed to LDM/STM?

The compiler won't detect if you break its alignment assumptions (i.e.
in your example pointers to struct locat are 64-bit aligned as per the
EABI/PCS). If you want the compiler to assume unaligned struct pointers,
you'd have to mark the structure with the packed attribute (with the
additional padding if necessary, not in your example though).

-- 
Catalin
