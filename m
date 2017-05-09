From: cdall@linaro.org (Christoffer Dall)
Date: Tue,  9 May 2017 10:56:17 +0200
Subject: [PATCH v2 10/11] KVM: arm/arm64: Don't call map_resources when
 restoring ITS tables
In-Reply-To: <20170509085618.28311-1-cdall@linaro.org>
References: <20170509085618.28311-1-cdall@linaro.org>
Message-ID: <20170509085618.28311-11-cdall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The only reason we called kvm_vgic_map_resources() when restoring the
ITS tables was because we wanted to have the KVM iodevs registered in
the KVM IO bus framework at the time when the ITS was restored such that
a restored and active device can inject MSIs prior to otherwise calling
kvm_vgic_map_resources() from the first run of a VCPU.

Since we now register the KVM iodevs for the redestributors and ITS as
soon as possible (when setting the base addresses), we no longer need
this call and kvm_vgic_map_resources() is again called only when first
running a VCPU.

Signed-off-by: Christoffer Dall <cdall@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
---
 virt/kvm/arm/vgic/vgic-its.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
index 89acaef..9aeaff0 100644
--- a/virt/kvm/arm/vgic/vgic-its.c
+++ b/virt/kvm/arm/vgic/vgic-its.c
@@ -2308,20 +2308,12 @@ static int vgic_its_restore_tables_v0(struct vgic_its *its)
 		goto out;
 
 	ret = vgic_its_restore_device_tables(its);
-
 out:
 	unlock_all_vcpus(kvm);
 	mutex_unlock(&its->its_lock);
 	mutex_unlock(&kvm->lock);
 
-	if (ret)
-		return ret;
-
-	/*
-	 * On restore path, MSI injections can happen before the
-	 * first VCPU run so let's complete the GIC init here.
-	 */
-	return kvm_vgic_map_resources(its->dev->kvm);
+	return ret;
 }
 
 static int vgic_its_commit_v0(struct vgic_its *its)
-- 
2.9.0
