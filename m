From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Fri, 24 Jul 2015 10:43:47 +0100
Subject: [RFC PATCH 01/10] arm64: feature registers: Documentation
In-Reply-To: <1437731037-25795-1-git-send-email-suzuki.poulose@arm.com>
References: <1437731037-25795-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1437731037-25795-2-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>

Documentation of the infrastructure

Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
---
 Documentation/arm64/cpu-feature-registers.txt |  185 +++++++++++++++++++++++++
 1 file changed, 185 insertions(+)
 create mode 100644 Documentation/arm64/cpu-feature-registers.txt

diff --git a/Documentation/arm64/cpu-feature-registers.txt b/Documentation/arm64/cpu-feature-registers.txt
new file mode 100644
index 0000000..08030be
--- /dev/null
+++ b/Documentation/arm64/cpu-feature-registers.txt
@@ -0,0 +1,185 @@
+		ARM64 CPU Feature Registers
+		===========================
+
+Author: Suzuki K. Poulose <suzuki.poulose@arm.com>
+
+
+This file describes the API for exporting the AArch64 CPU ID/feature registers
+to userspace.
+
+1. Motivation
+---------------
+
+The ARM architecture defines a set of feature registers, which describe
+the capabilities of the CPU/system. Access to these system registers is
+restricted from EL0 and there is no reliable way for an application to
+extract this information to make better decisions at runtime. There is
+limited information available to the application via ELF_HWCAPs, however
+there are some issues with their usage.
+
+ a) Any change to the HWCAPs requires an update to userspace (e.g libc)
+    to detect the new changes, which can take a long time to appear in
+    distributions. Exposing the registers allows applications to get the
+    information without requiring other userspace components to be updated.
+
+ b) Access to HWCAPs is sometimes restricted (e.g prior to libc, or when ld is
+    initialised at startup time).
+
+ c) HWCAPs cannot represent non-boolean information effectively. The
+    architecture defines a canonical format for representing features
+    in the ID registers; this is well defined and is capable of
+    representing all valid architecture variations. Exposing the ID
+    registers avoids having to come up with HWCAP representations
+    and parsing code.
+
+
+2. Requirements
+-----------------
+
+ a) Safety :
+    Applications should be able to use the information provided by the
+    infrastructure to run optimally safely across the system. This has
+    greater implications on a system with heterogeneous CPUs. The
+    infrastructure exports a value that is safe across all the available
+    CPU on the system.
+
+    e.g, If at least one CPU doesn't implement CRC32 instructions, while others
+    do, we should report that the CRC32 is not implemented. Otherwise an
+    application could crash when scheduled on the CPU which doesn't support
+    CRC32.
+
+ b) Security :
+    Applications should only be able to receive information that is relevant
+    to the normal operation in userspace. Hence, some of the fields
+    are masked out and the values of the fields are set to indicate the
+    feature is 'not supported' (See the 'visible' field in the
+    table in Section 4). Also, the kernel may manipulate the fields based on what
+    it supports. e.g, If FP is not supported by the kernel, the values
+    could indicate that the FP is not available (even when the CPU provides
+    it).
+
+ c) Implementation Defined Features
+    The infrastructure doesn't expose any register which is
+    IMPLEMENTATION DEFINED as per ARMv8-A Architecture and is set to 0.
+
+ d) CPU Identification :
+    MIDR_EL1 is exposed to help identify the processor. On a heterogeneous
+    system, this could be racy (just like getcpu()). The process could be
+    migrated to another CPU by the time we use the register value. Hence,
+    there is no guarantee that the value reflects the processor that it is
+    currently executing on.
+
+The list of supported registers and the attributes of individual
+feature bits are listed in section 4. Unless there is absolute necessity,
+we don't encourage the addition of new feature registers to the list.
+In any case, it should comply to the requirements listed above.
+
+3. Implementation
+--------------------
+
+The infrastructure is built on the emulation of the 'MRS' instruction.
+Accessing a restricted system register from an application generates an
+exception and ends up in SIGILL being delivered to the process.
+The infrastructure hooks into the exception handler and emulates the
+operation if the source belongs to the supported system register space.
+
+The infrastructure emulates only the following system register space:
+	Op0=3, Op1=0, CRn=0
+
+(See Table C5-6 'System instruction encodings for System register accesses'
+ in ARMv8 ARM, for the list of registers).
+
+
+The following rules are applied to the value returned by the infrastructure:
+
+ a) The value of an 'IMPLEMENTATION DEFINED' field is set to 0.
+ b) The value of a reserved field is set to the reserved value(as
+    defined by the architecture).
+ c) The value of a field marked as not 'visible', is set to indicate
+    the feature is missing (as defined by the architecture).
+ d) The value of a 'visible' field holds the system wide safe value
+    for the particular feature(except for MIDR_EL1, see section 4)
+
+There are only a few registers visible to the userspace. See Section 4,
+for the list of 'visible' registers.
+
+The registers which are either reserved RAZ or IMPLEMENTAION DEFINED are
+emulated as 0.
+
+All others are emulated as having 'invisible' features.
+
+4. List of exposed registers
+-----------------------------
+
+  1) ID_AA64ISAR0_EL1 - Instruction Set Attribute Register 0
+     x--------------------------------------------------x
+     | Name                         |  bits   | visible |
+     |--------------------------------------------------|
+     | RAZ                          | [63-20] |    n    |
+     |--------------------------------------------------|
+     | CRC32                        | [19-16] |    y    |
+     |--------------------------------------------------|
+     | SHA2                         | [15-12] |    y    |
+     |--------------------------------------------------|
+     | SHA1                         | [11-8]  |    y    |
+     |--------------------------------------------------|
+     | AES                          | [7-4]   |    y    |
+     |--------------------------------------------------|
+     | RAZ                          | [3-0]   |    n    |
+     x--------------------------------------------------x
+
+  2) ID_AA64ISAR1_EL1 - Instruction Set Attribute Register 1
+     x--------------------------------------------------x
+     | Name                         |  bits   | visible |
+     |--------------------------------------------------|
+     | RAZ                          | [63-0]  |    y    |
+     x--------------------------------------------------x
+
+  3) ID_AA64PFR0_EL1 - Processor Feature Register 0
+     x--------------------------------------------------x
+     | Name                         |  bits   | visible |
+     |--------------------------------------------------|
+     | RAZ                          | [63-28] |    n    |
+     |--------------------------------------------------|
+     | GIC                          | [27-24] |    n    |
+     |--------------------------------------------------|
+     | AdvSIMD                      | [23-20] |    y    |
+     |--------------------------------------------------|
+     | FP                           | [19-16] |    y    |
+     |--------------------------------------------------|
+     | EL3                          | [15-12] |    n    |
+     |--------------------------------------------------|
+     | EL2                          | [11-8]  |    n    |
+     |--------------------------------------------------|
+     | EL1                          | [7-4]   |    n    |
+     |--------------------------------------------------|
+     | EL0                          | [3-0]   |    n    |
+     x--------------------------------------------------x
+
+  4) ID_AA64PFR1_EL1 - Processor Feature Register 1
+     x--------------------------------------------------x
+     | Name                         |  bits   | visible |
+     |--------------------------------------------------|
+     | RAZ                          | [63-0]  |    y    |
+     x--------------------------------------------------x
+
+  5) MIDR_EL1 - Main ID Register
+     x--------------------------------------------------x
+     | Name                         |  bits   | visible |
+     |--------------------------------------------------|
+     | RAZ                          | [63-32] |    n    |
+     |--------------------------------------------------|
+     | Implementer                  | [31-24] |    y    |
+     |--------------------------------------------------|
+     | Variant                      | [23-20] |    y    |
+     |--------------------------------------------------|
+     | Architecture                 | [19-16] |    y    |
+     |--------------------------------------------------|
+     | PartNum                      | [15-4]  |    y    |
+     |--------------------------------------------------|
+     | Revision                     | [3-0]   |    y    |
+     x--------------------------------------------------x
+
+   NOTE: The 'visible' fields of MIDR_EL1 will contain the value
+   as available on the CPU where it is fetched and is not a system
+   wide safe value.
-- 
1.7.9.5
