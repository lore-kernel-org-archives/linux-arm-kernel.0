From: richard.genoud@gmail.com (Richard Genoud)
Date: Mon, 17 Nov 2014 17:14:21 +0100
Subject: [PATCH] gpio: mxs: implement get_direction callback
In-Reply-To: <546A064A.5060304@elproma.com.pl>
References: <1416004026-9667-1-git-send-email-j.uzycki@elproma.com.pl>
 <20141114232601.GW27002@pengutronix.de> <5467A980.5090204@elproma.com.pl>
 <20141116214239.GX27002@pengutronix.de> <54693A51.5080907@elproma.com.pl>
 <54695654.3070209@elproma.com.pl> <20141117082848.GZ27002@pengutronix.de>
 <5469BBBD.30003@elproma.com.pl>
 <CACQ1gAha1MuroyB35zN_BuwRNGS_J3Xh1htiHJda_2_19qh31g@mail.gmail.com>
 <20141117095909.GH27002@pengutronix.de>
 <CACQ1gAje6OA_n37jE_WnSqg4R+U5tr-bGnnfxpGM5NE9c=dAVg@mail.gmail.com>
 <546A064A.5060304@elproma.com.pl>
Message-ID: <CACQ1gAisamCxV8o-gCp58C5AY0OufZX-vSmssxcvRf4uYdHBUg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-11-17 15:29 GMT+01:00 Janusz U?ycki <j.uzycki@elproma.com.pl>:
> Hi Richard,
>
> W dniu 2014-11-17 o 11:05, Richard Genoud pisze:
>>
>> 2014-11-17 10:59 GMT+01:00 Uwe Kleine-K?nig
>> <u.kleine-koenig@pengutronix.de>:
>>
>> well, in this case, request_irq() will fail and all the previously
>> requested irqs will be freed:
>>      /*
>>       * If something went wrong, rollback.
>>       */
>>      while (err && (--i >= 0))
>>          if (irq[i] >= 0)
>>              free_irq(irq[i], port);
>
>
> I hesitate if use the rollback or just call mctrl_gpio_free_irqs().
> Let's note that "i" is enum and the loop ends on i < 0.

That's right, it's a bug.
I thought that enum was signed, but actually, it could be unsigned on
some platforms.
