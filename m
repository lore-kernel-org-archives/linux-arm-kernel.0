From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Thu, 29 Nov 2018 12:03:40 +0300
Subject: [PATCH v6 2/2] PCI: amlogic: Add the Amlogic Meson PCIe
 controller driver
In-Reply-To: <1542876836-191355-3-git-send-email-hanjie.lin@amlogic.com>
Message-ID: <20181129090340.GO3073@unbuntlaptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yue,

url:    https://github.com/0day-ci/linux/commits/Hanjie-Lin/dt-bindings-PCI-meson-add-DT-bindings-for-Amlogic-Meson-PCIe-controller/20181122-225955
base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next

smatch warnings:
drivers/pci/controller/dwc/pci-meson.c:171 meson_pcie_get_mem_shared() error: passing non negative 6 to ERR_PTR

# https://github.com/0day-ci/linux/commit/c882cdc75e49b6de65cd3d95ebf688272af6b5f9
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout c882cdc75e49b6de65cd3d95ebf688272af6b5f9
vim +171 drivers/pci/controller/dwc/pci-meson.c

c882cdc75 Yue Wang 2018-11-22  160  
c882cdc75 Yue Wang 2018-11-22  161  static void __iomem *meson_pcie_get_mem_shared(struct platform_device *pdev,
c882cdc75 Yue Wang 2018-11-22  162  					       struct meson_pcie *mp,
c882cdc75 Yue Wang 2018-11-22  163  					       const char *id)
c882cdc75 Yue Wang 2018-11-22  164  {
c882cdc75 Yue Wang 2018-11-22  165  	struct device *dev = mp->pci.dev;
c882cdc75 Yue Wang 2018-11-22  166  	struct resource *res;
c882cdc75 Yue Wang 2018-11-22  167  
c882cdc75 Yue Wang 2018-11-22  168  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, id);
c882cdc75 Yue Wang 2018-11-22  169  	if (!res) {
c882cdc75 Yue Wang 2018-11-22  170  		dev_err(dev, "No REG resource %s\n", id);
c882cdc75 Yue Wang 2018-11-22 @171  		return ERR_PTR(ENXIO);
                                                               ^^^^^
                                                               -ENXIO

c882cdc75 Yue Wang 2018-11-22  172  	}
c882cdc75 Yue Wang 2018-11-22  173  
c882cdc75 Yue Wang 2018-11-22  174  	return devm_ioremap(dev, res->start, resource_size(res));
c882cdc75 Yue Wang 2018-11-22  175  }
c882cdc75 Yue Wang 2018-11-22  176  

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
