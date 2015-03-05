From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 5 Mar 2015 15:53:35 +0530
Subject: [PATCH] clk: mediatek: Export CPU mux clocks for CPU frequency
 control
In-Reply-To: <20150305091948.GH11010@pengutronix.de>
References: <1425466152-7867-1-git-send-email-pi-cheng.chen@linaro.org>
 <20150304112109.GB11010@pengutronix.de>
 <CALx668WKKmifhuODsV+Uaoq4ggcmB1=wbpLzXBnjEtxbuB4qig@mail.gmail.com>
 <20150305074207.GC11010@pengutronix.de>
 <CAKohponSqLPcULA9-T8y9b_b44Torti0p6W3sJfRZ1oKUWqtTw@mail.gmail.com>
 <20150305091948.GH11010@pengutronix.de>
Message-ID: <CAKohpokVxxxTY9DpQVxNPnq92pyK=2J2dDeLmis_+WD16aatOg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 March 2015 at 14:49, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> The sequence to change the CPU frequency on the Mediatek SoCs is like this:
>
> - Change CPU from CPU PLL to another clock source (intermediate source)
> - Change CPU PLL frequency
> - wait until PLL has settled
> - switch back to CPU PLL

This should be the case for most of the intermediate-freq users..

> The frequency of the intermediate source is irrelevant, the important
> thing is that the CPU is switched to this source while the CPU PLL is
> reconfigured.

Right.

> In Pi-Chengs patches the switch to th eintermediate clock is done like:
>
>         rate = clk_get_rate(intermediate_clk);
>         clk_set_rate(cpu_clk, rate);
>
> Now the clk framework does the switch not because it's told to switch
> to another parent, but only because the other parent happens to be the
> only provider for that rate. That's rubbish, when the parent must be
> changed, then it should be done explicitly.
> What if the CPU PLL and the intermediate clk happen to have the same
> rate? Then the clk_set_rate above simply does nothing, no parent is
> changed and the following rate change of the CPU PLL just crashes the
> system.

The problem is that the code is common across platforms that need to
reparent or just change rate for intermediate clocks. And the best we
can do is clk_set_rate() and so probably the clk driver need to take care
of this somehow and make sure we don't result in a crash like you just
demonstrated.
