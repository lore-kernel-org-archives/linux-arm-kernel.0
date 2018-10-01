From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 1 Oct 2018 19:13:41 +0100
Subject: [PATCH] ARM: makefile: pass -march=armv4 to assembler even on
 CPU32v3
In-Reply-To: <CAKv+Gu9Z5AnT07_N0MCBMNKO7fd_42DS0qFGP-gubD9DxLiYDA@mail.gmail.com>
References: <20180930024904.14240-1-Jason@zx2c4.com>
 <20181001175622.GT30658@n2100.armlinux.org.uk>
 <CAKv+Gu9Z5AnT07_N0MCBMNKO7fd_42DS0qFGP-gubD9DxLiYDA@mail.gmail.com>
Message-ID: <20181001181341.GU30658@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 01, 2018 at 08:10:26PM +0200, Ard Biesheuvel wrote:
> On 1 October 2018 at 19:56, Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
> > On Sun, Sep 30, 2018 at 04:49:04AM +0200, Jason A. Donenfeld wrote:
> >> Per the discussion about half-way down in [1], the kernel doesn't
> >> actually support the ARMv3 ISA, but selects it for some ARMv4 ISA
> >> hardware that benefits from ARMv3 code generation.
> >
> > The issue is to do with the half-word stores in the ARMv4 ISA, which
> > need to be avoided on StrongARM RiscPC - the bus from the processor
> > card (which was designed for ARM610 and ARM710) does not support
> > anything except 8-bit and 32-bit accesses, so the 16-bit load/store
> > instructions don't work correctly.
> >
> > Obviously, the reason for having the compiler use ARMv3 is to avoid
> > those instructions which we have no other way to prevent - however,
> > the use of ARMv3 with the assembler ensures that ldrh/strh are not
> > accidentally used.
> >
> > We could argue that the ARMv3 assembly files are now stable, so the
> > chances of ldrh/strh being introduced is low, which would make this
> > change tolerable, but the commit message needs to spell out that
> > we lose this protection.
> >
> >> Such a consideration,
> >> then, only applies to the compiler but not to the assembler. This commit
> >> passes -march=armv4 to the assembler in those cases, so that code
> >> written for ARMv4 will continue to compile and run fine, without needing
> >> module-specific asflags-y overrides.
> >
> > Note that "code written for ARMv4" will not be usable on this platform
> > if it makes use of ldrh/strh, so depending on which instructions the
> > assembler is complaining about, it could very well be a real "you're
> > doing something wrong" case.
> >
> > The side effect of this patch is that such cases will now be hidden
> > rather than evaluated on a case-by-case basis.
> >
> 
> Thanks for the insight.
> 
> So Arnd's suggestion to switch to armv3-m would actually be feasible
> then? The code in question does not use ldrh only umull, and so it
> should build with armv3m as well. And we will even generate some
> better code for RiscPC if we apply it to both the cflags and the
> asflags.

Yep.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 14.8Mbps down 650kbps up
According to speedtest.net: 13Mbps down 490kbps up
