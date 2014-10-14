From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 14 Oct 2014 12:01:54 +0200
Subject: [RFC 4/7] ARM: dts: add support for Vybrid running on Cortex-M4
In-Reply-To: <7c474d8f876cbf9adaec55af1dffd6c2@agner.ch>
References: <cover.1413136383.git.stefan@agner.ch>
 <5748107.mfAXLUBGQg@wuerfel> <7c474d8f876cbf9adaec55af1dffd6c2@agner.ch>
Message-ID: <4791111.YE0gxP7ZrV@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 13 October 2014 23:20:38 Stefan Agner wrote:
> Ah ok I see. This parent/child relation is not yet part of the Vybrid
> device tree:
> 
> 
> slowosc: sxosc {
>         compatible = "fixed-clock";
>         #clock-cells = <0>;
>         clock-frequency = <32768>;
> };
> fastosc: fxosc {
>         compatible = "fixed-clock";
>         #clock-cells = <0>;
>         clock-frequency = <24000000>;
> };
> 
> ....
> 
> clks: ccm at 4006b000 {
>         compatible = "fsl,vf610-ccm";
>         reg = <0x4006b000 0x1000>;
>         #clock-cells = <1>;
> };
> 
> So we would need something like:
> 
> clocks = <&slowosc>, <&fastosc>;
> clock-names = "sxosc", "fxosc";
> 
> But how can we identify clock tree entries? There is no marker like
> "clock-controller;" currently, is there?

Actually it seems the of_clk_init does have all the code it needs:

        for_each_matching_node_and_match(np, matches, &match) {
                struct clock_provider *parent =
                        kzalloc(sizeof(struct clock_provider),  GFP_KERNEL);

                parent->clk_init_cb = match->data;
                parent->np = np;
                list_add_tail(&parent->node, &clk_provider_list);
        }

        while (!list_empty(&clk_provider_list)) {
                is_init_done = false;
                list_for_each_entry_safe(clk_provider, next,
                                        &clk_provider_list, node) {
                        if (force || parent_ready(clk_provider->np)) {

                                clk_provider->clk_init_cb(clk_provider->np);
                                of_clk_set_defaults(clk_provider->np, true);

                                list_del(&clk_provider->node);
                                kfree(clk_provider);
                                is_init_done = true;
                        }
                }

                /*
                 * We didn't manage to initialize any of the
                 * remaining providers during the last loop, so now we
                 * initialize all the remaining ones unconditionally
                 * in case the clock parent was not mandatory
                 */
                if (!is_init_done)
                        force = true;
        }

You are just missing the clock properties to describe the hierarchy
in your dts.

	Arnd
