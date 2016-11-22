From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 22 Nov 2016 15:17:52 +0100
Subject: [PATCH 2/2] PCI: iproc: avoid maybe-uninitialized warning
In-Reply-To: <20161122141844.1655574-1-arnd@arndb.de>
References: <20161122141844.1655574-1-arnd@arndb.de>
Message-ID: <20161122141844.1655574-2-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gcc notices that calling iproc_pcie_setup_ib with ib->nr_regions==0
would result in an uninitialized return value:

drivers/pci/host/pcie-iproc.c: In function 'iproc_pcie_setup_ib':
drivers/pci/host/pcie-iproc.c:894:6: error: 'ret' may be used uninitialized in this function [-Werror=maybe-uninitialized]

This can't really happen, but the correct behavior of the function
is probably to return -EINVAL if it ever did.

Fixes: 4213e15c364e ("PCI: iproc: Make outbound mapping code more generic")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pci/host/pcie-iproc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
index 857ff5198317..0359569c8d78 100644
--- a/drivers/pci/host/pcie-iproc.c
+++ b/drivers/pci/host/pcie-iproc.c
@@ -936,6 +936,7 @@ static int iproc_pcie_setup_ib(struct iproc_pcie *pcie,
 
 		}
 	}
+	ret = -EINVAL;
 err_ib:
 	dev_err(dev, "unable to configure inbound mapping\n");
 	dev_err(dev, "axi %pap, pci %pap, res size %pap\n",
-- 
2.9.0
