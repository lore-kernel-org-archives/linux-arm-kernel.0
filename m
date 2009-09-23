From: linux@bohmer.net (Remy Bohmer)
Date: Wed, 23 Sep 2009 23:04:09 +0200
Subject: [PATCH] Don't disable irqs in set_next_event and set_mode
	callbacks
In-Reply-To: <1253518763-15087-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1253518763-15087-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <3efb10970909231404me189b28yb90daa6f5f4767b8@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

2009/9/21 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> These functions are called with irqs already off.
>
> at91rm2000 had a WARN_ON_ONCE if irqs were enabled since Nov 2008 with
> noone reporting having hit it.

I guess this is not a processor widely used these days with recent
kernels, it has been deprecated by Atmel a couple of years ago.
Besides that, there is also a TC-library clocksource/event
implementation inside the kernel that runs at a much higher frequency
compared to the 32kHz the PIT is running on. It is likely that someone
who cares about accurate timestamps would use the TC-lib
implementation on this processor. So, it would have surprised me if
anybody would actually hit this WARN_ON_ONCE...

> It should be safe to remove now.

But anyway, if the problem we encountered back then would still be
here, many more boards/architectures would suffer from the same
problem. So, I guess it is safe to remove the irq_disable now.
But to be completely sure; I will test this patch on 2.6.31-rt11 with
the sam9261 processor once I have it running stable.(I expect Friday
and stress it during the weekend. Will inform you about the results on
Monday)

> should I split the patch?  Would you prefer to add a WARN_ON_ONCE for
> some time (as at91rm9200 had it)?

I expect this is not needed...


Kind Regards,

Remy
