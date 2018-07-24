From: will.deacon@arm.com (Will Deacon)
Date: Tue, 24 Jul 2018 10:44:07 +0100
Subject: [PATCH] arm64: fix ACPI dependencies
In-Reply-To: <CAJZ5v0jTowUW6myVf0B2Gyq0ZA2ATqPNnaeOgFS01ce8A=FBpA@mail.gmail.com>
References: <20180724093345.1575921-1-arnd@arndb.de>
 <CAJZ5v0jTowUW6myVf0B2Gyq0ZA2ATqPNnaeOgFS01ce8A=FBpA@mail.gmail.com>
Message-ID: <20180724094406.GF19324@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 24, 2018 at 11:37:10AM +0200, Rafael J. Wysocki wrote:
> On Tue, Jul 24, 2018 at 11:33 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > Kconfig reports a warning on x86 builds after the ARM64 dependency
> > was added.
> >
> > drivers/acpi/Kconfig:6:error: recursive dependency detected!
> > drivers/acpi/Kconfig:6:       symbol ACPI depends on EFI
> >
> > This rephrases the dependency to keep the ARM64 details out of the
> > shared Kconfig file, so Kconfig no longer gets confused by it.
> >
> > Fixes: 5bcd44083a08 ("drivers: acpi: add dependency of EFI for arm64")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  arch/arm64/Kconfig   | 1 +
> >  drivers/acpi/Kconfig | 5 ++++-
> >  2 files changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index cdcaa6a798b2..2f987a938405 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -1267,6 +1267,7 @@ config EFI
> >         bool "UEFI runtime support"
> >         depends on OF && !CPU_BIG_ENDIAN
> >         depends on KERNEL_MODE_NEON
> > +       select ARCH_SUPPORTS_ACPI
> >         select LIBFDT
> >         select UCS2_STRING
> >         select EFI_PARAMS_FROM_FDT
> > diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> > index a8da730fabc6..0cda51c5d433 100644
> > --- a/drivers/acpi/Kconfig
> > +++ b/drivers/acpi/Kconfig
> > @@ -6,7 +6,7 @@
> >  menuconfig ACPI
> >         bool "ACPI (Advanced Configuration and Power Interface) Support"
> >         depends on !IA64_HP_SIM
> > -       depends on IA64 || X86 || (ARM64 && EFI)
> > +       depends on IA64 || X86 || ARCH_SUPPORTS_ACPI
> 
> That doesn't look particularly consistent to me.
> 
> It should be either "depends on ARCH_SUPPORTS_ACPI" alone or mention
> ARM64 somehow IMO

How about something along the lines of what Ard suggested? Untested diff
below.

Will

--->8

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 303809c6..ec78d4d 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -56,6 +56,7 @@ config ARM64
        select ARCH_USE_CMPXCHG_LOCKREF
        select ARCH_USE_QUEUED_RWLOCKS
        select ARCH_USE_QUEUED_SPINLOCKS
+       select ARCH_SUPPORTS_ACPI
        select ARCH_SUPPORTS_MEMORY_FAILURE
        select ARCH_SUPPORTS_ATOMIC_RMW
        select ARCH_SUPPORTS_INT128 if GCC_VERSION >= 50000 || CC_IS_CLANG
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 15ab1da..198db2d 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -3,10 +3,12 @@
 # ACPI Configuration
 #
 
+config ARCH_SUPPORTS_ACPI
+       def_bool (IA64 && !IA64_HP_SIM) || X86
+
 menuconfig ACPI
        bool "ACPI (Advanced Configuration and Power Interface) Support"
-       depends on !IA64_HP_SIM
-       depends on IA64 || X86 || (ARM64 && EFI)
+       depends on ARCH_SUPPORTS_ACPI
        depends on PCI
        select PNP
        default y if (IA64 || X86)
