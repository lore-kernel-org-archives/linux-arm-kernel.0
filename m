From: al.stone@linaro.org (Al Stone)
Date: Mon, 25 Apr 2016 15:21:27 -0600
Subject: [PATCH v5 1/1] ARM64: ACPI: Update documentation for latest
 specification version
In-Reply-To: <1461619287-27211-1-git-send-email-al.stone@linaro.org>
References: <1461619287-27211-1-git-send-email-al.stone@linaro.org>
Message-ID: <1461619287-27211-2-git-send-email-al.stone@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ACPI 6.1 specification was recently released at the end of January
2016, but the arm64 kernel documentation for the use of ACPI was written
for the 5.1 version of the spec.  There were significant additions to the
spec that had not yet been mentioned -- for example, the 6.0 mechanisms
added to make it easier to define processors and low power idle states,
as well as the 6.1 addition allowing regular interrupts (not just from
GPIO) be used to signal ACPI general purpose events.

This patch reflects going back through and examining the specs in detail
and updating content appropriately.  Whilst there, a few odds and ends of
typos were caught as well.  This brings the documentation up to date with
ACPI 6.1 for arm64.

Signed-off-by: Al Stone <al.stone@linaro.org>
Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 Documentation/arm64/acpi_object_usage.txt | 343 ++++++++++++++++--------------
 Documentation/arm64/arm-acpi.txt          |  40 ++--
 2 files changed, 213 insertions(+), 170 deletions(-)

diff --git a/Documentation/arm64/acpi_object_usage.txt b/Documentation/arm64/acpi_object_usage.txt
index a6e1a18..c77010c 100644
--- a/Documentation/arm64/acpi_object_usage.txt
+++ b/Documentation/arm64/acpi_object_usage.txt
@@ -13,14 +13,14 @@ For ACPI on arm64, tables also fall into the following categories:
 
        -- Required: DSDT, FADT, GTDT, MADT, MCFG, RSDP, SPCR, XSDT
 
-       -- Recommended: BERT, EINJ, ERST, HEST, SSDT
+       -- Recommended: BERT, EINJ, ERST, HEST, PCCT, SSDT
 
-       -- Optional: BGRT, CPEP, CSRT, DRTM, ECDT, FACS, FPDT, MCHI, MPST,
-          MSCT, RASF, SBST, SLIT, SPMI, SRAT, TCPA, TPM2, UEFI
-
-       -- Not supported: BOOT, DBG2, DBGP, DMAR, ETDT, HPET, IBFT, IVRS,
-          LPIT, MSDM, RSDT, SLIC, WAET, WDAT, WDRT, WPBT
+       -- Optional: BGRT, CPEP, CSRT, DBG2, DRTM, ECDT, FACS, FPDT, IORT,
+          MCHI, MPST, MSCT, NFIT, PMTT, RASF, SBST, SLIT, SPMI, SRAT, STAO,
+	  TCPA, TPM2, UEFI, XENV
 
+       -- Not supported: BOOT, DBGP, DMAR, ETDT, HPET, IBFT, IVRS, LPIT,
+          MSDM, OEMx, PSDT, RSDT, SLIC, WAET, WDAT, WDRT, WPBT
 
 Table  Usage for ARMv8 Linux
 -----  ----------------------------------------------------------------
@@ -50,7 +50,8 @@ CSRT   Signature Reserved (signature == "CSRT")
 
 DBG2   Signature Reserved (signature == "DBG2")
        == DeBuG port table 2 ==
-       Microsoft only table, will not be supported.
+       License has changed and should be usable.  Optional if used instead
+       of earlycon=<device> on the command line.
 
 DBGP   Signature Reserved (signature == "DBGP")
        == DeBuG Port table ==
@@ -133,10 +134,11 @@ GTDT   Section 5.2.24 (signature == "GTDT")
 
 HEST   Section 18.3.2 (signature == "HEST")
        == Hardware Error Source Table ==
