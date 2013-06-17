From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 17 Jun 2013 10:48:44 +0200
Subject: [RFC] Staging: imx-drm: Do not use fractional part of divider
In-Reply-To: <1371195670.904413971@f400.i.mail.ru>
References: <1371195670.904413971@f400.i.mail.ru>
Message-ID: <20130617084844.GP32299@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 14, 2013 at 11:41:10AM +0400, Alexander Shiyan wrote:
> Hello.
> 
> Analysis of driver imx-drm led me to believe that the use fractional part of the divider is not always a good idea.
> For example, for a parallel display bus connected to LVDS converter chip (DS90C363), in this case the use of
> fractional part, clock will unstable and the on-chip PLL is not working properly, or rather, does not work at all.
> 
> Let me give a specific example.
> ipu_crtc_mode_set 0x36314752
> imx-ipuv3 40000000.ipu: clk_di_round_rate: inrate: 133000000 div: 0x00000035 outrate: 40150928 wanted: 40000000
> imx-ipuv3 40000000.ipu: clk_di_round_rate: inrate: 133000000 div: 0x00000035 outrate: 40150928 wanted: 40150928
> imx-ipuv3 40000000.ipu: clk_di_set_rate: inrate: 133000000 desired: 40150928 div: 0x00000035
> 
> In this case the divider is 3.5, that result to clock is incorrect. See an attached oscillogram F0000TEK.jpg.
> 
> After a patch the clocks is OK. Patch just uncomment some FSL code.
> imx-ipuv3 40000000.ipu: clk_di_round_rate: inrate: 133000000 div: 0x00000040 outrate: 33250000 wanted: 40000000
> imx-ipuv3 40000000.ipu: clk_di_round_rate: inrate: 133000000 div: 0x00000040 outrate: 33250000 wanted: 33250000
> imx-ipuv3 40000000.ipu: clk_di_set_rate: inrate: 133000000 desired: 33250000 div: 0x00000040
> 
> See an attached oscillogram F0001TEK.jpg.
> 
> So, I want to review this from developers and wait for comments.
> 

We may need some flag in the devicetree to specify whether the
fractional divider can be used or not.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
