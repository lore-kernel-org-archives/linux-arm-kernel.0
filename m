From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 07 Oct 2015 08:58:34 +0200
Subject: [PATCH v2] mlxsw: fix warnings for big-endian 32-bit dma_addr_t
In-Reply-To: <1444200782.26237.8.camel@perches.com>
References: <30258520.VaA2vDyUiY@wuerfel>
 <1444200782.26237.8.camel@perches.com>
Message-ID: <9933338.DDyBa8BQum@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The recently added mlxsw driver produces warnings in ARM
allmodconfig:

drivers/net/ethernet/mellanox/mlxsw/pci.c: In function 'mlxsw_pci_cmd_exec':
drivers/net/ethernet/mellanox/mlxsw/pci.c:1585:59: warning: right shift count >= width of type [-Wshift-count-overflow]
linux/byteorder/big_endian.h:38:51: note: in definition of macro '__cpu_to_be32'
drivers/net/ethernet/mellanox/mlxsw/pci.c:76:2: note: in expansion of macro 'iowrite32be'

This uses upper_32_bits() to extract the bits while avoiding that warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Jiri Pirko <jiri@mellanox.com>
Fixes: eda6500a987a "mlxsw: Add PCI bus implementation"
---
I've kept Jiri's Ack despite having in effect a completely different
patch here, as the effect and the changelog is the same for practical purposes.
Hope that's ok.

diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index 462cea31ecbb..cef866c37648 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -1582,11 +1582,11 @@ static int mlxsw_pci_cmd_exec(void *bus_priv, u16 opcode, u8 opcode_mod,
 
 	if (in_mbox)
 		memcpy(mlxsw_pci->cmd.in_mbox.buf, in_mbox, in_mbox_size);
-	mlxsw_pci_write32(mlxsw_pci, CIR_IN_PARAM_HI, in_mapaddr >> 32);
-	mlxsw_pci_write32(mlxsw_pci, CIR_IN_PARAM_LO, in_mapaddr);
+	mlxsw_pci_write32(mlxsw_pci, CIR_IN_PARAM_HI, upper_32_bits(in_mapaddr));
+	mlxsw_pci_write32(mlxsw_pci, CIR_IN_PARAM_LO, lower_32_bits(in_mapaddr));
 
-	mlxsw_pci_write32(mlxsw_pci, CIR_OUT_PARAM_HI, out_mapaddr >> 32);
-	mlxsw_pci_write32(mlxsw_pci, CIR_OUT_PARAM_LO, out_mapaddr);
+	mlxsw_pci_write32(mlxsw_pci, CIR_OUT_PARAM_HI, upper_32_bits(out_mapaddr));
+	mlxsw_pci_write32(mlxsw_pci, CIR_OUT_PARAM_LO, lower_32_bits(out_mapaddr));
 
 	mlxsw_pci_write32(mlxsw_pci, CIR_IN_MODIFIER, in_mod);
 	mlxsw_pci_write32(mlxsw_pci, CIR_TOKEN, 0);
