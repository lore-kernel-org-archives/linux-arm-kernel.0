From: N.Voss@weinmann.de (Voss, Nikolaus)
Date: Mon, 23 Jul 2012 07:03:11 +0200
Subject: Build error with [PATCH v10 3/4] drivers/i2c/busses/i2c-at91.c
In-Reply-To: <CAFLc3bpiu4zEKwkA8QSH0ORQp+6frmMn2AUNeQ4rURCtxTOM5Q@mail.gmail.com>
References: <CAFLc3brYJGkQoW5mGi9XaujNBMBdGX6RxfkNRbBZJQz_axz_Jg@mail.gmail.com>
 <EF2E73589CA71846A15D0B2CDF79505D090EA1AA99@wm021.weinmann.com>
 <CAFLc3bpiu4zEKwkA8QSH0ORQp+6frmMn2AUNeQ4rURCtxTOM5Q@mail.gmail.com>
Message-ID: <EF2E73589CA71846A15D0B2CDF79505D090EA8F0F8@wm021.weinmann.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefano,

Stefano Salati wrote on 2012-07-21:
> I did as you suggested, I manage to compile but get a waterfall of errors
> while booting the image (file attached).
> 
> I applied all the patches (manually so to better understand what was being
> done), apart from this one: https://lkml.org/lkml/2012/4/20/112
> as the file I'd patch is completely different (apart from the fact that my
> file is "at91sam9x5.c" I've checked also those you mention in the patch to
> take inspiration and are completely different as well). I attached
> at91sam9x5.c to explain better.

your at91sam9x5.c is quite out of date. If you can, you should use a more
recent kernel. If not, try to add the following to the file:

+static struct clk_lookup periph_clocks_lookups[] = {
+	CLKDEV_CON_DEV_ID(NULL, "at91_i2c.0", &twi0_clk),
+	CLKDEV_CON_DEV_ID(NULL, "at91_i2c.1", &twi1_clk),
+	CLKDEV_CON_DEV_ID(NULL, "at91_i2c.2", &twi2_clk),
+};

and in at91sam9x5_register_clocks():

	for (i = 0; i < ARRAY_SIZE(periph_clocks); i++)
		clk_register(periph_clocks[i]);

+	clkdev_add_table(periph_clocks_lookups,
+			 ARRAY_SIZE(periph_clocks_lookups));

	if (cpu_is_at91sam9g25()
	|| cpu_is_at91sam9x25())
		clk_register(&usart3_clk);

For a recent kernel, it should be:

diff --git a/arch/arm/mach-at91/at91sam9x5.c b/arch/arm/mach-at91/at91sam9x5.c
index 13c8cae..bfdd429 100644
--- a/arch/arm/mach-at91/at91sam9x5.c
+++ b/arch/arm/mach-at91/at91sam9x5.c
@@ -225,6 +225,9 @@ static struct clk_lookup periph_clocks_lookups[] = {
 	CLKDEV_CON_DEV_ID("t0_clk", "f800c000.timer", &tcb0_clk),
 	CLKDEV_CON_DEV_ID("dma_clk", "ffffec00.dma-controller", &dma0_clk),
 	CLKDEV_CON_DEV_ID("dma_clk", "ffffee00.dma-controller", &dma1_clk),
+	CLKDEV_CON_DEV_ID(NULL, "at91_i2c.0", &twi0_clk),
+	CLKDEV_CON_DEV_ID(NULL, "at91_i2c.1", &twi1_clk),
+	CLKDEV_CON_DEV_ID(NULL, "at91_i2c.2", &twi2_clk),
 	CLKDEV_CON_ID("pioA", &pioAB_clk),
 	CLKDEV_CON_ID("pioB", &pioAB_clk),
 	CLKDEV_CON_ID("pioC", &pioCD_clk),
