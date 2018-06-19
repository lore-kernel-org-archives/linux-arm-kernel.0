From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 19 Jun 2018 16:12:35 +0100
Subject: [RFC PATCH] ARM: Use logical or instead of addition for badr
 address calculation
In-Reply-To: <CAKv+Gu-T8Fx3Nry7pUdOoOeRU-Ns89w3oo4itmu1q4FzYF5Rag@mail.gmail.com>
References: <1529384828-2452-1-git-send-email-linux@roeck-us.net>
 <CAKv+Gu8Byj7G3Awnq4Y90Wot=GJTx0gO5A7-960au9ZkBBL2=A@mail.gmail.com>
 <b8bff03d-91a7-0e53-a44e-d1924beb382d@roeck-us.net>
 <CAKv+Gu-T8Fx3Nry7pUdOoOeRU-Ns89w3oo4itmu1q4FzYF5Rag@mail.gmail.com>
Message-ID: <20180619151235.GH17671@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 19, 2018 at 03:35:07PM +0200, Ard Biesheuvel wrote:
> On 19 June 2018 at 15:29, Guenter Roeck <linux@roeck-us.net> wrote:
> > Hi Ard,
> >
> >
> > On 06/19/2018 12:48 AM, Ard Biesheuvel wrote:
> >>
> >> On 19 June 2018 at 07:07, Guenter Roeck <linux@roeck-us.net> wrote:
> >>>
> >>> Modern assemblers may take the ISA into account when resolving local
> >>> symbols. This can result in bad address calculations when using badr
> >>> in the wrong location since the offset + 1 may be added twice, resulting
> >>> in an even address target for THUMB instructions. This in turn results
> >>> in an exception at (destination address + 2).
> >>>
> >>> Unhandled exception: IPSR = 00000006 LR = fffffff1
> >>> CPU: 0 PID: 1 Comm: init Not tainted 4.18.0-rc1-00026-gf773e5bdf0c9 #15
> >>> Hardware name: MPS2 (Device Tree Support)
> >>> PC is at ret_fast_syscall+0x2/0x58
> >>> LR is at tty_ioctl+0x2a5/0x528
> >>> pc : [<21009002>]    lr : [<210d1535>]    psr: 4000000b
> >>> sp : 21825fa8  ip : 0000001c  fp : 21a95892
> >>> r10: 00000000  r9 : 21824000  r8 : 210091c0
> >>> r7 : 00000036  r6 : 21ae1ee0  r5 : 00000000  r4 : 21ae1f3c
> >>> r3 : 00000000  r2 : 3d9adc25  r1 : 00000000  r0 : 00000000
> >>> xPSR: 4000000b
> >>> CPU: 0 PID: 1 Comm: init Not tainted 4.18.0-rc1-00026-gf773e5bdf0c9 #15
> >>> Hardware name: MPS2 (Device Tree Support)
> >>> [<2100bd8d>] (unwind_backtrace) from [<2100b13b>] (show_stack+0xb/0xc)
> >>> [<2100b13b>] (show_stack) from [<2100b87b>] (__invalid_entry+0x4b/0x4c)
> >>>
> >>> Fix the problem by using a logical or instead of an addition. This is
> >>> less efficient but guaranteed to work.
> >>>
> >>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> >>> ---
> >>> RFC: I don't really like this, but my ARM assembler knowledge is quite
> >>> limited. Just dropping the "+ 1" from badr doesn't work because some
> >>> other code needs it (the image hangs completely if I try that).
> >>> Ultimately I don't even know if the invoke_syscall macro should just
> >>> have used adr instead of badr (but then how did this ever work ?).
> >>>
> >>> Seen with various toolchains based on gcc 7.x and binutils 2.30 when
> >>> building and testing MPS2 images.
> >>>
> >>
> >> Hello Guenter,
> >>
> >> This issue has been discussed before. It appears the binutils people
> >> suddenly started caring about the thumb annotation of local function
> >> symbols, resulting in behavior that is not backwards compatible.
> >>
> >> https://marc.info/?l=linux-arm-kernel&m=151143776213636&w=2
> >> https://sourceware.org/bugzilla/show_bug.cgi?id=21458
> >>
> >> Can you try the fix below please?
> >>
> >>>   arch/arm/include/asm/assembler.h | 3 ++-
> >>>   1 file changed, 2 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/arch/arm/include/asm/assembler.h
> >>> b/arch/arm/include/asm/assembler.h
> >>> index 0cd4dccbae78..24c87ff2060f 100644
> >>> --- a/arch/arm/include/asm/assembler.h
> >>> +++ b/arch/arm/include/asm/assembler.h
> >>> @@ -195,7 +195,8 @@
> >>>          .irp    c,,eq,ne,cs,cc,mi,pl,vs,vc,hi,ls,ge,lt,gt,le,hs,lo
> >>>          .macro  badr\c, rd, sym
> >>>   #ifdef CONFIG_THUMB2_KERNEL
> >>> -       adr\c   \rd, \sym + 1
> >>> +       adr\c   \rd, \sym
> >>> +       orr     \rd, #1
> >>>   #else
> >>>          adr\c   \rd, \sym
> >>>   #endif
> >>> --
> >>> 2.7.4
> >>
> >>
> >> ----------8<------------
> >> From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >> Date: Tue, 16 Jan 2018 12:12:45 +0000
> >> Subject: [PATCH] ARM: assembler: prevent ADR from setting the Thumb bit
> >> twice
> >>
> >> To work around recent issues where ADR references to Thumb function
> >> symbols may or may not have the Thumb bit set already when they are
> >> resolved by GAS, reference the symbol indirectly via a local symbol
> >> typed as 'object', stripping the ARM/Thumb annotation.
> >>
> >> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >>
> >> diff --git a/arch/arm/include/asm/assembler.h
> >> b/arch/arm/include/asm/assembler.h
> >> index 6ae42ad29518..dd2ff94ad90b 100644
> >> --- a/arch/arm/include/asm/assembler.h
> >> +++ b/arch/arm/include/asm/assembler.h
> >> @@ -195,13 +195,19 @@
> >>          .irp    c,,eq,ne,cs,cc,mi,pl,vs,vc,hi,ls,ge,lt,gt,le,hs,lo
> >>          .macro  badr\c, rd, sym
> >>   #ifdef CONFIG_THUMB2_KERNEL
> >> -       adr\c   \rd, \sym + 1
> >> +       __badr  \c, \rd, \sym
> >>   #else
> >>          adr\c   \rd, \sym
> >>   #endif
> >>          .endm
> >>          .endr
> >>
> >> +       /* this needs to be a separate macro or \@ does not work correctly
> >> */
> >> +       .macro  __badr, c, rd, sym
> >> +       .eqv    .Lsym\@, \sym
> >> +       adr\c   \rd, .Lsym\@ + 1
> >
> >
> > Wild shot, but the following works for me.
> >
> >         .eqv    .Lsym\@, \sym + 1
> >         adr\c   \rd, .Lsym\@
> >
> > Does it make sense ?
> >
> 
> Interesting. Do you mean this works with your 2.30 binutils that
> triggers the original issue?
> 
> If so, then yes, it makes sense, although it still seems fragile,
> since we are relying on \sym being resolved without the Thumb bit in
> the context of the .eqv pseudo op. But if this works across all
> implementations we care about, I would be fine with it.
> 
> Russell?

Apart from my thoughts about the toolchain changing behaviour after
many years...

It seems that the .eqv solution works on my assembler for the files
I've tested it with, which is great.  However...

I'm left wondering how long it will be before the toolchain people
decide to propagate the thumb bit through the .eqv - is the behaviour
there explicitly documented that it won't, or is the above relying on
observed behaviour with a particular assembler version.  It could
also be that there's versions out there that do this already.

I think it's really up to _toolchain people_ to tell us how to solve
the problem _they've_ created, rather than us floundering around in
the dark using undocumented behaviour that could well change in the
future.

So, I'm going to continue sitting on the fence on this, and basically
take the attitude that it's better that people don't use the new
binutils until binutils people can provide us with an officially
sanctioned solution that's going to work for both older and future
assemblers.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
