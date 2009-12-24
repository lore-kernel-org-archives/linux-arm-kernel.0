From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 24 Dec 2009 18:37:18 +0000
Subject: [PATCH v2] Add interrupt handling capability to pca953x
In-Reply-To: <20091224185240.07474930@taxman.wild-wind.fr.eu.org>
References: <20091224185240.07474930@taxman.wild-wind.fr.eu.org>
Message-ID: <20091224183718.GA12572@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 24, 2009 at 06:52:40PM +0100, Marc Zyngier wrote:

> Pending problems to be solved:
> - Modular build is broken, as handle_edge_irq, set_irq_flags and
>   irq_to_desc are not exported, among others. First approach would be
>   to disable the irq_chip when build modular, but I really don't like
>   it.

The other approach here is just to not support modular builds; it's what
the IRQ core wants you to do and what I ended up doing for wm831x.  Or
speak to Ingo and Thomas and see if they'll relax the requirement that
interrupt controller drivers be built in.

> - request_irq vs request_threaded_irq: genirq is a bit of a mess in
>   this respect. We'd love a consistent API...

What's the problem here?  Are you referring to the consumer side or
something that the driver itself has to deal with - from the point of
view of the interrupt controller itself this is pretty much transparent.

Like I said in my previous mail a threaded interrupt context is
fundamentally not a non-threaded one so users do need to be aware of
which context they're running in - you can do more things in a threaded
context but you also have more possibility for concurrency issues to
creep in.  This means that the visible difference between the two
handlers always seemed reasonable to me.

It would be nice to have a third option for handlers which can cope with
either context, though.  Actually, using request_threaded_irq and
supplying the same function for both primary and secondary handler may
DTRT in that case but I'd need to check.  This is another thing we
really ought to bring up with Ingo and Thomas rather than discussing
here, though.

>  drivers/gpio/pca953x.c      |  208
> ++++++++++++++++++++++++++++++++++++++++--- include/linux/i2c/pca953x.h

Looks like your MUA is word wrapping things but other than that and the
modular build thing the patch itself looks good.
