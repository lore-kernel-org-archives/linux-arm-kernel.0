From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 19 Mar 2015 10:04:55 +0000
Subject: [PATCH v10 08/21] ARM64 / ACPI: Introduce early_param "acpi=" to
 enable/disable ACPI
In-Reply-To: <CAKv+Gu9wkh+J18cm1Mt4-Up5b3VA4-qeLtHcc+UD44DHbqABtQ@mail.gmail.com>
References: <1426077587-1561-1-git-send-email-hanjun.guo@linaro.org>
 <1426077587-1561-9-git-send-email-hanjun.guo@linaro.org>
 <20150318113549.GC2846@red-moon>
 <CAKv+Gu9wkh+J18cm1Mt4-Up5b3VA4-qeLtHcc+UD44DHbqABtQ@mail.gmail.com>
Message-ID: <20150319100455.GA24556@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 18, 2015 at 08:07:09PM +0000, Ard Biesheuvel wrote:
> On 18 March 2015 at 12:35, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
> > On Wed, Mar 11, 2015 at 12:39:34PM +0000, Hanjun Guo wrote:
> >> From: Al Stone <al.stone@linaro.org>
> >>
> >> This implements the following policy to decide whether ACPI should
> >> be used to boot the system:
> >> - acpi=off: ACPI will not be used to boot the system, even if there is
> >>   no alternative available (e.g., device tree is empty)
> >> - acpi=force: only ACPI will be used to boot the system; if that fails,
> >>   there will be no fallback to alternative methods (such as device tree)
> >
> > I think this comment is stale. acpi=force enables ACPI and tries to
> > init the ACPI tables without even checking DT, but it does fall back to
> > DT if ACPI table init fails (by disabling ACPI and unflattening the
> > FDT).
> >
> > Am I wrong ?
> >
> 
> No, you're right. But I would suggest that we fix the code, not the comment.

So would I. I flagged this up on the comment since I was not able to follow
the thread on arm64 acpi=force and thought I was missing something.

> I think we are all in agreement on the policy, we only need to make
> disable_acpi() conditional on whether acpi_param_force is set

Either this or Catalin's fix, in actual terms the end result should be
the same on arm64, leaving acpi_disabled will save us some pointless
parsing IMO.

Nit: "acpi" kernel parameter description defines

"force -- enable ACPI if default was off"

which is not what we do on arm64 if we leave ACPI disabled when
acpi=force and ACPI fails to init.

I do not think we should care, if anyone disagrees manifest yourselves.

Lorenzo

