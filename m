From: ynorov@caviumnetworks.com (Yury Norov)
Date: Wed, 2 Sep 2015 18:49:58 +0300
Subject: [PATCH v3 0/2] arm64: introduce run-time detection of aarch32 support
Message-ID: <1441209000-26746-1-git-send-email-ynorov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is needed to avoid loading aarch32 binaries if COMPAT is enabled, but
aarch32 is not supported by specific platform.

First patch fixes hidden header dependencies in arch/arm64/include/asm/cpufeature.h.
It's not related to the issue, but helps to avoid build failure that happens
if one applies second patch only.

Second patch adds run-time detection of aarch32 support, and rejects kernel to
load such binaries, if not supported.

Tested on ThunderX.

V3:
 - first patch message extended with explanation for cpu_feature macro move;
 - in second patch, restored pfr0 masking in id_aa64pfr0_aarch32_el0().

V2:
 - add missing <linux/compiler.h> for the __attribute_const__ on
   cpuid_feature_extract_field;
 - move cpu_feature macro under the __ASSEMBLY__ guard.
 - check that all CPUs support AArch32, not the current only,
   the same way as for endianness support.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>

Yury Norov (2):
  arm64: cpufeature.h: resolve hidden header dependencies
  arm64: don't load 32-bit binaries if platform has no aarch32_el0

 arch/arm64/include/asm/cpufeature.h | 10 +++++++++-
 arch/arm64/include/asm/cputype.h    |  8 ++++++++
 arch/arm64/include/asm/elf.h        |  6 ++++--
 arch/arm64/kernel/cpuinfo.c         | 12 ++++++++++++
 4 files changed, 33 insertions(+), 3 deletions(-)

-- 
2.1.4
