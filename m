From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 5 Mar 2015 11:59:05 +0100
Subject: [PATCH] clk: mediatek: Export CPU mux clocks for CPU frequency
 control
In-Reply-To: <CAKohponSqLPcULA9-T8y9b_b44Torti0p6W3sJfRZ1oKUWqtTw@mail.gmail.com>
References: <1425466152-7867-1-git-send-email-pi-cheng.chen@linaro.org>
 <20150304112109.GB11010@pengutronix.de>
 <CALx668WKKmifhuODsV+Uaoq4ggcmB1=wbpLzXBnjEtxbuB4qig@mail.gmail.com>
 <20150305074207.GC11010@pengutronix.de>
 <CAKohponSqLPcULA9-T8y9b_b44Torti0p6W3sJfRZ1oKUWqtTw@mail.gmail.com>
Message-ID: <20150305105905.GK11010@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 05, 2015 at 02:29:50PM +0530, Viresh Kumar wrote:
> On 5 March 2015 at 13:12, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > We have clk_set_parent for changing the parent and clk_set_rate to
> > change the rate. Use the former for changing the parent and the latter
> > for changing the rate. What you are interested in is changing the
> > parent, so use clk_set_parent for this and not abuse a side effect
> > of clk_set_rate.
> 
> clk_set_rate() for CPUs clock is responsible to change clock rate
> of the CPU. Whether it plays with PLLs or muxes, its not that relevant.
> 
> > My suggestion is to take another approach. Implement clk_set_rate for
> > these muxes and in the set_rate hook:
> >
> > - switch mux to intermediate PLL parent
> > - call clk_set_rate() for the real parent PLL
> > - switch mux back to real parent PLL
> >
> > This way the things happening behind the scenes are completely transparent
> > to the cpufreq driver and you can use cpufreq-dt as is without changes.
> 
> CPUFreq wants to change to intermediate frequency by itself against
> some magic change behind the scene. The major requirement for that
> comes from the fact that we want to send PRE/POST freq notifiers on
> which loops-per-jiffie depends.

You could register a clk notifier using clk_notifier_register(). The
notifer callback can then call the cpufreq notifiers. The clk notifiers
can also be used to change the CPU voltage.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
