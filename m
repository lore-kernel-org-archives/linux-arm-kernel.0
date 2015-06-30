From: jamesjj.liao@mediatek.com (James Liao)
Date: Tue, 30 Jun 2015 17:07:09 +0800
Subject: [PATCH] arm64: dts: mt8173: add clock_null
In-Reply-To: <1510058.fTE6dlSRsH@diego>
References: <1434605351-64592-1-git-send-email-eddie.huang@mediatek.com>
 <8860488.JuX1EN5tWB@diego> <1435132455.28866.21.camel@mtksdaap41>
 <1510058.fTE6dlSRsH@diego>
Message-ID: <1435655229.19330.15.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-06-24 at 12:24 +0200, Heiko St?bner wrote:
> Am Mittwoch, 24. Juni 2015, 15:54:15 schrieb James Liao:
> > On Mon, 2015-06-22 at 14:53 +0200, Heiko St?bner wrote:
> > > Am Montag, 22. Juni 2015, 11:38:37 schrieb James Liao:
> > > > On Fri, 2015-06-19 at 13:36 +0200, Heiko Stuebner wrote:
> > > > Some clocks such as clkph_mck_o, we don't really care where they come
> > > > from and what frequencies are. We model these clocks just because they
> > > > or their derived clocks can be the source of topckgen muxes. Is there a
> > > > better way to model "don't care" clocks?
> > > 
> > > There are two different concepts at work here. You might not care in your
> > > kernel driver implementation _at the moment_ where the clocks come from;
> > > but the devicetree is supposed to model how the hardware is structured
> > > and not contain implementation specific details.
> > 
> > If we model "don't care" clocks inside the driver (i.e. create clk_null
> > in clock driver), then we don't need to model the dummy clock in device.
> > Is it an acceptable way?
> > 
> > > So the clock tree should be modeled according to how the hardware is layed
> > > out not how you want to use the clocks at the moment :-) .
> > > 
> > > It would it any case be good, if you could describe where these clocks
> > > come
> > > from in the hardware, so we can find the best solution on how to model
> > > those.
> > In fact, I don't know where these clocks come from at all, especially
> > when they come from outside of SoC. Besides, some clocks don't need to
> > model in CCF, but they can be the source of clocks that controlled by
> > CCF.
> 
> If a clock is used inside the ccf driver, its tree should be modeled according 
> to the hardware - including these external clocks. Somebody (at least some 
> chip designer or so) should know where these clocks actually come from ;-) .
> 
> 
> > I don't think ALL clocks on a SoC need to be handled in CCF, so there
> > should be some clocks don't have a "real" or "correct" parent. In
> > current implementation I use a dummy clock (clk_null) to be the unreal
> > parent.
> 
> You are right that not all clocks needs to be implemented in a ccf _driver_, 
> but as the devicetree binding describes the hardware and is supposed to be 
> stable and (nearly) unchangeable outside-connections of the clock block need 
> to be defined carefully.
> 
> 
> > Do you think we should model as more clocks as we can in CCF even we
> > don't need them? If no, how do we handle those clocks which are not
> > handled in CCF but can be parent of CCF clocks?
> 
> In general I think everything that has a connection to the outside (external 
> source clock and clocks used by soc ips) should be modeled precisely. What 
> then happens inside the clock controller is less important, as it normally can 
> be fixed later on too.
> 
> 
> Citing my own code [which got inspired on how Samsung did this], Rockchip 
> clock controllers also have numerous possible external clock inputs with only 
> the 24MHz oscillator being required [0].
> 
> All the other clocks may or may not be present. For example xin32k normally 
> comes from an i2c-connected rtc or pmic chip which gets probed a lot later in 
> the boot process, so we rely on the orphan-handling of the ccf for these.
> 
> 
> So please really try to find out what these clocks are in the first place ... 
> somebody must know this ;-)
> 
> 
> Heiko
> 
> 
> [0] 
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/clock/rockchip,rk3288-cru.txt#n26

Hi Heiko,

There are 4 clocks which are derived from clk_null directly in current
topckgen implementation:

	clkph_mck_o, dpi_ck, usb_syspll_125m, hdmitx_dig_cts

Our designer mentioned 2 things about external clocks:

1. These 4 clocks come from analog macro, not from PLL, nor from
external clocks directly.

2. MT8173 only has 2 external clocks: 26M and 32K.

Analog macro may refer to 26M or other clocks to generate clocks with
specified frequency. But we don't know and don't care how they generate
these clocks. So we want to use a dummy clock to be the root of these 4
clocks.


Hi Sascha,

Do you have any suggestion on clk_null?


Best regards,

James
