From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 16 Sep 2014 17:48:49 +0200
Subject: [PATCH 6/7] ARM: dts: sun6i: Add required ahb1 clock parent and
 rates for dma controller
In-Reply-To: <CAGb2v64+RxJ52DzawhAtYCn=sw+28e4Q11jzG02KQE=8hxa0tQ@mail.gmail.com>
References: <1410000448-9999-1-git-send-email-wens@csie.org>
 <1410000448-9999-7-git-send-email-wens@csie.org>
 <20140911211531.GN31276@lukather>
 <CAGb2v64+RxJ52DzawhAtYCn=sw+28e4Q11jzG02KQE=8hxa0tQ@mail.gmail.com>
Message-ID: <20140916154849.GE2166@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 12, 2014 at 10:10:25AM +0800, Chen-Yu Tsai wrote:
> On Fri, Sep 12, 2014 at 5:15 AM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > On Sat, Sep 06, 2014 at 06:47:27PM +0800, Chen-Yu Tsai wrote:
> >> The DMA controller requires AHB1 bus clock to be clocked from PLL6.
> >>
> >> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> >> ---
> >>  arch/arm/boot/dts/sun6i-a31.dtsi | 5 +++++
> >>  1 file changed, 5 insertions(+)
> >>
> >> diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
> >> index 8eb2c6d..1117989 100644
> >> --- a/arch/arm/boot/dts/sun6i-a31.dtsi
> >> +++ b/arch/arm/boot/dts/sun6i-a31.dtsi
> >> @@ -317,6 +317,11 @@
> >>                       clocks = <&ahb1_gates 6>;
> >>                       resets = <&ahb1_rst 6>;
> >>                       #dma-cells = <1>;
> >> +
> >> +                     /* DMA controller requires AHB1 clocked from PLL6 */
> >> +                     assigned-clocks = <&ahb1>;
> >> +                     assigned-clock-parents = <&pll6>;
> >> +                     assigned-clock-rates = <200000000>;
> >
> > Where did you get that from?
> >
> > The user manual says that it should be clocked at 600MHz, and I'm not
> > sure it should be enforced there either.
> 
> The bindings mean that ahb1 should be clocked from pll6 and at 200 MHz,
> not "pll6 should be 200 MHz". I assume you were misled by them.
> 
> Clocking ahb1 from pll6 and at 200 MHz with the /3 pre-divider is the
> vendor BSP default:
> 
> On sun6i, the clock init code calls aw_ccu_switch_ahb_2_pll6(), which muxes
> ahb1 from pll6 with the highest dividers, then sets the rate for ahb1 to
> pll6, which sets pre-divider to /3 and divider to /1.
> 
> Hope this clears it up. :)

It does, thanks :)

But still, I find it the wrong place to enforce such a limit. This
should go into the clock driver itself. The DMA controller requires
such a parenting, but it doesn't require any specific rate, this is
more something of the global system policy.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140916/25a15db7/attachment-0001.sig>
