From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 14 Mar 2013 20:08:10 +0100 (CET)
Subject: [PATCH] genirq: allow an alternative setup for the mask cache
In-Reply-To: <1363277430-21325-1-git-send-email-holger.brunck@keymile.com>
References: <1363277430-21325-1-git-send-email-holger.brunck@keymile.com>
Message-ID: <alpine.LFD.2.02.1303142005430.22263@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 14 Mar 2013, Holger Brunck wrote:

> The same interrupt mask cache (stored within struct irq_chip_generic)
> is shared between all the irq_chip_type instances by default. But this
> does not work on Orion SOCs which have separate mask registers for edge
> and level interrupts. Therefore refactor the code that we always use a
> pointer to access the mask register. By default it points to
> gc->mask_cache for Orion SOCs it points to ct->mask_cache which is
> setup in irq_setup_alt_chip().

Sigh.
 
> @@ -275,6 +278,8 @@ int irq_setup_alt_chip(struct irq_data *d, unsigned int type)
>  	struct irq_chip_type *ct = gc->chip_types;
>  	unsigned int i;
>  
> +	/* Setup pointer to the mask_cache */
> +	gc->pmask_cache = &ct->mask_cache;

You cannot do this unconditionally as this might break existing
drivers.

See my previous mail:

I'd rather refactor the core code so it uses a pointer to the
mask_cache. The default would be to let it point to gc->mask_cache and
optionally let it point to ct->mask_cache. We'd need to store the flag
in the gc struct so we can redirect the pointer to the ct->mask_cache
in irq_setup_alt_chip().

I wrote that for a reason.

Thanks,

	tglx