-       Until further error source types are defined, use only types 6 (AER
-       Root Port), 7 (AER Endpoint), 8 (AER Bridge), or 9 (Generic Hardware
-       Error Source).  Firmware first error handling is possible if and only
-       if Trusted Firmware is being used on arm64.
+       ARM-specific error sources have been defined; please use those or the
+       PCI types such as type 6 (AER Root Port), 7 (AER Endpoint), or 8 (AER
+       Bridge), or use type 9 (Generic Hardware Error Source).  Firmware first
+       error handling is possible if and only if Trusted Firmware is being
+       used on arm64.
 
        Must be supplied if RAS support is provided by the platform.  It
        is recommended this table be supplied.
@@ -149,20 +151,30 @@ IBFT   Signature Reserved (signature == "IBFT")
        == iSCSI Boot Firmware Table ==
        Microsoft defined table, support TBD.
 
+IORT   Signature Reserved (signature == "IORT")
+       == Input Output Remapping Table ==
+       arm64 only table, required in order to describe IO topology, SMMUs,
+       and GIC ITSs, and how those various components are connected together,
+       such as identifying which components are behind which SMMUs/ITSs.
+       This table will only be required on certain SBSA platforms (e.g.,
+       when using GICv3-ITS and an SMMU); on SBSA Level 0 platforms, it 
+       remains optional.
+
 IVRS   Signature Reserved (signature == "IVRS")
        == I/O Virtualization Reporting Structure ==
        x86_64 (AMD) only table, will not be supported.
 
 LPIT   Signature Reserved (signature == "LPIT")
        == Low Power Idle Table ==
-       x86 only table as of ACPI 5.1; future versions have been adapted for
-       use with ARM and will be recommended in order to support ACPI power
-       management.
+       x86 only table as of ACPI 5.1; starting with ACPI 6.0, processor
+       descriptions and power states on ARM platforms should use the DSDT
+       and define processor container devices (_HID ACPI0010, Section 8.4,
+       and more specifically 8.4.3 and and 8.4.4).
 
 MADT   Section 5.2.12 (signature == "APIC")
        == Multiple APIC Description Table ==
        Required for arm64.  Only the GIC interrupt controller structures
-       should be used (types 0xA - 0xE).
+       should be used (types 0xA - 0xF).
 
 MCFG   Signature Reserved (signature == "MCFG")
        == Memory-mapped ConFiGuration space ==
@@ -176,14 +188,38 @@ MPST   Section 5.2.21 (signature == "MPST")
        == Memory Power State Table ==
        Optional, not currently supported.
 
+MSCT   Section 5.2.19 (signature == "MSCT")
+       == Maximum System Characteristic Table ==
+       Optional, not currently supported.
+
 MSDM   Signature Reserved (signature == "MSDM")
        == Microsoft Data Management table ==
        Microsoft only table, will not be supported.
 
