From: vijay.kilari@gmail.com (vijay.kilari at gmail.com)
Date: Thu,  7 Nov 2013 18:08:40 +0530
Subject: [RFC v1 PATCH] ARM64: KGDB: Add FPSIMD debug support
Message-ID: <1383827921-18526-1-git-send-email-vijay.kilari@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vijaya Kumar K <Vijaya.Kumar@caviumnetworks.com>

Based on ARM64 KGDB support patches, KGDB support for
FPSIMD is added. Only debugging of FPSIMD is kernel context
is supported.

This patch also requires Ard's patches where in kernel support
for NEON is added. So CONFIG_KERNEL_MODE_NEON should  be enabled.
with this, FPSIMD registers can be viewed or set from gdb tool.

Unlike CPU registers, the FPSIMD registers are not saved on 
exception entry. With the known restriction that FPSIMD  should not be
touched in interrupt/exception context, in this patch the FPSIMD
registers are directly read/written on gdb tool request

Here, the FPSIMD registers are read and restored for every FPSIMD
register read and write by GDB tool. So this has impact on 
gdb tool response which is neglible. Other architectures like
mips are also implemented similarly

Tested on ARM64 simulator

Vijaya Kumar K (1):
  ARM64: KGDB: Add FP/SIMD debug support

 arch/arm64/kernel/kgdb.c |   98 ++++++++++++++++++++++++++++------------------
 1 file changed, 60 insertions(+), 38 deletions(-)

-- 
1.7.9.5
