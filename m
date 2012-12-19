From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 19 Dec 2012 11:12:17 -0800
Subject: [PATCH 4/4] clk: zynq: Use of_init_clk_data()
In-Reply-To: <20121219183617.GC1005@beefymiracle.amer.corp.natinst.com>
References: <1355778135-32458-1-git-send-email-sboyd@codeaurora.org>
 <1355778135-32458-5-git-send-email-sboyd@codeaurora.org>
 <20121219172619.GB1005@beefymiracle.amer.corp.natinst.com>
 <50D2056E.9000507@codeaurora.org>
 <20121219183617.GC1005@beefymiracle.amer.corp.natinst.com>
Message-ID: <50D21191.3000501@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/19/12 10:36, Josh Cartwright wrote:
> On Wed, Dec 19, 2012 at 10:20:30AM -0800, Stephen Boyd wrote:
>> On 12/19/12 09:26, Josh Cartwright wrote:
>>> On Mon, Dec 17, 2012 at 01:02:15PM -0800, Stephen Boyd wrote:
> [..]
>> Can you show the code at those line numbers? There are quite a few
>> WARN_ONs in that code and it's possible the WARN_ON is the one
>> introduced in this patch.
> It looks like we're not hitting the WARN_ON() you added, but several of
> the other ones.

Ah it seems that zynq is doing different things with the clock names.
The periph clock is this

                                uart_clk: uart_clk {
                                        #clock-cells = <1>;
                                        compatible =
"xlnx,zynq-periph-clock";
                                        clocks = <&iopll &armpll &ddrpll>;
                                        reg = <0x154>;
                                        clock-output-names =
"uart0_ref_clk",
                                                            
"uart1_ref_clk";

and so zynq_periph_clk_setup() wants to register clocks named uart_clk,
uart0_ref_clk, and uart1_ref_clk. But my change causes uart0_ref_clk to
be registered twice because of the way of_init_clk_data() detects the
init.name property from the binding (we use clock-output-names[0] and
only use np->name if there is no clock-output-names).

Perhaps we need to make of_init_clk_data() take an integer argument
indicating which name to use? So of_init_clk_data(np, &init, 0) would
mean use the np->name as the init.name, and of_init_clk_data(np, &init,
1) would mean use the clock-output-names[0] property,
of_init_clk_data(np, &init, 2) would mean use the clock-output-names[1]
property.

Or perhaps we should think of some way to generate unique names from the
bindings that the clock APIs can use internally.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
