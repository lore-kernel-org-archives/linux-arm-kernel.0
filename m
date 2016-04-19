From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 19 Apr 2016 12:15:45 +0100
Subject: [PATCH v4] ARM64: ACPI: Update documentation for latest
 specification version
In-Reply-To: <1461007942-20969-1-git-send-email-al.stone@linaro.org>
References: <1461007942-20969-1-git-send-email-al.stone@linaro.org>
Message-ID: <20160419111545.GB9571@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 18, 2016 at 01:32:22PM -0600, Al Stone wrote:
> The ACPI 6.1 specification was recently released at the end of January
> 2016, but the arm64 kernel documentation for the use of ACPI was written
> for the 5.1 version of the spec.  There were significant additions to the
> spec that had not yet been mentioned -- for example, the 6.0 mechanisms
> added to make it easier to define processors and low power idle states,
> as well as the 6.1 addition allowing regular interrupts (not just from
> GPIO) be used to signal ACPI general purpose events.
> 
> This patch reflects going back through and examining the specs in detail
> and updating content appropriately.  Whilst there, a few odds and ends of
> typos were caught as well.  This brings the documentation up to date with
> ACPI 6.1 for arm64.
> 
> Changes for v4:
>    -- Clarify that IORT can sometimes be optional (Jon Masters).
>    -- Remove "Use as needed" descriptions of ACPI objects; they provide
>       no substantive information and doing so simplifies maintenance of
>       this document over time.  These have been replaced with a simpler
>       notice that states that unless otherwise noted, do what the APCI

s/APCI/ACPI

>       specification says is needed.
>    -- Corrected the _OSI object usage recommendation; it described kernel
>       behavior that does not exist (Al Stone).
> 
> Changes for v3:
>    -- Clarify use of _LPI/_RDI (Vikas Sajjan)
>    -- Whitespace cleanup as pointed out by checkpatch
> 
> Changes for v2:
>    -- Clean up white space (Harb Abdulhahmid)
>    -- Clarification on _CCA usage (Harb Abdulhamid)
>    -- IORT moved to required from recommended (Hanjun Guo)
>    -- Clarify IORT description (Hanjun Guo)

Changes summary does not belong in the commit log.

> Signed-off-by: Al Stone <al.stone@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> ---
>  Documentation/arm64/acpi_object_usage.txt | 347 ++++++++++++++++--------------
>  Documentation/arm64/arm-acpi.txt          |  28 ++-
>  2 files changed, 212 insertions(+), 163 deletions(-)
> 
> diff --git a/Documentation/arm64/acpi_object_usage.txt b/Documentation/arm64/acpi_object_usage.txt
> index a6e1a18..3891750 100644
> --- a/Documentation/arm64/acpi_object_usage.txt
> +++ b/Documentation/arm64/acpi_object_usage.txt
> @@ -13,14 +13,18 @@ For ACPI on arm64, tables also fall into the following categories:
>  
>         -- Required: DSDT, FADT, GTDT, MADT, MCFG, RSDP, SPCR, XSDT
>  
> -       -- Recommended: BERT, EINJ, ERST, HEST, SSDT
> +       -- Recommended: BERT, EINJ, ERST, HEST, PCCT, SSDT
>  
> -       -- Optional: BGRT, CPEP, CSRT, DRTM, ECDT, FACS, FPDT, MCHI, MPST,
> -          MSCT, RASF, SBST, SLIT, SPMI, SRAT, TCPA, TPM2, UEFI
> +       -- Optional: BGRT, CPEP, CSRT, DBG2, DRTM, ECDT, FACS, FPDT, MCHI,
> +          MPST, MSCT, NFIT, PMTT, RASF, SBST, SLIT, SPMI, SRAT, STAO, TCPA,
> +          TPM2, UEFI, XENV
>  
> -       -- Not supported: BOOT, DBG2, DBGP, DMAR, ETDT, HPET, IBFT, IVRS,
> -          LPIT, MSDM, RSDT, SLIC, WAET, WDAT, WDRT, WPBT
> +       -- Not supported: BOOT, DBGP, DMAR, ETDT, HPET, IBFT, IVRS, LPIT,
> +          MSDM, OEMx, PSDT, RSDT, SLIC, WAET, WDAT, WDRT, WPBT
>  
> +       -- NB: the IORT is required on certain SBSA platforms (e.g., when
> +          using GICv3-ITS and an SMMU); it is optional on SBSA Level 0
> +	  platforms.

Mark it as optional and refer to the specs in the IORT entry below.

[...]

