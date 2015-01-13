From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 13 Jan 2015 22:00:55 +0100 (CET)
Subject: [PATCH v2 1/5] irqchip: add dumb demultiplexer implementation
In-Reply-To: <1421174781-4340-2-git-send-email-boris.brezillon@free-electrons.com>
References: <1421174781-4340-1-git-send-email-boris.brezillon@free-electrons.com>
 <1421174781-4340-2-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <alpine.DEB.2.11.1501132153210.5526@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 13 Jan 2015, Boris Brezillon wrote:
> +	ret = irq_set_handler_data(irq, demux);
> +	if (ret) {
> +		pr_err("Failed to assign handler data\n");
> +		goto err_free_domain;
> +	}
> +
> +	irq_set_chained_handler(irq, irq_dumb_demux_handler);
> +
> +	/*
> +	 * Disable the src irq (automatically enabled by
> +	 * irq_set_chained_handler) to prevent irqs from happening while
> +	 * nobody requested any of the demuxed irqs.
> +	 */
> +	disable_irq(irq);

We rather prevent the startup of the irq line right away.

enum {
     IRQ_CHAINED_NONE,
     IRQ_CHAINED_STARTUP,
     IRQ_CHAINED_NOSTARTUP,
};

-__irq_set_handler(unsigned int irq, irq_flow_handler_t handle, int is_chained,
-                  const char *name);
+__irq_set_handler(unsigned int irq, irq_flow_handler_t handle, int chained_mode,
+                  const char *name);

{
....
        if (handle != handle_bad_irq && chained_mode) {
                irq_settings_set_noprobe(desc);
                irq_settings_set_norequest(desc);
                irq_settings_set_nothread(desc);
-               irq_startup(desc, true);
+               if (chained_mode == IRQ_CHAINED_STARTUP)
+                       irq_startup(desc, true);
	}
....
}

Hmm?

	tglx
