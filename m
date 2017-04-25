From: andre.przywara@arm.com (Andre Przywara)
Date: Tue, 25 Apr 2017 15:39:21 +0100
Subject: [kvmtool PATCH v10 04/15] MSI-X: update GSI routing after changed
 MSI-X configuration
In-Reply-To: <20170425143932.17235-1-andre.przywara@arm.com>
References: <20170425143932.17235-1-andre.przywara@arm.com>
Message-ID: <20170425143932.17235-5-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When we set up GSI routing to map MSIs to KVM's GSI numbers, we
write the current device's MSI setup into the kernel routing table.
However the device driver in the guest can use PCI configuration space
accesses to change the MSI configuration (address and/or payload data).
Whenever this happens after we have setup the routing table already,
we must amend the previously sent data.
So when MSI-X PCI config space accesses write address or payload,
find the associated GSI number and the matching routing table entry
and update the kernel routing table (only if the data has changed).

This fixes vhost-net, where the queue's IRQFD was setup before the
MSI vectors.

To avoid issues, we ignore writes to the PBA region. The spec says:
"Software should never write, and should only read Pending Bits.
If software writes to Pending Bits, the result is undefined."

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 include/kvm/irq.h |  1 +
 irq.c             | 34 ++++++++++++++++++++++++++++++++++
 virtio/pci.c      | 55 +++++++++++++++++++++++++++++++++++++++++++++----------
 3 files changed, 80 insertions(+), 10 deletions(-)

diff --git a/include/kvm/irq.h b/include/kvm/irq.h
index bb71521..f35eb7e 100644
--- a/include/kvm/irq.h
+++ b/include/kvm/irq.h
@@ -21,5 +21,6 @@ int irq__exit(struct kvm *kvm);
 
 int irq__allocate_routing_entry(void);
 int irq__add_msix_route(struct kvm *kvm, struct msi_msg *msg);
+void irq__update_msix_route(struct kvm *kvm, u32 gsi, struct msi_msg *msg);
 
 #endif
diff --git a/irq.c b/irq.c
index a742aa2..6ec71c3 100644
--- a/irq.c
+++ b/irq.c
@@ -93,6 +93,40 @@ int irq__add_msix_route(struct kvm *kvm, struct msi_msg *msg)
 	return next_gsi++;
 }
 
+static bool update_data(u32 *ptr, u32 newdata)
+{
+	if (*ptr == newdata)
+		return false;
+
+	*ptr = newdata;
+	return true;
+}
+
+void irq__update_msix_route(struct kvm *kvm, u32 gsi, struct msi_msg *msg)
+{
+	struct kvm_irq_routing_msi *entry;
+	unsigned int i;
+	bool changed;
+
+	for (i = 0; i < irq_routing->nr; i++)
+		if (gsi == irq_routing->entries[i].gsi)
+			break;
+	if (i == irq_routing->nr)
+		return;
+
+	entry = &irq_routing->entries[i].u.msi;
+
+	changed  = update_data(&entry->address_hi, msg->address_hi);
+	changed |= update_data(&entry->address_lo, msg->address_lo);
+	changed |= update_data(&entry->data, msg->data);
+
+	if (!changed)
+		return;
+
+	if (ioctl(kvm->vm_fd, KVM_SET_GSI_ROUTING, irq_routing) == -1)
+		die_perror("KVM_SET_GSI_ROUTING");
+}
+
 int __attribute__((weak)) irq__exit(struct kvm *kvm)
 {
 	free(irq_routing);
diff --git a/virtio/pci.c b/virtio/pci.c
index 072e5b7..e9f36c7 100644
--- a/virtio/pci.c
+++ b/virtio/pci.c
@@ -152,6 +152,30 @@ static bool virtio_pci__io_in(struct ioport *ioport, struct kvm_cpu *vcpu, u16 p
 	return ret;
 }
 
+static void update_msix_map(struct virtio_pci *vpci,
+			    struct msix_table *msix_entry, u32 vecnum)
+{
+	u32 gsi, i;
+
+	/* Find the GSI number used for that vector */
+	if (vecnum == vpci->config_vector) {
+		gsi = vpci->config_gsi;
+	} else {
+		for (i = 0; i < VIRTIO_PCI_MAX_VQ; i++)
+			if (vpci->vq_vector[i] == vecnum)
+				break;
+		if (i == VIRTIO_PCI_MAX_VQ)
+			return;
+		gsi = vpci->gsis[i];
+	}
+
+	if (gsi == 0)
+		return;
+
+	msix_entry = &msix_entry[vecnum];
+	irq__update_msix_route(vpci->kvm, gsi, &msix_entry->msg);
+}
+
 static bool virtio_pci__specific_io_out(struct kvm *kvm, struct virtio_device *vdev, u16 port,
 					void *data, int size, int offset)
 {
@@ -259,21 +283,32 @@ static void virtio_pci__msix_mmio_callback(struct kvm_cpu *vcpu,
 					   u8 is_write, void *ptr)
 {
 	struct virtio_pci *vpci = ptr;
-	void *table;
-	u32 offset;
+	struct msix_table *table;
+	int vecnum;
+	size_t offset;
 
 	if (addr > vpci->msix_io_block + PCI_IO_SIZE) {
-		table	= &vpci->msix_pba;
-		offset	= vpci->msix_io_block + PCI_IO_SIZE;
+		if (is_write)
+			return;
+		table  = (struct msix_table *)&vpci->msix_pba;
+		offset = addr - (vpci->msix_io_block + PCI_IO_SIZE);
 	} else {
-		table	= &vpci->msix_table;
-		offset	= vpci->msix_io_block;
+		table  = vpci->msix_table;
+		offset = addr - vpci->msix_io_block;
 	}
+	vecnum = offset / sizeof(struct msix_table);
+	offset = offset % sizeof(struct msix_table);
+
+	if (!is_write) {
+		memcpy(data, (void *)&table[vecnum] + offset, len);
+		return;
+	}
+
+	memcpy((void *)&table[vecnum] + offset, data, len);
 
-	if (is_write)
-		memcpy(table + addr - offset, data, len);
-	else
-		memcpy(data, table + addr - offset, len);
+	/* Did we just update the address or payload? */
+	if (offset < offsetof(struct msix_table, ctrl))
+		update_msix_map(vpci, table, vecnum);
 }
 
 static void virtio_pci__signal_msi(struct kvm *kvm, struct virtio_pci *vpci, int vec)
-- 
2.9.0
