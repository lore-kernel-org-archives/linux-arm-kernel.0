From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Tue, 14 Jun 2016 00:10:49 +0200
Subject: [PATCH 3/5] PM / Hibernate: Allow architectures to specify the
 hibernate/resume CPU
In-Reply-To: <1982845.x73eTHIS7X@vostro.rjw.lan>
References: <1464876657-6692-1-git-send-email-james.morse@arm.com>
 <1464876657-6692-4-git-send-email-james.morse@arm.com>
 <1982845.x73eTHIS7X@vostro.rjw.lan>
Message-ID: <4959514.g8dkWscZ3h@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, June 14, 2016 12:05:28 AM Rafael J. Wysocki wrote:
> On Thursday, June 02, 2016 03:10:55 PM James Morse wrote:
> > On arm64 the cpu with logical id 0 is assumed to be the boot CPU. If a
> > user hotplugs this CPU out, then uses kexec to boot a new kernel, the new
> > kernel will assign logical id 0 to a different physical CPU.
> > This breaks hibernate as hibernate and resume will be attempted on different
> > CPUs.
> > 
> > Define a weak symbol arch_hibernation_disable_cpus(), which defaults to
> > calling disable_nonboot_cpus). Architectures that allow CPU 0 to be
> > hotplugged can use this to control which CPU is used for hibernate/resume.
> > 
> > Signed-off-by: James Morse <james.morse@arm.com>
> > Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> > Cc: Pavel Machek <pavel@ucw.cz>
> > ---
> > I would have preferred a macro, but there is no hibernate-relevant header
> > file that all arch's have. arm, arm64 and x86 have a suspend.h, but powerpc
> > doesn't.
> 
> What about include/linux/suspend.h?
> 
> There are arch_ things declared in there.

I mean, what about using something like

#ifndef arch_hibernation_disable_cpus
#define arch_hibernation_disable_cpus disable_nonboot_cpus
#endif

in there or in another header file?

Thanks,
Rafael
