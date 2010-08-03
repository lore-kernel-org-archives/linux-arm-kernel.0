From: marek.vasut@gmail.com (Marek Vasut)
Date: Tue, 3 Aug 2010 05:10:03 +0200
Subject: [PATCH] PXA: Fix wakealarm capability for pxa-rtc
In-Reply-To: <20100803020328.1046308a@linux.lan.towertech.it>
References: <1280550147-12380-1-git-send-email-marek.vasut@gmail.com>
	<201008011738.16225.marek.vasut@gmail.com>
	<20100803020328.1046308a@linux.lan.towertech.it>
Message-ID: <201008030510.03205.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne ?t 3. srpna 2010 02:03:28 Alessandro Zummo napsal(a):
> On Sun, 1 Aug 2010 17:38:16 +0200
> 
> Marek Vasut <marek.vasut@gmail.com> wrote:
> > > As I see now your real
> > > problem, I would request you leave the existing "device_init_wakeup(x,
> > > 1)" *and* you add yours to make the class driver happy.
> > 
> > Why wouldn't the driver wake up from suspend?
> 
>  may I see the latest version of your patch, Marek?
> 
>  ty
---
 drivers/rtc/rtc-pxa.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-pxa.c b/drivers/rtc/rtc-pxa.c
index e9c6fa0..d76f187 100644
--- a/drivers/rtc/rtc-pxa.c
+++ b/drivers/rtc/rtc-pxa.c
@@ -403,6 +403,8 @@ static int __init pxa_rtc_probe(struct platform_device 
*pdev)
 
        rtsr_clear_bits(pxa_rtc, RTSR_PIALE | RTSR_RDALE1 | RTSR_HZE);
 
+       device_init_wakeup(dev, 1);
+
        pxa_rtc->rtc = rtc_device_register("pxa-rtc", &pdev->dev, &pxa_rtc_ops,
                                           THIS_MODULE);
        ret = PTR_ERR(pxa_rtc->rtc);
@@ -411,8 +413,6 @@ static int __init pxa_rtc_probe(struct platform_device 
*pdev)
                goto err_rtc_reg;
        }
 
-       device_init_wakeup(dev, 1);
-
        return 0;
 
 err_rtc_reg:
-- 
1.7.1
