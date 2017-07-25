From: ada@thorsis.com (Alexander Dahl)
Date: Tue, 25 Jul 2017 14:00:22 +0200
Subject: [PATCH 1/3] memory: atmel-ebi: Fix smc timing return value evaluation
In-Reply-To: <1500984024-26403-1-git-send-email-ada@thorsis.com>
References: <1500984024-26403-1-git-send-email-ada@thorsis.com>
Message-ID: <1500984024-26403-2-git-send-email-ada@thorsis.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Setting optional EBI/SMC properties through device tree always fails due
to wrong evaluation of the return value of
atmel_ebi_xslate_smc_timings().

If you put some of those properties in your dts file, but not
'atmel,smc-tdf-ns' the local variable 'required' in
atmel_ebi_xslate_smc_timings() stays on 'false' after the first 'if'
block. This leads to setting 'ret' to -EINVAL in the first run of the
following 'for' loop which is then the return value of this function.

However if you set 'atmel,smc-tdf-ns' in the dts file and everything in
atmel_ebi_xslate_smc_timings() works well, it returns the content of
'required' which is 'true' then.

So the function atmel_ebi_xslate_smc_timings() always returns non-zero
which lets its call in atmel_ebi_xslate_smc_config() always fail and
thus returning -EINVAL, so the EBI configuration for this node fails.

Judging from the following code evaluating the local 'required' variable
in atmel_ebi_xslate_smc_config() and the call of caps->xlate_config in
atmel_ebi_dev_setup() it's probably right to only let the call fail if a
negative error code is returned.

Signed-off-by: Alexander Dahl <ada@thorsis.com>
---
 drivers/memory/atmel-ebi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memory/atmel-ebi.c b/drivers/memory/atmel-ebi.c
index 99e644c..1cf34d2 100644
--- a/drivers/memory/atmel-ebi.c
+++ b/drivers/memory/atmel-ebi.c
@@ -263,7 +263,7 @@ static int atmel_ebi_xslate_smc_config(struct atmel_ebi_dev *ebid,
 	}
 
 	ret = atmel_ebi_xslate_smc_timings(ebid, np, &conf->smcconf);
-	if (ret)
+	if (ret < 0)
 		return -EINVAL;
 
 	if ((ret > 0 && !required) || (!ret && required)) {
-- 
2.1.4
