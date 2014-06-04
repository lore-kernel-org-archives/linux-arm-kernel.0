From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 04 Jun 2014 12:57:02 +0200
Subject: [PATCH] ARM: integrator: fix section mismatch problem
In-Reply-To: <1401879202-10516-1-git-send-email-linus.walleij@linaro.org>
References: <1401879202-10516-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <10542022.FtcLF0Em3k@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 04 June 2014 12:53:22 Linus Walleij wrote:
> This addresses a section mismatch problem in the IM-PD1
> driver in the Integrator/AP.
> 
> The IM-PD1 contains a VIC interrupt controller and therefore
> the driver calls vic_init_cascaded() which is marked __init as
> irqchips are simply not hot-pluggable and specifically the VIC
> is assumed to initiate only on boot.
> 
> However the module driver model of the Integrator LM bus
> assumes that logic tile drivers can be probed at runtime. This
> is not really the case for IM-PD1: these tiles are detected at
> boot and they cannot be plugged into a running system. Before
> this patch it is of course possible to modprobe them later.
> 
> By first forcing the IM-PD1 to bool we make sure this driver
> gets compiled into the kernel, and we know it will be probed
> only at boot time when the tiles are detected, so we can tag
> its probe function __init_refok as we know it won't be called
> after boot now, and the section mismatch problem goes away.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Russell King <linux@arm.linux.org.uk>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ARM SoC folks: please apply this directly if the solution seems
> acceptable.

Looks good to me, I'm applying this on top of another fix
I have just added to next/soc2.

	Arnd
