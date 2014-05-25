From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sun, 25 May 2014 20:18:52 +0200
Subject: [PATCH 06/16] KVM: Add KVM_EXIT_SYSTEM_EVENT to user space API header
In-Reply-To: <1401041942-23471-1-git-send-email-christoffer.dall@linaro.org>
References: <1401041942-23471-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1401041942-23471-7-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Anup Patel <anup.patel@linaro.org>

Currently, we don't have an exit reason to notify user space about
a system-level event (for e.g. system reset or shutdown) triggered
by the VCPU. This patch adds exit reason KVM_EXIT_SYSTEM_EVENT for
this purpose. We can also inform user space about the 'type' and
architecture specific 'flags' of a system-level event using the
kvm_run structure.

This newly added KVM_EXIT_SYSTEM_EVENT will be used by KVM ARM/ARM64
in-kernel PSCI v0.2 support to reset/shutdown VMs.

Signed-off-by: Anup Patel <anup.patel@linaro.org>
Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 Documentation/virtual/kvm/api.txt | 15 +++++++++++++++
 include/uapi/linux/kvm.h          |  8 ++++++++
 2 files changed, 23 insertions(+)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index 556d056..6a5de56 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -2740,6 +2740,21 @@ It gets triggered whenever both KVM_CAP_PPC_EPR are enabled and an
 external interrupt has just been delivered into the guest. User space
 should put the acknowledged interrupt vector into the 'epr' field.
 
+		/* KVM_EXIT_SYSTEM_EVENT */
+		struct {
+#define KVM_SYSTEM_EVENT_SHUTDOWN       1
+#define KVM_SYSTEM_EVENT_RESET          2
+			__u32 type;
+			__u64 flags;
+		} system_event;
+
+If exit_reason is KVM_EXIT_SYSTEM_EVENT then the vcpu has triggered
+a system-level event using some architecture specific mechanism (hypercall
+or some special instruction). In case of ARM/ARM64, this is triggered using
+HVC instruction based PSCI call from the vcpu. The 'type' field describes
+the system-level event type. The 'flags' field describes architecture
+specific flags for the system-level event.
+
 		/* Fix the size of the union. */
 		char padding[256];
 	};
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index f3252b1..16cb1a1 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -171,6 +171,7 @@ struct kvm_pit_config {
 #define KVM_EXIT_WATCHDOG         21
 #define KVM_EXIT_S390_TSCH        22
 #define KVM_EXIT_EPR              23
+#define KVM_EXIT_SYSTEM_EVENT     24
 
 /* For KVM_EXIT_INTERNAL_ERROR */
 /* Emulate instruction failed. */
@@ -301,6 +302,13 @@ struct kvm_run {
 		struct {
 			__u32 epr;
 		} epr;
+		/* KVM_EXIT_SYSTEM_EVENT */
+		struct {
+#define KVM_SYSTEM_EVENT_SHUTDOWN       1
+#define KVM_SYSTEM_EVENT_RESET          2
+			__u32 type;
+			__u64 flags;
+		} system_event;
 		/* Fix the size of the union. */
 		char padding[256];
 	};
-- 
1.8.5.2
