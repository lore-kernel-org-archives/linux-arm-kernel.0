From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Wed, 29 Feb 2012 17:21:27 +1100
Subject: linux-next: manual merge of the akpm tree with the arm-soc tree
Message-ID: <20120229172127.7b430cecc7ab2350d4e4a1b8@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

Today's linux-next merge of the akpm tree got a conflict in
drivers/rtc/rtc-sa1100.c between commit 3888c09074db ("rtc: sa1100:
declare irq in resource") from the arm-soc tree and commit "drivers/rtc:
remove IRQF_DISABLED" from the akpm tree.

I fixed it up (see below) and can carry the fix as necessary.
-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc drivers/rtc/rtc-sa1100.c
index c105774,e70b4e6..0000000
--- a/drivers/rtc/rtc-sa1100.c
+++ b/drivers/rtc/rtc-sa1100.c
@@@ -102,23 -156,20 +102,23 @@@ static irqreturn_t sa1100_rtc_interrupt
  
  static int sa1100_rtc_open(struct device *dev)
  {
 +	struct sa1100_rtc *info = dev_get_drvdata(dev);
 +	struct rtc_device *rtc = info->rtc;
  	int ret;
 -	struct platform_device *plat_dev = to_platform_device(dev);
 -	struct rtc_device *rtc = platform_get_drvdata(plat_dev);
  
 -	ret = request_irq(IRQ_RTC1Hz, sa1100_rtc_interrupt, 0,
 +	ret = clk_prepare_enable(info->clk);
 +	if (ret)
 +		goto fail_clk;
- 	ret = request_irq(info->irq_1hz, sa1100_rtc_interrupt, IRQF_DISABLED,
++	ret = request_irq(info->irq_1hz, sa1100_rtc_interrupt, 0,
  		"rtc 1Hz", dev);
  	if (ret) {
 -		dev_err(dev, "IRQ %d already in use.\n", IRQ_RTC1Hz);
 +		dev_err(dev, "IRQ %d already in use.\n", info->irq_1hz);
  		goto fail_ui;
  	}
- 	ret = request_irq(info->irq_alarm, sa1100_rtc_interrupt, IRQF_DISABLED,
 -	ret = request_irq(IRQ_RTCAlrm, sa1100_rtc_interrupt, 0,
++	ret = request_irq(info->irq_alarm, sa1100_rtc_interrupt, 0,
  		"rtc Alrm", dev);
  	if (ret) {
 -		dev_err(dev, "IRQ %d already in use.\n", IRQ_RTCAlrm);
 +		dev_err(dev, "IRQ %d already in use.\n", info->irq_alarm);
  		goto fail_ai;
  	}
  	rtc->max_user_freq = RTC_FREQ;
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120229/0cf92356/attachment-0001.sig>
