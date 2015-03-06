From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 6 Mar 2015 12:36:12 +0000
Subject: [PATCH v9 07/21] ACPI / sleep: Introduce arm64 specific
 acpi_sleep.c
In-Reply-To: <2304442.4NvTH1BPme@vostro.rjw.lan>
References: <1424853601-6675-1-git-send-email-hanjun.guo@linaro.org>
 <CAGCh1+=RWVfcFoG549_03AZx3Y548GrJUMAXMgmdFFMmiE40KQ@mail.gmail.com>
 <2489018.mr9Fb0WeOy@vostro.rjw.lan>
 <2304442.4NvTH1BPme@vostro.rjw.lan>
Message-ID: <20150306123611.GA24254@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 05, 2015 at 12:16:29AM +0000, Rafael J. Wysocki wrote:
> On Thursday, March 05, 2015 12:25:54 AM Rafael J. Wysocki wrote:
> > On Wednesday, March 04, 2015 10:49:25 PM G Gregory wrote:
> > > On 4 March 2015 at 22:38, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > > > On Wednesday, February 25, 2015 04:39:47 PM Hanjun Guo wrote:
> > > >> From: Graeme Gregory <graeme.gregory@linaro.org>
> > > >>
> > > >> ACPI 5.1 does not currently support S states for ARM64 hardware but
> > > >> ACPI code will call acpi_target_system_state() for device power
> > > >> management, so introduce acpi_sleep.c to allow other drivers to function
> > > >> until S states are defined.
> > > >>
> > > >> Since it is arm64 specific stub holder, so let acpi_sleep.c to ARM64
> > > >> specific.
> > > >>
> > > >> TODO: merge this with drivers/acpi/sleep.c once we fix the specification.
> > > >>
> > > >> CC: Rafael J. Wysocki <rjw@rjwysocki.net>
> > > >> Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> > > >> Tested-by: Yijing Wang <wangyijing@huawei.com>
> > > >> Tested-by: Mark Langsdorf <mlangsdo@redhat.com>
> > > >> Tested-by: Jon Masters <jcm@redhat.com>
> > > >> Tested-by: Timur Tabi <timur@codeaurora.org>
> > > >> Tested-by: Robert Richter <rrichter@cavium.com>
> > > >> Acked-by: Robert Richter <rrichter@cavium.com>
> > > >> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
> > > >> Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
> > > >> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> > > >> ---
> > > >>  arch/arm64/kernel/Makefile     |  2 +-
> > > >>  arch/arm64/kernel/acpi_sleep.c | 28 ++++++++++++++++++++++++++++
> > > >>  drivers/acpi/Makefile          |  2 ++
> > > >>  3 files changed, 31 insertions(+), 1 deletion(-)
> > > >>  create mode 100644 arch/arm64/kernel/acpi_sleep.c
> > > >>
> > > >> diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
> > > >> index 218eb7e..4435943 100644
> > > >> --- a/arch/arm64/kernel/Makefile
> > > >> +++ b/arch/arm64/kernel/Makefile
> > > >> @@ -34,7 +34,7 @@ arm64-obj-$(CONFIG_KGDB)            += kgdb.o
> > > >>  arm64-obj-$(CONFIG_EFI)                      += efi.o efi-stub.o efi-entry.o
> > > >>  arm64-obj-$(CONFIG_PCI)                      += pci.o
> > > >>  arm64-obj-$(CONFIG_ARMV8_DEPRECATED) += armv8_deprecated.o
> > > >> -arm64-obj-$(CONFIG_ACPI)             += acpi.o
> > > >> +arm64-obj-$(CONFIG_ACPI)             += acpi.o acpi_sleep.o
> > > >>
> > > >>  obj-y                                        += $(arm64-obj-y) vdso/
> > > >>  obj-m                                        += $(arm64-obj-m)
> > > >> diff --git a/arch/arm64/kernel/acpi_sleep.c b/arch/arm64/kernel/acpi_sleep.c
> > > >> new file mode 100644
> > > >> index 0000000..54578ef
> > > >> --- /dev/null
> > > >> +++ b/arch/arm64/kernel/acpi_sleep.c
> > > >> @@ -0,0 +1,28 @@
> > > >> +/*
> > > >> + *  ARM64 Specific Sleep Functionality
> > > >> + *
> > > >> + *  Copyright (C) 2013-2014, Linaro Ltd.
> > > >> + *      Author: Graeme Gregory <graeme.gregory@linaro.org>
> > > >> + *
> > > >> + *  This program is free software; you can redistribute it and/or modify
> > > >> + *  it under the terms of the GNU General Public License version 2 as
> > > >> + *  published by the Free Software Foundation.
> > > >> + */
> > > >> +
> > > >> +#include <linux/acpi.h>
> > > >> +
> > > >> +/*
> > > >> + * Currently the ACPI 5.1 standard does not define S states in a
> > > >> + * manner which is usable for ARM64. These two stubs are sufficient
> > > >> + * that system initialises and device PM works.
> > > >> + */
> > > >> +u32 acpi_target_system_state(void)
> > > >> +{
> > > >> +     return ACPI_STATE_S0;
> > > >> +}
> > > >> +EXPORT_SYMBOL_GPL(acpi_target_system_state);
> > > >> +
> > > >> +int __init acpi_sleep_init(void)
> > > >> +{
> > > >> +     return -ENOSYS;
> > > >> +}
> > > >> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> > > >> index 623b117..c32edf5 100644
> > > >> --- a/drivers/acpi/Makefile
> > > >> +++ b/drivers/acpi/Makefile
> > > >> @@ -23,7 +23,9 @@ acpi-y                              += nvs.o
> > > >>
> > > >>  # Power management related files
> > > >>  acpi-y                               += wakeup.o
> > > >> +ifneq (,$(findstring $(ARCH),x86 ia64))
> > > >
> > > > This is super-ugly.  Isn't there a better way to do that?
> > > >
> > > Its the standard example in the GNU Make manual,
> > 
> > It is never used in the kernel this way, though, and I'm not going to let
> > that slip through.
> > 
> > > I would certainly love if someone had a batter suggestion.
> > 
> > Define ACPI_GENERIC_SLEEP in drivers/acpi/Kconfig as
> > 
> > 	config ACPI_GENERIC_SLEEP
> > 		bool
> > 		depends on IA64 || X86
> > 
> > and build the file conditional on that.
> 
> Or define
> 
> 	config ACPI_GENERIC_SLEEP
> 		bool
> 
> and then make both x86 and ia64 do
> 
> 	select ACPI_GENERIC_SLEEP if ACPI
> 
> which kind of will make it clear where the choice takes place.

While at it, use the newly defined config entry to add the required static
inline in the respective headers and get rid of acpi_sleep.c from arm64.

Thanks,
Lorenzo
