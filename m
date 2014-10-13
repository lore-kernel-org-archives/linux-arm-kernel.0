From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 13 Oct 2014 13:24:06 +0200
Subject: [RFC 4/7] ARM: dts: add support for Vybrid running on Cortex-M4
In-Reply-To: <fadc1e22c016f4259819d87ba06d0d99@agner.ch>
References: <cover.1413136383.git.stefan@agner.ch>
 <20141013103219.GE14739@leverpostej>
 <fadc1e22c016f4259819d87ba06d0d99@agner.ch>
Message-ID: <2010256.3WXzPqutzu@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 13 October 2014 13:08:12 Stefan Agner wrote:
> Am 2014-10-13 12:32, schrieb Mark Rutland:
> > On Sun, Oct 12, 2014 at 07:13:58PM +0100, Stefan Agner wrote:
> >> This adds an initial device tree to run Linux on the Cortex-M4 on
> >> Vybrid.
> >>
> >> HACK: Because we include armv7-m.dtsi, the soc node happens to
> >> be before the clock node. This is a problem for vf610-clk.c, which
> >> tries to optain the fixed clocks defined in the clock nodes. But
> >> because clock drivers are initialized sequencially, and we do not
> >> have support for deferred probing, the clock initialization fails
> >> horrible.
> >> Move the armv7-m.dtsi include to the bottom to temporarily work
> >> work around this...
> >>
> >> Signed-off-by: Stefan Agner <stefan@agner.ch>
> >> ---
> >> Maybe a dummy soc entry in armv7-m.dtsi also helps here. But a
> >> hack as well. Is it common acceptable that the kernel depends
> >> on DTS order?
> > 
> > The kernel should not depend on DTS ordering. We should sort out
> > deferred probing if there is an issue with it.
> > 
> > [...]
> 
> Yes I guess to make this working independent of device tree order, we
> need to defer probing of vf610-clk when the fixed clocks are not
> initialized yet. 
> 
> Clock initialization (using CLK_OF_DECLARE) doesn't support EPROBE_DEFER
> currently. 
> 
> We seem to have already a work around merged because of this.
> http://thread.gmane.org/gmane.linux.kernel/1635576

Ah, maybe that's what I remembered. The clock handling should probably
do something similar to what we do for irqchips, where we probe the
parents first.

> Anybody tried to reverse device tree parsing to unveil how many such
> assumptions are still slumbering?

Not that I'm aware of. Sounds like a good thing to try.

> >> +
> >> +    soc {
> >> +            aips0: aips-bus at 40000000 {
> >> +                    compatible = "fsl,aips-bus", "simple-bus";
> >> +                    #address-cells = <1>;
> >> +                    #size-cells = <1>;
> >> +                    reg = <0x40000000 0x70000>;
> > 
> > Out of curiosity, given that this can be driven as a simple-bus, what do
> > the aips bus registers allow to be configured?
> > 
> 
> There is a chapter about the AIPS lite bus in the RM, but according to
> this the AIPS lite bus itself has no registers by itself. 

I just noticed that the only child you list below this node uses
registers within the area of the bus. I suspect you just confused
'reg' and 'ranges' here, please use 'ranges' to list which registers
are visible on the bus, and modify the 'reg' properties of the children
as necessary.

	Arnd
