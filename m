From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Fri, 25 Oct 2013 17:06:24 +0800
Subject: [PATCH] ASoC: Samsung: I2S: fix return value check in i2s_alloc_dai()
Message-ID: <CAPgLHd8nzO9Q1fF1KsuJna_JVJDd+cimBC3ipd3nTP9Sz=fE9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

In case of error, the function platform_device_alloc() returns NULL
pointer not ERR_PTR(). The IS_ERR() test in the return value check
should be replaced with NULL test.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 sound/soc/samsung/i2s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index b302f3b..b721443 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -1073,7 +1073,7 @@ static struct i2s_dai *i2s_alloc_dai(struct platform_device *pdev, bool sec)
 		dev_set_drvdata(&i2s->pdev->dev, i2s);
 	} else {	/* Create a new platform_device for Secondary */
 		i2s->pdev = platform_device_alloc("samsung-i2s-sec", -1);
-		if (IS_ERR(i2s->pdev))
+		if (!i2s->pdev)
 			return NULL;
 
 		i2s->pdev->dev.parent = &pdev->dev;
