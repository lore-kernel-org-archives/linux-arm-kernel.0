From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 11 Jun 2014 10:47:57 +0200
Subject: [PATCH v6 2/2] i2c: sunxi: add P2WI (Push/Pull 2 Wire Interface)
 controller support
In-Reply-To: <1402475980-15513-3-git-send-email-boris.brezillon@free-electrons.com>
References: <1402475980-15513-1-git-send-email-boris.brezillon@free-electrons.com>
 <1402475980-15513-3-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <4433415.Jcexj2E6Ru@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 11 June 2014 10:39:40 Boris BREZILLON wrote:
> The P2WI controller looks like an SMBus controller which only supports byte
> data transfers. But, it differs from standard SMBus protocol on several
> aspects:
> - it supports only one slave device, and thus drop the address field
> - it adds a parity bit every 8bits of data
> - only one read access is required to read a byte (instead of a write
>   followed by a read access in standard SMBus protocol)
> - there's no Ack bit after each byte transfer
> 
> This means this bus cannot be used to interface with standard SMBus
> devices (the only known device to support this interface is the AXP221
> PMIC).
> However the P2WI protocol is close enough to SMBus to be integrated in
> the I2C subsystem (see this thread [1] for detailed reasons that led to
> integrating this driver in the I2C subsystem).
> 
> [1] http://www.spinics.net/lists/linux-i2c/msg15066.html
> 
> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>

> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index c94db1c..a6023fe 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -771,6 +771,18 @@ config I2C_STU300
>           This driver can also be built as a module. If so, the module
>           will be called i2c-stu300.
>  
> +config I2C_SUN6I_P2WI
> +       tristate "Allwinner sun6i internal P2WI controller"
> +       depends on MACH_SUN6I && RESET_CONTROLLER

One very minor comment: I wonder if we should make this 

	depends on RESET_CONTROLLER
	depends on MACH_SUN6I || COMPILE_TEST

instead so we have better build coverage. I haven't tested if building
on other architectures works, or if there are additional dependencies.

No need to change this if there are no other comments.

	Arnd
