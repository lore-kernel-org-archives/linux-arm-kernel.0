From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 2 Nov 2009 12:00:27 +0000
Subject: [PATCH] pxa: fix system resume issue on pxa27x and pxa3xx
In-Reply-To: <771cded00911020342j5266b3c4ga4e94324c2369630@mail.gmail.com>
References: <771cded00911020342j5266b3c4ga4e94324c2369630@mail.gmail.com>
Message-ID: <20091102120027.GB3348@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 02, 2009 at 07:42:14AM -0400, Haojian Zhuang wrote:
> >From 1764e836424d42a0654b8b73c402a2dddb118dc4 Mon Sep 17 00:00:00 2001
> From: Haojian Zhuang <haojian.zhuang@marvell.com>
> Date: Mon, 2 Nov 2009 14:02:21 -0500
> Subject: [PATCH] pxa: fix system resume issue on pxa27x and pxa3xx
> 
> Since interrupt handler is changed to use interrupt priority, we also need to
> save and restore these interrupt controller registers in suspend/resume
> routine.

Since we've just been struggling with discovering why something doesn't
suspend/resume, is this:

> @@ -159,6 +160,10 @@ static int pxa_irq_suspend(struct sys_device
> *dev, pm_message_t state)
>  		saved_icmr[i] = _ICMR(irq);
>  		_ICMR(irq) = 0;
>  	}
> +	if (pxa_internal_irq_nr > 128)
> +		BUG();

really appropriate.  If we have more than 128 interrupts, do we really
want to cause the kernel to OOPS at this point?

What about:

	if (WARN_ON(pxa_internal_irq_nr > 128))
		return -EINVAL;

so that we refuse to sleep _and_ log the reason why?

This way, the platform will still be alive, and if you didn't see it via
the console, at least it'll be available via dmesg - which is a lot better
than trying to work out why the machine gets stuck during suspend.

Such a check should also be a little higher up - since we're already
looping over the number of irqs for ICMR.
