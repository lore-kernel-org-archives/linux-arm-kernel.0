From: vz@mleia.com (Vladimir Zapolskiy)
Date: Mon, 28 Sep 2015 19:51:18 +0300
Subject: [PATCH 1/4] memory: pl172: correct MPMC peripheral ID register bits
In-Reply-To: <1443459043-24144-1-git-send-email-vz@mleia.com>
References: <1443459043-24144-1-git-send-email-vz@mleia.com>
Message-ID: <1443459081-24199-1-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to PL172 TRM read of bits [7:6] of MPMCPeriphID3 is
undefined, so unmask them. Also the driver supports all currently
present revisions of PL172, this allows to alleviate requirements to
the revision version matched by the driver.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 drivers/memory/pl172.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/memory/pl172.c b/drivers/memory/pl172.c
index b2ef6072..95a4ad7 100644
--- a/drivers/memory/pl172.c
+++ b/drivers/memory/pl172.c
@@ -278,9 +278,10 @@ static int pl172_remove(struct amba_device *adev)
 }
 
 static const struct amba_id pl172_ids[] = {
+	/*  PrimeCell MPMC PL172, EMC found on NXP LPC18xx and LPC43xx */
 	{
-		.id	= 0x07341172,
-		.mask	= 0xffffffff,
+		.id	= 0x07041172,
+		.mask	= 0x3f0fffff,
 	},
 	{ 0, 0 },
 };
-- 
2.1.4
