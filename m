From: will.deacon@arm.com (Will Deacon)
Date: Wed, 21 Aug 2013 13:24:24 +0100
Subject: [PATCH v2 1/3] ARM: Introduce atomic MMIO clear/set
In-Reply-To: <1377017307-23201-2-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1377017307-23201-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1377017307-23201-2-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20130821122424.GB1653@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ezequiel,

Cheers for the v2. I've been thinking about how to improve the performance
of this operation and I ended up completely changing my mind about how it
should be implemented :)

Comments and questions below...

On Tue, Aug 20, 2013 at 05:48:25PM +0100, Ezequiel Garcia wrote:
> diff --git a/arch/arm/kernel/io.c b/arch/arm/kernel/io.c
> index dcd5b4d..b2a53a3 100644
> --- a/arch/arm/kernel/io.c
> +++ b/arch/arm/kernel/io.c
> @@ -1,6 +1,19 @@
>  #include <linux/export.h>
>  #include <linux/types.h>
>  #include <linux/io.h>
> +#include <linux/spinlock.h>
> +
> +static DEFINE_SPINLOCK(__io_lock);
> +
> +void atomic_io_clear_set(u32 clear, u32 set, void __iomem *reg)

First off, what exactly is this function supposed to guarantee? Do you simply
require thread-safe device access, or do you also require completion of the
the device writes?

Since the latter is device-specific (probably requiring some read-backs in
the driver), I assume you actually just need to ensure that multiple drivers
don't trip over each other. In which case, this can be *much* lighter
weight.

> +{
> +	spin_lock(&__io_lock);

Is this function likely to be used in irq context? If so, better disable
IRQs here.

> +	writel((readl(reg) & ~clear) | set, reg);

Going back to my earlier comments, this will assemble to something like:

	dmb
	ldr	[device]
	dsb
	...
	dsb
	outer_sync
	str	[device]
	dmb

If my assumption about completion is correct, you actually just want:

	dmb
	ldr	[device]
	...
	str	[device]
	dmb

which can be done by using the _relaxed variants of readl/writel.

> +	/* ensure the write get done before unlocking */
> +	__iowmb();

And then, despite my previous suggestion, you can drop this line too.

> +	spin_unlock(&__io_lock);
> +}
> +EXPORT_SYMBOL(atomic_io_clear_set);

Now, the only downside with this approach is that you need explicit barriers
in the driver if you want to enforce ordering with respect to normal,
cacheable buffers to be consumed/populated by the device.

What do you think? An alternative would be just to relax the readl and rely
on the dsb preceeding the writel, then add atomic_io_clear_set_relaxed
to implement what I described above, but it depends on how you envisage
this helper being used.

Will
