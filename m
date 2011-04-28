From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 28 Apr 2011 19:29:28 +0100
Subject: [PATCH] at91: fix map_io init usage
In-Reply-To: <1304012240-13571-1-git-send-email-plagnioj@jcrosoft.com>
References: <1304012240-13571-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <20110428182928.GG17290@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 28, 2011 at 07:37:20PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> switch early init to init_early and introduce soc map_io
> 
> with this Patch we will not do any more early device setup during the map io
> 
> tks to Russel to point the new call back
> 
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
> Cc: Russell King <linux@arm.linux.org.uk>

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

The only thing I'd suggest is:

> @@ -94,7 +94,8 @@ MACHINE_START(ONEARM, "Ajeco 1ARM single board computer")
>  	/* Maintainer: Lennert Buytenhek <buytenh@wantstofly.org> */
>  	.boot_params	= AT91_SDRAM_BASE + 0x100,
>  	.timer		= &at91rm9200_timer,
> -	.map_io		= onearm_map_io,
> +	.map_io		= at91rm9200_map_io,
>  	.init_irq	= onearm_init_irq,
> +	.init_early	= onearm_init_early,
>  	.init_machine	= onearm_board_init,

Ordering these as:
	.map_io
	.init_early
	.init_irq

as that's the order which they're called.  The struct itself is actually
layed out such that the members are called in order (which is: fixup,
map_io, init_early, init_irq, timer, init_machine).  I wouldn't suggest
doing a needless change to .timer in this patch though.
