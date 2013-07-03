From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 3 Jul 2013 09:46:24 +0800
Subject: [PATCH 3/5] ARM: dts: imx6: rename the uart's compatible property
In-Reply-To: <51D2AEC1.6030004@freescale.com>
References: <1372746628-20092-1-git-send-email-b32955@freescale.com>
 <1372746628-20092-4-git-send-email-b32955@freescale.com>
 <20130702095645.GD31358@e106331-lin.cambridge.arm.com>
 <51D2AEC1.6030004@freescale.com>
Message-ID: <20130703014623.GB9145@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 02, 2013 at 06:43:13PM +0800, Huang Shijie wrote:
> ? 2013?07?02? 17:56, Mark Rutland ??:
> >On Tue, Jul 02, 2013 at 07:30:26AM +0100, Huang Shijie wrote:
> >>>  The imx6 uart can supports the DMA, imx uart driver has added a new
> >>>  compatible property for the imx6 uart.
> >>>  >  In order to enable the DMA for some uart port in imx6, we
> >>rename the
> >>>  uart's compatible property to "fsl,imx6-uart".
> >Doesn't this change break using these dts with an older kernel? You
> is it reasonable to use a new dts with an old kernel?
> 
> 
> >remove the "fsl,imx21-uart" string older kernels understand.
> >
> >Given you already had "fsl,imx6q-uart" and "fsl,imx6sl-uart" strings,
> >would it not have made more sense to just add these to the driver?
> I think it's not a good idea.
> 
> Shawn, what's your opinion about this?

I agree with Mark.  I think all we need is to add "fsl,imx6q-uart"
into both driver matching table and imx6sl uart compatible property,
something like the below.

Shawn

---8<-------

diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index c5e5da0..078dfc7 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -152,7 +152,8 @@
                                };

                                uart5: serial@02018000 {
-                                       compatible = "fsl,imx6sl-uart", "fsl,imx21-uart";
+                                       compatible = "fsl,imx6sl-uart", "fsl,imx6q-uart",
+                                                    "fsl,imx21-uart";
                                        reg = <0x02018000 0x4000>;
                                        interrupts = <0 30 0x04>;
                                        clocks = <&clks IMX6SL_CLK_UART>,
diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 8cdfbd3..457984d 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -249,6 +249,7 @@ MODULE_DEVICE_TABLE(platform, imx_uart_devtype);
 static struct of_device_id imx_uart_dt_ids[] = {
        { .compatible = "fsl,imx1-uart", .data = &imx_uart_devdata[IMX1_UART], },
        { .compatible = "fsl,imx21-uart", .data = &imx_uart_devdata[IMX21_UART], },
+       { .compatible = "fsl,imx6q-uart", .data = &imx_uart_devdata[IMX6Q_UART], },
        { /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, imx_uart_dt_ids);
