From: eric.dumazet@gmail.com (Eric Dumazet)
Date: Tue, 15 Aug 2017 06:58:54 -0700
Subject: [PATCH v11 0/5] Add new PCI_DEV_FLAGS_NO_RELAXED_ORDERING flag
In-Reply-To: <20170814.221512.1430356980828045690.davem@davemloft.net>
References: <1502767407-6812-1-git-send-email-dingtianhong@huawei.com>
 <20170814.221512.1430356980828045690.davem@davemloft.net>
Message-ID: <1502805534.4936.73.camel@edumazet-glaptop3.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2017-08-14 at 22:15 -0700, David Miller wrote:
> From: Ding Tianhong <dingtianhong@huawei.com>
> Date: Tue, 15 Aug 2017 11:23:22 +0800
> 
> > Some devices have problems with Transaction Layer Packets with the Relaxed
> > Ordering Attribute set.  This patch set adds a new PCIe Device Flag,
> > PCI_DEV_FLAGS_NO_RELAXED_ORDERING, a set of PCI Quirks to catch some known
> > devices with Relaxed Ordering issues, and a use of this new flag by the
> > cxgb4 driver to avoid using Relaxed Ordering with problematic Root Complex
> > Ports.
>  ...
> 
> Series applied, thanks.

I got a NULL deref in pci_find_pcie_root_port()

Was it expected ?

This local hack seems to fix the issue.

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index af0cc3456dc1b48b1325c06c5edd2ca8cc22a640..cfd8eb5a3d0ba8347d44952ffab28d9c761044d3 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -522,7 +522,7 @@ struct pci_dev *pci_find_pcie_root_port(struct pci_dev *dev)
                bridge = pci_upstream_bridge(bridge);
        }
 
-       if (pci_pcie_type(highest_pcie_bridge) != PCI_EXP_TYPE_ROOT_PORT)
+       if (highest_pcie_bridge && pci_pcie_type(highest_pcie_bridge) != PCI_EXP_TYPE_ROOT_PORT)
                return NULL;
 
        return highest_pcie_bridge;
