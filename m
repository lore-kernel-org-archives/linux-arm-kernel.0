From: horms@verge.net.au (Simon Horman)
Date: Mon, 4 Sep 2017 10:35:46 +0200
Subject: [PATCH] arm64: dts: r8a7795: Add OPPs table for cpu devices
In-Reply-To: <20170829145630.GH12099@bigcity.dyn.berto.se>
References: <1501853180-23939-1-git-send-email-horms+renesas@verge.net.au>
 <20170829145630.GH12099@bigcity.dyn.berto.se>
Message-ID: <20170904083544.GA11396@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 29, 2017 at 04:56:30PM +0200, Niklas S?derlund wrote:
> Hi Simon,
> 
> Thanks for your patches and sorry for getting to this a bit late.
> 
> On 2017-08-04 15:26:20 +0200, Simon Horman wrote:
> > From: Dien Pham <dien.pham.ry@rvc.renesas.com>
> > 
> > Current, OPP tables are defined temporary,
> > they are being evaluated and adjust in future.
> > 
> > Based in part on work by Hien Dang.
> > 
> > Signed-off-by: Dien Pham <dien.pham.ry@rvc.renesas.com>
> > Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> > [simon: consolidated sseveral patches into one]
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > ---
> >  arch/arm64/boot/dts/renesas/r8a7795.dtsi | 309 +++++++++++++++++++++++++++++++
> >  1 file changed, 309 insertions(+)
> > 
> > I am not aware of any build-time depdendencies of this patch.
> > 
> > This patch has run-time depdnencies on:
> > * [PATCH] cpufreq: rcar: Add support for R8A7795 SoC
> > * [PATCH 0/4] r8a7795: Add Z and Z2 clock support
> > 
> > I have provided an integration patch with this patch, those DTS changes,
> > and Renesas clock updates also depended on by the DTS changes. The result
> > is working CPUFreq for the r8a7795 (R-Car H3) ES1.0.
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git topic/r8a7795-cpufreq
> > 
> > A description of steps taken to lightly exercise the above can be found here:
> > 
> > http://elinux.org/Tests:R-CAR-GEN3-CPUFreq
> 
> I tested this it's working, nice!

Thanks!

Its seems there are a few rough edges (like the one below).
I'll try and shake those out in the near future.

> > If this work is acceptable I plan to follow up with patches to
> > enable CPUFreq on the r8a7796 (R-Car M3-W).
> > 
> > This patch is based on renesas-arm64-dt-for-v4.14
> > 
> > diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> > index a87ae76880ab..f34da4c9ea52 100644
> > --- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> > +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> > @@ -46,6 +46,12 @@
> >  			power-domains = <&sysc R8A7795_PD_CA57_CPU0>;
> >  			next-level-cache = <&L2_CA57>;
> >  			enable-method = "psci";
> > +			clocks =<&cpg CPG_CORE R8A7795_CLK_Z>;
> > +			operating-points-v2 = <&cluster0_opp_tb0>,
> > +				<&cluster0_opp_tb1>, <&cluster0_opp_tb2>,
> > +				<&cluster0_opp_tb3>, <&cluster0_opp_tb4>,
> > +				<&cluster0_opp_tb5>, <&cluster0_opp_tb6>,
> > +				<&cluster0_opp_tb7>;
> 
> This however leaves me a bit confused. If I understand the bindings 
> documentation you should only specify one phandle here. IIUC only the 
> first one will be used anyhow, from drivers/base/power/opp/of.c
> 
> 253 static struct device_node *_opp_of_get_opp_desc_node(struct device_node *np)
> 254 {
> 255         /*
> 256          * There should be only ONE phandle present in "operating-points-v2"
> 257          * property.
> 258          */
> 259 
> 260         return of_parse_phandle(np, "operating-points-v2", 0);
> 261 }
> 
> I tried to look at other sources and bindings and I can't find anywhere 
> where more then one phandle could be useful, but I can have missed 
> something? My interest in this is that I wish to hook it up with the 
> thermal zones to have it act as passive cooling and implement the part 
> of the BSP emergency shutdown driver using already available code and 
> having more then one phandle here confuses me how to describe that in DT 
> :-)

Thanks for pointing that out.

I am also unable to find other sources of the bindings
and I now see that having multiple phandles present makes little sense.
I now plan to remove them.
