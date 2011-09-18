From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Sun, 18 Sep 2011 22:45:46 +0200
Subject: [PATCH 4/7] s3c-adc: Fix mux bit modification in s3c_adc_select
In-Reply-To: <201109182241.48858.heiko@sntech.de>
References: <201109182241.48858.heiko@sntech.de>
Message-ID: <201109182245.46943.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mux bits in the adccon register should be cleared only
if muxing is really done in ADCCON and not another register.

This patch introduces a conditional for this.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/plat-samsung/adc.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-samsung/adc.c b/arch/arm/plat-samsung/adc.c
index e3456d6..05030ca 100644
--- a/arch/arm/plat-samsung/adc.c
+++ b/arch/arm/plat-samsung/adc.c
@@ -121,7 +121,8 @@ static inline void s3c_adc_select(struct adc_device *adc,
 
 	client->select_cb(client, 1);
 
-	con &= ~S3C2410_ADCCON_MUXMASK;
+	if (cpu & S3C_ADC_QUIRK_MUXADCCON)
+		con &= ~S3C2410_ADCCON_MUXMASK;
 	con &= ~S3C2410_ADCCON_STDBM;
 	con &= ~S3C2410_ADCCON_STARTMASK;
 
-- 
1.7.2.3
