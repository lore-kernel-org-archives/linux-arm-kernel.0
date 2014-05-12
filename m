From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 12 May 2014 16:17:47 +0100
Subject: [PATCH 2/3] arm64: cpuinfo: print info for all CPUs
In-Reply-To: <CAKv+Gu8-=GjaFZjvcB4zNJyRNXOX8UnbCw-MCvuNFZmAb6xLug@mail.gmail.com>
References: <1399905470-26500-1-git-send-email-mark.rutland@arm.com>
 <1399905470-26500-3-git-send-email-mark.rutland@arm.com>
 <CAKv+Gu8-=GjaFZjvcB4zNJyRNXOX8UnbCw-MCvuNFZmAb6xLug@mail.gmail.com>
Message-ID: <20140512151747.GA10661@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 12, 2014 at 03:54:50PM +0100, Ard Biesheuvel wrote:
> Hi Mark,
 
Hi Ard,

> On 12 May 2014 16:37, Mark Rutland <mark.rutland@arm.com> wrote:
> > Currently reading /proc/cpuinfo will result in information being read
> > out of the MIDR_EL1 of the current CPU, and the information is not
> > associated with any particular logical CPU number.
> >
> > This is problematic for systems with heterogeneous CPUs (i.e.
> > big.LITTLE) where fields will vary across CPUs, and the output will
> > differ depending on the executing CPU. Additionally the output is
> > different in format to the 32-bit ARM Linux port, where information is
> > printed out for each CPU.
> >
> > This patch adds the necessary infrastructure to log the relevant
> > registers (currently just MPIDR_EL1) and print out the logged
> > information.
> >
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Jacob Bramley <jacob.bramley@arm.com>
> > ---
> >  arch/arm64/include/asm/cpu.h | 30 +++++++++++++++++++++++++++++
> >  arch/arm64/kernel/Makefile   |  2 +-
> >  arch/arm64/kernel/cpuinfo.c  | 30 +++++++++++++++++++++++++++++
> >  arch/arm64/kernel/setup.c    | 46 +++++++++++++++++++++++---------------------
> >  arch/arm64/kernel/smp.c      |  6 ++++++
> >  5 files changed, 91 insertions(+), 23 deletions(-)
> >  create mode 100644 arch/arm64/include/asm/cpu.h
> >  create mode 100644 arch/arm64/kernel/cpuinfo.c
> >

[...]

> > -       /* dump out the processor features */
> > -       seq_puts(m, "Features\t: ");
> > +               /* dump out the processor features */
> > +               seq_puts(m, "Features\t: ");
> >
> > -       for (i = 0; hwcap_str[i]; i++)
> > -               if (elf_hwcap & (1 << i))
> > -                       seq_printf(m, "%s ", hwcap_str[i]);
> > +               for (i = 0; hwcap_str[i]; i++)
> > +                       if (elf_hwcap & (1 << i))
> > +                               seq_printf(m, "%s ", hwcap_str[i]);
> >
> 
> Considering that you are printing the contents of the same variable
> every iteration, and the fact that your subsequent patch makes sure
> elf_hwcap is in sync between all CPUs, doesn't it make more sense to
> print this line only once?

Hmm, I'd meant to update this to parse hwcaps (or display purposes)
per-cpu.

Given everyone else (at least arm and x86) print features/flags per-cpu
even when they should be identical, I'm not sure I see the point of
breaking the pattern. I'd prefer to look the same, if nothing else it's
what users expect.

Cheers,
Mark.
