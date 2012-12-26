From: 21cnbao@gmail.com (Barry Song)
Date: Wed, 26 Dec 2012 16:00:27 +0800
Subject: [PATCH v4 1/5] ARM: Add interface for registering and calling
 firmware-specific operations
In-Reply-To: <1353599478-24617-2-git-send-email-t.figa@samsung.com>
References: <1353599478-24617-1-git-send-email-t.figa@samsung.com>
 <1353599478-24617-2-git-send-email-t.figa@samsung.com>
Message-ID: <CAGsJ_4xhE0dXmesBfZPgajeEUTWkO594rjy8qTKsN3fZ7LZNaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/11/22, Tomasz Figa <t.figa@samsung.com>:
> Some boards are running with secure firmware running in TrustZone secure
> world, which changes the way some things have to be initialized.
>
> This patch adds an interface for platforms to specify available firmware
> operations and call them.
>
> A wrapper macro, call_firmware_op(), checks if the operation is provided
> and calls it if so, otherwise returns -ENOSYS to allow fallback to
> legacy operation..
>
> By default no operations are provided.
>
> Example of use:
>
> In code using firmware ops:
>
> 	__raw_writel(virt_to_phys(exynos4_secondary_startup),
> 		CPU1_BOOT_REG);
>
> 	/* Call Exynos specific smc call */
> 	if (call_firmware_op(cpu_boot, cpu) == -ENOSYS)
> 		cpu_boot_legacy(...); /* Try legacy way */
>
> 	gic_raise_softirq(cpumask_of(cpu), 1);
>
> In board-/platform-specific code:
>
> 	static int platformX_do_idle(void)
> 	{
> 		/* tell platformX firmware to enter idle */
> 	        return 0;
> 	}
>
> 	static int platformX_cpu_boot(int i)
> 	{
> 		/* tell platformX firmware to boot CPU i */
> 		return 0;
> 	}
>
> 	static const struct firmware_ops platformX_firmware_ops = {
> 		.do_idle	= exynos_do_idle,
> 		.cpu_boot	= exynos_cpu_boot,
> 		/* other operations not available on platformX */
> 	};

i am thinking the firmware_ops should be namespaced, some hardware has
firmware, firmware_ops should not be using a global namespace here.

>
> 	static void __init board_init_early(void)
> 	{
> 	        register_firmware_ops(&platformX_firmware_ops);
> 	}
>

-barry
