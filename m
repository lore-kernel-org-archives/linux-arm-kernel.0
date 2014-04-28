From: zhichang.yuan@linaro.org (zhichang.yuan at linaro.org)
Date: Mon, 28 Apr 2014 13:11:28 +0800
Subject: [PATCHv2 0/6] arm64:lib: the optimized string library routines for
 armv8 processors
Message-ID: <1398661895-5559-1-git-send-email-zhichang.yuan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "zhichang.yuan" <zhichang.yuan@linaro.org>

In current aarch64 kernel,there are a few string library routines
implemented in arm64/lib,such as memcpy,memset, memmove,strchr.
Most string routines frequently used are provided by the
architecture-independent string library. Those routines are not so efficient.

This patch set focus on improving the string routines' performance in ARMv8.
It contains eight optimized functions.The work is based on the cortex-string
project in Linaro toolchain.
The original cortex-string code can be found in this website:
	https://code.launchpad.net/cortex-strings

Changes since v1:

* Use macro CPU_BE and CPU_LE to differentiate the instructions for different endianess.
  Do not use the #ifdef.

* Use .req instead of #define for aliases' definition.

* In patch-3 for memset, use DC ZVA unconditionally.

* Done LTP on big-endian and little-endian system according to maintianers' requirement.
  The test results can be found at https://wiki.linaro.org/WorkingGroups/Kernel/ARMv8/CortexStringsTests.

* Use macro L1_CAHCE_SHIFT to replace the constant number in .p2align.

* Rearrange the numeric labels in order.

* Modify the comments to be more readable.


Detail of the patches:

To obtain better performance,several ideas were utilized:
* Memory burst access;
	For the long memory data operation,adopted the armv8 instruction pairs,
	ldp/stp,to transfer the bulk data.Try best to use continuous ldp/stp
	to trigger the burst access.
* Parallel processing
	The current string routines mostly processed per-byte. This patch
	processes the data in parallel.Such as strlen, it will process
	eight string bytes each time.
* Aligned memory access
	Classfy the process into several categories according to the input
	memory address parameters.For the non-alignment memory address,firstly
	process the begginning short-length data to make the memory address
	aligned,then start the remain processing on alignment address.

After the optimization,those routines have better performance than the current ones.
Please refer to this website to get the test results:
	https://wiki.linaro.org/WorkingGroups/Kernel/ARMv8/cortex-strings

--

zhichang.yuan (6):
  arm64: lib: Implement optimized memcpy routine
  arm64: lib: Implement optimized memmove routine
  arm64: lib: Implement optimized memset routine
  arm64: lib: Implement optimized memcmp routine
  arm64: lib: Implement optimized string compare routines
  arm64: lib: Implement optimized string length routines

 arch/arm64/include/asm/string.h |   15 ++
 arch/arm64/kernel/arm64ksyms.c  |    5 +
 arch/arm64/lib/Makefile         |    1 +
 arch/arm64/lib/memcmp.S         |  258 ++++++++++++++++++++++++++++++++
 arch/arm64/lib/memcpy.S         |  192 +++++++++++++++++++++---
 arch/arm64/lib/memmove.S        |  190 ++++++++++++++++++++----
 arch/arm64/lib/memset.S         |  207 +++++++++++++++++++++++---
 arch/arm64/lib/strcmp.S         |  234 +++++++++++++++++++++++++++++
 arch/arm64/lib/strlen.S         |  126 ++++++++++++++++
 arch/arm64/lib/strncmp.S        |  310 +++++++++++++++++++++++++++++++++++++++
 arch/arm64/lib/strnlen.S        |  171 +++++++++++++++++++++
 11 files changed, 1640 insertions(+), 69 deletions(-)
 create mode 100644 arch/arm64/lib/memcmp.S
 create mode 100644 arch/arm64/lib/strcmp.S
 create mode 100644 arch/arm64/lib/strlen.S
 create mode 100644 arch/arm64/lib/strncmp.S
 create mode 100644 arch/arm64/lib/strnlen.S

-- 
1.7.9.5
