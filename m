From: jbrunet@baylibre.com (Jerome Brunet)
Date: Wed, 29 Mar 2017 08:21:30 +0200
Subject: [PATCH v2,1/3] meson_uart: expose CLKID_UARTx
In-Reply-To: <CAFBinCDF29+kQpedsJPqRy6fztWrj91Qi6tCno_2S6UCkhW7XQ@mail.gmail.com>
References: <20170328092545.4644-1-hgkr.klein@gmail.com>
 <20170328092545.4644-2-hgkr.klein@gmail.com>
 <1490716277.20764.6.camel@baylibre.com>
 <71489b62-78c8-7082-587e-8598dc43ca59@gmail.com>
 <1490728490.20764.8.camel@baylibre.com>
 <CAFBinCDF29+kQpedsJPqRy6fztWrj91Qi6tCno_2S6UCkhW7XQ@mail.gmail.com>
Message-ID: <1490768490.2439.1.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-03-28 at 23:24 +0200, Martin Blumenstingl wrote:
> Hi Jerome,
> 
> On Tue, Mar 28, 2017 at 9:14 PM, Jerome Brunet <jbrunet@baylibre.com> wrote:
> > On Tue, 2017-03-28 at 20:18 +0200, Helmut Klein wrote:
> > > i know for sure that the bluetooth chip of my system is connected to
> > > uart_A. so this clock must be exposed.
> > > 
> > > i don't know if the other 2 uarts are used on other hardware. so i will
> > > remove them from my patch.
> > 
> > What I meant is device trees "upstream".
> > I would expect such patch as part of a series to add support for your board
> > in
> > device-tree, with its bluetooth chipset.
> 
> are you sure about this? 

Actually no ;) I started questioning this reply as soon as I sent it.
the moto so far as been "we expose what's needed" but there is many ways to
interpret that.

DT bindings is an ABI. Simply because we don't use part of that ABI upstream,
doesn't mean we shouldn't provide it. My previous statement was clearly wrong
about this, apologies.

> Helmut is configuring the core clock of the
> UART controller(s) here. we have the same thing for many other drivers
> as well (MMC, SAR ADC, I2C, SPI, ethernet, you name it...) - these
> clocks are not part of a device specific .dts but rather the SoC
> specific dts (for example meson-gxbb.dtsi - because these clocks are
> not board specific).

Agreed
Since Helmut tested it, this clock should be added to the dtsi.

> I guess most boards are not affected because the bootloader simply
> enables the UART0 core/gate clock and keeps it enabled when booting
> the kernel. additionally our clock gates are marked with
> CLK_IGNORE_UNUSED so if the bootloader keeps the gates enabled then
> we're not disabling it either.
> 
> > I think it would better to drop this patch from the series.
> > You can either keep it for your personal work, or send it again when
> > upstreaming
> > the support for your board and/or add the support for the bluetooth chip.
> 
> if we decide to pass the core/gate clock directly in SoC.dtsi then we
> should think about doing it for all three non-AO UARTs (uart_a, uart_b
> and uart_c).
> we can test uart_b on GPIODV_24 and GPIODV_25 on the Khadas VIM board
> for example (pins 22 and 23 on the header, default mode of these pins
> is i2c_sck_a and i2c_sda_a, but we can re-configure it).
> uart_c unfortunately cannot be tested on the Khadas VIM board since
> it's only routed to GPIOX_8 and GPIOX_9 which are hard-wired to the
> bluetooth module's PCM pins (BTPCM_DOUT and BTPCM_DIN).
> 
> for Helmut this would mean that instead of dropping this patch (or
> dropping CLKID_UART1 and CLKID_UART2 from this patch) he would rather
> have to *add* another patch (for meson-gxbb.dtsi and meson-gxl.dtsi)
> which passes the core clocks to the corresponding UART controllers
> (similar to the CLKID_SD_EMMC_ clocks).

You are right. This could be part of another series.
I guess this patch fine as it is.

Acked-by:?Jerome Brunet <jbrunet@baylibre.com>

> 
> 
> Regards,
> Martin
> 
> 
> [0] http://lxr.free-electrons.com/source/drivers/clk/meson/clkc.h?v=4.10#L110
