From: vijay.kilari@gmail.com (vijay.kilari at gmail.com)
Date: Mon, 18 Nov 2013 17:36:56 +0530
Subject: [RFC v2 PATCH 0/1] ARM64: KGDB: Add FPSIMD debug support
Message-ID: <1384776417-29076-1-git-send-email-vijay.kilari@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vijaya Kumar K <Vijaya.Kumar@caviumnetworks.com>

Based on ARM64 KGDB support patches, KGDB support for
FPSIMD is added. Only debugging of FPSIMD kernel context
is supported.

This patch requires Ard's patches where in kernel support and
below patch for holding thread's fpsimd state.

http://permalink.gmane.org/gmane.linux.ports.arm.kernel/277228

So CONFIG_KERNEL_MODE_NEON should  be enabled.
with this, FPSIMD registers can be viewed or set from gdb tool.

Unlike CPU registers, the FPSIMD registers are not saved on
exception entry. With the known restriction that FPSIMD  should not be
touched in interrupt/exception context, in this patch the FPSIMD
registers are directly read/written on gdb tool request

Here, the FPSIMD registers are read and restored for every FPSIMD
register read and write by GDB tool. So this has impact on
gdb tool response which is neglible. Other architectures like
mips are also implemented similarly

v2 changes:
  - Added API to know thread fpsimd state by checking
    TIF_FOREIGN_FPSTATE flag. This is based on below patch

    http://permalink.gmane.org/gmane.linux.ports.arm.kernel/277228

  - Allow FPSIMD registers access only when FPSIMD is under use
    by current thread 

v1 changes: 
  - Initial patch

Tested on ARM64 simulator

Vijaya Kumar K (1):
  ARM64: KGDB: Add FP/SIMD debug support

 arch/arm64/include/asm/fpsimd.h |    1 +
 arch/arm64/kernel/fpsimd.c      |    5 ++
 arch/arm64/kernel/kgdb.c        |  105 +++++++++++++++++++++++++--------------
 3 files changed, 73 insertions(+), 38 deletions(-)

-- 
1.7.9.5
