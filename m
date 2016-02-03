From: timur@codeaurora.org (Timur Tabi)
Date: Wed, 3 Feb 2016 11:53:29 -0600
Subject: [PATCH v10 5/5] Watchdog: ARM SBSA Generic Watchdog half timeout
 panic support
In-Reply-To: <CADyBb7sxPg-QUjTbeHFtYkctKc_g7D8O=+jqbXN+DCCoCEnFqA@mail.gmail.com>
References: <1454519923-25230-1-git-send-email-fu.wei@linaro.org>
 <1454519923-25230-6-git-send-email-fu.wei@linaro.org>
 <56B23883.7000501@codeaurora.org>
 <CADyBb7sxPg-QUjTbeHFtYkctKc_g7D8O=+jqbXN+DCCoCEnFqA@mail.gmail.com>
Message-ID: <56B23E99.1030604@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fu Wei wrote:
> sorry, are you saying : using pre-timeout instead of this half timeout?
>
> But even we have pre-timeout support, pre-timeout  == timeout / 2, it
> can not be configured without touch timeout.
>
> if you want pre-timeout  != timeout / 2, we have to modify WCV in the
> interrupt routine.
>   (because of the explicit watchdog refresh  mechanism)
>
> Could you let me know why we need pre-timeout  here ??:-)

What I meant was that if we had full-blown pre-timeout support in the 
watchdog layer, then you could use that to implement the 
panic-on-half-timeout feature.

When pre-timeout is implemented, will you modify the interrupt handler 
to use it?

>> >belong upstream.  But like I said, it's just my opinion, and I won't
>> >complain if I'm outvoted.
>   I think this debugging feature is the  purpose of the two-stage
> watchdog, if I understand correctly

Hmmm... that make sense.  I think maybe you should drop the Kconfig 
option, and just have "static bool panic_enabled = false;"  Also, then 
do this:

if (panic_enabled) {
	ret = devm_request_irq(dev, irq, sbsa_gwdt_interrupt, 0,
			       pdev->name, gwdt);
	if (ret) {
		dev_err(dev, "unable to request IRQ %d\n", irq);
		return ret;
	}
}

That way, the interrupt handler is never registered if the command-line 
parameter is not specified.
