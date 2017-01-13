From: aospan@netup.ru (Abylay Ospan)
Date: Fri, 13 Jan 2017 03:20:17 +0300
Subject: [PATCH] PCI: iproc: fix kernel crash if dev->of_node not defined
Message-ID: <1484266817-6725-1-git-send-email-aospan@netup.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pcie->dev->of_node not always defined (NULL) and can cause crash:

[   19.053195] Unable to handle kernel NULL pointer dereference at
virtual address 00000020
[<c0b0370c>] (of_n_addr_cells) from [<c06599c4>]
(iproc_pcie_setup+0x30c/0xce0)

this patch adds sanity check to prevent crash.

Signed-off-by: Abylay Ospan <aospan@netup.ru>
---
 drivers/pci/host/pcie-iproc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
index 3ebc025..f2836a9 100644
--- a/drivers/pci/host/pcie-iproc.c
+++ b/drivers/pci/host/pcie-iproc.c
@@ -952,6 +952,9 @@ static int pci_dma_range_parser_init(struct of_pci_range_parser *parser,
 	const int na = 3, ns = 2;
 	int rlen;
 
+	if (!node)
+		return -ENOENT;
+
 	parser->node = node;
 	parser->pna = of_n_addr_cells(node);
 	parser->np = parser->pna + na + ns;
-- 
2.7.4
