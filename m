From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Sat, 11 Jan 2014 00:25:05 +0100
Subject: [PATCH v6 0/6] Hardware Reduced Mode Cleanup for ACPI
In-Reply-To: <1389394340-2680-1-git-send-email-al.stone@linaro.org>
References: <1389394340-2680-1-git-send-email-al.stone@linaro.org>
Message-ID: <5177919.p7dmYTQUj8@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, January 10, 2014 03:52:14 PM al.stone at linaro.org wrote:
> From: Al Stone <al.stone@linaro.org>
> 
> This series of patches starts with Hanjun's patch to create a kernel
> config item for CONFIG_ACPI_REDUCED_HARDWARE [0].  Building on that, I
> then reviewed all of the code that touched any of several fields in the
> FADT that the OSPM is supposed to ignore when ACPI is in Hardware Reduced
> mode [1].  Any time there was a use of one of the fields to be ignored,
> I evaluated whether or not the code was implementing Hardware Reduced
> mode correctly.  Similarly, for each the flags in the FADT flags field
> that are to be ignored in Hardware Reduced mode, the kernel code was again
> scanned for proper usage.  The remainder of the patches are to fix all of
> the situations I could find where the kernel would not behave correctly
> in this ACPI mode.
> 
> These seem to work just fine on the RTSM model for ARMv7, both with and
> without ACPI enabled, and with and without ACPI_REDUCED_HARDWARE enabled;
> similarly for the FVP model for ARMv8.  The patches for ACPI on ARM
> hardware have been submitted elsewhere but they presume that reduced HW
> mode is functioning correctly.  In the meantime, there's no way I can think
> of to test all possible scenarios so feedback would be greatly appreciated.

Quite frankly, I'm seeing a pattern in this patchset that I'm not really
liking, which is making changes on a hunch.  Especially things like
changing code under #ifdef CONFIG_X86 and similar.

Can we please focus on making changes that are *known* to be necessary and
where we know *why* this is the case?

> [0] List at https://wiki.linaro.org/LEG/Engineering/Kernel/ACPI/AcpiReducedHw#Section_5:_ACPI_Software_Programming_Model
> [1] Please see the ACPI Specification v5.0 for details on Hardware Reduced
>     mode (sections 3.11.1, 4.1, 5.2.9, at a minimum).
> 
> Changes for v6:
>    -- Allow selection of CONFIG_ACPI_REDUCED_HARDWARE_ONLY to be more
>       architecture-independent, but make it harder to accidentally enable.
>    -- Make sure that ACPI ECs do not use the ACPI global lock when in
>       hardware reduced mode (I had missed this case in earlier reviews
>       of the kernel tree).
> 
> Changes for v5:
>    -- Clarify that if the kernel config option to build ACPI hardware reduced
>       mode is used, it builds a hardware reduced *only* kernel (i.e., full
>       legacy ACPI mode will no longer work).
> 
> Changes for v4:
>    -- Given the current state of ACPICA, disable CONFIG_ACPI_REDUCED_HARDWARE
>       for use on anything other than ARM.
>    -- Replaced #ifdefs with run-time checking for hardware reduced mode,
>       whenever possible
> 
> Changes for v3:
>    -- Modified enabling ACPI_REDUCED_HARDWARE in ACPICA when using
>       kernel config item CONFIG_ACPI_REDUCED_HARDWARE; now consistent
>       with ACPICA code base where needed
>    -- Enable X86 for CONFIG_ACPI_REDUCED_HARDWARE
>    -- Minimize bus master reload patching
>    -- Remove unneeded patch for dmi_check_system() (was 4/6)
>    -- Correct the patch for removing unneeded map/unmap of FADT fields
> 
> Changes for v2:
>    -- Remove patch that was outside of reduced HW mode changes
>    -- Simplify CONFIG_ACPI_REDUCED_HARDWARE in Kconfig
>    -- Simplify use of CONFIG_ACPI_REDUCED_HARDWARE in #ifdefs
>    -- Ensure changelogs are present
>    -- Combine and simplify previous patches 8 & 10
> 
> 
> Al Stone (6):
>   ACPI: introduce CONFIG_ACPI_REDUCED_HARDWARE_ONLY to enforce this ACPI
>     mode
>   ACPI: bus master reload not supported in reduced HW mode
>   ACPI: HW reduced mode does not allow use of the FADT sci_interrupt
>     field
>   ACPI: in HW reduced mode, using FADT PM information is not allowed.
>   ACPI: do not map/unmap memory regions for FADT entries in reduced HW
>     mode
>   ACPI: make sure ECs do not use the ACPI global lock
> 
>  drivers/acpi/Kconfig            | 12 ++++++++++++
>  drivers/acpi/bus.c              | 30 ++++++++++++++++--------------
>  drivers/acpi/ec.c               | 12 ++++++++++--
>  drivers/acpi/osl.c              | 38 +++++++++++++++++++-------------------
>  drivers/acpi/pci_link.c         |  2 ++
>  drivers/acpi/processor_idle.c   | 14 ++++++++++++--
>  include/acpi/platform/aclinux.h |  6 ++++++
>  7 files changed, 77 insertions(+), 37 deletions(-)
> 
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
