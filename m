From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 2 Jul 2014 15:01:34 +0100
Subject: [PATCH v2] ARM: save/restore diagnostic register on Cortex-A9
 suspend/resume
In-Reply-To: <20140702123444.GB24879@arm.com>
References: <1403432119-1409-1-git-send-email-shawn.guo@freescale.com>
 <53A9A746.6080200@samsung.com> <20140624163320.GM9121@arm.com>
 <53A9B80B.7020608@samsung.com>
 <20140701144417.GV32514@n2100.arm.linux.org.uk>
 <53B2E11D.5000507@samsung.com> <20140702123444.GB24879@arm.com>
Message-ID: <20140702140134.GA21091@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 02, 2014 at 01:34:44PM +0100, Will Deacon wrote:
> Hi Tomasz,
> 
> I asked the hardware guys to take a closer look at your issue and they've
> uncovered the problem with trying to document an undocumented register.
> 
> On Tue, Jul 01, 2014 at 05:26:05PM +0100, Tomasz Figa wrote:
> > On 01.07.2014 16:44, Russell King - ARM Linux wrote:
> > > On Tue, Jun 24, 2014 at 07:40:27PM +0200, Tomasz Figa wrote:
> > >> On 24.06.2014 18:33, Will Deacon wrote:
> > >>> On A9, it should be write-ignore. Are you seeing problems on a real SoC?
> > >>
> > >> I'm observing a complete system hang on Exynos4412-based Trats2 board if
> > >> I try to write this register in resume from system-wide sleep.
> 
> In actual fact, this register causes an undefined instruction exception if
> you try to write it from a non-secure mode (although reads work fine, for
> whatever that's worth). That nicely explains what you're seeing, but it
> leaves us in a right old two and eight with respect to the suspend/resume
> code.
> 
> Given that we don't know whether we're running secure or non-secure, I'm
> not sure about the best approach to solve this. For arm64, we simply mandate
> booting non-secure and require firmware to do everything that requires
> secure access, but we're not in a position to attempt imposing these sorts
> of restrictions for arch/arm/.
> 
> Does anybody have any ideas? We could try `handling' the undef, but it's
> ugly and fragile.

You could try to treat it the same way as ACTLR (see cpu_v7_do_resume,
where the ACTLR is first read, if it is already set, ie equal to the
saved value, skip the write); ACTLR suffers from the same issue and IIRC
that's why Russell added the "teq" then "write" test at the time
cpu_suspend was consolidated.

Lorenzo
