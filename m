From: alex.bennee@linaro.org (=?UTF-8?q?Alex=20Benn=C3=A9e?=)
Date: Fri, 29 May 2015 10:30:17 +0100
Subject: [PATCH v5 01/12] KVM: add comments for kvm_debug_exit_arch struct
In-Reply-To: <1432891828-4816-1-git-send-email-alex.bennee@linaro.org>
References: <1432891828-4816-1-git-send-email-alex.bennee@linaro.org>
Message-ID: <1432891828-4816-2-git-send-email-alex.bennee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bring into line with the comments for the other structures and their
KVM_EXIT_* cases. Also update api.txt to reflect use in kvm_run
documentation.

Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>
Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Reviewed-by: Andrew Jones <drjones@redhat.com>
Acked-by: Christoffer Dall <christoffer.dall@linaro.org>

---

v2
  - add comments for other exit types
v3
  - s/commentary/comments/
  - add rb tags
  - update api.txt kvm_run to include KVM_EXIT_DEBUG desc
v4
  - sp fixes
  - add a-b
---
 Documentation/virtual/kvm/api.txt | 4 +++-
 include/uapi/linux/kvm.h          | 3 +++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index 9fa2bf8..c34c32d 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -3070,11 +3070,13 @@ data_offset describes where the data is located (KVM_EXIT_IO_OUT) or
 where kvm expects application code to place the data for the next
 KVM_RUN invocation (KVM_EXIT_IO_IN).  Data format is a packed array.
 
+		/* KVM_EXIT_DEBUG */
 		struct {
 			struct kvm_debug_exit_arch arch;
 		} debug;
 
-Unused.
+If the exit_reason is KVM_EXIT_DEBUG, then a vcpu is processing a debug event
+for which architecture specific information is returned.
 
 		/* KVM_EXIT_MMIO */
 		struct {
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 4b60056..70ac641 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -237,6 +237,7 @@ struct kvm_run {
 			__u32 count;
 			__u64 data_offset; /* relative to kvm_run start */
 		} io;
+		/* KVM_EXIT_DEBUG */
 		struct {
 			struct kvm_debug_exit_arch arch;
 		} debug;
@@ -285,6 +286,7 @@ struct kvm_run {
 			__u32 data;
 			__u8  is_write;
 		} dcr;
+		/* KVM_EXIT_INTERNAL_ERROR */
 		struct {
 			__u32 suberror;
 			/* Available with KVM_CAP_INTERNAL_ERROR_DATA: */
@@ -295,6 +297,7 @@ struct kvm_run {
 		struct {
 			__u64 gprs[32];
 		} osi;
+		/* KVM_EXIT_PAPR_HCALL */
 		struct {
 			__u64 nr;
 			__u64 ret;
-- 
2.4.1
