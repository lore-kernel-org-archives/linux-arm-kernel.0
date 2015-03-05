From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 5 Mar 2015 14:29:50 +0530
Subject: [PATCH] clk: mediatek: Export CPU mux clocks for CPU frequency
 control
In-Reply-To: <20150305074207.GC11010@pengutronix.de>
References: <1425466152-7867-1-git-send-email-pi-cheng.chen@linaro.org>
 <20150304112109.GB11010@pengutronix.de>
 <CALx668WKKmifhuODsV+Uaoq4ggcmB1=wbpLzXBnjEtxbuB4qig@mail.gmail.com>
 <20150305074207.GC11010@pengutronix.de>
Message-ID: <CAKohponSqLPcULA9-T8y9b_b44Torti0p6W3sJfRZ1oKUWqtTw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 March 2015 at 13:12, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> We have clk_set_parent for changing the parent and clk_set_rate to
> change the rate. Use the former for changing the parent and the latter
> for changing the rate. What you are interested in is changing the
> parent, so use clk_set_parent for this and not abuse a side effect
> of clk_set_rate.

clk_set_rate() for CPUs clock is responsible to change clock rate
of the CPU. Whether it plays with PLLs or muxes, its not that relevant.

> My suggestion is to take another approach. Implement clk_set_rate for
> these muxes and in the set_rate hook:
>
> - switch mux to intermediate PLL parent
> - call clk_set_rate() for the real parent PLL
> - switch mux back to real parent PLL
>
> This way the things happening behind the scenes are completely transparent
> to the cpufreq driver and you can use cpufreq-dt as is without changes.

CPUFreq wants to change to intermediate frequency by itself against
some magic change behind the scene. The major requirement for that
comes from the fact that we want to send PRE/POST freq notifiers on
which loops-per-jiffie depends.
