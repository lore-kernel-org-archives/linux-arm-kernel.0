From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 07 Oct 2015 09:59:34 +0200
Subject: [PATCH] NTB: fix 32-bit compiler warning
Message-ID: <10263287.Brd9HPYQJD@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

resource_size_t may be 32-bit wide on some architectures, which causes
this warning when building the NTB code:

drivers/ntb/ntb_transport.c: In function 'ntb_transport_link_work':
drivers/ntb/ntb_transport.c:828:46: warning: right shift count >= width of type [-Wshift-count-overflow]

The warning is harmless but can be avoided by using the upper_32_bits()
macro.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: e26a5843f7f5 ("NTB: Split ntb_hw_intel and ntb_transport drivers")
---
Found while building ARM allmodconfig

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 6e3ee907d186..700f3ae833c2 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -825,10 +825,10 @@ static void ntb_transport_link_work(struct work_struct *work)
 			size = max_mw_size;
 
 		spad = MW0_SZ_HIGH + (i * 2);
-		ntb_peer_spad_write(ndev, spad, (u32)(size >> 32));
+		ntb_peer_spad_write(ndev, spad, upper_32_bits(size));
 
 		spad = MW0_SZ_LOW + (i * 2);
-		ntb_peer_spad_write(ndev, spad, (u32)size);
+		ntb_peer_spad_write(ndev, spad, lower_32_bits(size));
 	}
 
 	ntb_peer_spad_write(ndev, NUM_MWS, nt->mw_count);
