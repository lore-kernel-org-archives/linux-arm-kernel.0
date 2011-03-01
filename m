From: r.sricharan@ti.com (Sricharan R)
Date: Wed, 2 Mar 2011 00:46:19 +0530
Subject: [PATCH 6/7] OMAP: Serial: Allow UART parameters to be configured
	from board file
In-Reply-To: <1298903958-6496-7-git-send-email-govindraj.raja@ti.com>
References: <1298903958-6496-1-git-send-email-govindraj.raja@ti.com>
	<1298903958-6496-7-git-send-email-govindraj.raja@ti.com>
Message-ID: <056ac5e848953fa5c37f7ed7a8cc1050@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
>diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
>index 755f4aa..530e9e3 100644
>--- a/arch/arm/mach-omap2/serial.c
>+++ b/arch/arm/mach-omap2/serial.c
>@@ -44,6 +44,15 @@
>
> static int omap_uart_con_id __initdata = -1;
>
>+static struct omap_uart_port_info omap_serial_default_info[] = {
>+	{
>+		.dma_enabled	= 0,
>+		.dma_rx_buf_size = DEFAULT_RXDMA_BUFSIZE,
>+		.dma_rx_timeout = DEFAULT_RXDMA_TIMEOUT,
>+		.idle_timeout	= DEFAULT_IDLE_TIMEOUT,
>+	},
>+};
>+
> static int uart_idle_hwmod(struct omap_device *od)
> {
> 	omap_hwmod_idle(od->hwmods[0]);
>@@ -66,6 +75,54 @@ static struct omap_device_pm_latency
omap_uart_latency[]
>= {
> 	},
> };
>
>+#ifdef CONFIG_OMAP_MUX
>+static struct omap_device_pad default_serial0_pads[] __initdata = {
>+	{
>+		.name	= "uart1_rx.uart1_rx",
>+		.flags	= OMAP_DEVICE_PAD_REMUX | OMAP_DEVICE_PAD_WAKEUP,
>+		.enable	= OMAP_MUX_MODE0,
>+	},
>+};
>+
>+static struct omap_device_pad default_serial1_pads[] __initdata = {
>+	{
>+		.name	= "uart2_rx.uart2_rx",
>+		.flags	= OMAP_DEVICE_PAD_REMUX | OMAP_DEVICE_PAD_WAKEUP,
>+		.enable	= OMAP_MUX_MODE0,
>+	},
>+};
>+
>+static struct omap_device_pad default_serial2_pads[] __initdata = {
>+	{
>+		.name	= "uart3_rx_irrx.uart3_rx_irrx",
>+		.flags	= OMAP_DEVICE_PAD_REMUX | OMAP_DEVICE_PAD_WAKEUP,
>+		.enable	= OMAP_MUX_MODE0,
>+	},
>+};
>+
>+static struct omap_device_pad default_omap36xx_serial3_pads[] __initdata
=
>{
>+	{
>+		.name	= "gpmc_wait3.uart4_rx",
>+		.flags	= OMAP_DEVICE_PAD_REMUX | OMAP_DEVICE_PAD_WAKEUP,
>+		.enable	= OMAP_MUX_MODE2,
>+	},
>+};
>+
>+static struct omap_device_pad default_omap4_serial3_pads[] __initdata =
{
>+	{
>+		.name	= "uart4_rx.uart4_rx",
>+		.flags	= OMAP_DEVICE_PAD_REMUX | OMAP_DEVICE_PAD_WAKEUP,
>+		.enable	= OMAP_MUX_MODE0,
>+	},
>+};
Here only the UART RX pins are muxed, so what about the cts, rts, tx pins?
Is it consistent that across all socs that only UART3 would have UART/IRDA
functions capability so that serial2 pads can always be called "rx_irxx"
?.

Thanks,
 sricharan
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>the body of a message to majordomo at vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