> +PMTT   Section 5.2.21.12 (signature == "PMTT")
> +       == Platform Memory Topology Table ==
> +       Optional, but useful, but not currently supported.

"Optional, not supported".

[...]

>  SLIT   Section 5.2.17 (signature == "SLIT")
>         == System Locality distance Information Table ==
> -       Optional in general, but required for NUMA systems.
> +       Optional in general, but required for arm64 NUMA systems.

We know it is arm64 related, it is an arm64 specific document.

[...]

> +_HRV   6.1.6           Use to clarify device behavior; in some cases, this 
> +		       may be easier to use than _DSD.

What does it mean ? Either we add a concrete example or "Use as needed".

[...]

> +Note too, that the processor Device objects defined and the entries in the
> +MADT for GICs are expected to be in sychronization.  The _UID of the Device

s/sychronization/synchronization

> +object must correspond to processor IDs used in the MADT.
> +
> +It is recommended that CPPC (8.4.5) be used as the primary model for processor
> +performance control on arm64.  C-states and P-states may become available at
> +some point in the future, but most current design work appears to favor CPPC.
>  
>  Further, it is essential that the ARMv8 SoC provide a fully functional
>  implementation of PSCI; this will be the only mechanism supported by ACPI
> -to control CPU power state (including secondary CPU booting).
> -
> -More details will be provided on the release of the ACPI 6.0 specification.
> +to control CPU power state.  Booting of secondary CPUs may be possible using
> +parking protocol, but only PSCI is to be used for ARM servers.

"Booting of secondary CPUs using the ACPI parking protocol
is possible but discouraged, only PSCI is to be supported for
ARM systems".

[...]

> diff --git a/Documentation/arm64/arm-acpi.txt b/Documentation/arm64/arm-acpi.txt
> index 570a4f8..12381c1 100644
> --- a/Documentation/arm64/arm-acpi.txt
> +++ b/Documentation/arm64/arm-acpi.txt
> @@ -57,11 +57,11 @@ The short form of the rationale for ACPI on ARM is:
>  
>  -- The new ACPI governance process works well and Linux is now at the same
>     table as hardware vendors and other OS vendors.  In fact, there is no
> -   longer any reason to feel that ACPI is only belongs to Windows or that
> +   longer any reason to feel that ACPI only belongs to Windows or that
>     Linux is in any way secondary to Microsoft in this arena.  The move of
>     ACPI governance into the UEFI forum has significantly opened up the
>     specification development process, and currently, a large portion of the
> -   changes being made to ACPI is being driven by Linux.
> +   changes being made to ACPI are being driven by Linux.
>  
>  Key to the use of ACPI is the support model.  For servers in general, the
>  responsibility for hardware behaviour cannot solely be the domain of the
> @@ -159,7 +159,7 @@ Further, the ACPI core will only use the 64-bit address fields in the FADT
>  (Fixed ACPI Description Table).  Any 32-bit address fields in the FADT will
>  be ignored on arm64.
>  
> -Hardware reduced mode (see Section 4.1 of the ACPI 5.1 specification) will
> +Hardware reduced mode (see Section 4.1 of the ACPI 6.1 specification) will
>  be enforced by the ACPI core on arm64.  Doing so allows the ACPI core to
>  run less complex code since it no longer has to provide support for legacy
>  hardware from other architectures.  Any fields that are not to be used for
> @@ -167,7 +167,7 @@ hardware reduced mode must be set to zero.
>  
>  For the ACPI core to operate properly, and in turn provide the information
>  the kernel needs to configure devices, it expects to find the following
> -tables (all section numbers refer to the ACPI 5.1 specfication):
> +tables (all section numbers refer to the ACPI 6.1 specfication):

s/specfication/specification

There are others in this document.

>  
>      -- RSDP (Root System Description Pointer), section 5.2.5
>  
> @@ -185,9 +185,22 @@ tables (all section numbers refer to the ACPI 5.1 specfication):
>      -- If PCI is supported, the MCFG (Memory mapped ConFiGuration
>         Table), section 5.2.6, specifically Table 5-31.
>  
> +    -- If booting without a console=<device> kernel parameter is
> +       supported, the SPCR (Serial Port Console Redirection table),
> +       section 5.2.6, specifically Table 5-31.
> +
> +    -- If virtualization is supported, the IORT (Input Output Remapping
> +       Table, section 5.2.6, specifically Table 5-31.

Why only "If virtualization is supported" ? Missing closing bracket.

I still question sections of this document that IMHO do not belong
in the kernel documentation (but in the ACPI specs - eg _PRx methods
usage), anyway the information seems accurate so, pending changes above:

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
