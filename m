From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 12 Mar 2013 14:47:14 +1100
Subject: linux-next: manual merge of the akpm tree with the arm-soc tree
Message-ID: <20130312144714.39749c5b0bd1aea14c4d2ff8@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

Today's linux-next merge of the akpm tree got a conflict in
drivers/rtc/rtc-mv.c between commit 89c58c198b25 ("rtc: rtc-mv: Add
support for clk to avoid lockups") from the arm-soc tree and commit "rtc:
rtc-mv: use devm_rtc_device_register()" from the akpm tree.

I fixed it up (I think - see below) and can carry the fix as necessary
(no action is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc drivers/rtc/rtc-mv.c
index f378e17,1ee8551..0000000
--- a/drivers/rtc/rtc-mv.c
+++ b/drivers/rtc/rtc-mv.c
@@@ -272,16 -262,15 +272,17 @@@ static int __init mv_rtc_probe(struct p
  
  	if (pdata->irq >= 0) {
  		device_init_wakeup(&pdev->dev, 1);
- 		pdata->rtc = rtc_device_register(pdev->name, &pdev->dev,
+ 		pdata->rtc = devm_rtc_device_register(&pdev->dev, pdev->name,
  						 &mv_rtc_alarm_ops,
  						 THIS_MODULE);
- 	} else
- 		pdata->rtc = rtc_device_register(pdev->name, &pdev->dev,
+ 	} else {
+ 		pdata->rtc = devm_rtc_device_register(&pdev->dev, pdev->name,
  						 &mv_rtc_ops, THIS_MODULE);
+ 	}
 -	if (IS_ERR(pdata->rtc))
 -		return PTR_ERR(pdata->rtc);
 +	if (IS_ERR(pdata->rtc)) {
 +		ret = PTR_ERR(pdata->rtc);
 +		goto out;
 +	}
  
  	if (pdata->irq >= 0) {
  		writel(0, pdata->ioaddr + RTC_ALARM_INTERRUPT_MASK_REG_OFFS);
@@@ -308,10 -292,6 +309,9 @@@ static int __exit mv_rtc_remove(struct 
  	if (pdata->irq >= 0)
  		device_init_wakeup(&pdev->dev, 0);
  
- 	rtc_device_unregister(pdata->rtc);
 +	if (!IS_ERR(pdata->clk))
 +		clk_disable_unprepare(pdata->clk);
 +
  	return 0;
  }
  
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130312/9e83b008/attachment-0001.sig>
