From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Thu, 06 Sep 2012 18:23:47 -0700 (PDT)
Subject: [PATCH] ARM: shmobile: r8a7740: add USB24 clock explain and
 sample code
In-Reply-To: <20120905225431.GD32084@quad.lixom.net>
References: <1346305969-27110-1-git-send-email-horms@verge.net.au>
 <1346305969-27110-2-git-send-email-horms@verge.net.au>
 <20120905225431.GD32084@quad.lixom.net>
Message-ID: <87d31yaan3.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Olof

Thank you for checking patch

> On Thu, Aug 30, 2012 at 02:52:49PM +0900, Simon Horman wrote:
> > From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > 
> > USBCKCR is controlling USB parent clock and divide rate.
> > This parent clock is used as a "usb24s" from other devices,
> > but the "divide rate" is not used.
> > Further, this clock itself is known as "usb24".
> > So, to set this clock is a little confusable.
> > This patch adds quick explain and sample code for this clock.
> > 
> > Cc: Damian Hobson-Garcia <dhobsong@igel.co.jp>
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > Signed-off-by: Simon Horman <horms@verge.net.au>
> > ---
> >  arch/arm/mach-shmobile/clock-r8a7740.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> > 
> > diff --git a/arch/arm/mach-shmobile/clock-r8a7740.c b/arch/arm/mach-shmobile/clock-r8a7740.c
> > index ad5fccc..a6a7583 100644
> > --- a/arch/arm/mach-shmobile/clock-r8a7740.c
> > +++ b/arch/arm/mach-shmobile/clock-r8a7740.c
> > @@ -188,6 +188,22 @@ static struct clk pllc1_div2_clk = {
> >  };
> >  
> >  /* USB clock */
> > +/*
> > + * USBCKCR is controlling usb24 clock
> > + * bit[7] : parent clock
> > + * bit[6] : clock divide rate
> 
> The divisor is either 1 or 2 in this case, for bit[6] values of 0 and 1?

Yes.
if (0 == bit[6]) clock is 1/2
if (1 == bit[6]) clock is 1/1

> > + * And this bit[7] is used as a "usb24s" from other devices.
> 
> Sorry, I don't follow the explanation here.
> 
> This is how I interpret the current code, can you confirm if it's accurate?
> 
> usb24 is the (potentially) divided output from usb24s, while usb24s is
> at a fixed pass-through rate from the parent if enabled. Both share the
> same enable bit. In other words, usb24 is a directly derived, potentially
> divided-by-two rate from usb24s?

clcok A ---+  bit[7]                 bit[6]
           |- select -> usb24s -+--> divide (1/1 or 1/2) -> usb24
clock B ---+                    |
                                +--> other clocks ->


> > + * (Video clock / Sub clock / SPU clock)
> > + * You can controll this clock as a below.
> > + *
> > + * struct clk *usb24	= clk_get(dev,  "usb24");
> > + * struct clk *usb24s	= clk_get(NULL, "usb24s");
> > + * struct clk *system	= clk_get(NULL, "system_clk");
> > + * int rate = clk_get_rate(system);
> > + *
> > + * clk_set_parent(usb24s, system);  // for bit[7]
> > + * clk_set_rate(usb24, rate / 2);   // for bit[6]
> 
> This is just standard clk infrastructure usage, I don't think there's need to
> include the example code here.

Ahh.. 50% yes.

_If_ this usb24/usb24s explanation on datasheet is same as other clocks,
it is easy to understand and can use clk_set_rate().

But this setting style of these 2 clock is very special case on our datasheet.
Maybe first case.
So, I added sample setting code here,
since it is difficult to understand how to set the clock from
datasheet/clock tree and clock-r8a7740.c

Best regards
---
Kuninori Morimoto