> 
> 
> >> - otherwise, ACPI will be used as a fallback if the device tree turns out
> >>   to lack a platform description; the heuristic to decide this is whether
> >>   /chosen is the only node present at depth 1
> >>
> >> CC: Catalin Marinas <catalin.marinas@arm.com>
> >> CC: Will Deacon <will.deacon@arm.com>
> >> CC: Rafael J. Wysocki <rjw@rjwysocki.net>
> >> Acked-by: Olof Johansson <olof@lixom.net>
> >> Acked-by: Grant Likely <grant.likely@linaro.org>
> >> Tested-by: Timur Tabi <timur@codeaurora.org>
> >> Signed-off-by: Al Stone <al.stone@linaro.org>
> >> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
> >> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> >> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >> ---
> >>  Documentation/kernel-parameters.txt |  3 ++-
> >>  arch/arm64/include/asm/acpi.h       |  7 +++++
> >>  arch/arm64/kernel/acpi.c            | 52 +++++++++++++++++++++++++++++++++----
> >>  3 files changed, 56 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
> >> index bfcb1a6..d6c35a7 100644
> >> --- a/Documentation/kernel-parameters.txt
> >> +++ b/Documentation/kernel-parameters.txt
> >> @@ -165,7 +165,7 @@ multipliers 'Kilo', 'Mega', and 'Giga', equalling 2^10, 2^20, and 2^30
> >>  bytes respectively. Such letter suffixes can also be entirely omitted.
> >>
> >>
> >> -     acpi=           [HW,ACPI,X86]
> >> +     acpi=           [HW,ACPI,X86,ARM64]
> >>                       Advanced Configuration and Power Interface
> >>                       Format: { force | off | strict | noirq | rsdt }
> >>                       force -- enable ACPI if default was off
> >> @@ -175,6 +175,7 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
> >>                               strictly ACPI specification compliant.
> >>                       rsdt -- prefer RSDT over (default) XSDT
> >>                       copy_dsdt -- copy DSDT to memory
> >> +                     For ARM64, ONLY "acpi=off" or "acpi=force" are available
> >>
> >>                       See also Documentation/power/runtime_pm.txt, pci=noacpi
> >>
> >> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
> >> index 40e0924..c5a9b97 100644
> >> --- a/arch/arm64/include/asm/acpi.h
> >> +++ b/arch/arm64/include/asm/acpi.h
> >> @@ -39,6 +39,13 @@ static inline void disable_acpi(void)
> >>       acpi_noirq = 1;
> >>  }
> >>
> >> +static inline void enable_acpi(void)
> >> +{
> >> +     acpi_disabled = 0;
> >> +     acpi_pci_disabled = 0;
> >> +     acpi_noirq = 0;
> >> +}
> >> +
> >>  /*
> >>   * It's used from ACPI core in kdump to boot UP system with SMP kernel,
> >>   * with this check the ACPI core will not override the CPU index
> >> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
> >> index 7abac24..2269e30 100644
> >> --- a/arch/arm64/kernel/acpi.c
> >> +++ b/arch/arm64/kernel/acpi.c
> >> @@ -22,15 +22,49 @@
> >>  #include <linux/irq.h>
> >>  #include <linux/irqdomain.h>
> >>  #include <linux/memblock.h>
> >> +#include <linux/of_fdt.h>
> >>  #include <linux/smp.h>
> >>
> >> -int acpi_noirq;                      /* skip ACPI IRQ initialization */
> >> -int acpi_disabled;
> >> +int acpi_noirq = 1;          /* skip ACPI IRQ initialization */
> >> +int acpi_disabled = 1;
> >>  EXPORT_SYMBOL(acpi_disabled);
> >>
> >> -int acpi_pci_disabled;               /* skip ACPI PCI scan and IRQ initialization */
> >> +int acpi_pci_disabled = 1;   /* skip ACPI PCI scan and IRQ initialization */
> >>  EXPORT_SYMBOL(acpi_pci_disabled);
> >>
> >> +static bool param_acpi_off __initdata;
> >> +static bool param_acpi_force __initdata;
> >> +
> >> +static int __init parse_acpi(char *arg)
> >> +{
> >> +     if (!arg)
> >> +             return -EINVAL;
> >> +
> >> +     /* "acpi=off" disables both ACPI table parsing and interpreter */
> >> +     if (strcmp(arg, "off") == 0)
> >> +             param_acpi_off = true;
> >> +     else if (strcmp(arg, "force") == 0) /* force ACPI to be enabled */
> >> +             param_acpi_force = true;
> >> +     else
> >> +             return -EINVAL; /* Core will print when we return error */
> >> +
> >> +     return 0;
> >> +}
> >> +early_param("acpi", parse_acpi);
> >> +
> >> +static int __init dt_scan_depth1_nodes(unsigned long node,
> >> +                                    const char *uname, int depth,
> >> +                                    void *data)
> >> +{
> >> +     /*
> >> +      * Return 1 as soon as we encounter a node at depth 1 that is
> >> +      * not the /chosen node.
> >> +      */
> >> +     if (depth == 1 && (strcmp(uname, "chosen") != 0))
> >> +             return 1;
> >> +     return 0;
> >> +}
> >> +
> >>  /*
> >>   * __acpi_map_table() will be called before page_init(), so early_ioremap()
> >>   * or early_memremap() should be called here to for ACPI table mapping.
> >> @@ -83,10 +117,18 @@ static int __init acpi_parse_fadt(struct acpi_table_header *table)
> >>   */
> >>  void __init acpi_boot_table_init(void)
> >>  {
> >> -     /* If acpi_disabled, bail out */
> >> -     if (acpi_disabled)
> >> +     /*
> >> +      * Enable ACPI instead of device tree unless
> >> +      * - ACPI has been disabled explicitly (acpi=off), or
> >> +      * - the device tree is not empty (it has more than just a /chosen node)
> >> +      *   and ACPI has not been force enabled (acpi=force)
> >> +      */
> >> +     if (param_acpi_off ||
> >> +         (!param_acpi_force && of_scan_flat_dt(dt_scan_depth1_nodes, NULL)))
> >>               return;
> >>
> >> +     enable_acpi();
> >> +
> >>       /* Initialize the ACPI boot-time table parser. */
> >>       if (acpi_table_init()) {
> >>               disable_acpi();
> >> --
> >> 1.9.1
> >>
> >>
> 
