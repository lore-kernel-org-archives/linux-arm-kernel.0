From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 10 Mar 2015 16:59:12 -0700
Subject: [PATCH] clk: mediatek: Export CPU mux clocks for CPU frequency
 control
In-Reply-To: <CAKohponSqLPcULA9-T8y9b_b44Torti0p6W3sJfRZ1oKUWqtTw@mail.gmail.com>
References: <1425466152-7867-1-git-send-email-pi-cheng.chen@linaro.org>
 <20150304112109.GB11010@pengutronix.de>
 <CALx668WKKmifhuODsV+Uaoq4ggcmB1=wbpLzXBnjEtxbuB4qig@mail.gmail.com>
 <20150305074207.GC11010@pengutronix.de>
 <CAKohponSqLPcULA9-T8y9b_b44Torti0p6W3sJfRZ1oKUWqtTw@mail.gmail.com>
Message-ID: <20150310235912.14952.99786@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Viresh Kumar (2015-03-05 00:59:50)
> On 5 March 2015 at 13:12, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > We have clk_set_parent for changing the parent and clk_set_rate to
> > change the rate. Use the former for changing the parent and the latter
> > for changing the rate. What you are interested in is changing the
> > parent, so use clk_set_parent for this and not abuse a side effect
> > of clk_set_rate.
> 
> clk_set_rate() for CPUs clock is responsible to change clock rate
> of the CPU. Whether it plays with PLLs or muxes, its not that relevant.

Agreed.

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

I assume you are saying that you want to update loops-per-jiffie while
at an intermediate frequency. Why? This operation should not take very
long.

Imagine a (hypothetical?) processor that changes frequency in many small
steps until it converges to the target rate. Would you want to update
lpj for every step?

Regards,
Mike
