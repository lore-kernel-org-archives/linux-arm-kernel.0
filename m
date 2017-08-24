From: hoeun.ryu@gmail.com (Hoeun Ryu)
Date: Thu, 24 Aug 2017 14:42:55 +0900
Subject: [RFC 1/3] arch: add 64BIT_ATOMIC_ACCESS to support 64bit atomic
 access on 32bit machines
In-Reply-To: <1503553377-3646-1-git-send-email-hoeun.ryu@gmail.com>
References: <1503553377-3646-1-git-send-email-hoeun.ryu@gmail.com>
Message-ID: <1503553377-3646-2-git-send-email-hoeun.ryu@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 On some 32-bit architectures, 64bit accesses are atomic when certain
conditions are satisfied.
 For example, on LPAE (Large Physical Address Extension) enabled ARM
architecture, 'ldrd/strd' (load/store doublewords) instructions are 64bit
atomic as long as the address is 64-bit aligned. This feature is to
guarantee atomic accesses on newly introduced 64bit wide descriptors in
the translation tables, and 's/u64' variables can be accessed atomically
when they are aligned(8) on LPAE enabled ARM architecture machines.

 Introducing 64BIT_ATOMIC_ACCESS and 64BIT_ATOMIC_ALIGNED_ACCESS, which
can be true for the 32bit architectures as well as 64bit architectures,
we can optimize some kernel codes using seqlock (timekeeping) or mimics
of it (like in sched/cfq) simply to read or write 64bit variables.
 The existing codes depend on CONFIG_64BIT to determine whether the 64bit
variables can be directly accessed or need additional synchronization
primitives like seqlock. CONFIG_64BIT_ATOMIC_ACCESS can be used instead of
CONFIG_64BIT in the cases.
 64BIT_ATOMIC_ALIGNED_ACCESS can be used in the variable declaration to
indicate the alignment requirement to the compiler
(__attribute__((aligned(8)))) in the way of #ifdef.

Signed-off-by: Hoeun Ryu <hoeun.ryu@gmail.com>
---
 arch/Kconfig | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 21d0089..1def331 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -115,6 +115,26 @@ config UPROBES
 	    managed by the kernel and kept transparent to the probed
 	    application. )
 
+config 64BIT_ATOMIC_ACCESS
+	def_bool 64BIT
+	help
+	  On some 32bit architectures as well as 64bit architectures,
+	  64bit accesses are atomic when certain conditions are satisfied.
+
+	  This symbol should be selected by an architecture if 64 bit
+	  accesses can be atomic.
+
+config 64BIT_ATOMIC_ALIGNED_ACCESS
+	def_bool n
+	depends on 64BIT_ATOMIC_ACCESS
+	help
+	  On 64BIT_ATOMIC_ACCESS enabled system, the address should be
+	  aligned by 8 to guarantee the accesses are atomic.
+
+	  This symbol should be selected by an architecture if 64 bit
+	  accesses are required to be 64 bit aligned to guarantee that
+	  the 64bit accesses are atomic.
+
 config HAVE_64BIT_ALIGNED_ACCESS
 	def_bool 64BIT && !HAVE_EFFICIENT_UNALIGNED_ACCESS
 	help
-- 
2.7.4
