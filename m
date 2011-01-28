From: khilman@ti.com (Kevin Hilman)
Date: Fri, 28 Jan 2011 13:47:52 -0800
Subject: [PATCH] davinci: tnetv107x: fix register indexing for GPIOs
	numbers > 31
In-Reply-To: <1295993126-6841-1-git-send-email-hirosh.dabui@snom.com> (Hirosh
	Dabui's message of "Tue, 25 Jan 2011 23:05:26 +0100")
References: <1295993126-6841-1-git-send-email-hirosh.dabui@snom.com>
Message-ID: <8762t8d7jr.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hirosh Dabui <hirosh.dabui@snom.com> writes:

> This patch fix a bug in the register indexing for GPIOs numbers >  31
> to get the relevant hardware registers of tnetv107x to control the GPIOs.
>
> In the structure tnetv107x_gpio_regs:
>
> struct tnetv107x_gpio_regs {
>             u32     idver;
>             u32     data_in[3];
>             u32     data_out[3];
>             u32     direction[3];
>             u32     enable[3];
> };
>
> The GPIO hardware register addresses of tnetv107x are stored.
> The chip implements 3 registers of each entity to serve 96 GPIOs,
> each register provides a subset of 32 GPIOs.
> The driver provides these macros: gpio_reg_set_bit, gpio_reg_get_bit
> and gpio_reg_clear_bit.
>
> The bug implied the use of macros to access the relevant hardware
> register e.g. the driver code used the macro like this:
> 'gpio_reg_clear_bit(&reg->data_out, gpio)'
>
> But it has to be used like this:
> 'gpio_reg_clear_bit(reg->data_out, gpio)'.
>
> The different results are shown here:
> - &reg->data_out + 1 (it will add the full array size of data_out i.e. 12 bytes)
> - reg->data_out + 1 (it will increment only the size of data_out i.e. only 4 bytes)
>
> Acked-by: Cyril Chemparathy <cyril@ti.com>
> Signed-off-by: Hirosh Dabui <hirosh.dabui@snom.com>

Thanks, applied and queuing for 2.6.39.

Kevin
