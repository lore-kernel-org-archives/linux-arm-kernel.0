From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 05 Sep 2016 16:37:23 +0200
Subject: [PATCH 2/3] ARM: pxa: lubbock: add pcmcia clock
References: <1473015587-15589-1-git-send-email-robert.jarzmik@free.fr>
 <1473015587-15589-2-git-send-email-robert.jarzmik@free.fr>
 <20160904200827.GL1041@n2100.armlinux.org.uk>
Message-ID: <877faqjtuk.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@armlinux.org.uk> writes:

> On Sun, Sep 04, 2016 at 08:59:46PM +0200, Robert Jarzmik wrote:
>> Add the clock provided to the PCMCIA block so that sa1111_pcmcia_add()
>> doesn't end up on error while probing "1800" device.
>
> I don't think this is correct - SA1111 is not really the PCMCIA
> controller - it's a load of logic which sits between the host
> device and the PCMCIA sockets to manage buffers and the PCMCIA
> socket control signals.

Gah I was naively thinking the SA1111 clock was used in the SA1111 to sample the
CF lines, and as a consequence, that the asynchronous nPIOWait, nPIORead,
nPIOWrite were derived from it.

I suppose the SA1111 takes 2 clocks, one for PS/2 etc ..., and SDCLK<1> for the
PCMCIA operations, while I was thinking SDCLK<1> input to SA1111 was only for
alternate bus-master operations.

> The quick fix here is to add a clock for the SA1111 PCMCIA sub-device,
> but it still needs to be the SoC memory clock - iow, what
> get_memclk_frequency_10khz() would have returned as that's what
> pxa2xx_base.c wants.
Right.

Would grant your sign-off to your patch in [1], if the commit message is good
enough for you (I can fix it up if the wording is too ... french) ?

Cheers.

-- 
Robert

[1]
---8>---
>From f8ba8367164056d7a79052b2b10fcecabd8e854d Mon Sep 17 00:00:00 2001
From: Russell King <rmk+kernel@armlinux.org.uk>
Date: Sun, 4 Sep 2016 19:59:19 +0200
Subject: [PATCH] ARM: pxa: lubbock: add pcmcia clock

Add the clock provided to the PCMCIA block so that sa1111_pcmcia_add()
doesn't end up on error while probing "1800" device.

[To be confirmed] Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mach-pxa/lubbock.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-pxa/lubbock.c b/arch/arm/mach-pxa/lubbock.c
index cd401546cea8..d7c5fb00da7a 100644
--- a/arch/arm/mach-pxa/lubbock.c
+++ b/arch/arm/mach-pxa/lubbock.c
@@ -149,6 +149,20 @@ static struct gpiod_lookup_table sa1111_pcmcia_gpio_table = {
 	},
 };
 
+static void lubbock_init_pcmcia(void)
+{
+	struct clk *clk;
+
+	gpiod_add_lookup_table(&sa1111_pcmcia_gpio_table);
+
+	/* Add an alias for the SA1111 PCMCIA clock */
+	clk = clk_get_sys("pxa2xx-pcmcia", NULL);
+	if (!IS_ERR(clk)) {
+		clkdev_create(clk, NULL, "1800");
+		clk_put(clk);
+	}
+}
+
 static struct resource sa1111_resources[] = {
 	[0] = {
 		.start	= 0x10000000,
@@ -488,7 +502,7 @@ static void __init lubbock_init(void)
 	pxa_set_btuart_info(NULL);
 	pxa_set_stuart_info(NULL);
 
-	gpiod_add_lookup_table(&sa1111_pcmcia_gpio_table);
+	lubbock_init_pcmcia();
 
 	clk_add_alias("SA1111_CLK", NULL, "GPIO11_CLK", NULL);
 	pxa_set_udc_info(&udc_info);
-- 
2.1.4
