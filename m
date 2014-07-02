From: will.deacon@arm.com (Will Deacon)
Date: Wed, 2 Jul 2014 13:34:44 +0100
Subject: [PATCH v2] ARM: save/restore diagnostic register on Cortex-A9
 suspend/resume
In-Reply-To: <53B2E11D.5000507@samsung.com>
References: <1403432119-1409-1-git-send-email-shawn.guo@freescale.com>
 <53A9A746.6080200@samsung.com> <20140624163320.GM9121@arm.com>
 <53A9B80B.7020608@samsung.com>
 <20140701144417.GV32514@n2100.arm.linux.org.uk>
 <53B2E11D.5000507@samsung.com>
Message-ID: <20140702123444.GB24879@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

I asked the hardware guys to take a closer look at your issue and they've
uncovered the problem with trying to document an undocumented register.

On Tue, Jul 01, 2014 at 05:26:05PM +0100, Tomasz Figa wrote:
> On 01.07.2014 16:44, Russell King - ARM Linux wrote:
> > On Tue, Jun 24, 2014 at 07:40:27PM +0200, Tomasz Figa wrote:
> >> On 24.06.2014 18:33, Will Deacon wrote:
> >>> On A9, it should be write-ignore. Are you seeing problems on a real SoC?
> >>
> >> I'm observing a complete system hang on Exynos4412-based Trats2 board if
> >> I try to write this register in resume from system-wide sleep.

In actual fact, this register causes an undefined instruction exception if
you try to write it from a non-secure mode (although reads work fine, for
whatever that's worth). That nicely explains what you're seeing, but it
leaves us in a right old two and eight with respect to the suspend/resume
code.

Given that we don't know whether we're running secure or non-secure, I'm
not sure about the best approach to solve this. For arm64, we simply mandate
booting non-secure and require firmware to do everything that requires
secure access, but we're not in a position to attempt imposing these sorts
of restrictions for arch/arm/.

Does anybody have any ideas? We could try `handling' the undef, but it's
ugly and fragile.

Anyway, apologies for the mistake earlier on -- I assumed the documentation
I had was correct.

Will
