From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 25 Sep 2014 15:41:01 +0200
Subject: [PATCH 6/7] ARM: dts: sun6i: Add required ahb1 clock parent and
 rates for dma controller
In-Reply-To: <CAGb2v67cf+UQW2Sp=vS1jSu1jCAgG-wXz8cvh7K4RM4zhJgjkA@mail.gmail.com>
References: <1410000448-9999-1-git-send-email-wens@csie.org>
 <1410000448-9999-7-git-send-email-wens@csie.org>
 <20140911211531.GN31276@lukather>
 <CAGb2v64+RxJ52DzawhAtYCn=sw+28e4Q11jzG02KQE=8hxa0tQ@mail.gmail.com>
 <20140916154849.GE2166@lukather>
 <CAGb2v64BLvB3v8Wnep5Fqh1COTXYJ5_uyeuevejqD-KpYiptQg@mail.gmail.com>
 <20140920095927.GQ2166@lukather>
 <CAGb2v67cf+UQW2Sp=vS1jSu1jCAgG-wXz8cvh7K4RM4zhJgjkA@mail.gmail.com>
Message-ID: <20140925134101.GL15315@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 21, 2014 at 04:31:06PM +0800, Chen-Yu Tsai wrote:
> On Sat, Sep 20, 2014 at 5:59 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > On Wed, Sep 17, 2014 at 12:01:46AM +0800, Chen-Yu Tsai wrote:
> >> On Tue, Sep 16, 2014 at 11:48 PM, Maxime Ripard
> >> <maxime.ripard@free-electrons.com> wrote:
> >> > On Fri, Sep 12, 2014 at 10:10:25AM +0800, Chen-Yu Tsai wrote:
> >> >> On Fri, Sep 12, 2014 at 5:15 AM, Maxime Ripard
> >> >> <maxime.ripard@free-electrons.com> wrote:
> >> >> > On Sat, Sep 06, 2014 at 06:47:27PM +0800, Chen-Yu Tsai wrote:
> >> >> >> The DMA controller requires AHB1 bus clock to be clocked from PLL6.
> >> >> >>
> >> >> >> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> >> >> >> ---
> >> >> >>  arch/arm/boot/dts/sun6i-a31.dtsi | 5 +++++
> >> >> >>  1 file changed, 5 insertions(+)
> >> >> >>
> >> >> >> diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
> >> >> >> index 8eb2c6d..1117989 100644
> >> >> >> --- a/arch/arm/boot/dts/sun6i-a31.dtsi
> >> >> >> +++ b/arch/arm/boot/dts/sun6i-a31.dtsi
> >> >> >> @@ -317,6 +317,11 @@
> >> >> >>                       clocks = <&ahb1_gates 6>;
> >> >> >>                       resets = <&ahb1_rst 6>;
> >> >> >>                       #dma-cells = <1>;
> >> >> >> +
> >> >> >> +                     /* DMA controller requires AHB1 clocked from PLL6 */
> >> >> >> +                     assigned-clocks = <&ahb1>;
> >> >> >> +                     assigned-clock-parents = <&pll6>;
> >> >> >> +                     assigned-clock-rates = <200000000>;
> >> >> >
> >> >> > Where did you get that from?
> >> >> >
> >> >> > The user manual says that it should be clocked at 600MHz, and I'm not
> >> >> > sure it should be enforced there either.
> >> >>
> >> >> The bindings mean that ahb1 should be clocked from pll6 and at 200 MHz,
> >> >> not "pll6 should be 200 MHz". I assume you were misled by them.
> >> >>
> >> >> Clocking ahb1 from pll6 and at 200 MHz with the /3 pre-divider is the
> >> >> vendor BSP default:
> >> >>
> >> >> On sun6i, the clock init code calls aw_ccu_switch_ahb_2_pll6(), which muxes
> >> >> ahb1 from pll6 with the highest dividers, then sets the rate for ahb1 to
> >> >> pll6, which sets pre-divider to /3 and divider to /1.
> >> >>
> >> >> Hope this clears it up. :)
> >> >
> >> > It does, thanks :)
> >> >
> >> > But still, I find it the wrong place to enforce such a limit. This
> >> > should go into the clock driver itself. The DMA controller requires
> >> > such a parenting, but it doesn't require any specific rate, this is
> >> > more something of the global system policy.
> >>
> >> But I am guessing the AHB bus clock cannot be clock at any arbitrary
> >> rate. Just muxing without setting a specific clock rate might result
> >> in a hang. We could address this with per clock limitations, like the
> >> patch you posted earlier. Not sure if there's anything in the kernel
> >> like that at the moment, or how the clock framework handles clock rates
> >> after re-parenting.
> >
> > There's the Tomeu patch series that allows to set clock rate
> > requirements from the user side, I guess that could be easily extended
> > to integrate some clock side boundaries. That's why I stopped working
> > on the sun5i MMC clock issue until that patch is merged.
> 
> I could take a look, but AFAIK none of our drivers need to propagate
> clock rate changes.

Don't worry about this.

> >> Or we could just specify in the clock driver, or in the DT via clock
> >> supplier defaults, that the AHB bus should be clocked from PLL6 @ 200 MHz.
> >>
> >> The latter seems easier to do.
> >
> > IIRC, there was some opposition to having the muxing assignment in the
> > clock driver.
> >
> >> Also, I tested the DMA controller using dmatest on my A31 Hummingbird
> >> without this re-parenting patch. It worked fine. How did your tests fail?
> >
> > It was just timeouting, and actually, it was only working to the SRAM,
> > and not the DRAM.
> >
> > Maybe the bootloader sets up the clock muxing already?
> 
> I just reran my tests on the A31, and dmatest indeed passes.
> I'm using your A31 sdcard.img, replaced u-boot with one built from
> u-boot-sunxi, so it supports DT.
> 
> I also checked both the clock framework and the raw registers.
> AHB1 is indeed clocked from AXI on my system.
> 
> Full log: https://gist.github.com/wens/ae17aed6728b83c0a9c3
> 
> If you (or someone else with A31) can verify the results,
> maybe we can just drop this patch.

I'm away from the colombus board this week, but if it works on the
hummingbird, we can just move this patch to the colombus DT, and not
put it in the DTSI.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140925/dacb99ce/attachment.sig>
