From: ben-linux@fluff.org (Ben Dooks)
Date: Sun, 14 Feb 2010 21:18:06 +0000
Subject: i2c-imx: Autoprobe of eeproms
In-Reply-To: <4B75D317.7040801@vmlinux.org>
References: <4B75D317.7040801@vmlinux.org>
Message-ID: <20100214211806.GA30679@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 12, 2010 at 11:15:51PM +0100, Mattias Walstrom wrote:
> I have tried to get autoprobe of eeproms to work on a custom freescale
> mx27-board, and i found out that the i2c-imx driver was missing the
> following, is there a reason for this, most other i2c-bus drivers seems
> to have it?

auto-probing of anything on an i2c bus is always going to be trumped
by actually knowing. The limited address space means often different
types of peripherals can end up with similar addresses.

It is highly recommended in the ARM world where the board information is
known from early in the initialisation process that the board registers
the devices it knows to have available so that the i2c core can atatch
the relevant drivers.

I'm not even sure if SPD is the right class to have on this, I think
Jean Delvare has pronounced on this on the linux-i2c list (iirc, it
is for probing DRAM DIMMS).

Even if Jean hasn't nixed this, I would still prefer not to apply this.

PS, this should have been cc'd to the linux-i2c list!
 
> --- linux-2.6.32.8.orig/drivers/i2c/busses/i2c-imx.c    2010-02-09
> 13:57:19.000000000 +0100
> +++ linux-2.6.32.8/drivers/i2c/busses/i2c-imx.c 2010-02-12
> 11:30:12.000000000 +0100
> @@ -521,6 +521,7 @@
>         i2c_imx->adapter.algo           = &i2c_imx_algo;
>         i2c_imx->adapter.dev.parent     = &pdev->dev;
>         i2c_imx->adapter.nr             = pdev->id;
> +        i2c_imx->adapter.class          = I2C_CLASS_HWMON | I2C_CLASS_SPD;
>         i2c_imx->irq                    = irq;
>         i2c_imx->base                   = base;
>         i2c_imx->res                    = res;
> 
> 
> Best regards
> Mattias Walstr?m

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
