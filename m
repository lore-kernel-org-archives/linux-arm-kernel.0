From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Sun, 4 Sep 2016 21:28:51 +0100
Subject: [PATCH 2/3] ARM: pxa: lubbock: add pcmcia clock
In-Reply-To: <20160904200827.GL1041@n2100.armlinux.org.uk>
References: <1473015587-15589-1-git-send-email-robert.jarzmik@free.fr>
 <1473015587-15589-2-git-send-email-robert.jarzmik@free.fr>
 <20160904200827.GL1041@n2100.armlinux.org.uk>
Message-ID: <20160904202851.GA26352@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 04, 2016 at 09:08:27PM +0100, Russell King - ARM Linux wrote:
> On Sun, Sep 04, 2016 at 08:59:46PM +0200, Robert Jarzmik wrote:
> > Add the clock provided to the PCMCIA block so that sa1111_pcmcia_add()
> > doesn't end up on error while probing "1800" device.
> 
> I don't think this is correct - SA1111 is not really the PCMCIA
> controller - it's a load of logic which sits between the host
> device and the PCMCIA sockets to manage buffers and the PCMCIA
> socket control signals.
> 
> The timing is done by the SoC, and the PCMCIA driver needs a
> clock to compute the timing information for the PCMCIA interface.
> Originally, in 2.6.12-rc2, lubbock (and all of the PXA socket
> drivers) were using pxa2xx_base.c, which got the clock frequency
> via get_memclk_frequency_10khz().
> 
> In 2a125dd56b3a ("ARM: pxa: remove get_memclk_frequency_10khz()")
> this was changed to use the clk API, and added the "pxa2xx-pcmcia"
> clock.  However, it ignored Lubbock, because that doesn't use
> _that_ device, but the SA1111 PCMCIA sub-device "1800".  This commit
> should have introduced an identical entry for the SA1111 PCMCIA
> sub-device.
> 
> This is actually one of the problems converting these platforms to
> DT - seemingly simple stuff is actually quite complex because the
> resources are spread around.  In the case of Lubbock, some of the
> resources are on the PXA255 SoC, others are on the SA1111 which
> requires a fair amount of initialisation to get to.  I think we're
> really into the "combine multiple devices into one logical device"
> game (iow, using the component helper), just like DRM and other
> subsystems.
> 
> The quick fix here is to add a clock for the SA1111 PCMCIA sub-device,
> but it still needs to be the SoC memory clock - iow, what
> get_memclk_frequency_10khz() would have returned as that's what
> pxa2xx_base.c wants.

IOW, something like:

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
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
