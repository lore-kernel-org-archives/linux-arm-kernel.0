From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Wed, 15 Jun 2016 01:07:34 +0200
Subject: [PATCH 3/5] PM / Hibernate: Allow architectures to specify the
 hibernate/resume CPU
In-Reply-To: <575FD20F.7020606@arm.com>
References: <1464876657-6692-1-git-send-email-james.morse@arm.com>
 <4959514.g8dkWscZ3h@vostro.rjw.lan> <575FD20F.7020606@arm.com>
Message-ID: <1814244.EyXNzvmsTg@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, June 14, 2016 10:44:47 AM James Morse wrote:
> Hi Rafael,
> 
> On 13/06/16 23:10, Rafael J. Wysocki wrote:
> > On Tuesday, June 14, 2016 12:05:28 AM Rafael J. Wysocki wrote:
> >> On Thursday, June 02, 2016 03:10:55 PM James Morse wrote:
> >>> On arm64 the cpu with logical id 0 is assumed to be the boot CPU. If a
> >>> user hotplugs this CPU out, then uses kexec to boot a new kernel, the new
> >>> kernel will assign logical id 0 to a different physical CPU.
> >>> This breaks hibernate as hibernate and resume will be attempted on different
> >>> CPUs.
> >>>
> >>> Define a weak symbol arch_hibernation_disable_cpus(), which defaults to
> >>> calling disable_nonboot_cpus). Architectures that allow CPU 0 to be
> >>> hotplugged can use this to control which CPU is used for hibernate/resume.
> >>>
> >>> Signed-off-by: James Morse <james.morse@arm.com>
> >>> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> >>> Cc: Pavel Machek <pavel@ucw.cz>
> >>> ---
> >>> I would have preferred a macro, but there is no hibernate-relevant header
> >>> file that all arch's have. arm, arm64 and x86 have a suspend.h, but powerpc
> >>> doesn't.
> >>
> >> What about include/linux/suspend.h?
> >>
> >> There are arch_ things declared in there.
> > 
> > I mean, what about using something like
> > 
> > #ifndef arch_hibernation_disable_cpus
> > #define arch_hibernation_disable_cpus disable_nonboot_cpus
> > #endif
> > 
> > in there or in another header file?
> 
> This would work fine for an architecture that doesn't need to use
> arch_hibernation_disable_cpus(), but which header file should we use for an
> architecture that does?
> 
> As a macro it needs to be in an arch-specific header included before the #ifndef
> above.
> 
> Of those:
> include/linux/suspend.h only includes <asm/errno.h>
> kernel/power/power.h doesn't include any 'asm' headers.
> snapshot.c includes:
> > #include <asm/uaccess.h>
> > #include <asm/mmu_context.h>
> > #include <asm/pgtable.h>
> > #include <asm/tlbflush.h>
> > #include <asm/io.h>
> 
> ... but none of those are appropriate.
> 
> 
> I initially added an include for <asm/suspend.h> to kernel/power/power.h, but it
> broke powerpc, as there is no suspend.h there. I took this as a dead-end for the
> macro approach, unless someone has a clever trick?!

OK, let's do the __weak function, then.

After all, it can be changed later if someone has a better idea.

Thanks,
Rafael
