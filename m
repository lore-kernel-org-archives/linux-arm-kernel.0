From: matthew.leach@arm.com (Matthew Leach)
Date: Fri, 11 Oct 2013 14:52:18 +0100
Subject: [PATCH 12/14] arm64: big-endian: write CPU holding pen address as LE
In-Reply-To: <1381499540-28794-1-git-send-email-matthew.leach@arm.com>
References: <1381499540-28794-1-git-send-email-matthew.leach@arm.com>
Message-ID: <1381499540-28794-13-git-send-email-matthew.leach@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently when CPUs are brought online via a spin-table, the address
they should jump to is written to the cpu-release-addr in the kernel's
native endianness. As the kernel may switch endianness, secondaries
might read the value byte-reversed from what was intended, and they
would jump to the wrong address.

As the only current arm64 spin-table implementations are
little-endian, stricten up the arm64 spin-table definition such that
the value written to cpu-release-addr is _always_ little-endian
regardless of the endianness of any CPU. If a spinning CPU is
operating big-endian, it must byte-reverse the value before jumping to
handle this.

Signed-off-by: Matthew Leach <matthew.leach@arm.com>
---
 arch/arm64/kernel/smp_spin_table.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/smp_spin_table.c b/arch/arm64/kernel/smp_spin_table.c
index 7c35fa6..c0bc097 100644
--- a/arch/arm64/kernel/smp_spin_table.c
+++ b/arch/arm64/kernel/smp_spin_table.c
@@ -48,7 +48,16 @@ static int __init smp_spin_table_prepare_cpu(int cpu)
 		return -ENODEV;
 
 	release_addr = __va(cpu_release_addr[cpu]);
-	release_addr[0] = (void *)__pa(secondary_holding_pen);
+
+	/*
+	 * We write the release address as LE regardless of the native
+	 * endianess of the kernel. Therefore, any boot-loaders that
+	 * read this address need to convert this address to the
+	 * boot-loader's endianess before jumping. This is mandated by
+	 * the boot protocol.
+	 */
+	release_addr[0] = (void *) cpu_to_le64(__pa(secondary_holding_pen));
+
 	__flush_dcache_area(release_addr, sizeof(release_addr[0]));
 
 	/*
-- 
1.7.9.5
