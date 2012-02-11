From: hs1218.kang@samsung.com (Huisung Kang)
Date: Sat, 11 Feb 2012 11:53:31 +0900
Subject: [PATCH] ARM: SAMSUNG: Add locking sequence for nomal mode
Message-ID: <018201cce868$5693a060$03bae120$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dongsoo Ha <dsfine.ha@samsung.com>

ADC need to lock the data when read the data from register.
It is a complicated timing issue. Lock the data before start ADC and keep it.

Signed-off-by: Dongsoo Ha <dsfine.ha@samsung.com>
Signed-off-by: Huisung Kang <hs1218.kang@samsung.com>
---
 arch/arm/plat-samsung/adc.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-samsung/adc.c b/arch/arm/plat-samsung/adc.c index fccc644..c68d56f 100644
--- a/arch/arm/plat-samsung/adc.c
+++ b/arch/arm/plat-samsung/adc.c
@@ -224,11 +224,16 @@ int s3c_adc_read(struct s3c_adc_client *client, unsigned int ch)  {
 	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wake);
 	int ret;
+	unsigned long flags;
+
+	spin_lock_irqsave(&adc_dev->lock, flags);
 
 	client->convert_cb = s3c_convert_done;
 	client->wait = &wake;
 	client->result = -1;
 
+	spin_unlock_irqrestore(&adc_dev->lock, flags);
+
 	ret = s3c_adc_start(client, ch, 1);
 	if (ret < 0)
 		goto err;
--
1.7.1
