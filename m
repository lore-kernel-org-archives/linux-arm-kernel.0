From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 9 Mar 2015 09:28:04 +0000
Subject: [PATCH v3 0/4] clk: st: New always-on clock domain
In-Reply-To: <20150306190812.11109.82130@quantum>
References: <1424799222-9301-1-git-send-email-lee.jones@linaro.org>
 <20150304120003.GL32624@x1> <20150306190812.11109.82130@quantum>
Message-ID: <20150309092804.GB3427@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 06 Mar 2015, Mike Turquette wrote:

> Quoting Lee Jones (2015-03-04 04:00:03)
> > Mike,
> > 
> > Do you want me to resend this set with Robert's Reviewed-by applied,
> > or are you happy to apply it yourself?
> 
> No need for the resend. I am hoping for a final review from a DT human.
> 
> This approach looks fine to me. In practice I think it is restricted to
> hardware blocks that don't exist in DT yet (e.g. no driver, in the case
> of your interconnect) and that restriction is probably for the best.

Agreed.

> > > v2 => v3:
> > >   - Ensure DT actually reflects h/w
> > >     - i.e. Nodes should not contain a mishmash of different IP
> > >       blocks, but should identify related h/w.  In the current
> > >       example we use interconnects
> > >   - Change naming from clkdomain to clk-always-on
> > >   - Place "do not abuse" warning in documentation
> > > 
> > > v1 => v2:
> > >   - Turned the ST specific driver into a generic one
> > >   
> > > Hardware can have a bunch of clocks which must not be turned off.
> > > If drivers a) fail to obtain a reference to any of these or b) give
> > > up a previously obtained reference during suspend, the common clk
> > > framework will attempt to turn them off and the hardware will
> > > subsequently die.  The only way to recover from this failure is to
> > > restart.
> > >   
> > > To avoid either of these two scenarios from catastrophically
> > > disabling the running system we have implemented a clock domain
> > > where clocks are consumed and references are taken, thus preventing
> > > them from being shut down by the framework.
> > > 
> > > *** BLURB HERE ***
> > > 
> > > Lee Jones (4):
> > >   ARM: sti: stih407-family: Supply defines for CLOCKGEN A0
> > >   ARM: sti: stih407-family: Add platform interconnects to always-on clk
> > >     domain
> > >   clk: Provide an always-on clock domain framework
> > >   clk: dt: Introduce always-on clock domain documentation
> > > 
> > >  .../devicetree/bindings/clock/clk-always-on.txt    | 35 ++++++++++++
> > >  arch/arm/boot/dts/stih407-family.dtsi              | 15 ++++++
> > >  drivers/clk/Makefile                               |  1 +
> > >  drivers/clk/clk-always-on.c                        | 62 ++++++++++++++++++++++
> > >  include/dt-bindings/clock/stih407-clks.h           |  4 ++
> > >  5 files changed, 117 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/clock/clk-always-on.txt
> > >  create mode 100644 drivers/clk/clk-always-on.c
> > > 
> > 

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
