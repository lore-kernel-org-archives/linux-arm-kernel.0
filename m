From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 24 Jan 2017 14:22:48 +0100
Subject: [PATCH] KVM: arm/arm64: vgic: Add debugfs vgic-state file
In-Reply-To: <524751ae-8e17-f9a0-88c6-95d4614478af@arm.com>
References: <20170120103330.13858-1-christoffer.dall@linaro.org>
 <524751ae-8e17-f9a0-88c6-95d4614478af@arm.com>
Message-ID: <20170124132144.GQ15850@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 24, 2017 at 10:23:57AM +0000, Andre Przywara wrote:
> Hi,
> 
> so I gave this patch (adapted to live without the soft_pending state)
> some testing on my machines (Midway, Juno, GICv3 ITS h/w) and it seemed
> to work well - at least if one is nice and starts only one process
> accessing vgic-state (see below). I caught some IRQs red-handed and the
> output looked plausible.
> The only comment I have is that "MPIDR" is a misleading header name for
> that column. It's actually a union with the GICv2 targets field, which
> is a bitmask of the targetting VCPUs. So the output looks more like a
> bitmask and not an MPIDR on many machines. But that's just cosmetic.
> 
> Just discovered one thing: As soon as a second task is reading the file
> (with "while [ 1 ]; do cat vgic-state > /dev/null; done &" in the
> background, for instance), I get this splat on the host:
> 
> [60796.007461] Unable to handle kernel NULL pointer dereference at
> virtual address 00000008
> [60796.015538] pgd = ffff800974e30000
> [60796.018952] [00000008] *pgd=00000009f4d0a003[60796.023067] Internal
> error: Oops: 96000006 [#1] PREEMPT SMP
> [60796.028588] Modules linked in:
> [60796.031626] CPU: 3 PID: 5690 Comm: cat Tainted: G        W
> 4.9.0-00026-ge24503e-dirty #444
> [60796.040326] Hardware name: ARM Juno development board (r0) (DT)
> [60796.046190] task: ffff80097231ab00 task.stack: ffff800973894000
> [60796.052059] PC is at iter_next+0x18/0x80
> [60796.055946] LR is at debug_next+0x38/0x90
> [60796.059917] pc : [<ffff0000080c4b38>] lr : [<ffff0000080c4bd8>]

Turns out it wasn't a difficult fix (patch includes rebase on pending
change and making the naming slightly less cute).

The bugfix is in vgic_debug_stop which now checks if the supplied
pointer is an error pointer.


diff --git a/virt/kvm/arm/vgic/vgic-debug.c b/virt/kvm/arm/vgic/vgic-debug.c
index 76e8b11..ec466a6 100644
--- a/virt/kvm/arm/vgic/vgic-debug.c
+++ b/virt/kvm/arm/vgic/vgic-debug.c
@@ -70,14 +70,14 @@ static void iter_init(struct kvm *kvm, struct vgic_state_iter *iter,
 		iter_next(iter);
 }
 
-static bool the_end(struct vgic_state_iter *iter)
+static bool end_of_vgic(struct vgic_state_iter *iter)
 {
 	return iter->dist_id > 0 &&
 		iter->vcpu_id == iter->nr_cpus &&
 		(iter->intid - VGIC_NR_PRIVATE_IRQS) == iter->nr_spis;
 }
 
-static void *debug_start(struct seq_file *s, loff_t *pos)
+static void *vgic_debug_start(struct seq_file *s, loff_t *pos)
 {
 	struct kvm *kvm = (struct kvm *)s->private;
 	struct vgic_state_iter *iter;
@@ -98,30 +98,37 @@ static void *debug_start(struct seq_file *s, loff_t *pos)
 	iter_init(kvm, iter, *pos);
 	kvm->arch.vgic.iter = iter;
 
-	if (the_end(iter))
+	if (end_of_vgic(iter))
 		iter = NULL;
 out:
 	mutex_unlock(&kvm->lock);
 	return iter;
 }
 
