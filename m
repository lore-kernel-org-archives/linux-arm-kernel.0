From: jamie@jamieiles.com (Jamie Iles)
Date: Fri, 23 Nov 2012 12:01:53 +0000
Subject: [PATCH 09/16] irqchip: Move ARM VIC to drivers/irqchip
In-Reply-To: <1353448867-15008-10-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1353448867-15008-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1353448867-15008-10-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20121123120153.GA1941@page>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On Tue, Nov 20, 2012 at 11:01:00PM +0100, Thomas Petazzoni wrote:
> +/*
> + * Keep iterating over all registered VIC's until there are no pending
> + * interrupts.
> + */
> +asmlinkage void __exception_irq_entry vic_handle_irq(struct pt_regs *regs)
> +{
> +	int i, handled;
> +
> +	do {
> +		for (i = 0, handled = 0; i < vic_id; ++i)
> +			handled |= handle_one_vic(&vic_devices[i], regs);
> +	} while (handled);
> +}

__exception_irq_entry is only defined for ARM, so I think we either need 
to add a Kconfig dependency on ARM or allow some other way to build on 
non-ARM platforms.

Jamie
