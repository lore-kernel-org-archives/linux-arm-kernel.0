From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 11 Mar 2015 13:40:12 +0100
Subject: [PATCH v5 3/3] ARM: dts: igep00x0: add wl18xx bindings
In-Reply-To: <CABxcv=nE_Qd7do+dRyp=fw3wYmWFb+0eEjXYOtdjqE55Cp0zmQ@mail.gmail.com>
References: <1425915402-10012-1-git-send-email-eliad@wizery.com>
 <3439869.6umCuOq6SV@wuerfel>
 <CABxcv=nE_Qd7do+dRyp=fw3wYmWFb+0eEjXYOtdjqE55Cp0zmQ@mail.gmail.com>
Message-ID: <6286151.8rcX893TN6@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 11 March 2015 12:34:03 Javier Martinez Canillas wrote:
> Hello Arnd,
> 
> On Wed, Mar 11, 2015 at 10:53 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Wednesday 11 March 2015 02:00:59 Javier Martinez Canillas wrote:
> >>
> >> What do you mean by parsing here? IIUC there isn't a clock driver for
> >> these clocks and are setup directly in the
> >> drivers/net/wireless/ti/wl12xx/main.c driver.
> >>
> >> So you can't make the WLAN chip dev node a consumer of these clocks by
> >> adding a phandle to a clock provider and clock specifiers since there
> >> isn't a provider to be referenced in the DT. Or did I misunderstand?
> >
> > As I understand it, the clock signal is provided by an external oscillator,
> 
> According to [0], it seems the chip can be connected to both external
> oscillators or internal clocks provided by the chip itself.

I see, that part wasn't clear to me.

> > which we can easily model in DT, and then you call clk_get_rate on that.
> >
> 
> Right, my point wast that this can be done only if the external
> oscillator have a proper clock driver / provider which I don't think
> is the case here. Most of this stuff predates the common clock
> framework.
> 
> Or at least Luciano Coelho had a patch on his series to make the
> wilink driver a clock provider itself by registering the refclock and
> tcxoclock clocks [0].

I guess we should only do this if the clocks from the wilink device
might be used by some other device.

> Luciano also had patches for:
> 
> * Adding the clock provider dev node in the DTS [1]
> * Have a table to map the clock rate with the FW configuration values [2]
> * Getting the clock from DT and the rate as you said to configure the
> firmware accordingly [3]
> 
> I think that patch [0] should not be needed since for external clocks,
> the IP providing the clocks should have its own clock driver and for
> internal clocks, a property should be used instead as you said.

Right.

> > If there is no external clock provider for this chip and the clocks
> > are provided by the device itself, then all we need is a clock-frequency
> > property in the device node.
> >
> 
> Agreed, IIUC Luciano wanted to expose the internal clocks by
> registering in the common clock framework but if those clocks are not
> really accessible from outside the wlan chip, then I also think that a
> device node property should be used instead.

If I understand this right, that measn we can easily distinguish between
an external XTAL clock and the internal clock by they way they are
described in the DT: for the internal clock, we just provide a clock-frequency
property, while the external clock would be referenced through a clocks
property.

	Arnd
