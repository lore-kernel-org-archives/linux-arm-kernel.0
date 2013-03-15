From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 15 Mar 2013 18:05:03 +0000
Subject: [PATCH 3/4 v2] net: mvmdio: enhance driver to support SMI
 error/done interrupts
In-Reply-To: <1363284515-9865-4-git-send-email-florian@openwrt.org>
References: <1359473048-26551-1-git-send-email-florian@openwrt.org>
 <1363284515-9865-1-git-send-email-florian@openwrt.org>
 <1363284515-9865-4-git-send-email-florian@openwrt.org>
Message-ID: <20130315180503.GU4977@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 14, 2013 at 07:08:34PM +0100, Florian Fainelli wrote:
> +	if (dev->err_interrupt == NO_IRQ) {
...
> +	init_waitqueue_head(&dev->smi_busy_wait);
> +
> +	dev->err_interrupt = platform_get_irq(pdev, 0);
> +	if (dev->err_interrupt != -ENXIO) {
...
> +	} else
> +		dev->err_interrupt = NO_IRQ;


FYI, NO_IRQ is not supposed to be used anymore (we're supposed to be
removing it).  platform_get_irq() returns negative numbers for failure,
so why not test for < 0 in both the above tests, or maybe <= 0 (as
IRQ0 is also not supposed to be valid.)?
