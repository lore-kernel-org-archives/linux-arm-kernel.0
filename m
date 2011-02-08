From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 8 Feb 2011 14:35:14 +0000
Subject: [PATCH 3/4] ARM: Xilinx: Adding timer support to the platform
In-Reply-To: <7803ac06-421f-455a-86af-ea9d480be64d@VA3EHSMHS012.ehs.local>
References: <1296922124-23379-1-git-send-email-john.linn@xilinx.com>
	<1296922124-23379-2-git-send-email-john.linn@xilinx.com>
	<1296922124-23379-3-git-send-email-john.linn@xilinx.com>
	<7803ac06-421f-455a-86af-ea9d480be64d@VA3EHSMHS012.ehs.local>
Message-ID: <20110208143514.GB27521@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 05, 2011 at 09:08:43AM -0700, John Linn wrote:
> +/*
> + * Definitions of the timer read/write macro
> + */
> +#define xttcpss_read(addr)	__raw_readl((void __iomem *)addr)
> +#define xttcpss_write(addr, val) __raw_writel(val, (void __iomem *)(addr))

Get rid of these casts.  You should never need to cast to void __iomem *.

> +
> +
> +/**
> + * struct xttcpss_timer - This definition defines local timer structure
> + *
> + * @name:	Name of Timer
> + * @base_addr:	Base address of timer
> + * @timer_irq:	irqaction structure for the timer device
> + * @mode:       only valid for an clock event, periodic or one-shot
> + **/
> +struct xttcpss_timer {
> +	char *name;
> +	unsigned long base_addr;

Replace this with void __iomem *base_addr.

> +		timer->base_addr = XTTCPSS_TIMER_BASE + (4*timer_id);

Right, so XTTCPSS_TIMER_BASE should be typed as void __iomem *.

> +#define XTTCPSS_TIMER_BASE	TTC0_BASE

which means TTC0_BASE should be void __iomem * as well as this is an
iomem cookie, not a physical address.
