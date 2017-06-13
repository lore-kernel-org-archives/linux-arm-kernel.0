From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 13 Jun 2017 10:02:01 +0200
Subject: [linux-sunxi] Re: [PATCH v2 10/11] ARM: sun8i: h3: add display
 engine pipeline for TVE
In-Reply-To: <87bf6e8c54286fd0630bd876ec0c6c56@aosc.io>
References: <20170604160149.30230-1-icenowy@aosc.io>
 <20170604160149.30230-11-icenowy@aosc.io>
 <20170607094241.65dcm42aacrn4eev@flea.lan>
 <87bf6e8c54286fd0630bd876ec0c6c56@aosc.io>
Message-ID: <20170613080201.pezlmcggfnfziiat@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 11, 2017 at 02:58:47PM +0800, icenowy at aosc.io wrote:
> ? 2017-06-07 17:42?Maxime Ripard ???
> > On Mon, Jun 05, 2017 at 12:01:48AM +0800, Icenowy Zheng wrote:
> > > +	soc {
> > > +		display_clocks: clock at 1000000 {
> > > +			compatible = "allwinner,sun8i-a83t-de2-clk";
> > > +			reg = <0x01000000 0x100000>;
> > > +			clocks = <&ccu CLK_BUS_DE>,
> > > +				 <&ccu CLK_DE>;
> > > +			clock-names = "bus",
> > > +				      "mod";
> > > +			resets = <&ccu RST_BUS_DE>;
> > > +			#clock-cells = <1>;
> > > +			#reset-cells = <1>;
> > > +			assigned-clocks = <&ccu CLK_DE>;
> > > +			assigned-clock-parents = <&ccu CLK_PLL_DE>;
> > > +			assigned-clock-rates = <432000000>;
> > > +		};
> > 
> > We discussed that already a few times, but there's no reason to do
> > so. If you need a downstream clock at a particular rate, call
> > clk_set_rate on it, period.
> > 
> > Whether its parent will be coming from PLL_DE or some other more
> > appriopriate clock is not relevant and doesn't make any difference.
> 
> The clock framework is not so smart to deal with these infomations:
> - CLK_PLL_PERIPH should always be 600MHz
> - CLK_TVE should always be 216MHz
> - CLK_DE (in fact CLK_MIXER{0,1}) should be larger than 300MHz (for 4K)

None of what you're doing guarantees what you state above, so I'm not
really sure what your point is.

> So we have to specify CLK_DE to be 432MHz, and then it will set
> CLK_PLL_DE to this value, then the CLK_TVE can be set to 216MHz with
> divider 2.

Yes, but it works by accident. Any clock change somewhere in the same
clock-tree might break whatever you have set in the DT.

Hence why you want to do it within the clock framework and your
driver, not here.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170613/095e1b7d/attachment.sig>
