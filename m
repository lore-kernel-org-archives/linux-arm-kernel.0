From: jmayo@nvidia.com (Jon Mayo)
Date: Tue, 21 Jun 2011 15:56:24 -0700
Subject: [PATCH] ARM: report present cpus in /proc/cpuinfo
Message-ID: <4E012198.6010405@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Because arm linux likes to dynamically hotplug cpus, the meaning of
online has changed slightly. Previously online meant a cpus is
schedulable, and conversely offline means they it is not schedulable.
But with the current power management infrastructure there are cpus
that can be scheduled (after they are woken up automatically), yet are
not considered "online" because the masks and flags for them are not
set.

---
  arch/arm/kernel/setup.c |    2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index d5231ae..2c52b4e 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -905,7 +905,7 @@ static int c_show(struct seq_file *m, void *v)
  		   cpu_name, read_cpuid_id() & 15, elf_platform);

  #if defined(CONFIG_SMP)
-	for_each_online_cpu(i) {
+	for_each_present_cpu(i) {
  		/*
  		 * glibc reads /proc/cpuinfo to determine the number of
  		 * online processors, looking for lines beginning with
-- 
1.7.0.4
