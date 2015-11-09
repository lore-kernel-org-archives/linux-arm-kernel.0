From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 9 Nov 2015 15:26:54 +0000
Subject: [PATCH v12 1/7] arm64: renesas: r8a7795: Add Renesas R8A7795 SoC
 support
In-Reply-To: <20151109021303.GA30553@verge.net.au>
References: <1445839312-8874-1-git-send-email-horms+renesas@verge.net.au>
 <1445839312-8874-2-git-send-email-horms+renesas@verge.net.au>
 <20151028184504.GG8899@e104818-lin.cambridge.arm.com>
 <CANqRtoT-7hhAN907KQFYwrP7+B7tVZdDEpp0SPrnXG3YrDbKoQ@mail.gmail.com>
 <20151030110835.GB2854@e104818-lin.cambridge.arm.com>
 <CAMuHMdWD0CXSoSgqzuDU7sdyqaBFWb3wQSPOxYxSvwJbhwRhwQ@mail.gmail.com>
 <20151109021303.GA30553@verge.net.au>
Message-ID: <20151109152654.GC21606@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 09, 2015 at 11:13:04AM +0900, Simon Horman wrote:
> On Fri, Oct 30, 2015 at 12:19:34PM +0100, Geert Uytterhoeven wrote:
> > On Fri, Oct 30, 2015 at 12:08 PM, Catalin Marinas
> > <catalin.marinas@arm.com> wrote:
> > > On Thu, Oct 29, 2015 at 02:15:19PM +0900, Magnus Damm wrote:
> > >> The two most common cases with SoC-specific IP for Renesas SoCs tend
> > >> to be Pinctrl which is using rather large tables to support the PFC
> > >> hardware and also the clocks (CCF) that drives the SoC specific CPG
> > >> hardware. For the PFC and CPG I think it makes sense to enable build
> > >> based on SoC model like we do already, but for the Kconfig bits in
> > >> arch/arm64 perhaps ARCH_RENESAS can simply select ARCH_R8A7795?
> > >
> > > I'm suggesting the other way around: CONFIG_PINCTRL_R8A7795 which
> > > depends on ARCH_RENESAS, default y. Similarly for clocks and other
> > > drivers.
> > 
> > For drivers in general I agree.
> > 
> > Pinctrl and clocks (and perhaps a few others we haven't implemented support
> > for yet) are special, as they are core SoC-support: either you want all of it,
> > or nothing.
> > 
> > E.g. a kernel with CONFIG_PINCTRL_R8A7795=y but CONFIG_CLK_R8A7795=n
> > won't get you far.
> 
> If I could be so bold as to summarise the concerns they are:
> 
> * On the one hand there is a desire to make configuration as simple as
>   possible. If I understand things correctly this is the main motivation
>   for requesting the removal of ARCH_R8A7795.

Yes.

> * On the other hand there is a desire to give users the flexibility to
>   easily configure their kernel for a single Renesas SoC. In particular
>   to make sure that the appropriate PFC (PINCTRL) and CPG (CLK) drivers are
>   present. A key reason that users want such flexibility is to reduce
>   the size of their kernels: in particular the PFC drives are rather large.

The flexibility would still be there with individual CONFIG_PINCTRL...
but IIUC, what you want is to be able to easily select only
ARCH_R8A7795. If you start from defconfig, there are a lot more things
to disable already, so I don't see how ARCH_R8A7795 helps here. Unless
you start from allnoconfig and build up your configuration which,
again, requires considerable more work (not something I would call
easy).

> With the above in mind I wonder if a good solution would be to keep
> ARCH_R8A7795 but to guard it with CONFIG_EXPERT.

We either keep it or remove it altogether, I don't see much point in a
dependency on EXPERT.

> Non-expert users would get all Renesas SoCs if the Renesas family is
> selected: the simple configuration that I believe Catalin desires.
> While expert users would have an easy way to select specific SoCs once
> they have enabled EXPERT. Not a terrible burden for them in my opinion.

It's not about allowing "expert" users to select certain features but
whether we want to continue the model of individual SoC support in arm64
vs. SoC _family_ with a possibility to trim down unwanted drivers
(including pinctrl, clocks) which are not needed for a SoC-specific
kernel.

Anyway, I'll leave the decision to the arm-soc folk.

-- 
Catalin
