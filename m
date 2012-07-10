From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 10 Jul 2012 21:36:35 +0000
Subject: [PATCH v2 04/23] ARM: LPC32xx: Add DMA configuration to platform
 data
In-Reply-To: <1339692673-7848-5-git-send-email-stigge@antcom.de>
References: <1339692673-7848-1-git-send-email-stigge@antcom.de>
 <1339692673-7848-5-git-send-email-stigge@antcom.de>
Message-ID: <201207102136.35944.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 14 June 2012, Roland Stigge wrote:
> --- linux-2.6.orig/arch/arm/mach-lpc32xx/phy3250.c
> +++ linux-2.6/arch/arm/mach-lpc32xx/phy3250.c
> @@ -226,7 +226,38 @@ static int __init phy3250_spi_board_regi
>  }
>  arch_initcall(phy3250_spi_board_register);
>  
> +static struct pl08x_channel_data pl08x_slave_channels[] = {
> +	{
> +		.bus_id = "nand-slc",
> +		.min_signal = 1, /* SLC NAND Flash */
> +		.max_signal = 1,
> +		.periph_buses = PL08X_AHB1,
> +	},
> +	{
> +		.bus_id = "nand-mlc",
> +		.min_signal = 12, /* MLC NAND Flash */
> +		.max_signal = 12,
> +		.periph_buses = PL08X_AHB1,
> +	},
> +};
> +
> +/* NOTE: These will change, according to RMK */
> +static int pl08x_get_signal(struct pl08x_dma_chan *ch)
> +{
> +	return ch->cd->min_signal;
> +}
> +

This has changed now, rendering linux-next broken for lpc32xx_defconfig:

/home/arnd/linux-arm/arch/arm/mach-lpc32xx/phy3250.c:190:36: warning: 'struct pl08x_dma_chan' declared inside parameter list [enabled by default]
/home/arnd/linux-arm/arch/arm/mach-lpc32xx/phy3250.c:190:36: warning: its scope is only this definition or declaration, which is probably not what you want [enabled by default]
/home/arnd/linux-arm/arch/arm/mach-lpc32xx/phy3250.c: In function 'pl08x_get_signal':
/home/arnd/linux-arm/arch/arm/mach-lpc32xx/phy3250.c:192:11: error: dereferencing pointer to incomplete type
/home/arnd/linux-arm/arch/arm/mach-lpc32xx/phy3250.c: At top level:
/home/arnd/linux-arm/arch/arm/mach-lpc32xx/phy3250.c:195:37: warning: 'struct pl08x_dma_chan' declared inside parameter list [enabled by default]
/home/arnd/linux-arm/arch/arm/mach-lpc32xx/phy3250.c:202:2: warning: initialization from incompatible pointer type [enabled by default]
/home/arnd/linux-arm/arch/arm/mach-lpc32xx/phy3250.c:202:2: warning: (near initialization for 'pl08x_pd.get_signal') [enabled by default]
/home/arnd/linux-arm/arch/arm/mach-lpc32xx/phy3250.c:203:2: warning: initialization from incompatible pointer type [enabled by default]
/home/arnd/linux-arm/arch/arm/mach-lpc32xx/phy3250.c:203:2: warning: (near initialization for 'pl08x_pd.put_signal') [enabled by default]
/home/arnd/linux-arm/arch/arm/mach-lpc32xx/phy3250.c: In function 'pl08x_get_signal':
/home/arnd/linux-arm/arch/arm/mach-lpc32xx/phy3250.c:193:1: warning: control reaches end of non-void function [-Wreturn-type]
/home/arnd/linux-arm/drivers/mtd/nand/lpc32xx_slc.c: In function 'lpc32xx_dma_filter':
/home/arnd/linux-arm/drivers/mtd/nand/lpc32xx_slc.c:720:48: error: dereferencing pointer to incomplete type
/home/arnd/linux-arm/drivers/mtd/nand/lpc32xx_slc.c:720:67: warning: initialization from incompatible pointer type [enabled by default]
/home/arnd/linux-arm/drivers/mtd/nand/lpc32xx_slc.c:720:67: warning: (near initialization for 'ch') [enabled by default]
/home/arnd/linux-arm/drivers/mtd/nand/lpc32xx_slc.c:720:145: error: invalid use of undefined type 'struct pl08x_dma_chan'
/home/arnd/linux-arm/drivers/mtd/nand/lpc32xx_slc.c:723:8: error: dereferencing pointer to incomplete type
make[4]: *** [drivers/mtd/nand/lpc32xx_slc.o] Error 1
/home/arnd/linux-arm/drivers/mtd/nand/lpc32xx_mlc.c: In function 'lpc32xx_dma_filter':
/home/arnd/linux-arm/drivers/mtd/nand/lpc32xx_mlc.c:582:48: error: dereferencing pointer to incomplete type
/home/arnd/linux-arm/drivers/mtd/nand/lpc32xx_mlc.c:582:67: warning: initialization from incompatible pointer type [enabled by default]
/home/arnd/linux-arm/drivers/mtd/nand/lpc32xx_mlc.c:582:67: warning: (near initialization for 'ch') [enabled by default]
/home/arnd/linux-arm/drivers/mtd/nand/lpc32xx_mlc.c:582:145: error: invalid use of undefined type 'struct pl08x_dma_chan'
/home/arnd/linux-arm/drivers/mtd/nand/lpc32xx_mlc.c:585:8: error: dereferencing pointer to incomplete type
make[4]: *** [drivers/mtd/nand/lpc32xx_mlc.o] Error 1

As far as I can tell, each branch touching these files is ok individually,
but they don't go together.

There is also this bit of suspicious code in lpc32xx_slc:

static bool lpc32xx_dma_filter(struct dma_chan *chan, void *param)
{
        struct pl08x_dma_chan *ch =
                container_of(chan, struct pl08x_dma_chan, chan);

        /* In LPC32xx's PL080 DMA wiring, the SLC NAND DMA signal is #1 */
        if (ch->cd->min_signal == 1)
                return true;
        return false;
}

I dont't think that actually valid -- you cannot make any assumption about
the structure outside of dma_chan here, only about the parameter you pass
in.

	Arnd
