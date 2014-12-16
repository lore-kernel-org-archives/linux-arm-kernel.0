From: david.lanzendoerfer@o2s.ch (David =?utf-8?q?Lanzend=C3=B6rfer?=)
Date: Tue, 16 Dec 2014 15:10:59 +0100
Subject: [PATCH 1/4] mmc: sunxi: Fix setup of last descriptor of dma transfer
In-Reply-To: <20141216140921.3036.14668.stgit@dizzy-6.o2s.ch>
References: <20141216140921.3036.14668.stgit@dizzy-6.o2s.ch>
Message-ID: <20141216141059.3036.53205.stgit@dizzy-6.o2s.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hans de Goede <hdegoede@redhat.com>

The last descriptor might be the first descriptor as well, so use masking to
add the LD (last descriptor) bit and drop the DIC (disable interrupt on
completion) bit rather then hard assignment as hard assigment will override
the FD (first descriptor) bit if there is only 1 descriptor.

Also set the ER (end of ring) bit and clear buf_addr_ptr2 on the last
descriptor, like the android kernel code does.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: David Lanzend?rfer <david.lanzendoerfer@o2s.ch>
Reported-by: ?? <lixiang@allwinnertech.com>
---
 drivers/mmc/host/sunxi-mmc.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 15cb8b7..1fe54a8 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -310,7 +310,9 @@ static void sunxi_mmc_init_idma_des(struct sunxi_mmc_host *host,
 	}
 
 	pdes[0].config |= SDXC_IDMAC_DES0_FD;
-	pdes[i - 1].config = SDXC_IDMAC_DES0_OWN | SDXC_IDMAC_DES0_LD;
+	pdes[i - 1].config |= SDXC_IDMAC_DES0_LD | SDXC_IDMAC_DES0_ER;
+	pdes[i - 1].config &= ~SDXC_IDMAC_DES0_DIC;
+	pdes[i - 1].buf_addr_ptr2 = 0;
 
 	/*
 	 * Avoid the io-store starting the idmac hitting io-mem before the
