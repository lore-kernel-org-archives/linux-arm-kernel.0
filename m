From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Fri, 21 Jan 2011 18:09:44 +0300
Subject: [PATCH] arm: Improve MMC performance on Versatile Express
In-Reply-To: <1295618352-26432-1-git-send-email-pawel.moll@arm.com>
References: <1295618352-26432-1-git-send-email-pawel.moll@arm.com>
Message-ID: <4D39A1B8.4020607@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

Pawel Moll wrote:

> VE suffers from serious problem with MMC transfers - low performance,
> errors when other IO peripherals (especially USB) are used at the
> same time etc.

> It all boils down to the MMC controller short FIFO and - in result -
> timing constrains. The most problematic case - USB driver hogging
> CPU and MMC FIFO under/overruns in the result - can be mitigated on
> SMP system by distributing interrupts handling for these peripherals
> between cores.

> With this, the MMC card clock can be safely (at least it looks like
> it) increased to 1.5MHz, improving performance.

> Signed-off-by: Pawel Moll <pawel.moll@arm.com>
> ---
>  arch/arm/mach-vexpress/v2m.c |   14 ++++++++++++++
>  1 files changed, 14 insertions(+), 0 deletions(-)

> diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
> index 4b5af01..300ac72 100644
> --- a/arch/arm/mach-vexpress/v2m.c
> +++ b/arch/arm/mach-vexpress/v2m.c
[...]
>  static AMBA_DEVICE(aaci,  "mb:aaci",  V2M_AACI, NULL);
> @@ -391,6 +392,19 @@ static void __init v2m_init(void)
>  	for (i = 0; i < ARRAY_SIZE(v2m_amba_devs); i++)
>  		amba_device_register(v2m_amba_devs[i], &iomem_resource);
>  
> +	/* WARNING: HACK HACK HACK!
> +	 *
> +	 * MMCI cell has very tight timing requirements regarding interrupt
> +	 * handling (fractions of millisecond), while the USB host controller
> +	 * interrupt handler can hog the CPU for more then 1 millisecond!
> +	 *
> +	 * To mitigate the problem on SMP systems, we can set CPU affinities
> +	 * of these interrupts to different cores... */

    The preferred style for the mutli-line comments is this:

/*
  * bla
  * bla
  */

    You were close. :-)

> +	BUG_ON(v2m_usb_resources[1].flags != IORESOURCE_IRQ);
> +	irq_set_affinity(v2m_usb_resources[1].start, cpumask_of(0));
> +	irq_set_affinity(mmci_device.irq[0], cpumask_of(1));
> +	irq_set_affinity(mmci_device.irq[1], cpumask_of(1));
> +
>  	pm_power_off = v2m_power_off;
>  	arm_pm_restart = v2m_restart;

WBR, Sergei
