From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 16 Nov 2009 16:36:59 +0000
Subject: [PATCH 2/3] msm: add minimal board file for HTC Dream device
In-Reply-To: <20091102104949.GA23456@elf.ucw.cz>
References: <20091102104949.GA23456@elf.ucw.cz>
Message-ID: <20091116163659.GB3568@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 02, 2009 at 11:49:49AM +0100, Pavel Machek wrote:
> +MACHINE_START(TROUT, "HTC Dream")
> +#ifdef CONFIG_MSM_DEBUG_UART
> +	.phys_io	= MSM_DEBUG_UART_PHYS,
> +	.io_pg_offst	= ((MSM_DEBUG_UART_BASE) >> 18) & 0xfffc,
> +#endif

Why is this ifdef'd?  Two reasons why not to do this:

1. MSM_DEBUG_UART is always defined, so the conditional is pointless

2. the low level page table building code does not expect these to be
   unset (or even set to an invalid value).  Leaving them unset and
   having DEBUG_LL enabled is a recipe to prevent booting.

To put it another way, these two fields aren't optional.
