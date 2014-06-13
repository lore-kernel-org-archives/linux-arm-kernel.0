From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 13 Jun 2014 15:32:58 +0200
Subject: [PATCH v2] ARM: integrator: fix section mismatch problem
In-Reply-To: <1401886048-22209-1-git-send-email-linus.walleij@linaro.org>
References: <1401886048-22209-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <201406131532.59198.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 04 June 2014, Linus Walleij wrote:
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
> As a side effect, sysfs binding from userspace becomes
> impossible, so we tag the driver to suppress the bind/unbind
> sysfs attributes.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Russell King <linux@arm.linux.org.uk>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Suppress sysfs bind/unbind for the IM-PD1
> 
> ARM SoC folks: please apply this directly if the solution seems
> acceptable.
> ---

Applied to fixes branch, thanks.

	Arnd
