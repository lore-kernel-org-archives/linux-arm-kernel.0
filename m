From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Fri, 13 Jun 2014 15:24:12 +0200
Subject: [PATCH v2] ARM: shmobile: koelsch: Add support HSCIF1
In-Reply-To: <CAMuHMdUd=E=TcSTPwy0xbpAcZH+voiEkjND=qzdSzG_zKdPe9g@mail.gmail.com>
References: <1402367659-21117-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
 <9058795.dyXpcFtuGJ@avalon>
 <CAMuHMdUd=E=TcSTPwy0xbpAcZH+voiEkjND=qzdSzG_zKdPe9g@mail.gmail.com>
Message-ID: <1751840.oCdYe48VRu@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

On Friday 13 June 2014 13:16:34 Geert Uytterhoeven wrote:
> On Fri, Jun 13, 2014 at 12:49 PM, Laurent Pinchart wrote:
> > On Friday 13 June 2014 16:43:07 Simon Horman wrote:
> >> On Fri, Jun 13, 2014 at 09:01:27AM +0200, Laurent Pinchart wrote:
> >> > On Tuesday 10 June 2014 16:00:48 Simon Horman wrote:
> >> > > On Tue, Jun 10, 2014 at 01:14:27PM +0900, Magnus Damm wrote:
> >> > > > On Tue, Jun 10, 2014 at 11:34 AM, Nobuhiro Iwamatsu wrote:
> >> > > > > Koelsch can use HSCIF1 insetead of SCIF1 as serial port. But if
> >> > > > > we want to use, we will need to disable the GPIO key and
> >> > > > > remodeling of the board. Therefore status of hscif1 does not set
> >> > > > > the "okay".
> >> > > > > 
> >> > > > > Signed-off-by: Nobuhiro Iwamatsu
> >> > > > > <nobuhiro.iwamatsu.yj@renesas.com>
> >> > > > > ---
> >> > > > > 
> >> > > > >  V2: Remove hscif1_clk from renesas,groups. This pin does not
> >> > > > >  use.
> >> > > > 
> >> > > > Thanks for updating the patch. This looks fine to me.
> >> > > > 
> >> > > > Acked-by: Magnus Damm <damm+renesas@opensource.se>
> >> > > 
> >> > > Thanks, I will queue this up.
> >> > 
> >> > Sorry for the late reply, but I have some doubts about this. The HRX0
> >> > and HTX0 signals are connected to push buttons and used as GPIOs.
> >> > Beside, they're not routed to serial port transceiver. If we want to
> >> > use HSCIF0 on those pins on Koelsch and extension board must be
> >> > connected to the EXIO C connector, and two resistors and two capacitors
> >> > should be unsoldered. I thus don't think the Koeslch DT should contain
> >> > pinmux data for the HSCIF0 device. If an extension board is used and
> >> > HSCIF0 needed, then the DT file for the extension board should define
> >> > pinmuxing for the serial port.
> 
> You mean HRX1, HTX1, and HSCIF1?

*sigh*... :-)

> HTX1 and HRX1 can be connected to the DEBUG1 transceiver by stuffing
> zero-Ohm resisters to R834 and R835.
> 
> About your comment about the resistors and capacitors, which applies to
> both HSCIF0 and HSCIF1: probably the serial port will still work if
> these are present.

With a 4.7?F capacitive load on the transmission line, assuming a drive 
strength of 40mA (which is pretty high), switching between 0V and 3.3V takes 
388?s, corresponding to 2579 Hz. You'll have to reduce the baud rate :-)

> >> If you would like me to revert this patch I am happy to consider doing
> >> so.
> > 
> > That's one option, but I'd like to get feedback on my point of view before
> > reverting it. Who knows, I might be wrong ;-)
> 
> Nevertheless, I agree with Laurent.
> 
> HSCIF1 (and HSCIF0) cannot be used on the Koelsch board as-is, hence they
> should not be present in the plain Koelsch DTS.  They should be put in
> an overlay DTS instead.

-- 
Regards,

Laurent Pinchart
