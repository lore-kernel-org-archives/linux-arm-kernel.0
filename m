From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 20 Nov 2012 15:40:48 -0700
Subject: [PATCH 01/16] irqchip: add basic infrastructure
In-Reply-To: <1353448867-15008-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1353448867-15008-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1353448867-15008-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <50AC06F0.5070402@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/20/2012 03:00 PM, Thomas Petazzoni wrote:
> With the recent creation of the drivers/irqchip/ directory, it is
> desirable to move irq controller drivers here. At the moment, the only
> driver here is irq-bcm2835, the driver for the irq controller found in
> the ARM BCM2835 SoC, present in Rasberry Pi systems. This irq
> controller driver was exporting its initialization function and its
> irq handling function through a header file in
> <linux/irqchip/bcm2835.h>.
...
> Reviewed-by: Stephen Warren <swarren@wwwdotorg.org>

That still stands as:

Reviewed-by: Stephen Warren <swarren@nvidia.com>

... although I think in this case the implementation changed enough it
probably shouldn't have been kept in v4.


> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig

> +config IRQCHIP

I wonder if it should be IRQCHIP_OF, since it's OF-specific?

> +	def_bool y
> +	depends on OF_IRQ

For the drivers/clocksource patch I created, I required the
architecture/machine config option to select it rather than making it a
def_bool. Would that be better? I suppose if it's going to be selected
in a lot of places anyway, and since the code will just be dropped if it
isn't used, then making it default to on is reasonable though.

> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h

> @@ -493,7 +502,8 @@
>  	DEV_DISCARD(init.rodata)					\
>  	CPU_DISCARD(init.rodata)					\
>  	MEM_DISCARD(init.rodata)					\
> -	KERNEL_DTB()
> +	KERNEL_DTB()							\
> +	IRQCHIP_OF_MATCH_TABLE()

Does it make sense to put that before KERNEL_DTB()? I did in my
drivers/clocksource patch just in case anything depended on KERNEL_DTB
being last along the lines of APPENDED_DTB. That said, now that I think
about it, nothing really should depend on the order...
