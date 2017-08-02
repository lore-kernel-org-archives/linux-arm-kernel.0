From: leedom@chelsio.com (Casey Leedom)
Date: Wed, 2 Aug 2017 17:53:52 +0000
Subject: [PATCH v7 2/3] PCI: Enable PCIe Relaxed Ordering if supported
In-Reply-To: <14218972-553d-eb60-0207-460ac7f4b064@huawei.com>
References: <1499955692-26556-1-git-send-email-dingtianhong@huawei.com>
 <1499955692-26556-3-git-send-email-dingtianhong@huawei.com>
 <e496ff1d-b836-ebef-fdf7-76273aaaaef6@codeaurora.org>
 <0260e398-bd8e-6615-6d5c-1f7c07b6fc09@huawei.com>
 <67be791f-e0cf-8284-9229-17174dc741ef@codeaurora.org>
 <5f9b8bfb-41a8-a17c-6fea-581aec1d5573@huawei.com>
 <20170724090516.2e0f0d2a@w520.home>
 <MWHPR12MB1600065968964410EDFBDA3BC8B90@MWHPR12MB1600.namprd12.prod.outlook.com>
 <75213fca-4522-2297-3cb8-338e643d3552@huawei.com>
 <CAKgT0UcqdRCwDDxD=22Q_jLuqz8KVHwH1-V45Aq-1WzQw=agcA@mail.gmail.com>,
 <14218972-553d-eb60-0207-460ac7f4b064@huawei.com>
Message-ID: <MWHPR12MB1600A6986E4AD13D302F2DC9C8B00@MWHPR12MB1600.namprd12.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? Okay, here you go.? As you can tell, it's almost a trivial copy of the
cxgb4 patch.
?
? By the way, I realized that we have yet another hole which is likely not
to be fixable.? If we're dealing with a problematic Root Complex, and we
instantiate Virtual Functions and attach them to a Virtual Machine along
with an NVMe device which can deal with Relaxed Ordering TLPs, the VF driver
in the VM will be able to tell that it shouldn't attempt to send RO TLPs to
the RC because it will see the state of its own PCIe Capability Device
Control[Relaxed Ordering Enable] (a copy of the setting in the VF's
corresponding PF), but it won't be able to change that and send non-RO TLPs
to the RC, and RO TLPs to the NVMe device.? Oh well.

? I sure wish that the Intel guys would pop up with a hidden register change
for these problematic Intel RCs that perform poorly with RO TLPs.? Their
silence has been frustrating.

Casey

----------

cxgb4vf Ethernet driver now queries PCIe configuration space to determine if
it can send TLPs to it with the Relaxed Ordering Attribute set.

diff --git a/drivers/net/ethernet/chelsio/cxgb4vf/adapter.h b/drivers/net/ethernet/chelsio/cxgb4vf/adapter.h
index 109bc63..08c6ddb 100644
--- a/drivers/net/ethernet/chelsio/cxgb4vf/adapter.h
+++ b/drivers/net/ethernet/chelsio/cxgb4vf/adapter.h
@@ -408,6 +408,7 @@ enum { /* adapter flags */
 	USING_MSI          = (1UL << 1),
 	USING_MSIX         = (1UL << 2),
 	QUEUES_BOUND       = (1UL << 3),
+	ROOT_NO_RELAXED_ORDERING = (1UL << 4),
 };
 
 /*
diff --git a/drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c b/drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c
index ac7a150..59e7639 100644
--- a/drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c
@@ -2888,6 +2888,24 @@ static int cxgb4vf_pci_probe(struct pci_dev *pdev,
 	 */
 	adapter->name = pci_name(pdev);
 	adapter->msg_enable = DFLT_MSG_ENABLE;
+
+	/* If possible, we use PCIe Relaxed Ordering Attribute to deliver
+	 * Ingress Packet Data to Free List Buffers in order to allow for
+	 * chipset performance optimizations between the Root Complex and
+	 * Memory Controllers.  (Messages to the associated Ingress Queue
+	 * notifying new Packet Placement in the Free Lists Buffers will be
+	 * send without the Relaxed Ordering Attribute thus guaranteeing that
+	 * all preceding PCIe Transaction Layer Packets will be processed
+	 * first.)  But some Root Complexes have various issues with Upstream
+	 * Transaction Layer Packets with the Relaxed Ordering Attribute set.
+	 * The PCIe devices which under the Root Complexes will be cleared the
+	 * Relaxed Ordering bit in the configuration space, So we check our
+	 * PCIe configuration space to see if it's flagged with advice against
+	 * using Relaxed Ordering.
+	 */
+	if (!pcie_relaxed_ordering_supported(pdev))
+		adapter->flags |= ROOT_NO_RELAXED_ORDERING;
+
 	err = adap_init0(adapter);
 	if (err)
 		goto err_unmap_bar;
diff --git a/drivers/net/ethernet/chelsio/cxgb4vf/sge.c b/drivers/net/ethernet/chelsio/cxgb4vf/sge.c
index e37dde2..05498e7 100644
--- a/drivers/net/ethernet/chelsio/cxgb4vf/sge.c
+++ b/drivers/net/ethernet/chelsio/cxgb4vf/sge.c
@@ -2205,6 +2205,7 @@ int t4vf_sge_alloc_rxq(struct adapter *adapter, struct sge_rspq *rspq,
 	struct port_info *pi = netdev_priv(dev);
 	struct fw_iq_cmd cmd, rpl;
 	int ret, iqandst, flsz = 0;
+	int relaxed = !(adapter->flags & ROOT_NO_RELAXED_ORDERING);
 
 	/*
 	 * If we're using MSI interrupts and we're not initializing the
@@ -2300,6 +2301,8 @@ int t4vf_sge_alloc_rxq(struct adapter *adapter, struct sge_rspq *rspq,
 			cpu_to_be32(
 				FW_IQ_CMD_FL0HOSTFCMODE_V(SGE_HOSTFCMODE_NONE) |
 				FW_IQ_CMD_FL0PACKEN_F |
+				FW_IQ_CMD_FL0FETCHRO_V(relaxed) |
+				FW_IQ_CMD_FL0DATARO_V(relaxed) |
 				FW_IQ_CMD_FL0PADEN_F);
 
 		/* In T6, for egress queue type FL there is internal overhead
