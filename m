From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Mon,  2 Feb 2015 20:45:49 +0800
Subject: [PATCH v8 21/21] arm64: ACPI: additions of ACPI documentation for
 arm64
In-Reply-To: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>
References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <1422881149-8177-22-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Al Stone <al.stone@linaro.org>

Two more documentation files are also being added:
(1) A verbatim copy of the "Why ACPI on ARM?" blog posting by Grant Likely,
    which is also summarized in arm-acpi.txt, and

(2) A section by section review of the ACPI spec (acpi_object_usage.txt)
    to note recommendations and prohibitions on the use of the numerous
    ACPI tables and objects.  This sets out the current expectations of
    the firmware by Linux very explicitly (or as explicitly as I can, for
    now).

CC: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
CC: Yi Li <phoenix.liyi@huawei.com>
CC: Mark Langsdorf <mlangsdo@redhat.com>
CC: Ashwin Chaugule <ashwinc@codeaurora.org>
Signed-off-by: Al Stone <al.stone@linaro.org>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 Documentation/arm64/acpi_object_usage.txt | 592 ++++++++++++++++++++++++++++++
 Documentation/arm64/why_use_acpi.txt      | 231 ++++++++++++
 2 files changed, 823 insertions(+)
 create mode 100644 Documentation/arm64/acpi_object_usage.txt
 create mode 100644 Documentation/arm64/why_use_acpi.txt

