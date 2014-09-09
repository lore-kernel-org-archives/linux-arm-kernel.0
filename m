From: alex.bennee@linaro.org (=?UTF-8?q?Alex=20Benn=C3=A9e?=)
Date: Tue,  9 Sep 2014 17:27:18 +0100
Subject: [PATCH 1/2] KVM: document KVM_SET_GUEST_DEBUG api
In-Reply-To: <1410280039-2823-1-git-send-email-alex.bennee@linaro.org>
References: <1410280039-2823-1-git-send-email-alex.bennee@linaro.org>
Message-ID: <1410280039-2823-2-git-send-email-alex.bennee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation for working on the ARM implementation I noticed the debug
interface was missing from the API document. I've pieced together the
expected behaviour from the code and commit messages written it up as
best I can.

Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index d3dde61..723d3f3 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -2575,6 +2575,50 @@ associated with the service will be forgotten, and subsequent RTAS
 calls by the guest for that service will be passed to userspace to be
 handled.
 
+4.87 KVM_SET_GUEST_DEBUG
+
+Capability: KVM_CAP_SET_GUEST_DEBUG
+Architectures: x86, s390, ppc
+Type: vcpu ioctl
+Parameters: struct kvm_guest_debug (in)
+Returns: 0 on success; -1 on error
+
+struct kvm_guest_debug {
+       __u32 control;
+       __u32 pad;
+       struct kvm_guest_debug_arch arch;
+};
+
+Set up the processor specific debug registers and configure vcpu for
+handling guest debug events. There are two parts to the structure, the
+first a control bitfield indicates the type of debug events to handle
+when running. Common control bits are:
+
+  - KVM_GUESTDBG_ENABLE:        guest debugging is enabled
+  - KVM_GUESTDBG_SINGLESTEP:    the next run should single-step
+
+The top 16 bits of the control field are architecture specific control
+flags which can include the following:
+
+  - KVM_GUESTDBG_USE_SW_BP:     using software breakpoints [x86]
+  - KVM_GUESTDBG_USE_HW_BP:     using hardware breakpoints [x86, s390]
+  - KVM_GUESTDBG_INJECT_DB:     inject DB type exception [x86]
+  - KVM_GUESTDBG_INJECT_BP:     inject BP type exception [x86]
+  - KVM_GUESTDBG_EXIT_PENDING:  trigger an immediate guest exit [s390]
+
+For example KVM_GUESTDBG_USE_SW_BP indicates that software breakpoints
+are enabled in memory so we need to ensure breakpoint exceptions are
+correctly trapped and the KVM run loop exits at the breakpoint and not
+running off into the normal guest vector. For KVM_GUESTDBG_USE_HW_BP
+we need to ensure the guest vCPUs architecture specific registers are
+updated to the correct (supplied) values.
+
+The second part of the structure is architecture specific and
+typically contains a set of debug registers.
+
+When debug events exit the main run loop with the reason
+KVM_EXIT_DEBUG with the kvm_debug_exit_arch part of the kvm_run
+structure containing architecture specific debug information.
 
 5. The kvm_run structure
 ------------------------
-- 
2.1.0
