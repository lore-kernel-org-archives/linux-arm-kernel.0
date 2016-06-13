From: dianders@chromium.org (Doug Anderson)
Date: Mon, 13 Jun 2016 13:43:42 -0700
Subject: [PATCH] clk: rockchip: add flag CLK_SET_RATE_PARENT for
 dclk_vop0_div on RK3399
In-Reply-To: <20160613183748.GA21936@google.com>
References: <1465724928-14611-1-git-send-email-zhengxing@rock-chips.com>
 <575D3D9B.1070501@rock-chips.com> <20160613183748.GA21936@google.com>
Message-ID: <CAD=FV=VUMaV-RAJAxyMooTjSTKqfDoqtTMoWe5L7ArDztvL+dA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jun 13, 2016 at 11:37 AM, Brian Norris <briannorris@chromium.org> wrote:
> Hi,
>
> On Sun, Jun 12, 2016 at 06:46:51PM +0800, Yakir Yang wrote:
>> On 06/12/2016 05:48 PM, Xing Zheng wrote:
>> >The functions and features VOP0 more complete than VOP1's, we need to
>> >use it dclk_vop0_div operate VPLLI, and let VOP0 as the default primary
>> >screen.
>
> Personally, I'd like a little better description that talks about the
> rates, not just the differences between VOP0 and VOP1. Presumably the
> clock rates needed by VOP0 are not achievable just by these dividers, so
> we need to adjust the PLL?

The idea is that there is a "big" VOP (vop0) and a "little" VOP
(vop1).  The "big" VOP can support higher resolutions and more output
formats but draws a little more power.  The "little" VOP supports
lower resolutions and a more limited set of formats.  If you're
curious, chapter 1 of the rk3399 TRM has a summary of the VOP features
(big and little).

In general, I think the SoC allows dynamic assignment of the VOPs to
the various video devices (eDP, DP, MIPI, HDMI).  So you can output to
two places at once and you get to pick whichever VOP you want for each
output.

The VOPs have three PLL sources: VPLL, CPLL, and GPLL.  Those PLLs are
best described as:
* CPLL - The PLL that runs at 800MHz.
* GPLL - The PLL that runs at ~600MHz (actually 594 MHz).
* VPLL - The PLL that can change rates to make various pixels clocks.

Presumably:
* The little VOP has enough features that you'd want to use it for
most internal laptop / cellphone / tablet panels.
* The big VOP is a good choice for whatever external graphics
connector you have so you can support the widest range of devices.

So if you've got a laptop that happens to have an internal panel and
an external connector, presumably:

* You want to adjust your display timings (hblank, vblank, etc) to
make sure that the internal display can be driven by dividing 800 MHz
or 594 MHz by some integral amount.  As an example, for the Starry
panel I posted recently <https://patchwork.kernel.org/patch/9170139/>
you could make exactly 148.5 (594 / 4) by subtracting 4 from the
horizontal total and adding 15 to the vertical: 1250 * 1980 * 60 Hz =
148.5 MHz

* You want to make sure that the internal display gets assigned the
little VOP so save power / leave flexibility for the external
connector.

* You want to make sure that that the little VOP _doesn't_
accidentally get assigned VPLL even if (at boot) VPLL happens to be at
a rate that would be fine for the panel.  If you accidentally use VPLL
as a parent then you'll have a tougher time changing VPLL later when
an external display is plugged in.


NOTE: If you have things other than a laptop the decisions between
VOP0 and VOP1 get much tougher.


> FWIW, I haven't actually found this patch necessary in my own testing (I
> have eDP running fine without this change), but perhaps with better
> justification, this will make more sense.

It is probable that firmware has already set the PLL up.  It would be
interested to hack your firmware to turn off the display and see if
your behavior changes.  Alternatively, try adding something like this
to hack the VOPs:

--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -816,7 +816,7 @@
                        <&cru ACLK_VOP1>, <&cru HCLK_VOP1>,
                        <&cru ARMCLKL>, <&cru ARMCLKB>,
                        <&cru PLL_GPLL>, <&cru PLL_CPLL>,
-                       <&cru PLL_NPLL>,
+                       <&cru PLL_NPLL>, <&cru PLL_VPLL>,
                        <&cru ACLK_PERIHP>, <&cru HCLK_PERIHP>,
                        <&cru PCLK_PERIHP>,
                        <&cru ACLK_PERILP0>, <&cru HCLK_PERILP0>,
@@ -827,7 +827,7 @@
                        <400000000>,  <200000000>,
                        <816000000>, <1008000000>,
                         <594000000>,  <800000000>,
-                       <1000000000>,
+                       <1000000000>,  <900000000>,
                         <150000000>,   <75000000>,
                          <37500000>,
                         <100000000>,  <100000000>,


NOTE also: it seems terribly unlikely that adding CLK_SET_RATE_PARENT
to "vop0" would help with eDP, which really ought to be using vop1,
right?  In testing on my board, I found that eDP is in fact using vop1
with my current patch stack.

---

To summarize all that, I think that the following things would work OK
for a laptop until a better solution comes along:

* Probably VOP0 and VOP1 should both be able to change their parent's rate.

* Somehow adjust the panel rate to one that could be produced by CPLL
/ GPLL.  Presumably we'd want some code to add these extra modes to
simple-panel (?) and some code to know which mode to pick (?).

* make sure VOP0 is assigned to the panel (make this already is forced somehow?)

* make sure VOP0 starts out with the right parent (CPLL / GPLL) using
assigned-clocks in the device tree, so CCF will leave things alone.


Anyway, maybe everything I said is wrong.  If so, please correct.  ;)


-Doug
