From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Wed, 10 Nov 2010 14:21:33 +0300
Subject: arm smp support patch
In-Reply-To: <73a3b42c84eb2bfde0f861d1e53042cd.squirrel@www.concentris-systems.com>
References: <73a3b42c84eb2bfde0f861d1e53042cd.squirrel@www.concentris-systems.com>
Message-ID: <4CDA803D.8090403@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 10-11-2010 2:33, Scott Valentine wrote:

> On arm multi-core platforms that have a gic, the secondary cores fail to
> wake if they are booted in WFI mode, as the gic_dist_init disables all
> interrupts including IPI. I've included a simple patch to the
> gic_dist_init function that enables interrupts 0-15 on SMP enabled
> systems. This patch was made against linux-2.6-HEAD-151f52f.

    Your signoff is necessary for the patch to be applied.

> diff -uNr a/arch/arm/common/gic.c b/arch/arm/common/gic.c
> --- a/arch/arm/common/gic.c     2010-11-05 15:57:04.000000000 -1000
> +++ b/arch/arm/common/gic.c     2010-11-09 13:08:33.000000000 -1000
> @@ -262,6 +262,13 @@
>          for (i = 0; i<  max_irq; i += 32)
>                  writel(0xffffffff, base + GIC_DIST_ENABLE_CLEAR + i * 4 /
> 32);
>
> +#ifdef CONFIG_SMP
> +       /*
> +        * Enable IPI interrupts on SMP systems so we can wake secondary
> cores

   Your patch is line wrapped.

> +        */
> +       writel(0x0000ffff, base + GIC_DIST_ENABLE_SET);
> +#endif
> +
>          /*
>           * Setup the Linux IRQ subsystem.
>           */

> Scott Valentine

WBR, Sergei
