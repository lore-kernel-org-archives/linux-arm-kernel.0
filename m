From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Tue, 17 Mar 2015 03:28:37 +0100
Subject: [update][PATCH v10 06/21] ACPI / sleep: Introduce
 CONFIG_ACPI_GENERIC_SLEEP
In-Reply-To: <55077E9D.50103@huawei.com>
References: <1426234469-6434-1-git-send-email-hanjun.guo@linaro.org>
 <5704037.pUGdJ0Q9hF@vostro.rjw.lan> <55077E9D.50103@huawei.com>
Message-ID: <3737028.Ib0fKlgSkd@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, March 17, 2015 09:08:45 AM Hanjun Guo wrote:
> On 2015/3/17 7:15, Rafael J. Wysocki wrote:
> > On Monday, March 16, 2015 08:14:52 PM Hanjun Guo wrote:
> >> On 2015?03?14? 05:49, Rafael J. Wysocki wrote:
> >>> On Friday, March 13, 2015 04:14:29 PM Hanjun Guo wrote:
> [...]
> >>>>
> >>>> diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
> >>>> index 074e52b..e8728d7 100644
> >>>> --- a/arch/ia64/Kconfig
> >>>> +++ b/arch/ia64/Kconfig
> >>>> @@ -10,6 +10,7 @@ config IA64
> >>>>   	select ARCH_MIGHT_HAVE_PC_SERIO
> >>>>   	select PCI if (!IA64_HP_SIM)
> >>>>   	select ACPI if (!IA64_HP_SIM)
> >>>> +	select ACPI_GENERIC_SLEEP if ACPI
> >>>>   	select ARCH_MIGHT_HAVE_ACPI_PDC if ACPI
> >>>>   	select HAVE_UNSTABLE_SCHED_CLOCK
> >>>>   	select HAVE_IDE
> >>>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> >>>> index b7d31ca..9804431 100644
> >>>> --- a/arch/x86/Kconfig
> >>>> +++ b/arch/x86/Kconfig
> >>>> @@ -22,6 +22,7 @@ config X86_64
> >>>>   ### Arch settings
> >>>>   config X86
> >>>>   	def_bool y
> >>>> +	select ACPI_GENERIC_SLEEP if ACPI
> >>> One more nit.  If you did
> >>>
> >>> +	select ACPI_GENERIC_SLEEP if ACPI_SLEEP
> >>>
> >>> here (and above for ia64), you'd avoid having to make ACPI_SLEEP
> >>> depend on ACPI_GENERIC_SLEEP which goes somewhat backwards.
> >> In sleep.c,
> >>
> >> #ifdef CONFIG_ACPI_SLEEP
> >> acpi_target_system_state()
> >> {
> >> }
> >> #endif
> >>
> >> and CONFIG_ACPI_SLEEP depends on SUSPEND || HIBERNATION,
> >> which one of them will be enabled on ARM64 so ACPI_SLEEP
> >> will also enabled too.
> >>
> >> So if we
> >>
> >> +select ACPI_GENERIC_SLEEP if ACPI_SLEEP
> >>
> >> and
> >>
> >> +acpi-$(CONFIG_ACPI_GENERIC_SLEEP) += sleep.o
> >>
> >> it will lead to errors for acpi_target_system_state() that
> >> is declared but not defined, so I will keep the code as
> >> it is, what do you think?
> > No, we need to hash this out.  Having two different Kconfig options meaning
> > almost the same thing (ACPI_SLEEP and ACPI_GENERIC_SLEEP) is beyond ugly.
> >
> > Do you need ACPI_SLEEP on ARM64 at all?
> 
> No, at least for now we don't need it, the spec for sleep is not ready for
> ARM64 arch, so ACPI_SLEEP will not work at all on ARM64.

Well, so what about selecting ACPI_SLEEP from the architectures that use it?


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
