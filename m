From: me@felipebalbi.com (Felipe Balbi)
Date: Wed, 30 Dec 2009 15:14:41 +0200
Subject: [patch-v2.6.34 7/9] usb: musb: use only clk framework for clk
	handling
In-Reply-To: <4B3B504B.4020602@ru.mvista.com>
References: <1262127567-15202-1-git-send-email-felipe.balbi@nokia.com>
	<1262127567-15202-8-git-send-email-felipe.balbi@nokia.com>
	<4B3B3720.9070205@ru.mvista.com> <1262174012.28789.178.camel@gandalf>
	<4B3B504B.4020602@ru.mvista.com>
Message-ID: <1262178881.17250.1.camel@gandalf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, 2009-12-30 at 16:06 +0300, Sergei Shtylyov wrote:
> Hello.
> 
> Felipe Balbi wrote:
> 
> >>    Why always "ick"?! Do you think OMAPs are the only boards using MUSB 
> >> out there?
> >>     
> >
> > err, I'm afraid you have to read more about clock framework. The clock
> > name should not matter when you issue clk_get().
> 
>    It depends on the matching type determined from a clkdev matching 
> table -- see dm644x_clks[] in arch/mach-davinci/dm644x.c as an example: 
> 'struct davinci_clk' incorporates 'struct clk_lookup', and where its 1st 
> member is initialized, the matching is done by device, where its second 
> member is initialized, the matching is done by clock name -- see 
> clk_find() in arch/arm/common/clkdev.c for the logic.

diff --git a/arch/arm/mach-davinci/dm644x.c
b/arch/arm/mach-davinci/dm644x.c
index 2cd0081..a0ad7b6 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -306,7 +306,7 @@ struct davinci_clk dm644x_clks[] = {
        CLK("davinci_mmc.0", NULL, &mmcsd_clk),
        CLK(NULL, "spi", &spi_clk),
        CLK(NULL, "gpio", &gpio_clk),
-       CLK(NULL, "usb", &usb_clk),
+       CLK("musb_hdrc", "usb", &usb_clk),
        CLK(NULL, "vlynq", &vlynq_clk),
        CLK(NULL, "aemif", &aemif_clk),
        CLK(NULL, "pwm0", &pwm0_clk),


there you are...

-- 
balbi
