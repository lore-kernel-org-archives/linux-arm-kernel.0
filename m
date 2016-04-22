From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 22 Apr 2016 16:18:02 +0100
Subject: [PATCH v2] drivers: firmware: psci: unify enable-method binding on
 ARM {64, 32}-bit systems
Message-ID: <1461338282-19509-1-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently ARM CPUs DT bindings allows different enable-method value for
PSCI based systems. On ARM 64-bit this property is required and must be
"psci" while on ARM 32-bit systems this property is optional and must
be "arm,psci" if present.

However, "arm,psci" has always been the compatible string for the PSCI
node, and was never intended to be the enable-method. So this is a bug
in the binding and not a deliberate attempt at specifying 32-bit
differently.

This is problematic if 32-bit OS is run on 64-bit system which has
"psci" as enable-method rather than the expected "arm,psci".

So let's unify the value into "psci" and remove support for "arm,psci"
before it finds any users.

Reported-by: Soby Mathew <Soby.Mathew@arm.com>
Cc: Rob Herring <robh+dt@kernel.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 Documentation/devicetree/bindings/arm/cpus.txt | 1 -
 drivers/firmware/psci.c                        | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

v2->v1:
	- Added Mark and Lorenzo's ACKs
	- Updated commit message to specify that it also conflicts with
	  PSCI compatible(from Mark's reply on the thread)

Hi ARM-SoC guys,

Can you please pick up this single fix for PSCI binding/driver for v4.6 ?

Regards,
Sudeep

diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
index ccc62f145306..3f0cbbb8395f 100644
--- a/Documentation/devicetree/bindings/arm/cpus.txt
+++ b/Documentation/devicetree/bindings/arm/cpus.txt
@@ -192,7 +192,6 @@ nodes to be present and contain the properties described below.
 			  can be one of:
 			    "allwinner,sun6i-a31"
 			    "allwinner,sun8i-a23"
-			    "arm,psci"
 			    "arm,realview-smp"
 			    "brcm,bcm-nsp-smp"
 			    "brcm,brahma-b15"
diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
index 11bfee8b79a9..b5d05807e6ec 100644
--- a/drivers/firmware/psci.c
+++ b/drivers/firmware/psci.c
@@ -360,7 +360,7 @@ static struct cpuidle_ops psci_cpuidle_ops __initdata = {
 	.init = psci_dt_cpu_init_idle,
 };
 
-CPUIDLE_METHOD_OF_DECLARE(psci, "arm,psci", &psci_cpuidle_ops);
+CPUIDLE_METHOD_OF_DECLARE(psci, "psci", &psci_cpuidle_ops);
 #endif
 #endif
 
-- 
1.9.1