diff --git a/Documentation/arm64/acpi_object_usage.txt b/Documentation/arm64/acpi_object_usage.txt
new file mode 100644
index 0000000..2c4f733
--- /dev/null
+++ b/Documentation/arm64/acpi_object_usage.txt
@@ -0,0 +1,592 @@
+ACPI Tables
+-----------
+The expectations of individual ACPI tables are discussed in the list that
+follows.
+
+If a section number is used, it refers to a section number in the ACPI
+specification where the object is defined.  If "Signature Reserved" is used,
+the table signature (the first four bytes of the table) is the only portion
+of the table recognized by the specification, and the actual table is defined
+outside of the UEFI Forum (see Section 5.2.6 of the specification).
+
+For ACPI on arm64, tables also fall into the following categories:
+
+	-- Required: DSDT, FADT, GTDT, MADT, MCFG, RSDP, SPCR, XSDT
+
+	-- Recommended: BERT, EINJ, ERST, HEST, SSDT
+
+	-- Optional: BGRT, CPEP, CSRT, DRTM, ECDT, FACS, FPDT, MCHI, MPST,
+	   MSCT, RASF, SBST, SLIT, SPMI, SRAT, TCPA, TPM2, UEFI
+
+	-- Not supported: BOOT, DBG2, DBGP, DMAR, ETDT, HPET, IBFT, IVRS,
+	   LPIT, MSDM, RSDT, SLIC, WAET, WDAT, WDRT, WPBT
+
+
+Table	Usage for ARMv8 Linux
+-----	----------------------------------------------------------------
+BERT	Section 18.3 (signature == "BERT")
+	== Boot Error Record Table ==
+	Must be supplied if RAS support is provided by the platform.  It
+	is recommended this table be supplied.
+
+BOOT	Signature Reserved (signature == "BOOT")
+	== simple BOOT flag table ==
+	Microsoft only table, will not be supported.
+
+BGRT	Section 5.2.22 (signature == "BGRT")
+	== Boot Graphics Resource Table ==
+	Optional, not currently supported, with no real use-case for an
+	ARM server.
+
+CPEP	Section 5.2.18 (signature == "CPEP")
+	== Corrected Platform Error Polling table ==
+	Optional, not currently supported, and not recommended until such
+	time as ARM-compatible hardware is available, and the specification
+	suitably modified.
+
+CSRT	Signature Reserved (signature == "CSRT")
+	== Core System Resources Table ==
+	Optional, not currently supported.
+
+DBG2	Signature Reserved (signature == "DBG2")
+	== DeBuG port table 2 ==
+	Microsoft only table, will not be supported.
+
+DBGP	Signature Reserved (signature == "DBGP")
+	== DeBuG Port table ==
+	Microsoft only table, will not be supported.
+
+DSDT	Section 5.2.11.1 (signature == "DSDT")
+	== Differentiated System Description Table ==
+	A DSDT is required; see also SSDT.
+
+	ACPI tables contain only one DSDT but can contain one or more SSDTs,
+	which are optional.  Each SSDT can only add to the ACPI namespace,
+	but cannot modify or replace anything in the DSDT.
+
+DMAR	Signature Reserved (signature == "DMAR")
+	== DMA Remapping table ==
+	x86 only table, will not be supported.
+
+DRTM	Signature Reserved (signature == "DRTM")
+	== Dynamic Root of Trust for Measurement table ==
+	Optional, not currently supported.
+
+ECDT	Section 5.2.16 (signature == "ECDT")
+	== Embedded Controller Description Table ==
+	Optional, not currently supported, but could be used on ARM if and
+	only if one uses the GPE_BIT field to represent an IRQ number, since
+	there are no GPE blocks defined in hardware reduced mode.  This would
+	need to be modified in the ACPI specification.
+
+EINJ	Section 18.6 (signature == "EINJ")
+	== Error Injection table ==
+	This table is very useful for testing platform response to error
+	conditions; it allows one to inject an error into the system as
+	if it had actually occurred.  However, this table should not be
+	shipped with a production system; it should be dynamically loaded
+	and executed with the ACPICA tools only during testing.
+
+ERST	Section 18.5 (signature == "ERST")
+	== Error Record Serialization Table ==
+	Must be supplied if RAS support is provided by the platform.  It
+	is recommended this table be supplied.
+
+ETDT	Signature Reserved (signature == "ETDT")
+	== Event Timer Description Table ==
+	Obsolete table, will not be supported.
+
+FACS	Section 5.2.10 (signature == "FACS")
+	== Firmware ACPI Control Structure ==
+	It is unlikely that this table will be terribly useful.  If it is
+	provided, the Global Lock will NOT be used since it is not part of
+	the hardware reduced profile, and only 64-bit address fields will
+	be considered valid.
+
+FADT	Section 5.2.9 (signature == "FACP")
+	== Fixed ACPI Description Table ==
+	Required for arm64.
+
+	The HW_REDUCED_ACPI flag must be set.  All of the fields that are
+	to be ignored when HW_REDUCED_ACPI is set are expected to be set to
+	zero.
+
+	If an FACS table is provided, the X_FIRMWARE_CTRL field is to be
+	used, not FIRMWARE_CTRL.
+
+	If PSCI is used (as is recommended), make sure that ARM_BOOT_ARCH is
+	filled in properly -- that the PSCI_COMPLIANT flag is set and that
+	PSCI_USE_HVC is set or unset as needed (see table 5-37).
+
+	For the DSDT that is also required, the X_DSDT field is to be used,
+	not the DSDT field.
+
+FPDT	Section 5.2.23 (signature == "FPDT")
+	== Firmware Performance Data Table ==
+	Optional, not currently supported.
+
+GTDT	Section 5.2.24 (signature == "GTDT")
+	== Generic Timer Description Table ==
+	Required for arm64.
+
+HEST	Section 18.3.2 (signature == "HEST")
+	== Hardware Error Source Table ==
+	Until further error source types are defined, use only types 6 (AER
+	Root Port), 7 (AER Endpoint), 8 (AER Bridge), or 9 (Generic Hardware
+	Error Source).  Firmware first error handling is possible if and only
+	if Trusted Firmware is being used on arm64.
+
+	Must be supplied if RAS support is provided by the platform.  It
+	is recommended this table be supplied.
+
+HPET	Signature Reserved (signature == "HPET")
+	== High Precision Event timer Table ==
+	x86 only table, will not be supported.
+
+IBFT	Signature Reserved (signature == "IBFT")
+	== iSCSI Boot Firmware Table ==
+	Microsoft defined table, support TBD.
+
+IVRS	Signature Reserved (signature == "IVRS")
+	== I/O Virtualization Reporting Structure ==
+	x86_64 (AMD) only table, will not be supported.
+
+LPIT	Signature Reserved (signature == "LPIT")
+	== Low Power Idle Table ==
+	x86 only table as of ACPI 5.1; future versions have been adapted for
+	use with ARM and will be recommended in order to support ACPI power
+	management.
+
+MADT	Section 5.2.12 (signature == "APIC")
+	== Multiple APIC Description Table ==
+	Required for arm64.  Only the GIC interrupt controller structures 
+	should be used (types 0xA - 0xE).
+
+MCFG	Signature Reserved (signature == "MCFG")
+	== Memory-mapped ConFiGuration space ==
+	If the platform supports PCI/PCIe, an MCFG table is required.
+
+MCHI	Signature Reserved (signature == "MCHI")
+	== Management Controller Host Interface table ==
+	Optional, not currently supported.
+
+MPST	Section 5.2.21 (signature == "MPST")
+	== Memory Power State Table ==
+	Optional, not currently supported.
+
+MSDM	Signature Reserved (signature == "MSDM")
+	== Microsoft Data Management table ==
+	Microsoft only table, will not be supported.
+
+MSCT	Section 5.2.19 (signature == "MSCT")
+	== Maximum System Characteristic Table ==
+	Optional, not currently supported.
+
+RASF	Section 5.2.20 (signature == "RASF")
+	== RAS Feature table ==
+	Optional, not currently supported.
+
+RSDP	Section 5.2.5 (signature == "RSD PTR")
+	== Root System Description PoinTeR ==
+	Required for arm64.
+
+RSDT	Section 5.2.7 (signature == "RSDT")
+	== Root System Description Table ==
+	Since this table can only provide 32-bit addresses, it is deprecated
+	on arm64, and will not be used.
+
+SBST	Section 5.2.14 (signature == "SBST")
+	== Smart Battery Subsystem Table ==
+	Optional, not currently supported.
+
+SLIC	Signature Reserved (signature == "SLIC")
+	== Software LIcensing table ==
+	Microsoft only table, will not be supported.
+
+SLIT	Section 5.2.17 (signature == "SLIT")
+	== System Locality distance Information Table ==
+	Optional in general, but required for NUMA systems.
+
+SPCR	Signature Reserved (signature == "SPCR")
+	== Serial Port Console Redirection table ==
+	Required for arm64.
+
+SPMI	Signature Reserved (signature == "SPMI")
+	== Server Platform Management Interface table ==
+	Optional, not currently supported.
+
+SRAT	Section 5.2.16 (signature == "SRAT")
+	== System Resource Affinity Table ==
+	Optional, but if used, only the GICC Affinity structures are read.
+	To support NUMA, this table is required.
+
+SSDT	Section 5.2.11.2 (signature == "SSDT")
+	== Secondary System Description Table ==
+	These tables are a continuation of the DSDT; these are recommended
+	for use with devices that can be added to a running system, but can
+	also serve the purpose of dividing up device descriptions into more
+	manageable pieces.
+
+	An SSDT can only ADD to the ACPI namespace.  It cannot modify or
+	replace existing device descriptions already in the namespace.
+
+	These tables are optional, however.  ACPI tables should contain only
+	one DSDT but can contain many SSDTs.
+
+TCPA	Signature Reserved (signature == "TCPA")
+	== Trusted Computing Platform Alliance table ==
+	Optional, not currently supported, and may need changes to fully
+	interoperate with arm64.
+
+TPM2	Signature Reserved (signature == "TPM2")
+	== Trusted Platform Module 2 table ==
+	Optional, not currently supported, and may need changes to fully
+	interoperate with arm64.
+
+UEFI	Signature Reserved (signature == "UEFI")
+	== UEFI ACPI data table ==
+	Optional, not currently supported.  No known use case for arm64,
+	at present.
+
+WAET	Signature Reserved (signature == "WAET")
+	== Windows ACPI Emulated devices Table ==
+	Microsoft only table, will not be supported.
+
+WDAT	Signature Reserved (signature == "WDAT")
+	== Watch Dog Action Table ==
+	Microsoft only table, will not be supported.
+
+WDRT	Signature Reserved (signature == "WDRT")
+	== Watch Dog Resource Table ==
+	Microsoft only table, will not be supported.
+
+WPBT	Signature Reserved (signature == "WPBT")
+	== Windows Platform Binary Table ==
+	Microsoft only table, will not be supported.
+
+XSDT	Section 5.2.8 (signature == "XSDT")
+	== eXtended System Description Table ==
+	Required for arm64.
+
+
+ACPI Objects
+------------
+The expectations on individual ACPI objects are discussed in the list that
+follows:
+
+Name	Section		Usage for ARMv8 Linux
+----	------------	-------------------------------------------------
+_ADR	6.1.1		Use as needed.
+
+_BBN	6.5.5		Use as needed; PCI-specific.
+
+_BDN	6.5.3		Optional; not likely to be used on arm64.
+
+_CCA	6.2.17		This method should be defined for all bus masters
+			on arm64.  While cache coherency is assumed, making
+			it explicit ensures the kernel will set up DMA as
+			it should.
+
+_CDM	6.2.1		Optional, to be used only for processor devices.
+
+_CID	6.1.2		Use as needed.
+
+_CLS	6.1.3		Use as needed.
+
+_CRS	6.2.2		Required on arm64.
+
+_DCK	6.5.2		Optional; not likely to be used on arm64.
+
+_DDN	6.1.4		This field can be used for a device name.  However,
+			it is meant for DOS device names (e.g., COM1), so be
+			careful of its use across OSes.
+
+_DEP	6.5.8		Use as needed.
+
+_DIS	6.2.3		Optional, for power management use.
+
+_DLM	5.7.5		Optional.
+
+_DMA	6.2.4		Optional.
+
+_DSD	6.2.5		To be used with caution.  If this object is used, try
+			to use it within the constraints already defined by the
+			Device Properties UUID.  Only in rare circumstances
+			should it be necessary to create a new _DSD UUID.
+
+			In either case, submit the _DSD definition along with
+			any driver patches for discussion, especially when
+			device properties are used.  A driver will not be 
+			considered complete without a corresponding _DSD
+			description.  Once approved by kernel maintainers,
+			the UUID or device properties must then be registered
+			with the UEFI Forum; this may cause some iteration as
+			more than one OS will be registering entries.
+
+_DSM			Do not use this method.  It is not standardized, the
+			return values are not well documented, and it is
+			currently a frequent source of error.
+
+_DSW	7.2.1		Use as needed; power management specific.
+
+_EDL	6.3.1		Optional.
+
+_EJD	6.3.2		Optional.
+
+_EJx	6.3.3		Optional.
+
+_FIX	6.2.7		x86 specific, not used on arm64.
+
+\_GL	5.7.1		This object is not to be used in hardware reduced
+			mode, and therefore should not be used on arm64.
+
+_GLK	6.5.7		This object requires a global lock be defined; there
+			is no global lock on arm64 since it runs in hardware
+			reduced mode.  Hence, do not use this object on arm64.
+
+\_GPE	5.3.1		This namespace is for x86 use only.  Do not use it
+			on arm64.
+
+_GSB	6.2.7		Optional.
+
+_HID	6.1.5		Use as needed.  This is the primary object to use in
+			device probing, though _CID and _CLS may also be used.
+
+_HPP	6.2.8		Optional, PCI specific.
+
+_HPX	6.2.9		Optional, PCI specific.
+
+_HRV	6.1.6		Optional, use as needed to clarify device behavior; in
+			some cases, this may be easier to use than _DSD.
+
+_INI	6.5.1		Not required, but can be useful in setting up devices
+			when UEFI leaves them in a state that may not be what
+			the driver expects before it starts probing.
+
+_IRC	7.2.15		Use as needed; power management specific.
+
+_LCK	6.3.4		Optional.
+
+_MAT	6.2.10		Optional; see also the MADT.
+
+_MLS	6.1.7		Optional, but highly recommended for use in 
+			internationalization.
+
+_OFF	7.1.2		It is recommended to define this method for any device
+			that can be turned on or off.
+
+_ON	7.1.3		It is recommended to define this method for any device
+			that can be turned on or off.
+
+\_OS	5.7.3		This method will return "Linux" by default (this is
+			the value of the macro ACPI_OS_NAME on Linux).  The
+			command line parameter acpi_os=<string> can be used
+			to set it to some other value.
+
+_OSC	6.2.11		This method can be a global method in ACPI (i.e.,
+			\_SB._OSC), or it may be associated with a specific
+			device (e.g., \_SB.DEV0._OSC), or both.  When used
+			as a global method, only capabilities published in
+			the ACPI specification are allowed.  When used as
+			a device-specifc method, the process described for
+			using _DSD MUST be used to create an _OSC definition;
+			out-of-process use of _OSC is not allowed.  That is,
+			submit the device-specific _OSC usage description as
+			part of the kernel driver submission, get it approved
+			by the kernel community, then register it with the
+			UEFI Forum.
+
+\_OSI	5.7.2		Deprecated on ARM64.  Any invocation of this method
+			will print a warning on the console and return false.
+			That is, as far as ACPI firmware is concerned, _OSI
+			cannot be used to determine what sort of system is
+			being used or what functionality is provided.  The
+			_OSC method is to be used instead.
+
+_OST	6.3.5		Optional.
+
+_PDC	8.4.1		Deprecated, do not use on arm64.
+
+\_PIC	5.8.1		The method should not be used.  On arm64, the only
+			interrupt model available is GIC.
+
+_PLD	6.1.8		Optional.
+
+\_PR	5.3.1		This namespace is for x86 use only on legacy systems.
+			Do not use it on arm64.
+
+_PRS	6.2.12		Optional.
+
+_PRT	6.2.13		Required as part of the definition of all PCI root
+			devices.
+
+_PRW	7.2.13		Use as needed; power management specific.
+
+_PRx	7.2.8-11	Use as needed; power management specific.  If _PR0 is
+			defined, _PR3 must also be defined. 
+
+_PSC	7.2.6		Use as needed; power management specific.
+
+_PSE	7.2.7		Use as needed; power management specific.
+
+_PSW	7.2.14		Use as needed; power management specific.
+
+_PSx	7.2.2-5		Use as needed; power management specific.  If _PS0 is
+			defined, _PS3 must also be defined.  If clocks or
+			regulators need adjusting to be consistent with power
+			usage, change them in these methods.
+
+\_PTS	7.3.1		Use as needed; power management specific.
+
+_PXM	6.2.14		Optional.
+
+_REG	6.5.4		Use as needed.
+
+\_REV	5.7.4		Always returns the latest version of ACPI supported.
+
+_RMV	6.3.6		Optional.
+
+\_SB	5.3.1		Required on arm64; all devices must be defined in this
+			namespace.
+
+_SEG	6.5.6		Use as needed; PCI-specific.
+
+\_SI	5.3.1,		Optional.
+	9.1
+
+_SLI	6.2.15		Optional; recommended when SLIT table is in use.
+
+_STA	6.3.7,		It is recommended to define this method for any device
+	7.1.4		that can be turned on or off.
+
+_SRS	6.2.16		Optional; see also _PRS.
+
+_STR	6.1.10		Recommended for conveying device names to end users;
+			this is preferred over using _DDN.
+
+_SUB	6.1.9		Use as needed; _HID or _CID are preferred.
+
+_SUN	6.1.11		Optional.
+
+\_Sx	7.3.2		Use as needed; power management specific.
+
+_SxD	7.2.16-19	Use as needed; power management specific.
+
+_SxW	7.2.20-24	Use as needed; power management specific.
+
+_SWS	7.3.3		Use as needed; power management specific; this may
+			require specification changes for use on arm64.
+
+\_TTS	7.3.4		Use as needed; power management specific.
+
+\_TZ	5.3.1		Optional.
+
+_UID	6.1.12		Recommended for distinguishing devices of the same
+			class; define it if at all possible.
+
+\_WAK	7.3.5		Use as needed; power management specific.
+
+
+ACPI Event Model
+----------------
+Do not use GPE block devices; these are not supported in the hardware reduced
+profile used by arm64.  Since there are no GPE blocks defined for use on ARM
+platforms, GPIO-signaled interrupts should be used for creating system events.
+
+
+ACPI Processor Control
+----------------------
+Section 8 of the ACPI specification is currently undergoing change that
+should be completed in the 6.0 version of the specification.  Processor
+performance control will be handled differently for arm64 at that point
+in time.  Processor aggregator devices (section 8.5) will not be used,
+for example, but another similar mechanism instead.
+
+While UEFI constrains what we can say until the release of 6.0, it is
+recommended that CPPC (8.4.5) be used as the primary model.  This will
+still be useful into the future.  C-states and P-states will still be
+provided, but most of the current design work appears to favor CPPC.
+
+Further, it is essential that the ARMv8 SoC provide a fully functional
+implementation of PSCI; this will be the only mechanism supported by ACPI
+to control CPU power state (including secondary CPU booting).
+
+More details will be provided on the release of the ACPI 6.0 specification.
+
+
+ACPI System Address Map Interfaces
+----------------------------------
+In Section 15 of the ACPI specification, several methods are mentioned as
+possible mechanisms for conveying memory resource information to the kernel.
+For arm64, we will only support UEFI for booting with ACPI, hence the UEFI
+GetMemoryMap() boot service is the only mechanism that will be used.
+
+
+ACPI Platform Error Interfaces (APEI)
+-------------------------------------
+The APEI tables supported are described above.
+
+APEI requires the equivalent of an SCI and an NMI on ARMv8.  The SCI is used
+to notify the OSPM of errors that have occurred but can be corrected and the
+system can continue correct operation, even if possibly degraded.  The NMI is
+used to indicate fatal errors that cannot be corrected, and require immediate
+attention.
+
+Since there is no direct equivalent of the x86 SCI or NMI, arm64 handles
+these slightly differently.  The SCI is handled as a normal GPIO-signaled
+interrupt; given that these are corrected (or correctable) errors being
+reported, this is sufficient.  The NMI is emulated as the highest priority
+GPIO-signaled interrupt possible.  This implies some caution must be used
+since there could be interrupts at higher privilege levels or even interrupts
+at the same priority as the emulated NMI.  In Linux, this should not be the
+case but one should be aware it could happen.
+
+
+ACPI Objects Not Supported on ARM64
+-----------------------------------
+While this may change in the future, there are several classes of objects
+that can be defined, but are not currently of general interest to ARM servers.
+
+These are not supported:
+
+	-- Section 9.2: ambient light sensor devices
+
+	-- Section 9.3: battery devices
+
+	-- Section 9.4: lids (e.g., laptop lids)
+
+	-- Section 9.8.2: IDE controllers
+
+	-- Section 9.9: floppy controllers
+
+	-- Section 9.10: GPE block devices
+
+	-- Section 9.15: PC/AT RTC/CMOS devices
+
+	-- Section 9.16: user presence detection devices
+
+	-- Section 9.17: I/O APIC devices; all GICs must be enumerable via MADT
+
+	-- Section 9.18: time and alarm devices (see 9.15)
+
+
+ACPI Objects Not Yet Implemented
+--------------------------------
+While these objects have x86 equivalents, and they do make some sense in ARM
+servers, there is either no hardware available at present, or in some cases
+there may not yet be a non-ARM implementation.  Hence, they are currently not
+implemented though that may change in the future.
+
+Not yet implemented are:
+
+	-- Section 10: power source and power meter devices
+
+	-- Section 11: thermal management
+
+	-- Section 12: embedded controllers interface
+
+	-- Section 13: SMBus interfaces
+
+	-- Section 17: NUMA support (prototypes have been submitted for
+	   review)
+
diff --git a/Documentation/arm64/why_use_acpi.txt b/Documentation/arm64/why_use_acpi.txt
new file mode 100644
index 0000000..9bb583e
--- /dev/null
+++ b/Documentation/arm64/why_use_acpi.txt
@@ -0,0 +1,231 @@
+Why ACPI on ARM?
+----------------
+Copyright (c) 2015, Linaro, Ltd.
+Author: Grant Likely <grant.likely@linaro.org>
+
+Why are we doing ACPI on ARM? That question has been asked many times, but
+we haven???t yet had a good summary of the most important reasons for wanting
+ACPI on ARM. This article is an attempt to state the rationale clearly.
+
+During an email conversation late last year, Catalin Marinas asked for
+a summary of exactly why we want ACPI on ARM, Dong Wei replied with the 
+following list:
+> 1. Support multiple OSes, including Linux and Windows
+> 2. Support device configurations
+> 3. Support dynamic device configurations (hot add/removal)
+> 4. Support hardware abstraction through control methods
+> 5. Support power management
+> 6. Support thermal management
+> 7. Support RAS interfaces
+
+The above list is certainly true in that all of them need to be supported.
+However, that list doesn???t give the rationale for choosing ACPI. We already
+have DT mechanisms for doing most of the above, and can certainly create
+new bindings for anything that is missing. So, if it isn???t an issue of
+functionality, then how does ACPI differ from DT and why is ACPI a better
+fit for general purpose ARM servers?
+
+The difference is in the support model. To explain what I mean, I???m first
+going to expand on each of the items above and discuss the similarities and
+differences between ACPI and DT. Then, with that as the groundwork, I???ll
+discuss how ACPI is a better fit for the general purpose hardware support
+model.
+
+
+Device Configurations
+---------------------
+2. Support device configurations
+3. Support dynamic device configurations (hot add/removal)
+
+From day one, DT was about device configurations. There isn???t any significant
+difference between ACPI & DT here. In fact, the majority of ACPI tables are
+completely analogous to DT descriptions. With the exception of the DSDT and
+SSDT tables, most ACPI tables are merely flat data used to describe hardware.
+
+DT platforms have also supported dynamic configuration and hotplug for years.
+There isn???t a lot here that differentiates between ACPI and DT. The biggest
+difference is that dynamic changes to the ACPI namespace can be triggered by
+ACPI methods, whereas for DT changes are received as messages from firmware
+and have been very much platform specific (e.g. IBM pSeries does this)
+
+
+Power Management
+----------------
+4. Support hardware abstraction through control methods
+5. Support power management
+6. Support thermal management
+
+Power, thermal, and clock management can all be dealt with as a group. ACPI
+defines a power management model (OSPM) that both the platform and the OS
+conform to. The OS implements the OSPM state machine, but the platform can
+provide state change behaviour in the form of bytecode methods. Methods can
+access hardware directly or hand off PM operations to a coprocessor. The OS
+really doesn???t have to care about the details as long as the platform obeys
+the rules of the OSPM model.
+
+With DT, the kernel has device drivers for each and every component in the
+platform, and configures them using DT data. DT itself doesn???t have a PM model.
+Rather the PM model is an implementation detail of the kernel. Device drivers
+use DT data to decide how to handle PM state changes. We have clock, pinctrl,
+and regulator frameworks in the kernel for working out runtime PM. However,
+this only works when all the drivers and support code have been merged into
+the kernel. When the kernel???s PM model doesn???t work for new hardware, then we
+change the model. This works very well for mobile/embedded because the vendor
+controls the kernel. We can change things when we need to, but we also struggle
+with getting board support mainlined.
+
+This difference has a big impact when it comes to OS support. Engineers from
+hardware vendors, Microsoft, and most vocally Red Hat have all told me bluntly
+that rebuilding the kernel doesn???t work for enterprise OS support. Their model
+is based around a fixed OS release that ideally boots out-of-the-box. It may
+still need additional device drivers for specific peripherals/features, but
+from a system view, the OS works. When additional drivers are provided 
+separately, those drivers fit within the existing OSPM model for power 
+management. This is where ACPI has a technical advantage over DT. The ACPI
+OSPM model and it???s bytecode gives the HW vendors a level of abstraction 
+under their control, not the kernel???s. When the hardware behaves differently
+from what the OS expects, the vendor is able to change the behaviour without
+changing the HW or patching the OS.
+
+At this point you???d be right to point out that it is harder to get the whole
+system working correctly when behaviour is split between the kernel and the
+platform. The OS must trust that the platform doesn???t violate the OSPM model.
+All manner of bad things happen if it does. That is exactly why the DT model
+doesn???t encode behaviour: It is easier to make changes and fix bugs when
+everything is within the same code base. We don???t need a platform/kernel 
+split when we can modify the kernel.
+
+However, the enterprise folks don???t have that luxury. The platform/kernel
+split isn???t a design choice. It is a characteristic of the market. Hardware
+and OS vendors each have their own product timetables, and they don???t line
+up. The timeline for getting patches into the kernel and flowing through into
+OS releases puts OS support far downstream from the actual release of hardware.
+Hardware vendors simply cannot wait for OS support to come online to be able to
+release their products. They need to be able to work with available releases,
+and make their hardware behave in the way the OS expects. The advantage of ACPI
+OSPM is that it defines behaviour and limits what the hardware is allowed to do
+without involving the kernel.
+
+What remains is sorting out how we make sure everything works. How do we make
+sure there is enough cross platform testing to ensure new hardware doesn???t 
+ship broken and that new OS releases don???t break on old hardware? Those are
+the reasons why a UEFI/ACPI firmware summit is being organized, it???s why the
+UEFI forum holds plugfests 3 times a year, and it is why we???re working on 
+FWTS and LuvOS.
+
+
+Reliability, Availability & Serviceability (RAS)
+------------------------------------------------
+7. Support RAS interfaces
+
+This isn???t a question of whether or not DT can support RAS. Of course it can.
+Rather it is a matter of RAS bindings already existing for ACPI, including a
+usage model. We???ve barely begun to explore this on DT. This item doesn???t make
+ACPI technically superior to DT, but it certainly makes it more mature.
+
+
+Multiplatform Support
+---------------------
+1. Support multiple OSes, including Linux and Windows
+
+I???m tackling this item last because I think it is the most contentious for
+those of us in the Linux world. I wanted to get the other issues out of the
+way before addressing it.
+
+The separation between hardware vendors and OS vendors in the server market
+is new for ARM. For the first time ARM hardware and OS release cycles are
+completely decoupled from each other, and neither are expected to have specific
+knowledge of the other (ie. the hardware vendor doesn???t control the choice of
+OS). ARM and their partners want to create an ecosystem of independent OSes
+and hardware platforms that don???t explicitly require the former to be ported
+to the latter.
+
+Now, one could argue that Linux is driving the potential market for ARM
+servers, and therefore Linux is the only thing that matters, but hardware
+vendors don???t see it that way. For hardware vendors it is in their best
+interest to support as wide a choice of OSes as possible in order to catch
+the widest potential customer base. Even if the majority choose Linux, some
+will choose BSD, some will choose Windows, and some will choose something
+else. Whether or not we think this is foolish is beside the point; it isn???t
+something we have influence over.
+
+During early ARM server planning meetings between ARM, its partners and other
+industry representatives (myself included) we discussed this exact point.
+Before us were two options, DT and ACPI. As one of the Linux people in the
+room, I advised that ACPI???s closed governance model was a show stopper for
+Linux and that DT is the working interface. Microsoft on the other hand made
+it abundantly clear that ACPI was the only interface that they would support.
+For their part, the hardware vendors stated the platform abstraction behaviour
+of ACPI is a hard requirement for their support model and that they would not
+close the door on either Linux or Windows.
+
+However, the one thing that all of us could agree on was that supporting
+multiple interfaces doesn???t help anyone: It would require twice as much 
+effort on defining bindings (once for Linux-DT and once for Windows-ACPI)
+and it would require firmware to describe everything twice. Eventually we
+reached the compromise to use ACPI, but on the condition of opening the
+governance process to give Linux engineers equal influence over the
+specification. The fact that we now have a much better seat at the ACPI
+table, for both ARM and x86, is a direct result of these early ARM server
+negotiations. We are no longer second class citizens in the ACPI world and
+are actually driving much of the recent development.
+
+I know that this line of thought is more about market forces rather than a
+hard technical argument between ACPI and DT, but it is an equally significant
+one. Agreeing on a single way of doing things is important. The ARM server
+ecosystem is better for the agreement to use the same interface for all
+operating systems. This is what is meant by standards compliant. The standard
+is a codification of the mutually agreed interface. It provides confidence
+that all vendors are using the same rules for interoperability.
+
+
+Summary
+-------
+To summarize, here is the short form rationale for ACPI on ARM:
+
+-- ACPI???s bytecode allows the platform to encode behaviour. DT explicitly
+   does not support this. For hardware vendors, being able to encode behaviour
+   is an important tool for supporting operating system releases on new
+   hardware.
+
+-- ACPI???s OSPM defines a power management model that constrains what the 
+   platform is allowed into a specific model while still having flexibility
+   in hardware design.
+
+-- For enterprise use-cases, ACPI has extablished bindings, such as for RAS,
+   which are used in production. DT does not. Yes, we can define those bindings
+   but doing so means ARM and x86 will use completely different code paths in
+   both firmware and the kernel.
+
+-- Choosing a single interface for platform/OS abstraction is important. It
+   is not reasonable to require vendors to implement both DT and ACPI if they
+   want to support multiple operating systems. Agreeing on a single interface
+   instead of being fragmented into per-OS interfaces makes for better
+   interoperability overall.
+
+-- The ACPI governance process works well and we???re at the same table as HW
+   vendors and other OS vendors. In fact, there is no longer any reason to
+   feel that ACPI is a Windows thing or that we are playing second fiddle to
+   Microsoft. The move of ACPI governance into the UEFI forum has significantly
+   opened up the processes, and currently, a large portion of the changes being
+   made to ACPI is being driven by Linux.
+
+At the beginning of this article I made the statement that the difference
+is in the support model. For servers, responsibility for hardware behaviour
+cannot be purely the domain of the kernel, but rather is split between the
+platform and the kernel. ACPI frees the OS from needing to understand all
+the minute details of the hardware so that the OS doesn???t need to be ported
+to each and every device individually. It allows the hardware vendors to take
+responsibility for PM behaviour without depending on an OS release cycle which
+it is not under their control.
+
+ACPI is also important because hardware and OS vendors have already worked
+out how to use it to support the general purpose ecosystem. The infrastructure
+is in place, the bindings are in place, and the process is in place. DT does
+exactly what we need it to when working with vertically integrated devices,
+but we don???t have good processes for supporting what the server vendors need.
+We could potentially get there with DT, but doing so doesn???t buy us anything.
+ACPI already does what the hardware vendors need, Microsoft won???t collaborate
+with us on DT, and the hardware vendors would still need to provide two
+completely separate firmware interface; one for Linux and one for Windows.
+
-- 
1.9.1