-static void *debug_next(struct seq_file *s, void *v, loff_t *pos)
+static void *vgic_debug_next(struct seq_file *s, void *v, loff_t *pos)
 {
 	struct kvm *kvm = (struct kvm *)s->private;
 	struct vgic_state_iter *iter = kvm->arch.vgic.iter;
 
 	++*pos;
 	iter_next(iter);
-	if (the_end(iter))
+	if (end_of_vgic(iter))
 		iter = NULL;
 	return iter;
 }
 
-static void debug_stop(struct seq_file *s, void *v)
+static void vgic_debug_stop(struct seq_file *s, void *v)
 {
 	struct kvm *kvm = (struct kvm *)s->private;
 	struct vgic_state_iter *iter;
 
+	/*
+	 * If the seq file wasn't properly opened, there's nothing to clearn
+	 * up.
+	 */
+	if (IS_ERR(v))
+		return;
+
 	mutex_lock(&kvm->lock);
 	iter = kvm->arch.vgic.iter;
 	kfree(iter);
@@ -156,8 +163,8 @@ static void print_header(struct seq_file *s, struct vgic_irq *irq,
 	}
 
 	seq_printf(s, "\n");
-	seq_printf(s, "%s%2d TYP   ID TGT_ID PLSAEHL     HWID    MPIDR SRC PRI VCPU_ID\n", hdr, id);
-	seq_printf(s, "----------------------------------------------------------------\n");
+	seq_printf(s, "%s%2d TYP   ID TGT_ID PLAEHL     HWID   TARGET SRC PRI VCPU_ID\n", hdr, id);
+	seq_printf(s, "---------------------------------------------------------------\n");
 }
 
 static void print_irq_state(struct seq_file *s, struct vgic_irq *irq,
@@ -176,7 +183,7 @@ static void print_irq_state(struct seq_file *s, struct vgic_irq *irq,
 
 	seq_printf(s, "       %s %4d "
 		      "    %2d "
-		      "%d%d%d%d%d%d%d "
+		      "%d%d%d%d%d%d "
 		      "%8x "
 		      "%8x "
 		      " %2x "
@@ -185,9 +192,8 @@ static void print_irq_state(struct seq_file *s, struct vgic_irq *irq,
 		      "\n",
 			type, irq->intid,
 			(irq->target_vcpu) ? irq->target_vcpu->vcpu_id : -1,
-			irq->pending,
+			irq->pending_latch,
 			irq->line_level,
-			irq->soft_pending,
 			irq->active,
 			irq->enabled,
 			irq->hw,
@@ -200,7 +206,7 @@ static void print_irq_state(struct seq_file *s, struct vgic_irq *irq,
 
 }
 
-static int debug_show(struct seq_file *s, void *v)
+static int vgic_debug_show(struct seq_file *s, void *v)
 {
 	struct kvm *kvm = (struct kvm *)s->private;
 	struct vgic_state_iter *iter = (struct vgic_state_iter *)v;
@@ -229,17 +235,17 @@ static int debug_show(struct seq_file *s, void *v)
 	return 0;
 }
 
-static struct seq_operations debug_seq_ops = {
-	.start = debug_start,
-	.next  = debug_next,
-	.stop  = debug_stop,
-	.show  = debug_show
+static struct seq_operations vgic_debug_seq_ops = {
+	.start = vgic_debug_start,
+	.next  = vgic_debug_next,
+	.stop  = vgic_debug_stop,
+	.show  = vgic_debug_show
 };
 
 static int debug_open(struct inode *inode, struct file *file)
 {
 	int ret;
-	ret = seq_open(file, &debug_seq_ops);
+	ret = seq_open(file, &vgic_debug_seq_ops);
 	if (!ret) {
 		struct seq_file *seq;
 		/* seq_open will have modified file->private_data */


I'll send out a v2.

Thanks,
-Christoffer
