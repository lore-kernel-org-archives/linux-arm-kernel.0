From: nm@ti.com (Nishanth Menon)
Date: Sat, 3 Oct 2015 18:38:48 -0500
Subject: [PATCH V2 1/3] Documentation: dt: keystone: provide SoC specific
 compatible flags
In-Reply-To: <1443915530-15035-1-git-send-email-nm@ti.com>
References: <1442938118-4718-1-git-send-email-nm@ti.com>
 <1443915530-15035-1-git-send-email-nm@ti.com>
Message-ID: <1443915530-15035-2-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Keystone2 devices are used on more platforms than just Texas
Instruments reference evaluation platforms called EVMs. Providing a
generic compatible "ti,keystone" is not sufficient to differentiate
various SoC definitions possible on various platforms for the
following reasons:
a) Userspace applications have no way of knowing which SoC they are
functioning, providing the compatible matches provide a mechanism for
them to enable SoC specific functionality. Such userspace applications
are typically automated test framework or SoC custom hardware
acceleration entitlement from a common file system.
b) Provides an accurate hardware description. This allows
SoC specific logic to be run time handled based on
of_machine_is_compatible("ti,k2hk") or as needed for the dependent
processor instead of needing to use board dependent compatibles that
are needed now.

Hence, provide compatible matches for each SoC in the Keystone family.

Acked-By: Murali Karicheri <m-karicheri2@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---

Changes since V2:
	- elaborated reasoning why this change is useful - highlighted
	  potential userspace usage as well.
	- picked up Acked-by from Murali

V1: https://patchwork.kernel.org/patch/7240891/

 .../devicetree/bindings/arm/keystone/keystone.txt    | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/keystone/keystone.txt b/Documentation/devicetree/bindings/arm/keystone/keystone.txt
index 59d7a46f85eb..800d2d02e27b 100644
--- a/Documentation/devicetree/bindings/arm/keystone/keystone.txt
+++ b/Documentation/devicetree/bindings/arm/keystone/keystone.txt
@@ -9,12 +9,26 @@ Required properties:
    the form "ti,keystone-*". Generic devices like gic, arch_timers, ns16550
    type UART should use the specified compatible for those devices.
 
+SoC families:
+
+- Keystone 2 generic SoC:
+   compatible = "ti,keystone"
+
+SoCs:
+
+- Keystone 2 Hawking/Kepler
+   compatible = ti,k2hk", "ti,keystone"
+- Keystone 2 Lamarr
+   compatible = ti,k2l", "ti,keystone"
+- Keystone 2 Edison
+   compatible = ti,k2e", "ti,keystone"
+
 Boards:
 -  Keystone 2 Hawking/Kepler EVM
-   compatible = "ti,k2hk-evm","ti,keystone"
+   compatible = "ti,k2hk-evm", "ti,k2hk", "ti,keystone"
 
 -  Keystone 2 Lamarr EVM
-   compatible = "ti,k2l-evm","ti,keystone"
+   compatible = "ti,k2l-evm", "ti, k2l", "ti,keystone"
 
 -  Keystone 2 Edison EVM
-   compatible = "ti,k2e-evm","ti,keystone"
+   compatible = "ti,k2e-evm", "ti,k2e", "ti,keystone"
-- 
2.1.4
