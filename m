From: alex.bennee@linaro.org (=?UTF-8?q?Alex=20Benn=C3=A9e?=)
Date: Wed, 11 Jan 2017 16:28:37 +0000
Subject: [kvm-unit-tests PATCH 2/6] lib/pci: fix BAR format strings
In-Reply-To: <20170111162841.15569-1-alex.bennee@linaro.org>
References: <20170111162841.15569-1-alex.bennee@linaro.org>
Message-ID: <20170111162841.15569-3-alex.bennee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using %x as a format string is not portable across 32/64 bit builds.
Use explicit PRIx32 format strings like the 64 bit version above.

Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>
---
 lib/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/pci.c b/lib/pci.c
index 6416191..597d8f2 100644
--- a/lib/pci.c
+++ b/lib/pci.c
@@ -67,7 +67,7 @@ bool pci_setup_msi(struct pci_dev *dev, uint64_t msi_addr, uint32_t msi_data)
 		pci_config_writel(addr, offset + PCI_MSI_DATA_32, msi_data);
 		printf("MSI: dev 0x%x init 32bit address: ", addr);
 	}
-	printf("addr=0x%lx, data=0x%x\n", msi_addr, msi_data);
+	printf("addr=0x%" PRIx64 ", data=0x%" PRIx32 "\n", msi_addr, msi_data);
 
 	msi_control |= PCI_MSI_FLAGS_ENABLE;
 	pci_config_writew(addr, offset + PCI_MSI_FLAGS, msi_control);
@@ -237,7 +237,7 @@ void pci_bar_print(struct pci_dev *dev, int bar_num)
 		printf("BAR#%d,%d [%" PRIx64 "-%" PRIx64 " ",
 		       bar_num, bar_num + 1, start, end);
 	} else {
-		printf("BAR#%d [%02x-%02x ",
+		printf("BAR#%d [%" PRIx32 "-%" PRIx32 " ",
 		       bar_num, (uint32_t)start, (uint32_t)end);
 	}
 
-- 
2.11.0
