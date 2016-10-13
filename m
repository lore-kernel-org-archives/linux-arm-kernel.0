From: jun.nie@linaro.org (Jun Nie)
Date: Thu, 13 Oct 2016 20:31:20 +0800
Subject: [PATCH v2 1/2] arm64: dts: zx: Fix gic GICR property
In-Reply-To: <1476361881-19685-1-git-send-email-jun.nie@linaro.org>
References: <1476361881-19685-1-git-send-email-jun.nie@linaro.org>
Message-ID: <1476361881-19685-2-git-send-email-jun.nie@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GICR for multiple CPU can be described with start address and stride,
or with multiple address. Current multiple address and stride are
both used. Fix it.

vmalloc patch 727a7f5a9 triggered this bug:
[    0.097146] Unable to handle kernel paging request at virtual address ffff000008060008
[    0.097150] pgd = ffff000008602000
[    0.097160] [ffff000008060008] *pgd=000000007fffe003, *pud=000000007fffd003, *pmd=000000007fffc003, *pte=0000000000000000
[    0.097165] Internal error: Oops: 96000007 [#1] PREEMPT SMP
[    0.097170] Modules linked in:
[    0.097177] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.8.0+ #1474
[    0.097179] Hardware name: ZTE zx296718 evaluation board (DT)
[    0.097183] task: ffff80003e8c8b80 task.stack: ffff80003e8d0000
[    0.097197] PC is at gic_populate_rdist+0x74/0x15c
[    0.097202] LR is at gic_starting_cpu+0xc/0x20
[    0.097206] pc : [<ffff0000082b1b18>] lr : [<ffff0000082b26e0>] pstate: 600001c5

Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 arch/arm64/boot/dts/zte/zx296718.dtsi | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/zte/zx296718.dtsi b/arch/arm64/boot/dts/zte/zx296718.dtsi
index a223066..6b239a3 100644
--- a/arch/arm64/boot/dts/zte/zx296718.dtsi
+++ b/arch/arm64/boot/dts/zte/zx296718.dtsi
@@ -239,16 +239,11 @@
 		compatible = "arm,gic-v3";
 		#interrupt-cells = <3>;
 		#address-cells = <0>;
-		#redistributor-regions = <6>;
-		redistributor-stride = <0x0 0x40000>;
+		#redistributor-regions = <1>;
+		redistributor-stride = <0x20000>;
 		interrupt-controller;
 		reg = <0x02a00000 0x10000>,
-		      <0x02b00000 0x20000>,
-		      <0x02b20000 0x20000>,
-		      <0x02b40000 0x20000>,
-		      <0x02b60000 0x20000>,
-		      <0x02b80000 0x20000>,
-		      <0x02ba0000 0x20000>;
+		      <0x02b00000 0xc0000>;
 		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
-- 
1.9.1
