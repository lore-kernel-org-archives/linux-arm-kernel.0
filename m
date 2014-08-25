From: eric.auger@linaro.org (Eric Auger)
Date: Mon, 25 Aug 2014 15:27:37 +0200
Subject: [RFC 2/9] KVM: ARM: VGIC: add forwarded irq rbtree lock
In-Reply-To: <1408973264-30384-1-git-send-email-eric.auger@linaro.org>
References: <1408973264-30384-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1408973264-30384-3-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add a lock related to the rb tree manipulation. The rb tree can be
searched in one thread (irqfd handler for instance) and map/unmap
happen in another.

Signed-off-by: Eric Auger <eric.auger@linaro.org>
---
 virt/kvm/arm/vgic.c | 46 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 37 insertions(+), 9 deletions(-)

diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index 195c10c..3311e0a 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -1628,9 +1628,15 @@ static struct rb_root *vgic_get_irq_phys_map(struct kvm_vcpu *vcpu,
 
 int vgic_map_phys_irq(struct kvm_vcpu *vcpu, int virt_irq, int phys_irq)
 {
-	struct rb_root *root = vgic_get_irq_phys_map(vcpu, virt_irq);
-	struct rb_node **new = &root->rb_node, *parent = NULL;
+	struct rb_root *root;
+	struct rb_node **new, *parent = NULL;
 	struct irq_phys_map *new_map;
+	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
+
+	spin_lock(&dist->rb_tree_lock);
+
+	root = vgic_get_irq_phys_map(vcpu, virt_irq);
+	new = &root->rb_node;
 
 	/* Boilerplate rb_tree code */
 	while (*new) {
@@ -1642,13 +1648,17 @@ int vgic_map_phys_irq(struct kvm_vcpu *vcpu, int virt_irq, int phys_irq)
 			new = &(*new)->rb_left;
 		else if (this->virt_irq > virt_irq)
 			new = &(*new)->rb_right;
-		else
+		else {
+			spin_unlock(&dist->rb_tree_lock);
 			return -EEXIST;
+		}
 	}
 
 	new_map = kzalloc(sizeof(*new_map), GFP_KERNEL);
-	if (!new_map)
+	if (!new_map) {
+		spin_unlock(&dist->rb_tree_lock);
 		return -ENOMEM;
+	}
 
 	new_map->virt_irq = virt_irq;
 	new_map->phys_irq = phys_irq;
@@ -1656,6 +1666,8 @@ int vgic_map_phys_irq(struct kvm_vcpu *vcpu, int virt_irq, int phys_irq)
 	rb_link_node(&new_map->node, parent, new);
 	rb_insert_color(&new_map->node, root);
 
+	spin_unlock(&dist->rb_tree_lock);
+
 	return 0;
 }
 
@@ -1683,24 +1695,39 @@ static struct irq_phys_map *vgic_irq_map_search(struct kvm_vcpu *vcpu,
 
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
 
@@ -1896,6 +1923,7 @@ int kvm_vgic_create(struct kvm *kvm)
 	}
 
 	spin_lock_init(&kvm->arch.vgic.lock);
+	spin_lock_init(&kvm->arch.vgic.rb_tree_lock);
 	kvm->arch.vgic.in_kernel = true;
 	kvm->arch.vgic.vctrl_base = vgic->vctrl_base;
 	kvm->arch.vgic.vgic_dist_base = VGIC_ADDR_UNDEF;
-- 
1.9.1
