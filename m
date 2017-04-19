From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Apr 2017 19:48:07 +0200
Subject: [PATCH] memory: atmel-ebi: mark PM ops as __maybe_unused
Message-ID: <20170419174824.4134087-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We get a harmless warning without CONFIG_PM:

drivers/memory/atmel-ebi.c:584:12: error: 'atmel_ebi_resume' defined but not used [-Werror=unused-function]

Marking the function as __maybe_unused does the right thing here
and drops it silently when unused.

Fixes: a483fb10e5ea ("memory: atmel-ebi: Add PM ops")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/memory/atmel-ebi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memory/atmel-ebi.c b/drivers/memory/atmel-ebi.c
index 35910f945bfa..99e644cda4d1 100644
--- a/drivers/memory/atmel-ebi.c
+++ b/drivers/memory/atmel-ebi.c
@@ -581,7 +581,7 @@ static int atmel_ebi_probe(struct platform_device *pdev)
 	return of_platform_populate(np, NULL, NULL, dev);
 }
 
-static int atmel_ebi_resume(struct device *dev)
+static __maybe_unused int atmel_ebi_resume(struct device *dev)
 {
 	struct atmel_ebi *ebi = dev_get_drvdata(dev);
 	struct atmel_ebi_dev *ebid;
-- 
2.9.0
