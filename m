From: al.stone@linaro.org (Al Stone)
Date: Thu, 17 Mar 2016 15:38:29 -0600
Subject: [RESEND PATCH v2] ARM64: ACPI: Update documentation for latest
 specification version
In-Reply-To: <CAGm_ybgvVp-m70+QJO1r4uEg3V_fYjY963=zHPs37pjxEfq+Qw@mail.gmail.com>
References: <1458073681-11178-1-git-send-email-al.stone@linaro.org>
 <CAGm_ybgvVp-m70+QJO1r4uEg3V_fYjY963=zHPs37pjxEfq+Qw@mail.gmail.com>
Message-ID: <56EB23D5.6090401@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/15/2016 10:50 PM, Vikas Sajjan wrote:
> Hi Al Stone,
> 
> On Wed, Mar 16, 2016 at 1:58 AM, Al Stone <al.stone@linaro.org> wrote:
>> The ACPI 6.1 specification was recently released at the end of January 2016,
>> but the arm64 kernel documentation for the use of ACPI was written for the
>> 5.1 version of the spec.  There were significant additions to the spec that
>> had not yet been mentioned -- for example, the 6.0 mechanisms added to make
>> it easier to define processors and low power idle states, as well as the
>> 6.1 addition allowing regular interrupts (not just from GPIO) be used to
>> signal ACPI general purpose events.
>>
>> This patch reflects going back through and examining the specs in detail
>> and updating content appropriately.  Whilst there, a few odds and ends of
>> typos were caught as well.  This brings the documentation up to date with
>> ACPI 6.1 for arm64.
>>
>> RESEND:
>>    -- Corrected From: header and added missing Cc's
>>
>> Changes for v2:
>>    -- Clean up white space (Harb Abdulhahmid)
>>    -- Clarification on _CCA usage (Harb Abdulhamid)
>>    -- IORT moved to required from recommended (Hanjun Guo)
>>    -- Clarify IORT description (Hanjun Guo)
>>
>> Signed-off-by: Al Stone <al.stone@linaro.org>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> ---
>>  Documentation/arm64/acpi_object_usage.txt | 445 ++++++++++++++++++++++--------
>>  Documentation/arm64/arm-acpi.txt          |  28 +-
>>  2 files changed, 356 insertions(+), 117 deletions(-)
>>
>> diff --git a/Documentation/arm64/acpi_object_usage.txt b/Documentation/arm64/acpi_object_usage.txt
>> index a6e1a18..29bc1a1 100644
>> --- a/Documentation/arm64/acpi_object_usage.txt
>> +++ b/Documentation/arm64/acpi_object_usage.txt
>> @@ -11,15 +11,16 @@ outside of the UEFI Forum (see Section 5.2.6 of the specification).
>>
>>  For ACPI on arm64, tables also fall into the following categories:
>>
>> -       -- Required: DSDT, FADT, GTDT, MADT, MCFG, RSDP, SPCR, XSDT
>> +       -- Required: DSDT, FADT, GTDT, IORT, MADT, MCFG, RSDP, SPCR, XSDT
>>
>> -       -- Recommended: BERT, EINJ, ERST, HEST, SSDT
>> +       -- Recommended: BERT, EINJ, ERST, HEST, PCCT, SSDT
>>
>> -       -- Optional: BGRT, CPEP, CSRT, DRTM, ECDT, FACS, FPDT, MCHI, MPST,
>> -          MSCT, RASF, SBST, SLIT, SPMI, SRAT, TCPA, TPM2, UEFI
>> +       -- Optional: BGRT, CPEP, CSRT, DBG2, DRTM, ECDT, FACS, FPDT, MCHI,
>> +          MPST, MSCT, NFIT, PMTT, RASF, SBST, SLIT, SPMI, SRAT, STAO, TCPA,
>> +          TPM2, UEFI, XENV
>>
>> -       -- Not supported: BOOT, DBG2, DBGP, DMAR, ETDT, HPET, IBFT, IVRS,
>> -          LPIT, MSDM, RSDT, SLIC, WAET, WDAT, WDRT, WPBT
>> +       -- Not supported: BOOT, DBGP, DMAR, ETDT, HPET, IBFT, IVRS, LPIT,
>> +          MSDM, OEMx, PSDT, RSDT, SLIC, WAET, WDAT, WDRT, WPBT
>>
>>
>>  Table  Usage for ARMv8 Linux
>> @@ -50,7 +51,8 @@ CSRT   Signature Reserved (signature == "CSRT")
>>
>>  DBG2   Signature Reserved (signature == "DBG2")
>>         == DeBuG port table 2 ==
>> -       Microsoft only table, will not be supported.
>> +       License has changed and should be usable.  Optional if used instead
>> +       of earlycon=<device> on the command line.
>>
>>  DBGP   Signature Reserved (signature == "DBGP")
>>         == DeBuG Port table ==
>> @@ -133,10 +135,11 @@ GTDT   Section 5.2.24 (signature == "GTDT")
>>
>>  HEST   Section 18.3.2 (signature == "HEST")
>>         == Hardware Error Source Table ==
>> -       Until further error source types are defined, use only types 6 (AER
>> -       Root Port), 7 (AER Endpoint), 8 (AER Bridge), or 9 (Generic Hardware
>> -       Error Source).  Firmware first error handling is possible if and only
>> -       if Trusted Firmware is being used on arm64.
>> +       ARM-specific error sources have been defined; please use those or the
>> +       PCI types such as type 6 (AER Root Port), 7 (AER Endpoint), or 8 (AER
>> +       Bridge), or use type 9 (Generic Hardware Error Source).  Firmware first
>> +       error handling is possible if and only if Trusted Firmware is being
>> +       used on arm64.
>>
>>         Must be supplied if RAS support is provided by the platform.  It
>>         is recommended this table be supplied.
>> @@ -149,20 +152,27 @@ IBFT   Signature Reserved (signature == "IBFT")
>>         == iSCSI Boot Firmware Table ==
>>         Microsoft defined table, support TBD.
>>
>> +IORT   Signature Reserved (signature == "IORT")
>> +       == Input Output Remapping Table ==
>> +       arm64 only table, required in order to describe IO topology, SMMUs,
>> +       and GIC ITSs, and how those various components are connected together,
>> +       such as identifying which components are behind which SMMUs/ITSs.
>> +
>>  IVRS   Signature Reserved (signature == "IVRS")
>>         == I/O Virtualization Reporting Structure ==
>>         x86_64 (AMD) only table, will not be supported.
>>
>>  LPIT   Signature Reserved (signature == "LPIT")
>>         == Low Power Idle Table ==
>> -       x86 only table as of ACPI 5.1; future versions have been adapted for
>> -       use with ARM and will be recommended in order to support ACPI power
>> -       management.
>> +       x86 only table as of ACPI 5.1; starting with ACPI 6.0, processor
>> +       descriptions and power states on ARM platforms should use the DSDT
>> +       and define processor container devices (_HID ACPI0010, Section 8.4,
>> +       and more specifically 8.4.3 and and 8.4.4).
>>
>>  MADT   Section 5.2.12 (signature == "APIC")
>>         == Multiple APIC Description Table ==
>>         Required for arm64.  Only the GIC interrupt controller structures
>> -       should be used (types 0xA - 0xE).
>> +       should be used (types 0xA - 0xF).
>>
>>  MCFG   Signature Reserved (signature == "MCFG")
>>         == Memory-mapped ConFiGuration space ==
>> @@ -176,14 +186,38 @@ MPST   Section 5.2.21 (signature == "MPST")
>>         == Memory Power State Table ==
>>         Optional, not currently supported.
>>
>> +MSCT   Section 5.2.19 (signature == "MSCT")
>> +       == Maximum System Characteristic Table ==
>> +       Optional, not currently supported.
>> +
>>  MSDM   Signature Reserved (signature == "MSDM")
>>         == Microsoft Data Management table ==
>>         Microsoft only table, will not be supported.
>>
>> -MSCT   Section 5.2.19 (signature == "MSCT")
>> -       == Maximum System Characteristic Table ==
>> +NFIT   Section 5.2.25 (signature == "NFIT")
>> +       == NVDIMM Firmware Interface Table ==
>>         Optional, not currently supported.
>>
>> +OEMx   Signature of "OEMx" only
>> +       == OEM Specific Tables ==
>> +       All tables starting with a signature of "OEM" are reserved for OEM
>> +       use.  Since these are not meant to be of general use but are limited
>> +       to very specific end users, they are not recommended for use and are
>> +       not supported by the kernel for arm64.
>> +
>> +PCCT   Section 14.1 (signature == "PCCT)
>> +       == Platform Communications Channel Table ==
>> +       Recommend for use on arm64, and required when using CPPC to control
>> +       power on the platform.
>> +
>> +PMTT   Section 5.2.21.12 (signature == "PMTT")
>> +       == Platform Memory Topology Table ==
>> +       Optional, but useful, but not currently supported.
>> +
>> +PSDT   Section 5.2.11.3 (signature == "PSDT")
>> +       == Persistent System Description Table ==
>> +       Obsolete table, will not be supported.
>> +
>>  RASF   Section 5.2.20 (signature == "RASF")
>>         == RAS Feature table ==
>>         Optional, not currently supported.
>> @@ -195,7 +229,7 @@ RSDP   Section 5.2.5 (signature == "RSD PTR")
>>  RSDT   Section 5.2.7 (signature == "RSDT")
>>         == Root System Description Table ==
>>         Since this table can only provide 32-bit addresses, it is deprecated
>> -       on arm64, and will not be used.
>> +       on arm64, and will not be used.  If provided, it will be ignored.
>>
>>  SBST   Section 5.2.14 (signature == "SBST")
>>         == Smart Battery Subsystem Table ==
>> @@ -207,7 +241,7 @@ SLIC   Signature Reserved (signature == "SLIC")
>>
>>  SLIT   Section 5.2.17 (signature == "SLIT")
>>         == System Locality distance Information Table ==
>> -       Optional in general, but required for NUMA systems.
>> +       Optional in general, but required for arm64 NUMA systems.
>>
>>  SPCR   Signature Reserved (signature == "SPCR")
>>         == Serial Port Console Redirection table ==
>> @@ -220,7 +254,7 @@ SPMI   Signature Reserved (signature == "SPMI")
>>  SRAT   Section 5.2.16 (signature == "SRAT")
>>         == System Resource Affinity Table ==
>>         Optional, but if used, only the GICC Affinity structures are read.
>> -       To support NUMA, this table is required.
>> +       To support arm64 NUMA, this table is required.
>>
>>  SSDT   Section 5.2.11.2 (signature == "SSDT")
>>         == Secondary System Description Table ==
>> @@ -235,6 +269,11 @@ SSDT   Section 5.2.11.2 (signature == "SSDT")
>>         These tables are optional, however.  ACPI tables should contain only
>>         one DSDT but can contain many SSDTs.
>>
>> +STAO   Signature Reserved (signature == "STAO")
>> +       == _STA Override table ==
>> +       Optional, but only necessary in virtualized environments in order to
>> +       hide devices from guest OSs.
>> +
>>  TCPA   Signature Reserved (signature == "TCPA")
>>         == Trusted Computing Platform Alliance table ==
>>         Optional, not currently supported, and may need changes to fully
>> @@ -266,6 +305,10 @@ WPBT   Signature Reserved (signature == "WPBT")
>>         == Windows Platform Binary Table ==
>>         Microsoft only table, will not be supported.
>>
>> +XENV   Signature Reserved (signature == "XENV")
>> +       == Xen project table ==
>> +       Optional, used only by Xen at present.
>> +
>>  XSDT   Section 5.2.8 (signature == "XSDT")
>>         == eXtended System Description Table ==
>>         Required for arm64.
>> @@ -273,31 +316,57 @@ XSDT   Section 5.2.8 (signature == "XSDT")
>>
>>  ACPI Objects
>>  ------------
>> -The expectations on individual ACPI objects are discussed in the list that
>> -follows:
>> +The expectations on individual ACPI objects that are likely to be used are
>> +shown in the list that follows:
>>
>>  Name   Section         Usage for ARMv8 Linux
>>  ----   ------------    -------------------------------------------------
>> +_ACx   11.4.1          Use as needed.
>> +
>>  _ADR   6.1.1           Use as needed.
>>
>> +_ALx   11.4.2          Use as needed.
>> +
>> +_ART   11.4.3          Use as needed.
>> +
>>  _BBN   6.5.5           Use as needed; PCI-specific.
>>
>> -_BDN   6.5.3           Optional; not likely to be used on arm64.
>> +_CCA   6.2.17          This method must be defined for all bus masters
>> +                       on arm64 -- there are no assumptions made about
>> +                       whether such devices are cache coherent or not.
>> +                       The _CCA value is inherited by all descendants of
>> +                       these devices so it does not need to be repeated.
>> +                       Without _CCA on arm64, the kernel does not know what
>> +                       to do about setting up DMA for the device.
>>
>> -_CCA   6.2.17          This method should be defined for all bus masters
>> -                       on arm64.  While cache coherency is assumed, making
>> -                       it explicit ensures the kernel will set up DMA as
>> -                       it should.
>> +                       NB: this method provides default cache coherency
>> +                       attributes; the presence of an SMMU can be used to
>> +                       modify that, however.  For example, a master could
>> +                       default to non-coherent, but be made coherent with
>> +                       the appropriate SMMU configuration (see Table 17 of
>> +                       the IORT specification, ARM Document DEN 0049B).
>>
>> -_CDM   6.2.1           Optional, to be used only for processor devices.
>> +_CDM   6.2.1           Use as needed, to be used only for processor devices.
>>
>> -_CID   6.1.2           Use as needed.
>> +_CID   6.1.2           Use as needed, see also _HID.
>>
>> -_CLS   6.1.3           Use as needed.
>> +_CLS   6.1.3           Use as needed, see also _HID.
>> +
>> +_CPC   8.4.7.1         Use as needed; power management specific.  CPPC is
>> +                       recommended on arm64.
>> +
>> +_CR3   11.4.5          Use as needed.
>>
>>  _CRS   6.2.2           Required on arm64.
>>
>> -_DCK   6.5.2           Optional; not likely to be used on arm64.
>> +_CRT   11.4.4          Use as needed.
>> +
>> +_CSD   8.4.2.2         Use as needed, used only in conjuction with _CST.
>> +
>> +_CST   8.4.2.1         Low power idle states (8.4.4) are recommended instead
>> +                       of C-states.
>> +
>> +_CWS   9.18.6          Use as needed.
>>
>>  _DDN   6.1.4           This field can be used for a device name.  However,
>>                         it is meant for DOS device names (e.g., COM1), so be
>> @@ -305,11 +374,11 @@ _DDN   6.1.4           This field can be used for a device name.  However,
>>
>>  _DEP   6.5.8           Use as needed.
>>
>> -_DIS   6.2.3           Optional, for power management use.
>> +_DIS   6.2.3           Use as needed, for power management use.
>>
>> -_DLM   5.7.5           Optional.
>> +_DLM   5.7.5           Use as needed.
>>
>> -_DMA   6.2.4           Optional.
>> +_DMA   6.2.4           Use as needed.
>>
>>  _DSD   6.2.5           To be used with caution.  If this object is used, try
>>                         to use it within the constraints already defined by the
>> @@ -325,19 +394,29 @@ _DSD   6.2.5           To be used with caution.  If this object is used, try
>>                         with the UEFI Forum; this may cause some iteration as
>>                         more than one OS will be registering entries.
>>
>> -_DSM                   Do not use this method.  It is not standardized, the
>> +_DSM   9.1.1           Do not use this method.  It is not standardized, the
>>                         return values are not well documented, and it is
>>                         currently a frequent source of error.
>>
>> -_DSW   7.2.1           Use as needed; power management specific.
>> +_DSW   7.3.1           Use as needed; power management specific.
>>
>> -_EDL   6.3.1           Optional.
>> +_DTI   11.4.6          Use as needed.
>>
>> -_EJD   6.3.2           Optional.
>> +_EDL   6.3.1           Use as needed.
>>
>> -_EJx   6.3.3           Optional.
>> +_EJD   6.3.2           Use as needed.
>>
>> -_FIX   6.2.7           x86 specific, not used on arm64.
>> +_EJx   6.3.3           Use as needed.
>> +
>> +_FIF   11.3.1.1        Use as needed.
>> +
>> +_FPS   11.3.1.2        Use as needed.
>> +
>> +_FSL   11.3.1.3        Use as needed.
>> +
>> +_FST   11.3.1.4        Use as needed.
>> +
>> +_GCP   9.18.2          Use as needed.
>>
>>  \_GL   5.7.1           This object is not to be used in hardware reduced
>>                         mode, and therefore should not be used on arm64.
>> @@ -349,35 +428,57 @@ _GLK   6.5.7           This object requires a global lock be defined; there
>>  \_GPE  5.3.1           This namespace is for x86 use only.  Do not use it
>>                         on arm64.
>>
>> -_GSB   6.2.7           Optional.
>> +_GRT   9.18.3          Use as needed.
>> +
>> +_GSB   6.2.7           Use as needed.
>> +
>> +_GTF   9.9.1.1         Use as needed.
>> +
>> +_GWS   9.18.5          Use as needed.
>>
>>  _HID   6.1.5           Use as needed.  This is the primary object to use in
>>                         device probing, though _CID and _CLS may also be used.
>>
>> -_HPP   6.2.8           Optional, PCI specific.
>> +_HOT   11.4.7          Use as needed.
>> +
>> +_HPP   6.2.8           Use as needed, PCI specific.
>>
>> -_HPX   6.2.9           Optional, PCI specific.
>> +_HPX   6.2.9           Use as needed, PCI specific.
>>
>> -_HRV   6.1.6           Optional, use as needed to clarify device behavior; in
>> -                       some cases, this may be easier to use than _DSD.
>> +_HRV   6.1.6           Use as needed, use as needed to clarify device
>> +                       behavior; in some cases, this may be easier to use
>> +                       than _DSD.
>>
>>  _INI   6.5.1           Not required, but can be useful in setting up devices
>>                         when UEFI leaves them in a state that may not be what
>>                         the driver expects before it starts probing.
>>
>> -_IRC   7.2.15          Use as needed; power management specific.
>> +_IRC   7.3.15          Use as needed; power management specific.
>> +
>> +_LCK   6.3.4           Use as needed.
>> +
>> +_LPI   8.4.4.3         Use as needed, but recommended for use with processor
>> +                       definitions (_HID ACPI0010) on arm64.
>>
>> -_LCK   6.3.4           Optional.
>> +_MAT   6.2.10          Use as needed; see also the MADT.
>>
>> -_MAT   6.2.10          Optional; see also the MADT.
>> +_MBM   9.13.2.1        Use as needed.
>>
>> -_MLS   6.1.7           Optional, but highly recommended for use in
>> +_MLS   6.1.7           Use as needed, but highly recommended for use in
>>                         internationalization.
>>
>> -_OFF   7.1.2           It is recommended to define this method for any device
>> +_MSG   9.2.2           Use as needed.
>> +
>> +_MSM   9.13.2.2        Use as needed.
>> +
>> +_MTL   11.4.8          Use as needed.
>> +
>> +_NTT   11.4.9          Use as needed.
>> +
>> +_OFF   7.2.2           It is recommended to define this method for any device
>>                         that can be turned on or off.
>>
>> -_ON    7.1.3           It is recommended to define this method for any device
>> +_ON    7.2.3           It is recommended to define this method for any device
>>                         that can be turned on or off.
>>
>>  \_OS   5.7.3           This method will return "Linux" by default (this is
>> @@ -405,115 +506,219 @@ _OSC   6.2.11          This method can be a global method in ACPI (i.e.,
>>                         being used or what functionality is provided.  The
>>                         _OSC method is to be used instead.
>>
>> -_OST   6.3.5           Optional.
>> +_OST   6.3.5           Use as needed.
>> +
>> +_PCT   8.4.6.1         Use as needed; power management specific.
>>
>>  _PDC   8.4.1           Deprecated, do not use on arm64.
>>
>> +_PDL   8.4.6.2         Use as needed; power management specific.
>> +
>>  \_PIC  5.8.1           The method should not be used.  On arm64, the only
>>                         interrupt model available is GIC.
>>
>> -_PLD   6.1.8           Optional.
>> +_PLD   6.1.8           Use as needed.
>> +
>> +_PPC   8.4.6.3         Use as needed; power management specific.
>> +
>> +_PPE   8.4.8           Use as needed.
>>
>>  \_PR   5.3.1           This namespace is for x86 use only on legacy systems.
>>                         Do not use it on arm64.
>>
>> -_PRS   6.2.12          Optional.
>> +_PRE   7.3.12          Use as needed; power management specific.
>> +
>> +_PRR   7.3.26          Use as needed; power management specific.
>> +
>> +_PRS   6.2.12          Use as needed.
>>
>>  _PRT   6.2.13          Required as part of the definition of all PCI root
>>                         devices.
>>
>> -_PRW   7.2.13          Use as needed; power management specific.
>> +_PRW   7.3.13          Use as needed; power management specific.
>>
>> -_PRx   7.2.8-11        Use as needed; power management specific.  If _PR0 is
>> +_PRx   7.3.8-11        Use as needed; power management specific.  If _PR0 is
>>                         defined, _PR3 must also be defined.
>>
>> -_PSC   7.2.6           Use as needed; power management specific.
>> +_PSC   7.3.6           Use as needed; power management specific.
>> +
>> +_PSD   8.4.6.5         Use as needed; power management specific.
>>
>> -_PSE   7.2.7           Use as needed; power management specific.
>> +_PSE   7.3.7           Use as needed; power management specific.
>>
>> -_PSW   7.2.14          Use as needed; power management specific.
>> +_PSL   11.4.10         Use as needed.
>>
>> -_PSx   7.2.2-5         Use as needed; power management specific.  If _PS0 is
>> +_PSS   8.4.6.2         Use as needed; power management specific.
>> +
>> +_PSV   11.4.11         Use as needed.
>> +
>> +_PSW   7.3.14          Use as needed; power management specific.
>> +
>> +_PSx   7.3.2-5         Use as needed; power management specific.  If _PS0 is
>>                         defined, _PS3 must also be defined.  If clocks or
>>                         regulators need adjusting to be consistent with power
>>                         usage, change them in these methods.
>>
>> -\_PTS  7.3.1           Use as needed; power management specific.
>> +_PTC   8.4.5.1         Use as needed; power management specific.
>> +
>> +\_PTS  7.4.1           Use as needed; power management specific.
>> +
>> +_PUR   8.5.1.1         Use as needed.
>> +
>> +_PXM   6.2.14          Use as needed.
>>
>> -_PXM   6.2.14          Optional.
>> +_RDI   8.4.4.4         Use as needed, but recommended for use with processor
>> +                       definitions (_HID ACPI0010) on arm64.
>>
> 
> Should we also mention here that _RDI used only in conjuction with _LPI.
> 
> Because as per section 8.4.4.4 "The dependency between the power
> resources and the LPI state is described in _RDI"
> 

It definitely wouldn't hurt.  I've tried to avoid duplicating content in
the spec and focus on how this applies to arm64 in particular; I'll play
with some wording and see if I can make it work, though.

Thanks for the review.

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Linaro Enterprise Group
al.stone at linaro.org
-----------------------------------
