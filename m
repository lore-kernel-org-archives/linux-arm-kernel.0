From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 10 Mar 2015 08:55:43 +0100
Subject: [PATCH] clk: mediatek: Export CPU mux clocks for CPU frequency
 control
In-Reply-To: <CALx668V4KJBmpSg3PKfXuzJsMHWgY=RCh8L=TzTC7-fEUh5HBw@mail.gmail.com>
References: <1425466152-7867-1-git-send-email-pi-cheng.chen@linaro.org>
 <20150304112109.GB11010@pengutronix.de>
 <CALx668WKKmifhuODsV+Uaoq4ggcmB1=wbpLzXBnjEtxbuB4qig@mail.gmail.com>
 <20150305074207.GC11010@pengutronix.de>
 <CALx668V4KJBmpSg3PKfXuzJsMHWgY=RCh8L=TzTC7-fEUh5HBw@mail.gmail.com>
Message-ID: <20150310075543.GB24885@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 10, 2015 at 09:53:19AM +0800, Pi-Cheng Chen wrote:
> On 5 March 2015 at 15:42, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> >
> > My suggestion is to take another approach. Implement clk_set_rate for
> > these muxes and in the set_rate hook:
> >
> > - switch mux to intermediate PLL parent
> > - call clk_set_rate() for the real parent PLL
> > - switch mux back to real parent PLL
> 
> Hi Sascha,
> 
> Thanks for your suggestion. I've tried to take this approach, but there's some
> issues here.
> 
> Calling clk_set_rate() inside the set_rate callback of cpumux will cause
> an infinite recursive calling in the clock framework:
> mux.set_rate() -> pll.set_rate() -> mux.set_rate -> ...

I don't understand why setting the PLL rate should call into the mux
set_rate. Are you sure you call clk_set_rate for the mux parent clk?
I think the general approach should work, drivers/clk/sirf/clk-common.c
does something similar in cpu_clk_set_rate(). If you like you can send
me your work in progress state privatly, I'll have a look then.

> 
> I've also tries to update pll register settings in the set_rate()
> callback of cpumux,
> but the PLL clock information will not be correctly updated in this case.

No, that won't work.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
