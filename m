From: cdall@linaro.org (Christoffer Dall)
Date: Sun, 23 Apr 2017 19:09:19 +0200
Subject: [PULL 69/79] arm/arm64: Add hyp-stub API documentation
In-Reply-To: <20170423170929.27334-1-cdall@linaro.org>
References: <20170423170929.27334-1-cdall@linaro.org>
Message-ID: <20170423170929.27334-70-cdall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

In order to help people understanding the hyp-stub API that exists
between the host kernel and the hypervisor mode (whether a hypervisor
has been installed or not), let's document said API.

As with any form of documentation, I expect it to become obsolete
and completely misleading within 20 minutes after having being merged.

Acked-by: Russell King <rmk+kernel@armlinux.org.uk>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <cdall@linaro.org>
---
 Documentation/virtual/kvm/arm/hyp-abi.txt | 53 +++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 Documentation/virtual/kvm/arm/hyp-abi.txt

diff --git a/Documentation/virtual/kvm/arm/hyp-abi.txt b/Documentation/virtual/kvm/arm/hyp-abi.txt
new file mode 100644
index 0000000..a20a0be
--- /dev/null
+++ b/Documentation/virtual/kvm/arm/hyp-abi.txt
@@ -0,0 +1,53 @@
+* Internal ABI between the kernel and HYP
+
+This file documents the interaction between the Linux kernel and the
+hypervisor layer when running Linux as a hypervisor (for example
+KVM). It doesn't cover the interaction of the kernel with the
+hypervisor when running as a guest (under Xen, KVM or any other
+hypervisor), or any hypervisor-specific interaction when the kernel is
+used as a host.
+
+On arm and arm64 (without VHE), the kernel doesn't run in hypervisor
+mode, but still needs to interact with it, allowing a built-in
+hypervisor to be either installed or torn down.
+
+In order to achieve this, the kernel must be booted at HYP (arm) or
+EL2 (arm64), allowing it to install a set of stubs before dropping to
+SVC/EL1. These stubs are accessible by using a 'hvc #0' instruction,
+and only act on individual CPUs.
+
+Unless specified otherwise, any built-in hypervisor must implement
+these functions (see arch/arm{,64}/include/asm/virt.h):
+
+* r0/x0 = HVC_SET_VECTORS
+  r1/x1 = vectors
+
+  Set HVBAR/VBAR_EL2 to 'vectors' to enable a hypervisor. 'vectors'
+  must be a physical address, and respect the alignment requirements
+  of the architecture. Only implemented by the initial stubs, not by
+  Linux hypervisors.
+
+* r0/x0 = HVC_RESET_VECTORS
+
+  Turn HYP/EL2 MMU off, and reset HVBAR/VBAR_EL2 to the initials
+  stubs' exception vector value. This effectively disables an existing
+  hypervisor.
+
+* r0/x0 = HVC_SOFT_RESTART
+  r1/x1 = restart address
+  x2 = x0's value when entering the next payload (arm64)
+  x3 = x1's value when entering the next payload (arm64)
+  x4 = x2's value when entering the next payload (arm64)
+
+  Mask all exceptions, disable the MMU, move the arguments into place
+  (arm64 only), and jump to the restart address while at HYP/EL2. This
+  hypercall is not expected to return to its caller.
+
+Any other value of r0/x0 triggers a hypervisor-specific handling,
+which is not documented here.
+
+The return value of a stub hypercall is held by r0/x0, and is 0 on
+success, and HVC_STUB_ERR on error. A stub hypercall is allowed to
+clobber any of the caller-saved registers (x0-x18 on arm64, r0-r3 and
+ip on arm). It is thus recommended to use a function call to perform
+the hypercall.
-- 
2.9.0
