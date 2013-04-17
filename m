From: andre.przywara@linaro.org (Andre Przywara)
Date: Wed, 17 Apr 2013 12:52:01 +0200
Subject: [PATCH] ARM: KVM: iterate over all CPUs for CPU compatibility check
Message-ID: <1366195921-28053-1-git-send-email-andre.przywara@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

kvm_target_cpus() checks the compatibility of the used CPU with
KVM, which is currently limited to ARM Cortex-A15 cores.
However by calling it only once on any random CPU it assumes that
all cores are the same, which is not true for big.LITTLE parts.

After doing about 40 boots on a TC-2 core tile, I found it running
in all but one case on one of the A7 cores (which correctly denied
KVM initialization). On the 39th boot however the code ran on
an A15, leading to a hang after returning success:

...
TCP: reno registered
UDP hash table entries: 512 (order: 2, 16384 bytes)
UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
NET: Registered protocol family 1
kvm_target_cpu() on CPU #1, part is c0f0
 ... (pause for a while) ...
INFO: rcu_sched self-detected stall on CPUINFO: rcu_sched detected stalls on CPU
s/tasks: { 1} (detected by 0, t=6002 jiffies, g=4294966999, c=4294966998, q=15)
Task dump for CPU 1:
swapper/0       R running      0     1      0 0x00000002

It turned out that this core is waiting for the first A7 to complete
initialization, but this one hangs in HYP for a yet unknown reason.

To avoid this, iterate over every CPU to correctly determine the
capability of the system to run the current KVM implementation.

If users want to use KVM anyway, it will probably help to restrict
Linux to the A15 CPUs by giving an appropriate maxcpus= on the
kernel command line.

v2 change: remove potentially misleading hint message

Please push this still into 3.9.

Signed-off-by: Andre Przywara <andre.przywara@linaro.org>
---
 arch/arm/kvm/arm.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index c1fe498..74513e8 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -1129,19 +1129,29 @@ out_err:
 	return err;
 }
 
+static void check_kvm_target_cpu(void *ret)
+{
+	*(int*)ret = kvm_target_cpu();
+}
+
 /**
  * Initialize Hyp-mode and memory mappings on all CPUs.
  */
 int kvm_arch_init(void *opaque)
 {
 	int err;
+	int ret, cpu;
 
 	if (!is_hyp_mode_available()) {
 		kvm_err("HYP mode not available\n");
 		return -ENODEV;
 	}
 
-	if (kvm_target_cpu() < 0) {
+	for_each_online_cpu(cpu) {
+		smp_call_function_single(cpu, check_kvm_target_cpu, &ret, 1);
+		if (ret >= 0)
+			continue;
+
 		kvm_err("Target CPU not supported!\n");
 		return -ENODEV;
 	}
-- 
1.7.12.1
