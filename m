From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 19 Jun 2014 12:31:29 +0100
Subject: [PATCHv2 2/4] arm64: cpuinfo: print info for all CPUs
In-Reply-To: <CAKv+Gu9XJnFizEtOxyyXAdUH0OQgBjxuOeCV8FB5ajXtGe5gJQ@mail.gmail.com>
References: <1403024674-25108-1-git-send-email-mark.rutland@arm.com>
 <1403024674-25108-3-git-send-email-mark.rutland@arm.com>
 <CAKv+Gu9XJnFizEtOxyyXAdUH0OQgBjxuOeCV8FB5ajXtGe5gJQ@mail.gmail.com>
Message-ID: <20140619113129.GC22217@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 18, 2014 at 07:29:01PM +0100, Ard Biesheuvel wrote:
> Hi Mark,

Hi Ard,

> On 17 June 2014 19:04, Mark Rutland <mark.rutland@arm.com> wrote:
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
> > registers (currently just MIDR_EL1) and print out the logged
> > information.
> >
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > ---
> >  arch/arm64/include/asm/cpu.h | 30 +++++++++++++++++++++++++++++
> >  arch/arm64/kernel/Makefile   |  3 ++-
> >  arch/arm64/kernel/cpuinfo.c  | 31 +++++++++++++++++++++++++++++
> >  arch/arm64/kernel/setup.c    | 46 +++++++++++++++++++++++---------------------
> >  arch/arm64/kernel/smp.c      |  6 ++++++
> >  5 files changed, 93 insertions(+), 23 deletions(-)
> >  create mode 100644 arch/arm64/include/asm/cpu.h
> >  create mode 100644 arch/arm64/kernel/cpuinfo.c
> >
> [...]
> > @@ -447,38 +447,40 @@ static const char *hwcap_str[] = {
> >
> >  static int c_show(struct seq_file *m, void *v)
> >  {
> > -       int i;
> > +       int c;
> >
> > -       seq_printf(m, "Processor\t: %s rev %d (%s)\n",
> > -                  cpu_name, read_cpuid_id() & 15, ELF_PLATFORM);
> > +       for_each_online_cpu(c) {
> > +               int i;
> > +               struct cpuinfo_arm64 *cpuinfo = &per_cpu(cpu_data, c);
> > +               u32 midr = cpuinfo->reg_midr;
> >
> > -       for_each_online_cpu(i) {
> >                 /*
> >                  * glibc reads /proc/cpuinfo to determine the number of
> >                  * online processors, looking for lines beginning with
> >                  * "processor".  Give glibc what it expects.
> >                  */
> >  #ifdef CONFIG_SMP
> > -               seq_printf(m, "processor\t: %d\n", i);
> > +               seq_printf(m, "processor\t: %d\n", c);
> >  #endif
> > -       }
> > +               seq_printf(m, "Type\t\t: %s rev %d (%s)\n",
> > +                          cpu_name, MIDR_REVISION(midr), ELF_PLATFORM);
> >
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
> Same question as first time around: does it really make sense to print
> the value of elf_hwcap (whose value depends only on the capabilities
> of the boot cpu) for every CPU listed?

Sorry, factoring out the hwcap parsing slipped my mind when I went to
investigate the I-cache policy issue.

I've taken another look, and it's somewhat painful to sort out.

Ideally we'd read all of the cpuinfo data, parse that into hwcap fields,
then copy the boot CPU fields into the globals. Unfortunately
setup_processor happens before we setup the percpu offsets, and some of
the hwcaps are set elsewhere (fpsimd_init and
arch_timer_evtstrm_enable). It's not obvious to me how to handle those,
the timer case should certainly live in the timer driver.

We expect globally uniform hwcaps anyway, the CPUs should be identical
instruction-set wise (and the sanity checks from later in this series
will trigger were this not the case), so is this a problem?

I agree it would be nicer to have accurate per-CPU hwcaps were they to
differ, but that's a case we don't expect to support as far as I am
aware.

Cheers,
Mark.
