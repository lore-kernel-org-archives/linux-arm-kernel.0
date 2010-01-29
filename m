From: lethal@linux-sh.org (Paul Mundt)
Date: Fri, 29 Jan 2010 11:50:41 +0900
Subject: [PATCH 05/06] sh: Let INTC set IRQF_VALID on ARM platforms
In-Reply-To: <20100128124121.8982.71803.sendpatchset@rxone.opensource.se>
References: <20100128124028.8982.16123.sendpatchset@rxone.opensource.se>
	<20100128124121.8982.71803.sendpatchset@rxone.opensource.se>
Message-ID: <20100129025041.GB7396@linux-sh.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 28, 2010 at 09:41:21PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Reuse the SuperH INTC code on ARM by using set_irq_flags()
> to set IRQF_VALID on ARM platforms. Reworking the shared ARM
> interrupt code and removing IRQF_VALID is another option.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  drivers/sh/intc.c |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> --- 0001/drivers/sh/intc.c
> +++ work/drivers/sh/intc.c	2010-01-21 19:53:15.000000000 +0900
> @@ -658,6 +658,11 @@ static void __init intc_register_irq(str
>  
>  	if (desc->ack_regs)
>  		ack_handle[irq] = intc_ack_data(desc, d, enum_id);
> +
> +	/* Set IRQF_VALID to enable IRQ on ARM systems */
> +#ifdef CONFIG_ARCH_SHMOBILE
> +	set_irq_flags(irq, IRQF_VALID);
> +#endif
>  }
>  
This should be CONFIG_ARM rather than ARCH_SHMOBILE, as it's hardly
SH-Mobile specific.