-MSCT   Section 5.2.19 (signature == "MSCT")
-       == Maximum System Characteristic Table ==
+NFIT   Section 5.2.25 (signature == "NFIT")
+       == NVDIMM Firmware Interface Table ==
+       Optional, not currently supported.
+
+OEMx   Signature of "OEMx" only
+       == OEM Specific Tables ==
+       All tables starting with a signature of "OEM" are reserved for OEM
+       use.  Since these are not meant to be of general use but are limited
+       to very specific end users, they are not recommended for use and are
+       not supported by the kernel for arm64.
+
+PCCT   Section 14.1 (signature == "PCCT)
+       == Platform Communications Channel Table ==
+       Recommend for use on arm64; use of PCC is recommended when using CPPC
+       to control performance and power for platform processors.
+
+PMTT   Section 5.2.21.12 (signature == "PMTT")
+       == Platform Memory Topology Table ==
        Optional, not currently supported.
 
+PSDT   Section 5.2.11.3 (signature == "PSDT")
+       == Persistent System Description Table ==
+       Obsolete table, will not be supported.
+
 RASF   Section 5.2.20 (signature == "RASF")
        == RAS Feature table ==
        Optional, not currently supported.
@@ -195,7 +231,7 @@ RSDP   Section 5.2.5 (signature == "RSD PTR")
 RSDT   Section 5.2.7 (signature == "RSDT")
        == Root System Description Table ==
        Since this table can only provide 32-bit addresses, it is deprecated
-       on arm64, and will not be used.
+       on arm64, and will not be used.  If provided, it will be ignored.
 
 SBST   Section 5.2.14 (signature == "SBST")
        == Smart Battery Subsystem Table ==
@@ -220,7 +256,7 @@ SPMI   Signature Reserved (signature == "SPMI")
 SRAT   Section 5.2.16 (signature == "SRAT")
        == System Resource Affinity Table ==
        Optional, but if used, only the GICC Affinity structures are read.
-       To support NUMA, this table is required.
+       To support arm64 NUMA, this table is required.
 
 SSDT   Section 5.2.11.2 (signature == "SSDT")
        == Secondary System Description Table ==
@@ -235,6 +271,11 @@ SSDT   Section 5.2.11.2 (signature == "SSDT")
        These tables are optional, however.  ACPI tables should contain only
        one DSDT but can contain many SSDTs.
 
+STAO   Signature Reserved (signature == "STAO")
+       == _STA Override table ==
+       Optional, but only necessary in virtualized environments in order to
+       hide devices from guest OSs.
+
 TCPA   Signature Reserved (signature == "TCPA")
        == Trusted Computing Platform Alliance table ==
        Optional, not currently supported, and may need changes to fully
@@ -266,6 +307,10 @@ WPBT   Signature Reserved (signature == "WPBT")
        == Windows Platform Binary Table ==
        Microsoft only table, will not be supported.
 
+XENV   Signature Reserved (signature == "XENV")
+       == Xen project table ==
+       Optional, used only by Xen at present.
+
 XSDT   Section 5.2.8 (signature == "XSDT")
        == eXtended System Description Table ==
        Required for arm64.
@@ -273,44 +318,46 @@ XSDT   Section 5.2.8 (signature == "XSDT")
 
 ACPI Objects
 ------------
-The expectations on individual ACPI objects are discussed in the list that
-follows:
+The expectations on individual ACPI objects that are likely to be used are
+shown in the list that follows; any object not explicitly mentioned below
+should be used as needed for a particular platform or particular subsystem,
+such as power management or PCI.
 
 Name   Section         Usage for ARMv8 Linux
 ----   ------------    -------------------------------------------------
-_ADR   6.1.1           Use as needed.
-
-_BBN   6.5.5           Use as needed; PCI-specific.
+_CCA   6.2.17          This method must be defined for all bus masters
+                       on arm64 -- there are no assumptions made about
+                       whether such devices are cache coherent or not.
+                       The _CCA value is inherited by all descendants of
+                       these devices so it does not need to be repeated.
+                       Without _CCA on arm64, the kernel does not know what
+                       to do about setting up DMA for the device.
 
-_BDN   6.5.3           Optional; not likely to be used on arm64.
+                       NB: this method provides default cache coherency
+                       attributes; the presence of an SMMU can be used to
+                       modify that, however.  For example, a master could
+                       default to non-coherent, but be made coherent with
+                       the appropriate SMMU configuration (see Table 17 of
+                       the IORT specification, ARM Document DEN 0049B).
 
-_CCA   6.2.17          This method should be defined for all bus masters
-                       on arm64.  While cache coherency is assumed, making
-                       it explicit ensures the kernel will set up DMA as
-                       it should.
+_CID   6.1.2           Use as needed, see also _HID.
 
-_CDM   6.2.1           Optional, to be used only for processor devices.
+_CLS   6.1.3           Use as needed, see also _HID.
 
-_CID   6.1.2           Use as needed.
-
-_CLS   6.1.3           Use as needed.
+_CPC   8.4.7.1         Use as needed, power management specific.  CPPC is
+                       recommended on arm64.
 
 _CRS   6.2.2           Required on arm64.
 
-_DCK   6.5.2           Optional; not likely to be used on arm64.
+_CSD   8.4.2.2         Use as needed, used only in conjunction with _CST.
+
+_CST   8.4.2.1         Low power idle states (8.4.4) are recommended instead
+                       of C-states.
 
 _DDN   6.1.4           This field can be used for a device name.  However,
                        it is meant for DOS device names (e.g., COM1), so be
                        careful of its use across OSes.
 
-_DEP   6.5.8           Use as needed.
-
-_DIS   6.2.3           Optional, for power management use.
-
-_DLM   5.7.5           Optional.
-
-_DMA   6.2.4           Optional.
-
 _DSD   6.2.5           To be used with caution.  If this object is used, try
                        to use it within the constraints already defined by the
                        Device Properties UUID.  Only in rare circumstances
@@ -325,20 +372,10 @@ _DSD   6.2.5           To be used with caution.  If this object is used, try
                        with the UEFI Forum; this may cause some iteration as
                        more than one OS will be registering entries.
 
-_DSM                   Do not use this method.  It is not standardized, the
+_DSM   9.1.1           Do not use this method.  It is not standardized, the
                        return values are not well documented, and it is
                        currently a frequent source of error.
 
-_DSW   7.2.1           Use as needed; power management specific.
-
-_EDL   6.3.1           Optional.
-
-_EJD   6.3.2           Optional.
-
-_EJx   6.3.3           Optional.
-
-_FIX   6.2.7           x86 specific, not used on arm64.
-
 \_GL   5.7.1           This object is not to be used in hardware reduced
                        mode, and therefore should not be used on arm64.
 
@@ -349,35 +386,22 @@ _GLK   6.5.7           This object requires a global lock be defined; there
 \_GPE  5.3.1           This namespace is for x86 use only.  Do not use it
                        on arm64.
 
-_GSB   6.2.7           Optional.
-
-_HID   6.1.5           Use as needed.  This is the primary object to use in
-                       device probing, though _CID and _CLS may also be used.
-
-_HPP   6.2.8           Optional, PCI specific.
-
-_HPX   6.2.9           Optional, PCI specific.
-
-_HRV   6.1.6           Optional, use as needed to clarify device behavior; in
-                       some cases, this may be easier to use than _DSD.
+_HID   6.1.5           This is the primary object to use in device probing,
+		       though _CID and _CLS may also be used.
 
 _INI   6.5.1           Not required, but can be useful in setting up devices
                        when UEFI leaves them in a state that may not be what
                        the driver expects before it starts probing.
 
-_IRC   7.2.15          Use as needed; power management specific.
-
-_LCK   6.3.4           Optional.
-
-_MAT   6.2.10          Optional; see also the MADT.
+_LPI   8.4.4.3         Recommended for use with processor definitions (_HID
+		       ACPI0010) on arm64.  See also _RDI.
 
-_MLS   6.1.7           Optional, but highly recommended for use in
-                       internationalization.
+_MLS   6.1.7           Highly recommended for use in internationalization.
 
-_OFF   7.1.2           It is recommended to define this method for any device
+_OFF   7.2.2           It is recommended to define this method for any device
                        that can be turned on or off.
 
-_ON    7.1.3           It is recommended to define this method for any device
+_ON    7.2.3           It is recommended to define this method for any device
                        that can be turned on or off.
 
 \_OS   5.7.3           This method will return "Linux" by default (this is
@@ -398,122 +422,107 @@ _OSC   6.2.11          This method can be a global method in ACPI (i.e.,
                        by the kernel community, then register it with the
                        UEFI Forum.
 
-\_OSI  5.7.2           Deprecated on ARM64.  Any invocation of this method
-                       will print a warning on the console and return false.
-                       That is, as far as ACPI firmware is concerned, _OSI
-                       cannot be used to determine what sort of system is
-                       being used or what functionality is provided.  The
-                       _OSC method is to be used instead.
-
-_OST   6.3.5           Optional.
+\_OSI  5.7.2           Deprecated on ARM64.  As far as ACPI firmware is 
+		       concerned, _OSI is not to be used to determine what 
+		       sort of system is being used or what functionality
+		       is provided.  The _OSC method is to be used instead.
 
 _PDC   8.4.1           Deprecated, do not use on arm64.
 
 \_PIC  5.8.1           The method should not be used.  On arm64, the only
                        interrupt model available is GIC.
 
-_PLD   6.1.8           Optional.
-
 \_PR   5.3.1           This namespace is for x86 use only on legacy systems.
                        Do not use it on arm64.
 
-_PRS   6.2.12          Optional.
-
 _PRT   6.2.13          Required as part of the definition of all PCI root
                        devices.
 
-_PRW   7.2.13          Use as needed; power management specific.
-
-_PRx   7.2.8-11        Use as needed; power management specific.  If _PR0 is
+_PRx   7.3.8-11        Use as needed; power management specific.  If _PR0 is
                        defined, _PR3 must also be defined.
 
-_PSC   7.2.6           Use as needed; power management specific.
-
-_PSE   7.2.7           Use as needed; power management specific.
-
-_PSW   7.2.14          Use as needed; power management specific.
-
-_PSx   7.2.2-5         Use as needed; power management specific.  If _PS0 is
+_PSx   7.3.2-5         Use as needed; power management specific.  If _PS0 is
                        defined, _PS3 must also be defined.  If clocks or
                        regulators need adjusting to be consistent with power
                        usage, change them in these methods.
 
-\_PTS  7.3.1           Use as needed; power management specific.
-
-_PXM   6.2.14          Optional.
-
-_REG   6.5.4           Use as needed.
+_RDI   8.4.4.4         Recommended for use with processor definitions (_HID
+		       ACPI0010) on arm64.  This should only be used in 
+		       conjunction with _LPI.
 
 \_REV  5.7.4           Always returns the latest version of ACPI supported.
 
-_RMV   6.3.6           Optional.
-
 \_SB   5.3.1           Required on arm64; all devices must be defined in this
                        namespace.
 
-_SEG   6.5.6           Use as needed; PCI-specific.
-
-\_SI   5.3.1,          Optional.
-       9.1
-
-_SLI   6.2.15          Optional; recommended when SLIT table is in use.
+_SLI   6.2.15          Use is recommended when SLIT table is in use.
 
 _STA   6.3.7,          It is recommended to define this method for any device
-       7.1.4           that can be turned on or off.
+       7.2.4           that can be turned on or off.  See also the STAO table
+                       that provides overrides to hide devices in virtualized
+                       environments.
 
-_SRS   6.2.16          Optional; see also _PRS.
+_SRS   6.2.16          Use as needed; see also _PRS.
 
 _STR   6.1.10          Recommended for conveying device names to end users;
                        this is preferred over using _DDN.
 
 _SUB   6.1.9           Use as needed; _HID or _CID are preferred.
 
-_SUN   6.1.11          Optional.
-
-\_Sx   7.3.2           Use as needed; power management specific.
-
-_SxD   7.2.16-19       Use as needed; power management specific.
-
-_SxW   7.2.20-24       Use as needed; power management specific.
+_SUN   6.1.11          Use as needed, but recommended.
 
-_SWS   7.3.3           Use as needed; power management specific; this may
+_SWS   7.4.3           Use as needed; power management specific; this may
                        require specification changes for use on arm64.
 
-\_TTS  7.3.4           Use as needed; power management specific.
-
-\_TZ   5.3.1           Optional.
-
 _UID   6.1.12          Recommended for distinguishing devices of the same
                        class; define it if at all possible.
 
-\_WAK  7.3.5           Use as needed; power management specific.
+
 
 
 ACPI Event Model
 ----------------
 Do not use GPE block devices; these are not supported in the hardware reduced
 profile used by arm64.  Since there are no GPE blocks defined for use on ARM
-platforms, GPIO-signaled interrupts should be used for creating system events.
+platforms, ACPI events must be signaled differently.
+
+There are two options: GPIO-signaled interrupts (Section 5.6.5), and
+interrupt-signaled events (Section 5.6.9).  Interrupt-signaled events are a
+new feature in the ACPI 6.1 specification.  Either -- or both -- can be used
+on a given platform, and which to use may be dependent of limitations in any
+given SoC.  If possible, interrupt-signaled events are recommended.
 
 
 ACPI Processor Control
 ----------------------
-Section 8 of the ACPI specification is currently undergoing change that
-should be completed in the 6.0 version of the specification.  Processor
-performance control will be handled differently for arm64 at that point
-in time.  Processor aggregator devices (section 8.5) will not be used,
-for example, but another similar mechanism instead.
-
-While UEFI constrains what we can say until the release of 6.0, it is
-recommended that CPPC (8.4.5) be used as the primary model.  This will
-still be useful into the future.  C-states and P-states will still be
-provided, but most of the current design work appears to favor CPPC.
+Section 8 of the ACPI specification changed significantly in version 6.0.
+Processors should now be defined as Device objects with _HID ACPI0007; do
+not use the deprecated Processor statement in ASL.  All multiprocessor systems
+should also define a hierarchy of processors, done with Processor Container
+Devices (see Section 8.4.3.1, _HID ACPI0010); do not use processor aggregator
+devices (Section 8.5) to describe processor topology.  Section 8.4 of the
+specification describes the semantics of these object definitions and how
+they interrelate.
+
+Most importantly, the processor hierarchy defined also defines the low power
+idle states that are available to the platform, along with the rules for
+determining which processors can be turned on or off and the circumstances
+that control that.  Without this information, the processors will run in
+whatever power state they were left in by UEFI.
+
+Note too, that the processor Device objects defined and the entries in the
+MADT for GICs are expected to be in synchronization.  The _UID of the Device
+object must correspond to processor IDs used in the MADT.
+
+It is recommended that CPPC (8.4.5) be used as the primary model for processor
+performance control on arm64.  C-states and P-states may become available at
+some point in the future, but most current design work appears to favor CPPC.
 
 Further, it is essential that the ARMv8 SoC provide a fully functional
 implementation of PSCI; this will be the only mechanism supported by ACPI
-to control CPU power state (including secondary CPU booting).
-
-More details will be provided on the release of the ACPI 6.0 specification.
+to control CPU power state.  Booting of secondary CPUs using the ACPI
+parking protocol is possible, but discouraged, since only PSCI is supported
+for ARM servers.
 
 
 ACPI System Address Map Interfaces
@@ -535,21 +544,25 @@ used to indicate fatal errors that cannot be corrected, and require immediate
 attention.
 
 Since there is no direct equivalent of the x86 SCI or NMI, arm64 handles
-these slightly differently.  The SCI is handled as a normal GPIO-signaled
-interrupt; given that these are corrected (or correctable) errors being
-reported, this is sufficient.  The NMI is emulated as the highest priority
-GPIO-signaled interrupt possible.  This implies some caution must be used
-since there could be interrupts at higher privilege levels or even interrupts
-at the same priority as the emulated NMI.  In Linux, this should not be the
-case but one should be aware it could happen.
+these slightly differently.  The SCI is handled as a high priority interrupt;
+given that these are corrected (or correctable) errors being reported, this
+is sufficient.  The NMI is emulated as the highest priority interrupt
+possible.  This implies some caution must be used since there could be
+interrupts at higher privilege levels or even interrupts at the same priority
+as the emulated NMI.  In Linux, this should not be the case but one should
+be aware it could happen.
 
 
 ACPI Objects Not Supported on ARM64
 -----------------------------------
 While this may change in the future, there are several classes of objects
 that can be defined, but are not currently of general interest to ARM servers.
+Some of these objects have x86 equivalents, and may actually make sense in ARM
+servers.  However, there is either no hardware available at present, or there
+may not even be a non-ARM implementation yet.  Hence, they are not currently
+supported.
 
-These are not supported:
+The following classes of objects are not supported:
 
        -- Section 9.2: ambient light sensor devices
 
@@ -571,16 +584,6 @@ These are not supported:
 
        -- Section 9.18: time and alarm devices (see 9.15)
 
-
-ACPI Objects Not Yet Implemented
---------------------------------
-While these objects have x86 equivalents, and they do make some sense in ARM
-servers, there is either no hardware available at present, or in some cases
-there may not yet be a non-ARM implementation.  Hence, they are currently not
-implemented though that may change in the future.
-
-Not yet implemented are:
-
        -- Section 10: power source and power meter devices
 
        -- Section 11: thermal management
@@ -589,5 +592,31 @@ Not yet implemented are:
 
        -- Section 13: SMBus interfaces
 
-       -- Section 17: NUMA support (prototypes have been submitted for
-          review)
+
+This also means that there is no support for the following objects:
+
+Name   Section                     Name   Section
+----   ------------                ----   ------------
+_ALC   9.3.4                       _FDM   9.10.3
+_ALI   9.3.2                       _FIX   6.2.7
+_ALP   9.3.6                       _GAI   10.4.5
+_ALR   9.3.5                       _GHL   10.4.7
+_ALT   9.3.3                       _GTM   9.9.2.1.1
+_BCT   10.2.2.10                   _LID   9.5.1
+_BDN   6.5.3                       _PAI   10.4.4
+_BIF   10.2.2.1                    _PCL   10.3.2
+_BIX   10.2.2.1                    _PIF   10.3.3
+_BLT   9.2.3                       _PMC   10.4.1
+_BMA   10.2.2.4                    _PMD   10.4.8
+_BMC   10.2.2.12                   _PMM   10.4.3
+_BMD   10.2.2.11                   _PRL   10.3.4
+_BMS   10.2.2.5                    _PSR   10.3.1
+_BST   10.2.2.6                    _PTP   10.4.2
+_BTH   10.2.2.7                    _SBS   10.1.3
+_BTM   10.2.2.9                    _SHL   10.4.6
+_BTP   10.2.2.8                    _STM   9.9.2.1.1
+_DCK   6.5.2                       _UPD   9.16.1
+_EC    12.12                       _UPP   9.16.2
+_FDE   9.10.1                      _WPC   10.5.2
+_FDI   9.10.2                      _WPP   10.5.3
+
diff --git a/Documentation/arm64/arm-acpi.txt b/Documentation/arm64/arm-acpi.txt
index 570a4f8..1a74a04 100644
--- a/Documentation/arm64/arm-acpi.txt
+++ b/Documentation/arm64/arm-acpi.txt
@@ -34,7 +34,7 @@ of the summary text almost directly, to be honest.
 
 The short form of the rationale for ACPI on ARM is:
 
--- ACPI?s bytecode (AML) allows the platform to encode hardware behavior,
+-- ACPI?s byte code (AML) allows the platform to encode hardware behavior,
    while DT explicitly does not support this.  For hardware vendors, being
    able to encode behavior is a key tool used in supporting operating
    system releases on new hardware.
@@ -57,11 +57,11 @@ The short form of the rationale for ACPI on ARM is:
 
 -- The new ACPI governance process works well and Linux is now at the same
    table as hardware vendors and other OS vendors.  In fact, there is no
-   longer any reason to feel that ACPI is only belongs to Windows or that
+   longer any reason to feel that ACPI only belongs to Windows or that
    Linux is in any way secondary to Microsoft in this arena.  The move of
    ACPI governance into the UEFI forum has significantly opened up the
    specification development process, and currently, a large portion of the
-   changes being made to ACPI is being driven by Linux.
+   changes being made to ACPI are being driven by Linux.
 
 Key to the use of ACPI is the support model.  For servers in general, the
 responsibility for hardware behaviour cannot solely be the domain of the
@@ -110,7 +110,7 @@ ACPI support in drivers and subsystems for ARMv8 should never be mutually
 exclusive with DT support at compile time.
 
 At boot time the kernel will only use one description method depending on
-parameters passed from the bootloader (including kernel bootargs).
+parameters passed from the boot loader (including kernel bootargs).
 
 Regardless of whether DT or ACPI is used, the kernel must always be capable
 of booting with either scheme (in kernels with both schemes enabled at compile
@@ -159,7 +159,7 @@ Further, the ACPI core will only use the 64-bit address fields in the FADT
 (Fixed ACPI Description Table).  Any 32-bit address fields in the FADT will
 be ignored on arm64.
 
-Hardware reduced mode (see Section 4.1 of the ACPI 5.1 specification) will
+Hardware reduced mode (see Section 4.1 of the ACPI 6.1 specification) will
 be enforced by the ACPI core on arm64.  Doing so allows the ACPI core to
 run less complex code since it no longer has to provide support for legacy
 hardware from other architectures.  Any fields that are not to be used for
@@ -167,7 +167,7 @@ hardware reduced mode must be set to zero.
 
 For the ACPI core to operate properly, and in turn provide the information
 the kernel needs to configure devices, it expects to find the following
-tables (all section numbers refer to the ACPI 5.1 specfication):
+tables (all section numbers refer to the ACPI 6.1 specification):
 
     -- RSDP (Root System Description Pointer), section 5.2.5
 
@@ -185,9 +185,23 @@ tables (all section numbers refer to the ACPI 5.1 specfication):
     -- If PCI is supported, the MCFG (Memory mapped ConFiGuration
        Table), section 5.2.6, specifically Table 5-31.
 
+    -- If booting without a console=<device> kernel parameter is
+       supported, the SPCR (Serial Port Console Redirection table),
+       section 5.2.6, specifically Table 5-31.
+
+    -- If necessary to describe the I/O topology, SMMUs and GIC ITSs,
+       the IORT (Input Output Remapping Table, section 5.2.6, specifically
+       Table 5-31).
+
+    -- If NUMA is supported, the SRAT (System Resource Affinity Table)
+       and SLIT (System Locality distance Information Table), sections
+       5.2.16 and 5.2.17, respectively.
+
 If the above tables are not all present, the kernel may or may not be
 able to boot properly since it may not be able to configure all of the
-devices available.
+devices available.  This list of tables is not meant to be all inclusive;
+in some environments other tables may be needed (e.g., any of the APEI
+tables from section 18) to support specific functionality.
 
 
 ACPI Detection
@@ -198,7 +212,7 @@ the device structure.  This is detailed further in the "Driver
 Recommendations" section.
 
 In non-driver code, if the presence of ACPI needs to be detected at
-runtime, then check the value of acpi_disabled. If CONFIG_ACPI is not
+run time, then check the value of acpi_disabled. If CONFIG_ACPI is not
 set, acpi_disabled will always be 1.
 
 
@@ -233,7 +247,7 @@ that looks like this: Name(KEY0, "value0").  An ACPI device driver would
 then retrieve the value of the property by evaluating the KEY0 object.
 However, using Name() this way has multiple problems: (1) ACPI limits
 names ("KEY0") to four characters unlike DT; (2) there is no industry
-wide registry that maintains a list of names, minimzing re-use; (3)
+wide registry that maintains a list of names, minimizing re-use; (3)
 there is also no registry for the definition of property values ("value0"),
 again making re-use difficult; and (4) how does one maintain backward
 compatibility as new hardware comes out?  The _DSD method was created
@@ -434,7 +448,8 @@ The ACPI specification changes regularly.  During the year 2014, for instance,
 version 5.1 was released and version 6.0 substantially completed, with most of
 the changes being driven by ARM-specific requirements.  Proposed changes are
 presented and discussed in the ASWG (ACPI Specification Working Group) which
-is a part of the UEFI Forum.
+is a part of the UEFI Forum.  The current version of the ACPI specification
+is 6.1 release in January 2016.
 
 Participation in this group is open to all UEFI members.  Please see
 http://www.uefi.org/workinggroup for details on group membership.
@@ -443,7 +458,7 @@ It is the intent of the ARMv8 ACPI kernel code to follow the ACPI specification
 as closely as possible, and to only implement functionality that complies with
 the released standards from UEFI ASWG.  As a practical matter, there will be
 vendors that provide bad ACPI tables or violate the standards in some way.
-If this is because of errors, quirks and fixups may be necessary, but will
+If this is because of errors, quirks and fix-ups may be necessary, but will
 be avoided if possible.  If there are features missing from ACPI that preclude
 it from being used on a platform, ECRs (Engineering Change Requests) should be
 submitted to ASWG and go through the normal approval process; for those that
@@ -480,8 +495,7 @@ References
     Software on ARM Platforms", dated 16 Aug 2014
 
 [2] http://www.secretlab.ca/archives/151, 10 Jan 2015, Copyright (c) 2015,
-    Linaro Ltd., written by Grant Likely.  A copy of the verbatim text (apart
-    from formatting) is also in Documentation/arm64/why_use_acpi.txt.
+    Linaro Ltd., written by Grant Likely.
 
 [3] AMD ACPI for Seattle platform documentation:
     http://amd-dev.wpengine.netdna-cdn.com/wordpress/media/2012/10/Seattle_ACPI_Guide.pdf
-- 
2.5.5
