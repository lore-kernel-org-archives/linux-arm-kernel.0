From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 12 Apr 2011 19:46:01 +0200
Subject: [PATCH 1/2] ux500: Adding support for u8500 Hsem functionality V2
In-Reply-To: <1302535464-12294-1-git-send-email-mathieu.poirier@linaro.org>
References: <1302535464-12294-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <201104121946.01618.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 11 April 2011, mathieu.poirier at linaro.org wrote:
> From: Mathieu J. Poirier <mathieu.poirier@linaro.org>
> 
> This is the second spin on STE's Hsem driver that is implemented
> through the hwspinlock scheme.  More specifically:
> 
>  More comments have been added in the code.
>  Cleanup of included header files.
>  One of the original contributor's name corrected.
>  Calls to 'pm_runtime_disable'restored.
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Looks very nice overall, just a few small details I noticed:

> +
> +#define HSEM_REGISTER_OFFSET		0x08
> +
> +#define HSEM_CTRL_REG			0x00
> +#define HSEM_ICRALL			0x90
> +#define HSEM_PROTOCOL_1			0x01
> +
> +#define to_u8500_hsem(lock)	\
> +	container_of(lock, struct u8500_hsem, lock)
> +
> +struct u8500_hsem {
> +	struct hwspinlock lock;
> +	void __iomem *addr;
> +};

It seems inconsistent to name it sem instead of spinlock.

> +struct u8500_hsem_state {
> +	void __iomem *io_base;		/* Mapped base address */
> +};

If you make that one data structure, you only need a single allocation:

struct u8500_hsem_state {
	void __iomem *io_base;
	struct u8500_hsem hsem[U8500_MAX_SEMAPHORE];
}

> +
> +	for (i = 0; i < U8500_MAX_SEMAPHORE; i++) {
> +		u8500_lock = kzalloc(sizeof(*u8500_lock), GFP_KERNEL);
> +		if (!u8500_lock) {
> +			ret = -ENOMEM;
> +			goto free_locks;
> +		}
> +
> +		u8500_lock->lock.dev = &pdev->dev;
> +		u8500_lock->lock.owner = THIS_MODULE;
> +		u8500_lock->lock.id = i;
> +		u8500_lock->lock.ops = &u8500_hwspinlock_ops;
> +		u8500_lock->addr = io_base + offset + sizeof(u32) * i;
> +
> +		ret = hwspin_lock_register(&u8500_lock->lock);
> +		if (ret) {
> +			kfree(u8500_lock);
> +			goto free_locks;
> +		}
> +	}

When you do that, this can be a single allocation.

Thinking about it some more, it may actually be worthwhile to still improve
the API here: I think the owner field should be part of the operations structure,
because it is constant. It would also be nice to have a "private" pointer
in struct hwspinlock, so you don't need to wrap it if you don't want to.

Finally, the hwspin_lock_register could take the specific values as arguments
instead of requiring you to fill it out first.

	Arnd
