From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Mon, 11 Nov 2013 18:43:21 +0100
Subject: arm/arm64 UEFI boot protocol
Message-ID: <20131111174321.GQ1557@rocoto.smurfnet.nu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

We currently have a few sets of patches floating around, for UEFI
runtime services, UEFI stub and GRUB support for Linux/UEFI on
arm/arm64.

The last version of Documentation/arm/uefi.txt I sent out raised a few
questions with regards to the boot protocol between UEFI and Linux, and
there is also upcoming support for ACPI which could use a few
clarifications in this area.

So, rather than sending out complete sets of patches for all these until
consensus is reached, below is my proposed suggestion for a
Documentation/arm/uefi.txt, to be shared for arm and arm64. If noone has
strong objections to this, we can quickly send updated (and hopefully
final-ish) versions of these sets.

/
    Leif

---

UEFI, the Unified Extensible Firmware Interface is a specification
governing the behaviours of compatible firmware interfaces.
It is maintained by the UEFI Forum - http://www.uefi.org/.
Support for the AArch32 (arm) architecture was added in version 2.3 of
the specification, and support for AAaarch64 (arm64) was added in
version 2.4.

UEFI is an evolution of its predecessor 'EFI', so the terms EFI and
EFI are used somewhat interchangeably in this document and associated
source code. As a rule, anything new uses 'UEFI', whereas 'EFI' refers
to legacy code or specifications.  

UEFI support in Linux                                                           
=====================                                                           
Booting on a platform with firmware compliant with the UEFI
specification makes it possible for the kernel to support additional
features:
- UEFI Runtime Services
- Retrieving various configuration information through the standardised
  interface of UEFI configuration tables. (ACPI, SMBIOS, ...)

For actually enabling [U]EFI support, enable:
- CONFIG_EFI=y
- CONFIG_EFI_VARS=y or m

UEFI stub
=========
The "stub" is a feature that turns the Image/zImage/bzImage into a valid
UEFI PE/COFF executable, including a loader application that makes it
possible to load the kernel directly from the UEFI shell, boot menu, or
one of the lightweight bootloaders like Gummiboot or rEFInd. 
The kernel image built with stub support remains a valid kernel image
for booting in the legacy fashion.

UEFI kernel support on ARM
==========================
The implementation depends on receiving information about the UEFI
environment in a Flattened Device Tree (FDT) - so is only available with
CONFIG_OF.

UEFI support also depends on early_memremap().

UEFI kernel support on the ARM architectures (arm and arm64) is only
available when boot is performed through the stub.

When booting in UEFI mode, the kernel ignores any memory nodes in the
DT, and instead reads the UEFI memory map. To prevent confusion, the
stub deletes any memory nodes from a provided DT.

The stub populates the FDT /chosen node with, and the kernel scans for
the following parameters:
________________________________________________________________________________
Name                      | Size   | Description
================================================================================
linux,uefi-system-table   | 64-bit | Physical address of the UEFI System Table.
--------------------------------------------------------------------------------
linux,uefi-mmap           | 64-bit | Physical address of the UEFI memory map,
                          |        | populated by the UEFI GetMemoryMap() call.
--------------------------------------------------------------------------------
linux,uefi-mmap-size      | 32-bit | Size in bytes of the UEFI memory map
                          |        | pointed to in previous entry.
--------------------------------------------------------------------------------
linux,uefi-mmap-desc-size | 32-bit | Size in bytes of each entry in the UEFI
                          |        | memory map.
--------------------------------------------------------------------------------
linux,uefi-stub-kern-ver  | string | Copy of linux_banner from build.
--------------------------------------------------------------------------------

For verbose debug messages, specify 'uefi_debug' on the kernel command line.
