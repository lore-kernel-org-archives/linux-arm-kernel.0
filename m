From: eric.auger@redhat.com (Eric Auger)
Date: Mon, 27 Mar 2017 11:31:06 +0200
Subject: [PATCH v4 16/22] KVM: expose next_segment()
In-Reply-To: <1490607072-21610-1-git-send-email-eric.auger@redhat.com>
References: <1490607072-21610-1-git-send-email-eric.auger@redhat.com>
Message-ID: <1490607072-21610-17-git-send-email-eric.auger@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Expose next_segment() as we would like to reuse this routine in
ARM vgic-its code.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 include/linux/kvm_host.h | 8 ++++++++
 virt/kvm/kvm_main.c      | 8 --------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 2c14ad9..b4b5d82 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -92,6 +92,14 @@ static inline bool is_noslot_pfn(kvm_pfn_t pfn)
 	return pfn == KVM_PFN_NOSLOT;
 }
 
+static inline int next_segment(unsigned long len, int offset)
+{
+	if (len > PAGE_SIZE - offset)
+		return PAGE_SIZE - offset;
+	else
+		return len;
+}
+
 /*
  * architectures with KVM_HVA_ERR_BAD other than PAGE_OFFSET (e.g. s390)
  * provide own defines and kvm_is_error_hva
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index a17d787..b825e86 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1738,14 +1738,6 @@ void kvm_get_pfn(kvm_pfn_t pfn)
 }
 EXPORT_SYMBOL_GPL(kvm_get_pfn);
 
-static int next_segment(unsigned long len, int offset)
-{
-	if (len > PAGE_SIZE - offset)
-		return PAGE_SIZE - offset;
-	else
-		return len;
-}
-
 static int __kvm_read_guest_page(struct kvm_memory_slot *slot, gfn_t gfn,
 				 void *data, int offset, int len)
 {
-- 
2.5.5
