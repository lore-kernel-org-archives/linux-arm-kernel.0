From: sophian.yoma@gmail.com (yoma sophian)
Date: Wed, 27 May 2015 17:47:09 +0800
Subject: some question about arm64 smp_spin_table.c
Message-ID: <CADUS3o=4b9zfKtyiZ2CKgC2AA9ntkFLo91pJug17t1Xz2jM34w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi all:
in arm64/kernel/smp_spin_table.c
    --> smp_spin_table_prepare_cpu,
we suppose the cpu_release_addr[cpu] is located in kernel logical memory.

in Arm plarform, this part is implement by each platform driver, since
they register its own smp_operations.

And in Arm64, once other platform use different area, such as register
or device memory, to put cpu_release_addr[cpu], shall we use ioremap
to get the va like below patch?

Appreciate your kind in advance,

diff --git a/arch/arm64/kernel/smp_spin_table.c
b/arch/arm64/kernel/smp_spin_table.c
index 7c35fa6..9d945bd 100644
--- a/arch/arm64/kernel/smp_spin_table.c
+++ b/arch/arm64/kernel/smp_spin_table.c
@@ -21,6 +21,7 @@
 #include <linux/smp.h>

 #include <asm/cacheflush.h>
+#include <linux/io.h>

 static phys_addr_t cpu_release_addr[NR_CPUS];

@@ -47,10 +48,9 @@ static int __init smp_spin_table_prepare_cpu(int cpu)
        if (!cpu_release_addr[cpu])
                return -ENODEV;

-       release_addr = __va(cpu_release_addr[cpu]);
+       release_addr = ioremap(cpu_release_addr[cpu], SZ_4K);
        release_addr[0] = (void *)__pa(secondary_holding_pen);
-       __flush_dcache_area(release_addr, sizeof(release_addr[0]));
-
+       iounmap(release_addr);
        /*
         * Send an event to wake up the secondary CPU.
         */
