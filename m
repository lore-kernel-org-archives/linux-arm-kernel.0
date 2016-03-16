From: vikas.sajjan@samsung.com (Vikas Sajjan)
Date: Wed, 16 Mar 2016 10:20:23 +0530
Subject: [RESEND PATCH v2] ARM64: ACPI: Update documentation for latest
 specification version
In-Reply-To: <1458073681-11178-1-git-send-email-al.stone@linaro.org>
References: <1458073681-11178-1-git-send-email-al.stone@linaro.org>
Message-ID: <CAGm_ybgvVp-m70+QJO1r4uEg3V_fYjY963=zHPs37pjxEfq+Qw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Al Stone,

On Wed, Mar 16, 2016 at 1:58 AM, Al Stone <al.stone@linaro.org> wrote:
> The ACPI 6.1 specification was recently released at the end of January 2016,
> but the arm64 kernel documentation for the use of ACPI was written for the
> 5.1 version of the spec.  There were significant additions to the spec that
> had not yet been mentioned -- for example, the 6.0 mechanisms added to make
> it easier to define processors and low power idle states, as well as the
> 6.1 addition allowing regular interrupts (not just from GPIO) be used to
> signal ACPI general purpose events.
>
> This patch reflects going back through and examining the specs in detail
> and updating content appropriately.  Whilst there, a few odds and ends of
> typos were caught as well.  This brings the documentation up to date with
> ACPI 6.1 for arm64.
>
> RESEND:
>    -- Corrected From: header and added missing Cc's
>
> Changes for v2:
>    -- Clean up white space (Harb Abdulhahmid)
>    -- Clarification on _CCA usage (Harb Abdulhamid)
>    -- IORT moved to required from recommended (Hanjun Guo)
>    -- Clarify IORT description (Hanjun Guo)
>
> Signed-off-by: Al Stone <al.stone@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> ---
>  Documentation/arm64/acpi_object_usage.txt | 445 ++++++++++++++++++++++--------
>  Documentation/arm64/arm-acpi.txt          |  28 +-
>  2 files changed, 356 insertions(+), 117 deletions(-)
>
> diff --git a/Documentation/arm64/acpi_object_usage.txt b/Documentation/arm64/acpi_object_usage.txt
> index a6e1a18..29bc1a1 100644
> --- a/Documentation/arm64/acpi_object_usage.txt
> +++ b/Documentation/arm64/acpi_object_usage.txt
> @@ -11,15 +11,16 @@ outside of the UEFI Forum (see Section 5.2.6 of the specification).
>
>  For ACPI on arm64, tables also fall into the following categories:
>
> -       -- Required: DSDT, FADT, GTDT, MADT, MCFG, RSDP, SPCR, XSDT
> +       -- Required: DSDT, FADT, GTDT, IORT, MADT, MCFG, RSDP, SPCR, XSDT
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
>
>  Table  Usage for ARMv8 Linux
> @@ -50,7 +51,8 @@ CSRT   Signature Reserved (signature == "CSRT")
>
>  DBG2   Signature Reserved (signature == "DBG2")
>         == DeBuG port table 2 ==
> -       Microsoft only table, will not be supported.
> +       License has changed and should be usable.  Optional if used instead
> +       of earlycon=<device> on the command line.
>
>  DBGP   Signature Reserved (signature == "DBGP")
>         == DeBuG Port table ==
> @@ -133,10 +135,11 @@ GTDT   Section 5.2.24 (signature == "GTDT")
>
>  HEST   Section 18.3.2 (signature == "HEST")
>         == Hardware Error Source Table ==
> -       Until further error source types are defined, use only types 6 (AER
> -       Root Port), 7 (AER Endpoint), 8 (AER Bridge), or 9 (Generic Hardware
> -       Error Source).  Firmware first error handling is possible if and only
> -       if Trusted Firmware is being used on arm64.
> +       ARM-specific error sources have been defined; please use those or the
> +       PCI types such as type 6 (AER Root Port), 7 (AER Endpoint), or 8 (AER
> +       Bridge), or use type 9 (Generic Hardware Error Source).  Firmware first
> +       error handling is possible if and only if Trusted Firmware is being
> +       used on arm64.
>
>         Must be supplied if RAS support is provided by the platform.  It
>         is recommended this table be supplied.
> @@ -149,20 +152,27 @@ IBFT   Signature Reserved (signature == "IBFT")
>         == iSCSI Boot Firmware Table ==
>         Microsoft defined table, support TBD.
>
> +IORT   Signature Reserved (signature == "IORT")
> +       == Input Output Remapping Table ==
> +       arm64 only table, required in order to describe IO topology, SMMUs,
> +       and GIC ITSs, and how those various components are connected together,
> +       such as identifying which components are behind which SMMUs/ITSs.
> +
>  IVRS   Signature Reserved (signature == "IVRS")
>         == I/O Virtualization Reporting Structure ==
>         x86_64 (AMD) only table, will not be supported.
>
>  LPIT   Signature Reserved (signature == "LPIT")
>         == Low Power Idle Table ==
> -       x86 only table as of ACPI 5.1; future versions have been adapted for
> -       use with ARM and will be recommended in order to support ACPI power
> -       management.
> +       x86 only table as of ACPI 5.1; starting with ACPI 6.0, processor
> +       descriptions and power states on ARM platforms should use the DSDT
> +       and define processor container devices (_HID ACPI0010, Section 8.4,
> +       and more specifically 8.4.3 and and 8.4.4).
>
>  MADT   Section 5.2.12 (signature == "APIC")
>         == Multiple APIC Description Table ==
>         Required for arm64.  Only the GIC interrupt controller structures
> -       should be used (types 0xA - 0xE).
> +       should be used (types 0xA - 0xF).
>
>  MCFG   Signature Reserved (signature == "MCFG")
>         == Memory-mapped ConFiGuration space ==
> @@ -176,14 +186,38 @@ MPST   Section 5.2.21 (signature == "MPST")
>         == Memory Power State Table ==
>         Optional, not currently supported.
>
> +MSCT   Section 5.2.19 (signature == "MSCT")
> +       == Maximum System Characteristic Table ==
> +       Optional, not currently supported.
> +
>  MSDM   Signature Reserved (signature == "MSDM")
>         == Microsoft Data Management table ==
>         Microsoft only table, will not be supported.
>
> -MSCT   Section 5.2.19 (signature == "MSCT")
> -       == Maximum System Characteristic Table ==
> +NFIT   Section 5.2.25 (signature == "NFIT")
> +       == NVDIMM Firmware Interface Table ==
>         Optional, not currently supported.
>
> +OEMx   Signature of "OEMx" only
> +       == OEM Specific Tables ==
> +       All tables starting with a signature of "OEM" are reserved for OEM
> +       use.  Since these are not meant to be of general use but are limited
> +       to very specific end users, they are not recommended for use and are
> +       not supported by the kernel for arm64.
> +
> +PCCT   Section 14.1 (signature == "PCCT)
> +       == Platform Communications Channel Table ==
> +       Recommend for use on arm64, and required when using CPPC to control
> +       power on the platform.
> +
> +PMTT   Section 5.2.21.12 (signature == "PMTT")
> +       == Platform Memory Topology Table ==
> +       Optional, but useful, but not currently supported.
> +
> +PSDT   Section 5.2.11.3 (signature == "PSDT")
> +       == Persistent System Description Table ==
> +       Obsolete table, will not be supported.
> +
>  RASF   Section 5.2.20 (signature == "RASF")
>         == RAS Feature table ==
>         Optional, not currently supported.
> @@ -195,7 +229,7 @@ RSDP   Section 5.2.5 (signature == "RSD PTR")
>  RSDT   Section 5.2.7 (signature == "RSDT")
>         == Root System Description Table ==
>         Since this table can only provide 32-bit addresses, it is deprecated
> -       on arm64, and will not be used.
> +       on arm64, and will not be used.  If provided, it will be ignored.
>
>  SBST   Section 5.2.14 (signature == "SBST")
>         == Smart Battery Subsystem Table ==
> @@ -207,7 +241,7 @@ SLIC   Signature Reserved (signature == "SLIC")
>
>  SLIT   Section 5.2.17 (signature == "SLIT")
>         == System Locality distance Information Table ==
> -       Optional in general, but required for NUMA systems.
> +       Optional in general, but required for arm64 NUMA systems.
>
>  SPCR   Signature Reserved (signature == "SPCR")
>         == Serial Port Console Redirection table ==
> @@ -220,7 +254,7 @@ SPMI   Signature Reserved (signature == "SPMI")
>  SRAT   Section 5.2.16 (signature == "SRAT")
>         == System Resource Affinity Table ==
>         Optional, but if used, only the GICC Affinity structures are read.
> -       To support NUMA, this table is required.
> +       To support arm64 NUMA, this table is required.
>
>  SSDT   Section 5.2.11.2 (signature == "SSDT")
>         == Secondary System Description Table ==
> @@ -235,6 +269,11 @@ SSDT   Section 5.2.11.2 (signature == "SSDT")
>         These tables are optional, however.  ACPI tables should contain only
>         one DSDT but can contain many SSDTs.
>
> +STAO   Signature Reserved (signature == "STAO")
> +       == _STA Override table ==
> +       Optional, but only necessary in virtualized environments in order to
> +       hide devices from guest OSs.
> +
>  TCPA   Signature Reserved (signature == "TCPA")
>         == Trusted Computing Platform Alliance table ==
>         Optional, not currently supported, and may need changes to fully
> @@ -266,6 +305,10 @@ WPBT   Signature Reserved (signature == "WPBT")
>         == Windows Platform Binary Table ==
>         Microsoft only table, will not be supported.
>
> +XENV   Signature Reserved (signature == "XENV")
> +       == Xen project table ==
> +       Optional, used only by Xen at present.
> +
>  XSDT   Section 5.2.8 (signature == "XSDT")
>         == eXtended System Description Table ==
>         Required for arm64.
> @@ -273,31 +316,57 @@ XSDT   Section 5.2.8 (signature == "XSDT")
>
>  ACPI Objects
>  ------------
> -The expectations on individual ACPI objects are discussed in the list that
> -follows:
> +The expectations on individual ACPI objects that are likely to be used are
> +shown in the list that follows:
>
>  Name   Section         Usage for ARMv8 Linux
>  ----   ------------    -------------------------------------------------
> +_ACx   11.4.1          Use as needed.
> +
>  _ADR   6.1.1           Use as needed.
>
> +_ALx   11.4.2          Use as needed.
> +
> +_ART   11.4.3          Use as needed.
> +
>  _BBN   6.5.5           Use as needed; PCI-specific.
>
> -_BDN   6.5.3           Optional; not likely to be used on arm64.
> +_CCA   6.2.17          This method must be defined for all bus masters
> +                       on arm64 -- there are no assumptions made about
> +                       whether such devices are cache coherent or not.
> +                       The _CCA value is inherited by all descendants of
> +                       these devices so it does not need to be repeated.
> +                       Without _CCA on arm64, the kernel does not know what
> +                       to do about setting up DMA for the device.
>
> -_CCA   6.2.17          This method should be defined for all bus masters
> -                       on arm64.  While cache coherency is assumed, making
> -                       it explicit ensures the kernel will set up DMA as
> -                       it should.
> +                       NB: this method provides default cache coherency
> +                       attributes; the presence of an SMMU can be used to
> +                       modify that, however.  For example, a master could
> +                       default to non-coherent, but be made coherent with
> +                       the appropriate SMMU configuration (see Table 17 of
> +                       the IORT specification, ARM Document DEN 0049B).
>
> -_CDM   6.2.1           Optional, to be used only for processor devices.
> +_CDM   6.2.1           Use as needed, to be used only for processor devices.
>
> -_CID   6.1.2           Use as needed.
> +_CID   6.1.2           Use as needed, see also _HID.
>
> -_CLS   6.1.3           Use as needed.
> +_CLS   6.1.3           Use as needed, see also _HID.
> +
> +_CPC   8.4.7.1         Use as needed; power management specific.  CPPC is
> +                       recommended on arm64.
> +
> +_CR3   11.4.5          Use as needed.
>
>  _CRS   6.2.2           Required on arm64.
>
> -_DCK   6.5.2           Optional; not likely to be used on arm64.
> +_CRT   11.4.4          Use as needed.
> +
> +_CSD   8.4.2.2         Use as needed, used only in conjuction with _CST.
> +
> +_CST   8.4.2.1         Low power idle states (8.4.4) are recommended instead
> +                       of C-states.
> +
> +_CWS   9.18.6          Use as needed.
>
>  _DDN   6.1.4           This field can be used for a device name.  However,
>                         it is meant for DOS device names (e.g., COM1), so be
> @@ -305,11 +374,11 @@ _DDN   6.1.4           This field can be used for a device name.  However,
>
>  _DEP   6.5.8           Use as needed.
>
> -_DIS   6.2.3           Optional, for power management use.
> +_DIS   6.2.3           Use as needed, for power management use.
>
> -_DLM   5.7.5           Optional.
> +_DLM   5.7.5           Use as needed.
>
> -_DMA   6.2.4           Optional.
> +_DMA   6.2.4           Use as needed.
>
>  _DSD   6.2.5           To be used with caution.  If this object is used, try
>                         to use it within the constraints already defined by the
> @@ -325,19 +394,29 @@ _DSD   6.2.5           To be used with caution.  If this object is used, try
>                         with the UEFI Forum; this may cause some iteration as
>                         more than one OS will be registering entries.
>
> -_DSM                   Do not use this method.  It is not standardized, the
> +_DSM   9.1.1           Do not use this method.  It is not standardized, the
>                         return values are not well documented, and it is
>                         currently a frequent source of error.
>
> -_DSW   7.2.1           Use as needed; power management specific.
> +_DSW   7.3.1           Use as needed; power management specific.
>
> -_EDL   6.3.1           Optional.
> +_DTI   11.4.6          Use as needed.
>
> -_EJD   6.3.2           Optional.
> +_EDL   6.3.1           Use as needed.
>
> -_EJx   6.3.3           Optional.
> +_EJD   6.3.2           Use as needed.
>
> -_FIX   6.2.7           x86 specific, not used on arm64.
> +_EJx   6.3.3           Use as needed.
> +
> +_FIF   11.3.1.1        Use as needed.
> +
> +_FPS   11.3.1.2        Use as needed.
> +
> +_FSL   11.3.1.3        Use as needed.
> +
> +_FST   11.3.1.4        Use as needed.
> +
> +_GCP   9.18.2          Use as needed.
>
>  \_GL   5.7.1           This object is not to be used in hardware reduced
>                         mode, and therefore should not be used on arm64.
> @@ -349,35 +428,57 @@ _GLK   6.5.7           This object requires a global lock be defined; there
>  \_GPE  5.3.1           This namespace is for x86 use only.  Do not use it
>                         on arm64.
>
> -_GSB   6.2.7           Optional.
> +_GRT   9.18.3          Use as needed.
> +
> +_GSB   6.2.7           Use as needed.
> +
> +_GTF   9.9.1.1         Use as needed.
> +
> +_GWS   9.18.5          Use as needed.
>
>  _HID   6.1.5           Use as needed.  This is the primary object to use in
>                         device probing, though _CID and _CLS may also be used.
>
> -_HPP   6.2.8           Optional, PCI specific.
> +_HOT   11.4.7          Use as needed.
> +
> +_HPP   6.2.8           Use as needed, PCI specific.
>
> -_HPX   6.2.9           Optional, PCI specific.
> +_HPX   6.2.9           Use as needed, PCI specific.
>
> -_HRV   6.1.6           Optional, use as needed to clarify device behavior; in
> -                       some cases, this may be easier to use than _DSD.
> +_HRV   6.1.6           Use as needed, use as needed to clarify device
> +                       behavior; in some cases, this may be easier to use
> +                       than _DSD.
>
>  _INI   6.5.1           Not required, but can be useful in setting up devices
>                         when UEFI leaves them in a state that may not be what
>                         the driver expects before it starts probing.
>
> -_IRC   7.2.15          Use as needed; power management specific.
> +_IRC   7.3.15          Use as needed; power management specific.
> +
> +_LCK   6.3.4           Use as needed.
> +
> +_LPI   8.4.4.3         Use as needed, but recommended for use with processor
> +                       definitions (_HID ACPI0010) on arm64.
>
> -_LCK   6.3.4           Optional.
> +_MAT   6.2.10          Use as needed; see also the MADT.
>
> -_MAT   6.2.10          Optional; see also the MADT.
> +_MBM   9.13.2.1        Use as needed.
>
> -_MLS   6.1.7           Optional, but highly recommended for use in
> +_MLS   6.1.7           Use as needed, but highly recommended for use in
>                         internationalization.
>
> -_OFF   7.1.2           It is recommended to define this method for any device
> +_MSG   9.2.2           Use as needed.
> +
> +_MSM   9.13.2.2        Use as needed.
> +
> +_MTL   11.4.8          Use as needed.
> +
> +_NTT   11.4.9          Use as needed.
> +
> +_OFF   7.2.2           It is recommended to define this method for any device
>                         that can be turned on or off.
>
> -_ON    7.1.3           It is recommended to define this method for any device
> +_ON    7.2.3           It is recommended to define this method for any device
>                         that can be turned on or off.
>
>  \_OS   5.7.3           This method will return "Linux" by default (this is
> @@ -405,115 +506,219 @@ _OSC   6.2.11          This method can be a global method in ACPI (i.e.,
>                         being used or what functionality is provided.  The
>                         _OSC method is to be used instead.
>
> -_OST   6.3.5           Optional.
> +_OST   6.3.5           Use as needed.
> +
> +_PCT   8.4.6.1         Use as needed; power management specific.
>
>  _PDC   8.4.1           Deprecated, do not use on arm64.
>
> +_PDL   8.4.6.2         Use as needed; power management specific.
> +
>  \_PIC  5.8.1           The method should not be used.  On arm64, the only
>                         interrupt model available is GIC.
>
> -_PLD   6.1.8           Optional.
> +_PLD   6.1.8           Use as needed.
> +
> +_PPC   8.4.6.3         Use as needed; power management specific.
> +
> +_PPE   8.4.8           Use as needed.
>
>  \_PR   5.3.1           This namespace is for x86 use only on legacy systems.
>                         Do not use it on arm64.
>
> -_PRS   6.2.12          Optional.
> +_PRE   7.3.12          Use as needed; power management specific.
> +
> +_PRR   7.3.26          Use as needed; power management specific.
> +
> +_PRS   6.2.12          Use as needed.
>
>  _PRT   6.2.13          Required as part of the definition of all PCI root
>                         devices.
>
> -_PRW   7.2.13          Use as needed; power management specific.
> +_PRW   7.3.13          Use as needed; power management specific.
>
> -_PRx   7.2.8-11        Use as needed; power management specific.  If _PR0 is
> +_PRx   7.3.8-11        Use as needed; power management specific.  If _PR0 is
>                         defined, _PR3 must also be defined.
>
> -_PSC   7.2.6           Use as needed; power management specific.
> +_PSC   7.3.6           Use as needed; power management specific.
> +
> +_PSD   8.4.6.5         Use as needed; power management specific.
>
> -_PSE   7.2.7           Use as needed; power management specific.
> +_PSE   7.3.7           Use as needed; power management specific.
>
> -_PSW   7.2.14          Use as needed; power management specific.
> +_PSL   11.4.10         Use as needed.
>
> -_PSx   7.2.2-5         Use as needed; power management specific.  If _PS0 is
> +_PSS   8.4.6.2         Use as needed; power management specific.
> +
> +_PSV   11.4.11         Use as needed.
> +
> +_PSW   7.3.14          Use as needed; power management specific.
> +
> +_PSx   7.3.2-5         Use as needed; power management specific.  If _PS0 is
>                         defined, _PS3 must also be defined.  If clocks or
>                         regulators need adjusting to be consistent with power
>                         usage, change them in these methods.
>
> -\_PTS  7.3.1           Use as needed; power management specific.
> +_PTC   8.4.5.1         Use as needed; power management specific.
> +
> +\_PTS  7.4.1           Use as needed; power management specific.
> +
> +_PUR   8.5.1.1         Use as needed.
> +
> +_PXM   6.2.14          Use as needed.
>
> -_PXM   6.2.14          Optional.
> +_RDI   8.4.4.4         Use as needed, but recommended for use with processor
> +                       definitions (_HID ACPI0010) on arm64.
>

Should we also mention here that _RDI used only in conjuction with _LPI.

Because as per section 8.4.4.4 "The dependency between the power
resources and the LPI state is described in _RDI"

>  _REG   6.5.4           Use as needed.
>
>  \_REV  5.7.4           Always returns the latest version of ACPI supported.
>
> -_RMV   6.3.6           Optional.
> +_RMV   6.3.6           Use as needed.
> +
> +_RST   7.3.25          Use as needed; power management specific.
> +
> +_RTV   11.4.12         Use as needed.
>
>  \_SB   5.3.1           Required on arm64; all devices must be defined in this
>                         namespace.
>
> +_SCP   11.4.13         Use as needed.
> +
> +_SDD   9.9.3.3.1       Use as needed.
> +
>  _SEG   6.5.6           Use as needed; PCI-specific.
>
> -\_SI   5.3.1,          Optional.
> -       9.1
> +\_SI   5.3.1,          Use as needed.
> +       9.2
> +
> +_SLI   6.2.15          Use as needed; recommended when SLIT table is in use.
>
> -_SLI   6.2.15          Optional; recommended when SLIT table is in use.
> +_SRT   9.18.4          Use as needed.
>
>  _STA   6.3.7,          It is recommended to define this method for any device
> -       7.1.4           that can be turned on or off.
> +       7.2.4           that can be turned on or off.  See also the STAO table
> +                       that provides overrides to hide devices in virtualized
> +                       environments.
>
> -_SRS   6.2.16          Optional; see also _PRS.
> +_SRS   6.2.16          Use as needed; see also _PRS.
> +
> +_SST   9.2.1           Use as needed.
>
>  _STR   6.1.10          Recommended for conveying device names to end users;
>                         this is preferred over using _DDN.
>
> +_SST   9.2.1           Use as needed.
> +
> +_STP   9.18.7          Use as needed.
> +
> +_STV   9.18.8          Use as needed.
> +
>  _SUB   6.1.9           Use as needed; _HID or _CID are preferred.
>
> -_SUN   6.1.11          Optional.
> +_SUN   6.1.11          Use as needed, but recommended.
>
> -\_Sx   7.3.2           Use as needed; power management specific.
> +\_Sx   7.4.2           Use as needed; power management specific.
>
> -_SxD   7.2.16-19       Use as needed; power management specific.
> +_SxD   7.3.16-19       Use as needed; power management specific.
>
> -_SxW   7.2.20-24       Use as needed; power management specific.
> +_SxW   7.3.20-24       Use as needed; power management specific.
>
> -_SWS   7.3.3           Use as needed; power management specific; this may
> +_SWS   7.4.3           Use as needed; power management specific; this may
>                         require specification changes for use on arm64.
>
> -\_TTS  7.3.4           Use as needed; power management specific.
> +_TC1   11.4.14         Use as needed.
> +
> +_TC2   11.4.15         Use as needed.
> +
> +_TDL   8.4.5.5         Use as needed; power management specific.
> +
> +_TFP   11.4.16         Use as needed.
> +
> +_TIP   9.18.9          Use as needed.
> +
> +_TIV   9.18.10         Use as needed.
> +
> +_TMP   11.4.17         Use as needed.
> +
> +_TPC   8.4.5.3         Use as needed; power management specific.
>
> -\_TZ   5.3.1           Optional.
> +_TPT   11.4.18         Use as needed.
> +
> +_TRT   11.4.19         Use as needed.
> +
> +_TSD   8.4.5.4         Use as needed; power management specific.
> +
> +_TSN   11.4.20         Use as needed.
> +
> +_TSP   11.4.21         Use as needed.
> +
> +_TSS   8.4.5.2         Use as needed; power management specific.
> +
> +_TST   11.4.22         Use as needed.
> +
> +\_TTS  7.4.4           Use as needed; power management specific.
> +
> +\_TZ   5.3.1           Use as needed.
> +
> +_TZD   11.4.23         Use as needed.
> +
> +_TZM   11.4.24         Use as needed.
> +
> +_TZP   11.4.25         Use as needed.
>
>  _UID   6.1.12          Recommended for distinguishing devices of the same
>                         class; define it if at all possible.
>
> -\_WAK  7.3.5           Use as needed; power management specific.
> +_UPC   9.14            Use as needed.
> +
> +\_WAK  7.4.5           Use as needed; power management specific.
> +
> +
>
>
>  ACPI Event Model
>  ----------------
>  Do not use GPE block devices; these are not supported in the hardware reduced
>  profile used by arm64.  Since there are no GPE blocks defined for use on ARM
> -platforms, GPIO-signaled interrupts should be used for creating system events.
> +platforms, ACPI events must be signaled differently.
> +
> +There are two options: GPIO-signaled interrupts (Section 5.6.5), and
> +interrupt-signaled events (Section 5.6.9).  Interrupt-signaled events are a
> +new feature in the ACPI 6.1 specification.  Either -- or both -- can be used
> +on a given platform, and which to use may be dependent of limitations in any
> +given SoC.  If possible, interrupt-signaled events are recommended.
>
>
>  ACPI Processor Control
>  ----------------------
> -Section 8 of the ACPI specification is currently undergoing change that
> -should be completed in the 6.0 version of the specification.  Processor
> -performance control will be handled differently for arm64 at that point
> -in time.  Processor aggregator devices (section 8.5) will not be used,
> -for example, but another similar mechanism instead.
> -
> -While UEFI constrains what we can say until the release of 6.0, it is
> -recommended that CPPC (8.4.5) be used as the primary model.  This will
> -still be useful into the future.  C-states and P-states will still be
> -provided, but most of the current design work appears to favor CPPC.
> +Section 8 of the ACPI specification changed significantly in version 6.0.
> +Processors should now be defined as Device objects with _HID ACPI0007; do
> +not use the deprecated Processor statement in ASL.  All multiprocessor systems
> +should also define a hierarchy of processors, done with Processor Container
> +Devices (see Section 8.4.3.1, _HID ACPI0010); do not use processor aggregator
> +devices (Section 8.5) to describe processor topology.  Section 8.4 of the
> +specification describes the semantics of these object definitions and how
> +they interrelate.
> +
> +Most importantly, the processor hierarchy defined also defines the low power
> +idle states that are available to the platform, along with the rules for
> +determining which processors can be turned on or off and the circumstances
> +that control that.  Without this information, the processors will run in
> +whatever power state they were left in by UEFI.
> +
> +Note too, that the processor Device objects defined and the entries in the
> +MADT for GICs are expected to be in sychronization.  The _UID of the Device
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
>
>
>  ACPI System Address Map Interfaces
> @@ -535,21 +740,25 @@ used to indicate fatal errors that cannot be corrected, and require immediate
>  attention.
>
>  Since there is no direct equivalent of the x86 SCI or NMI, arm64 handles
> -these slightly differently.  The SCI is handled as a normal GPIO-signaled
> -interrupt; given that these are corrected (or correctable) errors being
> -reported, this is sufficient.  The NMI is emulated as the highest priority
> -GPIO-signaled interrupt possible.  This implies some caution must be used
> -since there could be interrupts at higher privilege levels or even interrupts
> -at the same priority as the emulated NMI.  In Linux, this should not be the
> -case but one should be aware it could happen.
> +these slightly differently.  The SCI is handled as a high priority interrupt;
> +given that these are corrected (or correctable) errors being reported, this
> +is sufficient.  The NMI is emulated as the highest priority interrupt
> +possible.  This implies some caution must be used since there could be
> +interrupts at higher privilege levels or even interrupts at the same priority
> +as the emulated NMI.  In Linux, this should not be the case but one should
> +be aware it could happen.
>
>
>  ACPI Objects Not Supported on ARM64
>  -----------------------------------
>  While this may change in the future, there are several classes of objects
>  that can be defined, but are not currently of general interest to ARM servers.
> +Some of these objects have x86 equivalents, and may actually make sense in ARM
> +servers.  However, there is either no hardware available at present, or there
> +may not even be a non-ARM implementation yet.  Hence, they are not currently
> +supported.
>
> -These are not supported:
> +The following classes of objects are not supported:
>
>         -- Section 9.2: ambient light sensor devices
>
> @@ -571,16 +780,6 @@ These are not supported:
>
>         -- Section 9.18: time and alarm devices (see 9.15)
>
> -
> -ACPI Objects Not Yet Implemented
> ---------------------------------
> -While these objects have x86 equivalents, and they do make some sense in ARM
> -servers, there is either no hardware available at present, or in some cases
> -there may not yet be a non-ARM implementation.  Hence, they are currently not
> -implemented though that may change in the future.
> -
> -Not yet implemented are:
> -
>         -- Section 10: power source and power meter devices
>
>         -- Section 11: thermal management
> @@ -589,5 +788,31 @@ Not yet implemented are:
>
>         -- Section 13: SMBus interfaces
>
> -       -- Section 17: NUMA support (prototypes have been submitted for
> -          review)
> +
> +This also mean that there is no support for the following objects:
> +
> +Name   Section                     Name   Section
> +----   ------------                ----   ------------
> +_ALC   9.3.4                       _FDM   9.10.3
> +_ALI   9.3.2                       _FIX   6.2.7
> +_ALP   9.3.6                       _GAI   10.4.5
> +_ALR   9.3.5                       _GHL   10.4.7
> +_ALT   9.3.3                       _GTM   9.9.2.1.1
> +_BCT   10.2.2.10                   _LID   9.5.1
> +_BDN   6.5.3                       _PAI   10.4.4
> +_BIF   10.2.2.1                    _PCL   10.3.2
> +_BIX   10.2.2.1                    _PIF   10.3.3
> +_BLT   9.2.3                       _PMC   10.4.1
> +_BMA   10.2.2.4                    _PMD   10.4.8
> +_BMC   10.2.2.12                   _PMM   10.4.3
> +_BMD   10.2.2.11                   _PRL   10.3.4
> +_BMS   10.2.2.5                    _PSR   10.3.1
> +_BST   10.2.2.6                    _PTP   10.4.2
> +_BTH   10.2.2.7                    _SBS   10.1.3
> +_BTM   10.2.2.9                    _SHL   10.4.6
> +_BTP   10.2.2.8                    _STM   9.9.2.1.1
> +_DCK   6.5.2                       _UPD   9.16.1
> +_EC    12.12                       _UPP   9.16.2
> +_FDE   9.10.1                      _WPC   10.5.2
> +_FDI   9.10.2                      _WPP   10.5.3
> +
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
> +
> +    -- If NUMA is supported, the SRAT (System Resource Affinity Table)
> +       and SLIT (System Locality distance Information Table), sections
> +       5.2.16 and 5.2.17, respectively.
> +
>  If the above tables are not all present, the kernel may or may not be
>  able to boot properly since it may not be able to configure all of the
> -devices available.
> +devices available.  This list of tables is not meant to be all inclusive;
> +in some environments other tables may be needed (e.g., any of the APEI
> +tables from section 18) to support specific functionality.
>
>
>  ACPI Detection
> @@ -233,7 +246,7 @@ that looks like this: Name(KEY0, "value0").  An ACPI device driver would
>  then retrieve the value of the property by evaluating the KEY0 object.
>  However, using Name() this way has multiple problems: (1) ACPI limits
>  names ("KEY0") to four characters unlike DT; (2) there is no industry
> -wide registry that maintains a list of names, minimzing re-use; (3)
> +wide registry that maintains a list of names, minimizing re-use; (3)
>  there is also no registry for the definition of property values ("value0"),
>  again making re-use difficult; and (4) how does one maintain backward
>  compatibility as new hardware comes out?  The _DSD method was created
> @@ -434,7 +447,8 @@ The ACPI specification changes regularly.  During the year 2014, for instance,
>  version 5.1 was released and version 6.0 substantially completed, with most of
>  the changes being driven by ARM-specific requirements.  Proposed changes are
>  presented and discussed in the ASWG (ACPI Specification Working Group) which
> -is a part of the UEFI Forum.
> +is a part of the UEFI Forum.  The current version of the ACPI specification
> +is 6.1 release in January 2016.
>
>  Participation in this group is open to all UEFI members.  Please see
>  http://www.uefi.org/workinggroup for details on group membership.
> --
> 2.5.0
>
