From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 19 Feb 2015 10:11:06 +0000
Subject: [PATCH v2 4/4] clk: dt: Introduce always-on clock domain
 documentation
In-Reply-To: <CAMuHMdW+np0_zUhBOXVBN_7ztM5Z=xN5-mE-P_wR35BggQxerQ@mail.gmail.com>
References: <1424276101-30137-1-git-send-email-lee.jones@linaro.org>
 <1424276101-30137-5-git-send-email-lee.jones@linaro.org>
 <CAL_Jsq+r1BKt5B9FNPG+Y0Oi1-3RGNmRUDbpX_uDJwr45bxMXA@mail.gmail.com>
 <20150218171230.GA30676@x1>
 <CAL_JsqJ0sfQ-OQvYjL3X3ebH4p9HkN4iy35iT7i9S2d+yz9zYg@mail.gmail.com>
 <20150218215435.GA32415@x1>
 <CAMuHMdU6DpZoi-q3pUFUX8xjnXGfTqfEYyzajZZm=-qZTk1qHQ@mail.gmail.com>
 <20150219094200.GB12212@x1>
 <CAMuHMdW+np0_zUhBOXVBN_7ztM5Z=xN5-mE-P_wR35BggQxerQ@mail.gmail.com>
Message-ID: <20150219101106.GD12212@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 19 Feb 2015, Geert Uytterhoeven wrote:

> Hi Lee,
> 
> On Thu, Feb 19, 2015 at 10:42 AM, Lee Jones <lee.jones@linaro.org> wrote:
> >> What kind of clocks are these? What do they control?
> >> Memory controllers? Bus controllers?
> >>
> >> They must control some device(s), so there should be one or more device
> >> nodes in DT that reference these clocks.
> >> As soon as that information is in DT, support can be added to Linux to
> >> make sure the "critical" clocks stay enabled, either through a real driver,
> >> or through platform code.
> >
> > Some do, some don't.  For instance, we have one clock which controls
> > SPI and I2C that must not be turned off.  We discovered this then when
> > a suspend was attempted and the board refused to resume.  This clock
> > also runs one of the critical interconnects that runs from the a9.  It
> > would be wrong to remove the clk_disable() attempt from the SPI/I2C
> > drivers because the same IP on another board might be controlled by a
> > different clock which is able to be gated.
> >
> > There are also clocks which control other interconnects that are not
> > connected to any device drivers.  If we fail to take references for
> > them before clk_disable_unused() is called, again the board hangs.  We
> > even lose JTAG support.
> 
> Interconnects are buses. Can't you represent those buses in the DT
> hierarchy, and give them clocks properties?

So instead of this nice succinct, simple, cover all bases
(interconnects was just an example, there are bound to be others),
generic framework, you are suggesting to write drivers for devices
which other than "don't turn my clocks off", Linux can't actually see
or control?

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
