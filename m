From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 25 Sep 2014 09:06:01 +0200
Subject: [PATCH v2 02/22] PCI/MSI: Remove useless bus->msi assignment
In-Reply-To: <1411614872-4009-3-git-send-email-wangyijing@huawei.com>
References: <1411614872-4009-1-git-send-email-wangyijing@huawei.com>
 <1411614872-4009-3-git-send-email-wangyijing@huawei.com>
Message-ID: <20140925070601.GF12423@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 25, 2014 at 11:14:12AM +0800, Yijing Wang wrote:
> Currently, PCI drivers will initialize bus->msi in
> pcibios_add_bus(). pcibios_add_bus() will be called
> in every pci bus initialization. So the bus->msi
> assignment in pci_alloc_child_bus() is useless.

I think this should be the other way around. The default should be to
inherit bus->msi from the parent. That way drivers don't typically have
to do it, yet they can still opt to override it if they need to.

For Tegra for example I think it would work if we assigned the MSI chip
to the root bus (in tegra_pcie_scan_bus()) and then have it propagated
to child busses in pci_alloc_child_bus() so that tegra_pcie_add_bus()
can be removed altogether.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140925/19df7d44/attachment.sig>
