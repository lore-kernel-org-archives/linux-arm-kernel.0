From: clemens.gruber@pqgruber.com (Clemens Gruber)
Date: Fri, 6 Jan 2017 23:50:26 +0100
Subject: imx: RS-485 problems during TX, maybe DMA related
In-Reply-To: <CAOMZO5C3enuThR1DpcwNnqFdxd8tGoBwd76O62Gnviz8x1_a9w@mail.gmail.com>
References: <20170104160024.GA13442@archie.localdomain>
 <CAOMZO5C3enuThR1DpcwNnqFdxd8tGoBwd76O62Gnviz8x1_a9w@mail.gmail.com>
Message-ID: <20170106225026.GA3804@archie.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

On Fri, Jan 06, 2017 at 07:22:32PM -0200, Fabio Estevam wrote:
> Hi Clemens,
> 
> On Wed, Jan 4, 2017 at 2:00 PM, Clemens Gruber
> <clemens.gruber@pqgruber.com> wrote:
> > Hi,
> >
> > I observed odd behavior of the current tty/serial/imx.c driver in RS-485
> > mode.
> >
> > RX works fine, but TX does not: When sending data, it arrives multiple
> 
> I am also trying to get rs485 in half-duplex mode to work on mx6dl
> with kernel 4.9.

I am glad I am not the only one working on this. Maybe we can figure it
out together :)

> 
> RX also works for me, but TX does not.
> 
> On my board it is the MX6QDL_PAD_CSI0_DAT16__UART4_RTS_B pin that
> controls the rs485 transceiver flow, but I do not
> see RTS to toggle to 1 during transmit. It stays always at 0.
> 
> I see you use CTS pin instead, but I thought RTS pin should be used.

I am pretty sure that CTS is the correct signal to control the
transceiver. In the reference manual on page 5231 (section 64.7.1) it
says: "The CTS_B pin can be used to control RS-485 output driver outside
the chip."
Maybe it is only called RTS in struct serial_rs485 because of DTE mode
where RX, TX, RTS and CTS are interchanged? Very confusing.

I am muxing MX6QDL_PAD_CSI0_DAT16__UART4_RTS_B and
MX6QDL_PAD_CSI0_DAT17__UART4_CTS_B because the transceiver-enable signal
is connected to ball L3 (CSI0_DAT17).

But according to the i.MX Pins tool, they can be muxed vice-versa too.
So if you connected the transceiver-enable to ball L4 (CSI0_DAT16), you
could mux MX6QDL_PAD_CSI0_DAT16__UART4_CTS_B and
MX6QDL_PAD_CSI0_DAT17__UART4_RTS_B instead?

As far as I understand, RTS is an input which is not used for RS-485, so
it is a no-connect on our board.

> 
> On my userspace application I have:
> 
> /* enable RS485 mode: */
> rs485conf.flags |= SER_RS485_ENABLED;
> 
> /* set logical level for RTS pin equal to 1 when sending: */
> rs485conf.flags |= SER_RS485_RTS_ON_SEND;
> 
> /* set logical level for RTS pin equal to 0 after sending: */
> rs485conf.flags &= ~(SER_RS485_RTS_AFTER_SEND);

This is similar to my config, however I had to also enable
SER_RS485_RX_DURING_TX, otherwise TX would not work at all.
Also, due to the active-low signal output on UART4_CTS_B, I use
~SER_RS485_RTS_ON_SEND and SER_RS485_RTS_AFTER_SEND.

--

Do you have an idea what could cause this doubling of the transmitted
characters and extra data I described?

Maybe you will see that effect too after you changed the pinmuxing.

At the moment I am trying to understand the interaction between the SDMA
engine and the imx UART driver. But this is the first time I dig into
DMA parts of the kernel and i.MX6/SDMA.. very challenging imho.

What's odd is that in RS-232 mode, everything works fine. This
buffer/DMA? problem only appears in RS-485 mode.

Regards,
Clemens
