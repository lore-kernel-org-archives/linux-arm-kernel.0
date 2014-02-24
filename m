From: jbe@pengutronix.de (Juergen Beisert)
Date: Mon, 24 Feb 2014 14:16:24 +0100
Subject: [PATCHv6] staging/iio/adc: change the MXS touchscreen driver
 implementation
In-Reply-To: <201401100955.45885.jbe@pengutronix.de>
References: <1379946998-23041-1-git-send-email-jbe@pengutronix.de>
 <52CEA4AA.8050503@free-electrons.com> <201401100955.45885.jbe@pengutronix.de>
Message-ID: <201402241416.24270.jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexandre,

> While I don't have much experience with the TS part of the code but I
> can investigate if you don't have any idea.

can you please test the following patch?
After releasing the touchscreen the internal state machine was left in a
wrong state.

diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
index e2dd783..558a76c 100644
--- a/drivers/staging/iio/adc/mxs-lradc.c
+++ b/drivers/staging/iio/adc/mxs-lradc.c
@@ -698,6 +698,7 @@ static void mxs_lradc_finish_touch_event(struct mxs_lradc *lradc, bool valid)
        }

        /* if it is released, wait for the next touch via IRQ */
+       lradc->cur_plate = LRADC_TOUCH;
        mxs_lradc_reg_clear(lradc, LRADC_CTRL1_TOUCH_DETECT_IRQ, LRADC_CTRL1);
        mxs_lradc_reg_set(lradc, LRADC_CTRL1_TOUCH_DETECT_IRQ_EN, LRADC_CTRL1);
 }

Regards,
Juergen

-- 
Pengutronix e.K. ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?| Juergen Beisert ? ? ? ? ? ? |
Linux Solutions for Science and Industry ? ? ?| Phone: +49-5121-206917-5128 |
Peiner Str. 6-8, 31137 Hildesheim, Germany ? ?| Fax: ? +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686 ? ? ? ? ? ? ?| http://www.pengutronix.de/ ?|
