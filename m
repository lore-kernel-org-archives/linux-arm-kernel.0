From: tj@kernel.org (Tejun Heo)
Date: Mon, 4 May 2015 11:47:26 -0400
Subject: [PATCH v3 1/2] libahci: Add support to handle HOST_IRQ_STAT as
 edge trigger latch.
In-Reply-To: <1430667220-23477-2-git-send-email-stripathi@apm.com>
References: <1430667220-23477-1-git-send-email-stripathi@apm.com>
 <1430667220-23477-2-git-send-email-stripathi@apm.com>
Message-ID: <20150504154726.GA1971@htj.duckdns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 03, 2015 at 09:03:39PM +0530, Suman Tripathi wrote:
> This patch adds the support to handle HOST_IRQ_STAT as edge trigger
> latch.
...
> +	/*
> +	 * HOST_IRQ_STAT behaves as edge trigger latch. When HOST_IRQ_STAT
> +	 * detects a egde from PORT_IRQ_STAT, it happens to loose interrupts
> +	 * when interrupts are triggered from both ports. So handling of
> +	 * the residual interrupt is required.
> +	 */
> +	if (hpriv->flags & AHCI_HFLAG_EDGE_TRIG_IRQ) {
> +		for (i = 0; i < host->n_ports; i++) {
> +			struct ata_port *ap;
> +
> +			ap = host->ports[i];
> +			if (ap) {
> +				ahci_port_intr(ap);
> +				VPRINTK("Residual irq from port %u\n", i);
> +			}
> +			handled = 1;
> +		}
> +	}

This is kinda gross.  The right thing do is clearing irq stat
registers before handling the events, right?  That shouldn't be too
difficult to implement.  Create a separate set of irq functions which
clear irqs before processing rather than after.

Thanks.

-- 
tejun
