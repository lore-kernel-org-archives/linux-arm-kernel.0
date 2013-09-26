From: lbyang@marvell.com (Libin Yang)
Date: Wed, 25 Sep 2013 19:47:19 -0700
Subject: [PATCH v2] [media] marvell-ccic: simplify and fix clk handling
 (a bit)
In-Reply-To: <20130925011520.1fa24013@lwn.net>
References: <1380048167-13729-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1380049187-16036-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20130925011520.1fa24013@lwn.net>
Message-ID: <A63A0DC671D719488CD1A6CD8BDC16CF4AB6BB9AAD@SC-VEXCH4.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jonathan & Uwe,

In the clk enable and prepare function, we will check the NULL pointer. So it should be no problem.

For the mipi_clk, it is shared between other components, so we put the clk it we don't use it.

For the free_irq, it's my fault. Out before patch really removed this code together with gpio free .... It missed the last part of the original patch.


Regards,
Libin 

>-----Original Message-----
>From: Jonathan Corbet [mailto:corbet at lwn.net]
>Sent: Wednesday, September 25, 2013 3:15 PM
>To: Uwe Kleine-K?nig
>Cc: Mauro Carvalho Chehab; linux-media at vger.kernel.org; linux-arm-
>kernel at lists.infradead.org; Russell King; kernel at pengutronix.de; Libin Yang
>Subject: Re: [PATCH v2] [media] marvell-ccic: simplify and fix clk handling (a bit)
>
>On Tue, 24 Sep 2013 20:59:47 +0200
>Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> wrote:
>
>> The marvell-ccic does several things wrong or ineffectively in the
>> clock handling and it's usage of the devm_* stuff
>>
>>  - it assumes clk_get doesn't return NULL
>>  - it explicitly calls devm_clk_put instead just keeping the reference
>>    during it's lifetime and let the driver core call it
>>  - it calls kfree, gpio_free and free_irq for resources it requested
>>    using devm_kzalloc, devm_gpio_request and devm_request_irq
>>    respectively.
>>  - it mixes devm_ and unmanaged resources which probably results in a
>>    race condition during remove
>
>OK, all of that stuff was added this time around by Libin; my understanding of that particular
>hardware is ... minimal.  The basic idea of the patch seems sound.  I do note, though, that
>you've changed the behavior of the driver somewhat.  The MIPI clock is current obtained at
>power-up time and released on power-down; you've moved it to probe time instead, and it's
>held for the lifetime of the driver.
>Perhaps that's even better, I don't know...Libin, what do you say on that?
>
>The free_irq() call is also removed by a patch previously submitted by Wei Yongjun.
>
>> This patch fixes all but the last issue in this list. This patch
>> doesn't introduce new reasons for not building, but there are already
>> several bulid problems.
>
>Care to report those?
>
>Thanks,
>
>jon
