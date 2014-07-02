From: will.deacon@arm.com (Will Deacon)
Date: Wed, 2 Jul 2014 11:01:33 +0100
Subject: Android and compatibility with deprecated armv7 instructions
In-Reply-To: <20140701234800.GA23577@sirena.org.uk>
References: <CAMbhsRSzDYqDnLbicYYNq+=J1N8hZ0fu-mik+UNLs0cBfUf8DA@mail.gmail.com>
 <CAOesGMh25XO=PYSSTbYkoVrQER=09mnKt68LMbLVT4+dBa716w@mail.gmail.com>
 <20140701234800.GA23577@sirena.org.uk>
Message-ID: <20140702100133.GE18731@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 02, 2014 at 12:48:00AM +0100, Mark Brown wrote:
> On Tue, Jul 01, 2014 at 04:42:01PM -0700, Olof Johansson wrote:
> > On Tue, Jul 1, 2014 at 4:06 PM, Colin Cross <ccross@google.com> wrote:
> > > Would you consider taking support for SWP emulation, enabling CP15
> > > barriers (CP15BEN bit only until there's a real device that needs
> > > emulation, also requires clearing COMPAT_PSR_E_BIT in
> > > compat_setup_return) and enabling SETEND, all behind a default-off
> > > CONFIG_DEPRECATED_ARMV7_COMPAT?
> 
> > It sounds really silly to push back against this, since it's actually
> > needed by so many platforms out there.

The big problem with emulating instructions that don't even appear in the
hardware anymore is that we end up creating baggage which we can *never*
remove.

I'm against SWP emulation in the kernel for a number of reasons:

  (1) The hardware doesn't have the instruction at all. If we start
      emulating it, then we'll always have to emulate it and it doesn't
      encourage software migration.

  (2) I'm not convinced that it can't be handled in userspace by trapping
      the SIGILL and emulating there (admittedly, this sounds difficult).

  (3) The usual uses of SWP are in homebrew locking implementations and
      are almost certainly a _bug_. For those v7 CPUs that could do SWP,
      it's not even guaranteed to be atomic iirc. Trapping and emulating
      is also bad for performance (although I note that Colin made an
      argument that it was acceptable).

  (4) This only affects legacy binaries. Should we also try to support OABI?
      How about misaligned ldm/stm? We have to draw the line somewhere.

The CP15 barriers are a more interesting case, as the CPUs can *currently*
support those if we flip a bit in the SCTLR. However, I see that as a
slippery slope to emulation if CPUs stop supporting those instructions in
the future (they almost certainly will).

Whilst I appreciate that people are being bitten by this lack of emulation
support, the vast majority of AArch32 code out there is working fine with
the existing compat layer. I think the right way to solve this problem is
to fix the code making use of the missing instructions.

Will
