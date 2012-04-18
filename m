From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 18 Apr 2012 20:09:17 +0200
Subject: [PATCH v3 8/8] i2c: Add device tree support to i2c-pnx.c
In-Reply-To: <1333528480-17134-9-git-send-email-stigge@antcom.de>
References: <1333528480-17134-1-git-send-email-stigge@antcom.de>
 <1333528480-17134-9-git-send-email-stigge@antcom.de>
Message-ID: <20120418180917.GD2548@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 04, 2012 at 10:34:40AM +0200, Roland Stigge wrote:
> This patch adds device tree support to the pnx-i2c driver by using platform
> resources for memory region and irq and removing dependency on mach includes.
> 
> The following platforms are affected:
> 
> * PNX
> * LPC31xx (WIP)
> * LPC32xx
> 
> The patch is based on a patch by Jon Smirl, working on lpc31xx integration
> 
> Signed-off-by: Roland Stigge <stigge@antcom.de>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>

I added devicetree-discuss to the (quite long) CC list. I am not sure
about all of the bindings.

> 
> ---
> 
>  Applies to v3.4-rc1
> 
>  Documentation/devicetree/bindings/i2c/pnx.txt |   40 ++++++++++++++++
>  drivers/i2c/busses/i2c-pnx.c                  |   65 +++++++++++++++++++-------
>  include/linux/i2c-pnx.h                       |    1 
>  3 files changed, 89 insertions(+), 17 deletions(-)
> 
> --- /dev/null
> +++ linux-2.6/Documentation/devicetree/bindings/i2c/pnx.txt
> @@ -0,0 +1,40 @@
> +* NXP PNX I2C Controller
> +
> +Required properties:
> +
> + - reg: Offset and length of the register set for the device
> + - compatible: should be "nxp,pnx-i2c"
> + - interrupts: configure one interrupt line
> + - #address-cells: always 1 (for i2c addresses)
> + - #size-cells: always 0
> +
> +Optional properties:
> +
> + - interrupt-parent: the phandle for the interrupt controller that
> +   services interrupts for this device.

That one is not optional, or? You always need it but in most cases it
gets inherited as I understand.

> + - clock-frequency: desired I2C bus clock frequency in Hz, Default: 100000 Hz
> + - pnx,timeout: I2C bus timeout in milliseconds, Default: 10 ms

To devicetree-folks: Can we argue this is a hardware property of the
bus? Then we could introduce a generic "timeout" property? I see, there
is already "fsl,timeout", and it won't make sense to have that per
vendor?

> + - slave-addr: Address used by the controller, Hardware default: 110

I'd prefer the hex value here, I2C addresses are mostly specified in
hex.

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120418/1cafc3d8/attachment-0001.sig>
