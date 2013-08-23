From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 23 Aug 2013 08:56:07 +0100
Subject: [PATCH 09/33] ARM: ux500: Supply the I2C clocks lookup to the
 DBX500 DT
In-Reply-To: <20130822211912.GE31036@pengutronix.de>
References: <1370521041-32318-1-git-send-email-lee.jones@linaro.org>
 <1370521041-32318-10-git-send-email-lee.jones@linaro.org>
 <CACRpkdbE86HgPr+7LZD9BFU_OsDFFFWTaFHW_i2fNXivKZ-3Dw@mail.gmail.com>
 <20130820093034.GL31036@pengutronix.de>
 <20130822133730.GB23152@e106331-lin.cambridge.arm.com>
 <20130822141900.GB17154@lee--X1>
 <20130822151723.GE23152@e106331-lin.cambridge.arm.com>
 <20130822154116.GC17154@lee--X1>
 <20130822211912.GE31036@pengutronix.de>
Message-ID: <20130823075607.GD17154@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I had a short chat with Rob last night about this. I'm going to loop
him in to the conversation, as he wrote the binding.

> > When most of the other clocks that we deal with are being requested,
> > they rely on being index zero:
> > 
> >   drivers/i2c/busses/i2c-nomadik.c: dev->clk = clk_get(&adev->dev, NULL);
> 
> Look at drivers/clk/clkdev.c, there's some fuzzy matching
> involved when you pass NULL as connection id.

Yes, I've been looking at that. This is why it works currently. I
think I need to change all of the drivers to specify which clock they
want. At the moment that 'fuzzy matching' is what's saving us. If
anyone were to change our DTS file to match what the binding says,
then it would cease to work. I'm guessing this is the same for all
other DTS files too:

arch/arm/boot/dts/imx23.dtsi:                clock-names = "uart", "apb_pclk";
arch/arm/boot/dts/imx28.dtsi:                clock-names = "uart", "apb_pclk";
arch/arm/boot/dts/nspire-cx.dts:             clock-names = "uart_clk", "apb_pclk";
arch/arm/boot/dts/ste-nomadik-stn8815.dtsi:  clock-names = "timclk", "apb_pclk";
arch/arm/boot/dts/ste-nomadik-stn8815.dtsi:  clock-names = "timclk", "apb_pclk";
arch/arm/boot/dts/ste-nomadik-stn8815.dtsi:  clock-names = "uartclk", "apb_pclk";
arch/arm/boot/dts/ste-nomadik-stn8815.dtsi:  clock-names = "uartclk", "apb_pclk";
arch/arm/boot/dts/ste-nomadik-stn8815.dtsi:  clock-names = "uartclk", "apb_pclk";
arch/arm/boot/dts/ste-nomadik-stn8815.dtsi:  clock-names = "rng", "apb_pclk";
arch/arm/boot/dts/ste-nomadik-stn8815.dtsi:  clock-names = "mclk", "apb_pclk";
arch/arm/boot/dts/vexpress-v2m-rs1.dtsi:     clock-names = "refclk", "timclk", "apb_pclk";
arch/arm/boot/dts/vexpress-v2m-rs1.dtsi:     clock-names = "mclk", "apb_pclk";
arch/arm/boot/dts/vexpress-v2m-rs1.dtsi:     clock-names = "KMIREFCLK", "apb_pclk";
arch/arm/boot/dts/vexpress-v2m-rs1.dtsi:     clock-names = "KMIREFCLK", "apb_pclk";
arch/arm/boot/dts/vexpress-v2m-rs1.dtsi:     clock-names = "uartclk", "apb_pclk";
arch/arm/boot/dts/vexpress-v2m-rs1.dtsi:     clock-names = "uartclk", "apb_pclk";
arch/arm/boot/dts/vexpress-v2m-rs1.dtsi:     clock-names = "uartclk", "apb_pclk";
arch/arm/boot/dts/vexpress-v2m-rs1.dtsi:     clock-names = "uartclk", "apb_pclk";
arch/arm/boot/dts/vexpress-v2m-rs1.dtsi:     clock-names = "wdogclk", "apb_pclk";
arch/arm/boot/dts/vexpress-v2m-rs1.dtsi:     clock-names = "timclken1", "timclken2", "apb_pclk";
arch/arm/boot/dts/vexpress-v2m-rs1.dtsi:     clock-names = "timclken1", "timclken2", "apb_pclk";
arch/arm/boot/dts/vexpress-v2m-rs1.dtsi:     clock-names = "clcdclk", "apb_pclk";
arch/arm/boot/dts/vexpress-v2m.dtsi:         clock-names = "refclk", "timclk", "apb_pclk";
arch/arm/boot/dts/vexpress-v2m.dtsi:         clock-names = "mclk", "apb_pclk";
arch/arm/boot/dts/vexpress-v2m.dtsi:         clock-names = "KMIREFCLK", "apb_pclk";
arch/arm/boot/dts/vexpress-v2m.dtsi:         clock-names = "KMIREFCLK", "apb_pclk";
arch/arm/boot/dts/vexpress-v2m.dtsi:         clock-names = "uartclk", "apb_pclk";
arch/arm/boot/dts/vexpress-v2m.dtsi:         clock-names = "uartclk", "apb_pclk";
arch/arm/boot/dts/vexpress-v2m.dtsi:         clock-names = "uartclk", "apb_pclk";
arch/arm/boot/dts/vexpress-v2m.dtsi:         clock-names = "uartclk", "apb_pclk";
arch/arm/boot/dts/vexpress-v2m.dtsi:         clock-names = "wdogclk", "apb_pclk";
arch/arm/boot/dts/vexpress-v2m.dtsi:         clock-names = "timclken1", "timclken2", "apb_pclk";
arch/arm/boot/dts/vexpress-v2m.dtsi:         clock-names = "timclken1", "timclken2", "apb_pclk";
arch/arm/boot/dts/vexpress-v2m.dtsi:         clock-names = "clcdclk", "apb_pclk";
arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts:  clock-names = "wdogclk", "apb_pclk";
arch/arm/boot/dts/vexpress-v2p-ca9.dts:      clock-names = "clcdclk", "apb_pclk";
arch/arm/boot/dts/vexpress-v2p-ca9.dts:      clock-names = "timclk", "apb_pclk";
arch/arm/boot/dts/vexpress-v2p-ca9.dts:      clock-names = "wdogclk", "apb_pclk";

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
