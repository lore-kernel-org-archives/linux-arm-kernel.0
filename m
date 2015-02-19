From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 19 Feb 2015 10:43:32 +0000
Subject: [PATCH v2 4/4] clk: dt: Introduce always-on clock domain
 documentation
In-Reply-To: <CAMuHMdXYT6HvKhpi1mxF7SJBDyLVHw2W2Rxe1poDrdwKR0nu=w@mail.gmail.com>
References: <20150218171230.GA30676@x1>
 <CAL_JsqJ0sfQ-OQvYjL3X3ebH4p9HkN4iy35iT7i9S2d+yz9zYg@mail.gmail.com>
 <20150218215435.GA32415@x1>
 <CAMuHMdU6DpZoi-q3pUFUX8xjnXGfTqfEYyzajZZm=-qZTk1qHQ@mail.gmail.com>
 <20150219094200.GB12212@x1>
 <CAMuHMdW+np0_zUhBOXVBN_7ztM5Z=xN5-mE-P_wR35BggQxerQ@mail.gmail.com>
 <20150219101106.GD12212@x1>
 <CAMuHMdW=kV+zx=Uq7y7SyrH3eQyWsdfWjuLFMAKQjPhX-QaPPA@mail.gmail.com>
 <20150219102810.GE12212@x1>
 <CAMuHMdXYT6HvKhpi1mxF7SJBDyLVHw2W2Rxe1poDrdwKR0nu=w@mail.gmail.com>
Message-ID: <20150219104332.GF12212@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 19 Feb 2015, Geert Uytterhoeven wrote:

> Hi Lee,
> 
> On Thu, Feb 19, 2015 at 11:28 AM, Lee Jones <lee.jones@linaro.org> wrote:
> > On Thu, 19 Feb 2015, Geert Uytterhoeven wrote:
> >> On Thu, Feb 19, 2015 at 11:11 AM, Lee Jones <lee.jones@linaro.org> wrote:
> >> > On Thu, 19 Feb 2015, Geert Uytterhoeven wrote:
> >> >> On Thu, Feb 19, 2015 at 10:42 AM, Lee Jones <lee.jones@linaro.org> wrote:
> >> >> >> What kind of clocks are these? What do they control?
> >> >> >> Memory controllers? Bus controllers?
> >> >> >>
> >> >> >> They must control some device(s), so there should be one or more device
> >> >> >> nodes in DT that reference these clocks.
> >> >> >> As soon as that information is in DT, support can be added to Linux to
> >> >> >> make sure the "critical" clocks stay enabled, either through a real driver,
> >> >> >> or through platform code.
> >> >> >
> >> >> > Some do, some don't.  For instance, we have one clock which controls
> >> >> > SPI and I2C that must not be turned off.  We discovered this then when
> >> >> > a suspend was attempted and the board refused to resume.  This clock
> >> >> > also runs one of the critical interconnects that runs from the a9.  It
> >> >> > would be wrong to remove the clk_disable() attempt from the SPI/I2C
> >> >> > drivers because the same IP on another board might be controlled by a
> >> >> > different clock which is able to be gated.
> >> >> >
> >> >> > There are also clocks which control other interconnects that are not
> >> >> > connected to any device drivers.  If we fail to take references for
> >> >> > them before clk_disable_unused() is called, again the board hangs.  We
> >> >> > even lose JTAG support.
> >> >>
> >> >> Interconnects are buses. Can't you represent those buses in the DT
> >> >> hierarchy, and give them clocks properties?
> >> >
> >> > So instead of this nice succinct, simple, cover all bases
> >> > (interconnects was just an example, there are bound to be others),
> >> > generic framework, you are suggesting to write drivers for devices
> >> > which other than "don't turn my clocks off", Linux can't actually see
> >> > or control?
> >>
> >> DT describes the hardware, not behavior.
> >
> > Okay so ...
> >
> > /*
> >  * ICNs are not visible/controllable in Linux, but references to their
> >  * clocks must be obtained and retained or the platform will become
> >  * irrecoverably unresponsive.
> >  */
> > interconnects at 0 {
> >        compatible = "always-on-clk-domain";
> 
> st,...flexgen...
> 
> >        clocks = <&clk_s_c0_flexgen CLK_ICN_SBC>,
> >                 <&clk_s_c0_flexgen CLK_ICN_LMI>,
> >                 <&clk_s_c0_flexgen CLK_ICN_CPU>,
> >                 <&clk_s_c0_flexgen CLK_TX_ICN_DMU>;
> > };
> 
> And then you can have platform code that binds against st,...flexgen...,
> and enables all referenced clocks.

Flexgen isn't a device, it's a clk source.  a) writing a device driver
for a clk source seems wrong b) what if on another platform a
different clock source supplied the clock?  Write another driver?  And
what if the ICNs are connected to different clock sources?  More
drivers?  c) all of these drivers will only do one thing -- pull a
reference and keep hold of it.  You want 50 drivers (across all
platforms) doing only that?  Or, more sanely, do you want this one
generic framework driver doing that?

> Alternatively, if you have power domains, you can add a reference to
> the power domain, and let the power domain driver handle it.

I'm not sure what a power domain driver will do?  We need a driver to
_not_ give up references, that is all. :)

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
