From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 14 May 2014 21:41:06 -0700
Subject: [PATCH 2/8] clk: berlin: add clock binding docs for Marvell
 Berlin2 SoCs
In-Reply-To: <5373F9A0.6000702@gmail.com>
References: <1399839881-29895-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1399839881-29895-3-git-send-email-sebastian.hesselbarth@gmail.com>
 <20140514223230.19795.63328@quantum> <5373F9A0.6000702@gmail.com>
Message-ID: <20140515044106.19795.57249@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Sebastian Hesselbarth (2014-05-14 16:17:52)
> On 05/15/2014 12:32 AM, Mike Turquette wrote:
> > Quoting Sebastian Hesselbarth (2014-05-11 13:24:35)
> >> +avpll: pll at ea0040 {
> >> +       compatible = "marvell,berlin2-avpll";
> >> +       #clock-cells = <2>;
> >> +       reg = <0xea0050 0x100>;
> >> +       clocks = <&refclk>;
> >> +};
> > 
> > Thanks for submitting the series. It looks good. I do have some comments
> > about the DT bindings though. I'm encouraging new bindings (and
> > especially new platforms or existing platforms that are only now
> > converting over to CCF) to not put their per-clock data into DTS. This
> > has scalability problems, is unpopular with the DT crowd and sometimes
> > makes it hard to do things like set CLK_SET_RATE_PARENT flags for
> > individual clocks.
> 
> Ok, so you are proposing the have a single node for all the SoCs
> internal plls and clocks. The individual SoCs will have to deal
> with the differences in a single driver, right?

To be precise, I'm talking about modeling an IP block as a single node.
So if you have one clock generator IP block then you have one node. If
you have more than one clock generator block then you have more than one
node. Re-using the qcom example there are compatible strings for two
different clock generator blocks named gcc and mmcc, respectively. So
two DT nodes in the case for msm platforms that have one gcc instance
and one rcg instance.

Additionally other IP blocks may have internal clocks that can be
modeled as part of that node. OMAP's Display SubSystem (DSS) and Image
Signal Processor (ISP) blocks all have internal clocks that are modeled
through the clock framework. (There are no DT bindings for that stuff,
but the concept still applies)

> 
> > The following is a copy/paste from an email I sent earlier today[1]. Of
> > course per-clock data makes great sense if you have an off-SoC clock
> > such as a fixed-rate oscillator (e.g. the fixed-clock binding). Let me
> > know what you think:
> [...]
> > Using this type of binding you only need to declare your clock generator
> > IP node in dts, and then define a mapping in the DT include chroot. Then
> > you can define your per-clock data inside of your clock driver instead
> > of putting all of the details inside of DT.
> > 
> > If you have a strong reason to do it the way that you originally posted
> > then let me know.
> 
> Actually, the intermediate patch set sent before this one had a single
> DT clock node. The most important draw-back of a single clock node
> is that Berlin's global registers are more like a register dumpster.
> Vital other registers, e.g. reset, are intermixed with clock registers.

Yeah, this is pretty common. The compatible string should reflect the IP
block as a whole, not just the clocks part of it. Lots of vendors have
PRCMs or PRCMUs or CARs or whatever.

Check out the recent series to have the reset bits and regulator support
added to the qcom binding[1]. (I'm using qcom quite a bit in my examples
but they are not the first to add reset control to their clock driver. I
think Tegra did it first...)

> 
> Given the lack of public datasheets (I look everything up in some
> auto-generated BSP includes), I like the current approach because it
> helps to get in at least some structure to the register mess ;)
> 
> Considering the postponed of_clk_create_name() helper, that would allow
> us to remove at least the names from DT again. Another option would be
> a syscon node for the registers, that clk, reset, pinctrl drivers can
> access. But IIRC early syscon support isn't settled, yet?

Yeah, I'm not sure of the state of syscon. And modeling this stuff in
the clock driver isn't the end of the world. There might be better
places than drivers/clk/* for sure... I sometimes joke that the name of
the IP block determines where the code lands. If it is Power, Reset &
Clock Manager (several platforms use this acronym) then it can end up in
drivers/clk or drivers/reset really easily. Same for Clock and Reset IP
blocks (Tegra).

> 
> So, my current idea is:
> - take this as is, stabilize berlin branches for v3.16
> - review of_clk_create_name() and of_clk_get_parent_name() to allow
>   to remove clock-output-names properties from Berlin (and other) dtsis
> - maybe switch to early syscon if it is available in v3.16
> 
> I know this would likely break DT ABI policy, but hey who else boots
> mainline Linux on his Chromecast currently except me :P

I'm not a big fan of DT stable ABI, but if you plan on changing it for
3.17 why not just do it the right way the first time? And switching to
syscon is not a hard requirement. I'm OK with you putting the reset and
regulator stuff in the clock driver if that makes the most sense for
your platform (especially if registers are shared and the same locks
need to be used, etc).

What do you think?

Regards,
Mike

[1] https://lkml.org/lkml/2014/4/4/568

> 
> Is that okay with you (and DT folks)?
> 
> Sebastian
