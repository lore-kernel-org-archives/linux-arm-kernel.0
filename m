From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Fri, 11 Feb 2011 14:58:02 +0100
Subject: [PATCH v2] i.MX51 iomux: Fixes MX51_PAD_UART2_TXD__UART2_TXD
	declaration
In-Reply-To: <20110211133945.GA2282@richard-laptop>
References: <1297420916-14505-1-git-send-email-julien.boibessot@free.fr>
	<20110211122505.GB1866@richard-laptop>
	<19797.13329.366998.503112@ipc1.ka-ro>
	<20110211133945.GA2282@richard-laptop>
Message-ID: <19797.16490.726250.924375@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Richard Zhao writes:
> On Fri, Feb 11, 2011 at 02:05:21PM +0100, Lothar Wa?mann wrote:
> > Hi,
> > 
> > Richard Zhao writes:
> > > Hi Julien,
> > > 
> > > #define _MX51_PAD_USBH1_DATA2__UART2_TXD	IOMUX_PAD(0x690, 0x290, 1, 0x09ec, 5, 0)
> > > 
> > > Will you change the above line too?
> > > 
> > Seems like a general copy/paste error in the i.MX51 Ref Manual.
> > For all pads that can have an UART RXD or TXD function the manual
> > states that the UART*_IPP_UART_RXD_MUX_SELECT_INPUT register must be
> > configured, while this is obviously only sensible for the RXD
> > function.
> Yes, it's for RXD. RXD can also select input from TXD.
> 
The RXD function can be routed to the TXD pads via
RXD_MUX_SELECT_INPUT, but IMO setting the INPUT_MUX for an OUTPUT
function (TXD) is nonsense.

E.g.:
|Table A-1271. Register: IOMUXC_UART2_IPP_UART_RXD_MUX_SELECT_INPUT
|
|010: Selecting Pad: UART2_RXD for Mode: ALT0.
|011: Selecting Pad: UART2_TXD for Mode: ALT0.
so, the input path for the RXD function can be routed to either the
UART2_RXD or UART2_TXD pad.

|Table A-286. Register IOMUXC_SW_MUX_CTL_PAD_UART2_RXD Bits Description
|000: Select mux mode: ALT0 mux port: RXD_MUX of instance: uart2.
|NOTE: Pad UART2_RXD is involved in Daisy Chain.
|- Config Register IOMUXC_UART2_IPP_UART_RXD_MUX_SELECT_INPUT for mode
|ALT0.
This is OK. RXD_MUX is an input whose source is defined by the
RXD_MUX_SELECT_INPUT register.

But:
|Table A-288. Register IOMUXC_SW_MUX_CTL_PAD_UART2_TXD Bits Description
|000: Select mux mode: ALT0 mux port: TXD_MUX of instance: uart2.
|
|NOTE: Pad UART2_TXD is involved in Daisy Chain.
|- Config Register IOMUXC_UART2_IPP_UART_RXD_MUX_SELECT_INPUT for mode
|ALT0.
IMO does not make any sense. TXD_MUX is an OUTPUT function.
How can the INPUT MUX route an OUTPUT PAD?

Also, the table Table 4-3. i.MX51 Daisy Chain Settings only mentions
the uart_rxd_mux pins, but not uart_txd_mux.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
