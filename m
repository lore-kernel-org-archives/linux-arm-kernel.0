From: eric.auger@linaro.org (Eric Auger)
Date: Wed, 11 Feb 2015 09:20:56 +0100
Subject: [RFC v2 3/4] KVM: arm: vgic: add forwarded irq rbtree lock
In-Reply-To: <1423642857-24240-1-git-send-email-eric.auger@linaro.org>
References: <1423642857-24240-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1423642857-24240-4-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a lock related to the rb tree manipulation. The rb tree can be
searched in one thread (irqfd handler for instance) and map/unmap
may happen in another.

Signed-off-by: Eric Auger <eric.auger@linaro.org>

---

v2 -> v3:
re-arrange lock sequence in vgic_map_phys_irq
---
 include/kvm/arm_vgic.h |  1 +
 virt/kvm/arm/vgic.c    | 56 ++++++++++++++++++++++++++++++++++++--------------
 2 files changed, 42 insertions(+), 15 deletions(-)

diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
index 1a49108..ad7229b 100644
--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -220,6 +220,7 @@ struct vgic_dist {
 	unsigned long		*irq_pending_on_cpu;
 
 	struct rb_root		irq_phys_map;
+	spinlock_t			rb_tree_lock;
 #endif
 };
 
diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index 433ecba..dd72ca2 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -1756,9 +1756,22 @@ static struct rb_root *vgic_get_irq_phys_map(struct kvm_vcpu *vcpu,
 
 int vgic_map_phys_irq(struct kvm_vcpu *vcpu, int virt_irq, int phys_irq)
 {
-	struct rb_root *root = vgic_get_irq_phys_map(vcpu, virt_irq);
-	struct rb_node **new = &root->rb_node, *parent = NULL;
+	struct rb_root *root;
+	struct rb_node **new, *parent = NULL;
 	struct irq_phys_map *new_map;
+	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
+
+	root = vgic_get_irq_phys_map(vcpu, virt_irq);
+	new = &root->rb_node;
+
+	new_map = kzalloc(sizeof(*new_map), GFP_KERNEL);
+	if (!new_map)
+		return -ENOMEM;
+
+	new_map->virt_irq = virt_irq;
+	new_map->phys_irq = phys_irq;
+
+	spin_lock(&dist->rb_tree_lock);
 
 	/* Boilerplate rb_tree code */
 	while (*new) {
@@ -1770,19 +1783,16 @@ int vgic_map_phys_irq(struct kvm_vcpu *vcpu, int virt_irq, int phys_irq)
 			new = &(*new)->rb_left;
 		else if (this->virt_irq > virt_irq)
 			new = &(*new)->rb_right;
-		else
+		else {
+			kfree(new_map);
+			spin_unlock(&dist->rb_tree_lock);
 			return -EEXIST;
+		}
 	}
 
-	new_map = kzalloc(sizeof(*new_map), GFP_KERNEL);
-	if (!new_map)
-		return -ENOMEM;
-
-	new_map->virt_irq = virt_irq;
-	new_map->phys_irq = phys_irq;
-
 	rb_link_node(&new_map->node, parent, new);
 	rb_insert_color(&new_map->node, root);
+	spin_unlock(&dist->rb_tree_lock);
 
 	return 0;
 }
@@ -1811,24 +1821,39 @@ static struct irq_phys_map *vgic_irq_map_search(struct kvm_vcpu *vcpu,
 
 int vgic_get_phys_irq(struct kvm_vcpu *vcpu, int virt_irq)
 {
-	struct irq_phys_map *map = vgic_irq_map_search(vcpu, virt_irq);
+	struct irq_phys_map *map;
+	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
+	int ret;
+
+	spin_lock(&dist->rb_tree_lock);
+	map = vgic_irq_map_search(vcpu, virt_irq);
 
 	if (map)
-		return map->phys_irq;
+		ret = map->phys_irq;
+	else
+		ret =  -ENOENT;
+
+	spin_unlock(&dist->rb_tree_lock);
+	return ret;
 
-	return -ENOENT;
 }
 
 int vgic_unmap_phys_irq(struct kvm_vcpu *vcpu, int virt_irq, int phys_irq)
 {
-	struct irq_phys_map *map = vgic_irq_map_search(vcpu, virt_irq);
+	struct irq_phys_map *map;
+	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
+
+	spin_lock(&dist->rb_tree_lock);
+
+	map = vgic_irq_map_search(vcpu, virt_irq);
 
 	if (map && map->phys_irq == phys_irq) {
 		rb_erase(&map->node, vgic_get_irq_phys_map(vcpu, virt_irq));
 		kfree(map);
+		spin_unlock(&dist->rb_tree_lock);
 		return 0;
 	}
-
+	spin_unlock(&dist->rb_tree_lock);
 	return -ENOENT;
 }
 
@@ -2071,6 +2096,7 @@ int kvm_vgic_create(struct kvm *kvm)
 	ret = 0;
 
 	spin_lock_init(&kvm->arch.vgic.lock);
+	spin_lock_init(&kvm->arch.vgic.rb_tree_lock);
 	kvm->arch.vgic.in_kernel = true;
 	kvm->arch.vgic.vctrl_base = vgic->vctrl_base;
 	kvm->arch.vgic.vgic_dist_base = VGIC_ADDR_UNDEF;
-- 
1.9.1
