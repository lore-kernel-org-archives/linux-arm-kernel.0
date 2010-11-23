From: ionut.nicu@mindbit.ro (Ionut Nicu)
Date: Wed, 24 Nov 2010 01:23:27 +0200
Subject: [PATCH v2 2/4] drivers: hwspinlock: add OMAP implementation
In-Reply-To: <1290526740-27624-3-git-send-email-ohad@wizery.com>
References: <1290526740-27624-1-git-send-email-ohad@wizery.com>
	<1290526740-27624-3-git-send-email-ohad@wizery.com>
Message-ID: <1290554607.3647.12.camel@atlantis.mindbit.ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ohad,

On Tue, 2010-11-23 at 17:38 +0200, Ohad Ben-Cohen wrote:
> From: Simon Que <sque@ti.com>
> 
> Add hwspinlock support for the OMAP4 Hardware Spinlock device.
> 

<snip>

> +
> +	io_base = ioremap(res->start, resource_size(res));
> +	if (!io_base) {
> +		ret = -ENOMEM;
> +		goto free_state;
> +	}
> +
> +	/* Determine number of locks */
> +	i = readl(io_base + SYSSTATUS_OFFSET);
> +	i >>= SPINLOCK_NUMLOCKS_BIT_OFFSET;
> +
> +	/* exactly one of the four least significant bits must be 1 */
> +	if (!i || !is_power_of_2(i) || i > 8) {
> +		ret = -EINVAL;
> +		goto iounmap_base;
> +	}
> +

At iounmap_base you unmap state->io_base, but that's set only after this
check. You should probably iounmap(io_base).

Regards,
Ionut.
