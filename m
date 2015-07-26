From: stern@rowland.harvard.edu (Alan Stern)
Date: Sun, 26 Jul 2015 11:14:37 -0400 (EDT)
Subject: [PATCH v3 42/46] usb: gadget: move ep_matches() from epautoconf
 to udc-core
In-Reply-To: <55B427B4.5010309@tul.cz>
Message-ID: <Pine.LNX.4.44L0.1507261053500.1012-100000@netrider.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 26 Jul 2015, Petr Cvek wrote:

> What about higher speeds (not relevant on PXA, but ep_matches() is
> called from usb_ep_autoconfig_ss() )? According to
> 
> 	http://wiki.osdev.org/Universal_Serial_Bus#Maximum_Data_Payload_Size_2
> 
> High speed INT endpoint has a maximum data payload 1024 B and BULK
> only 512 B (are other attributes of the data phase similar?). What
> about superspeed?

It's true that high speed interrupt endpoints can have higher maxpacket
values than bulk endpoints.  But this is okay, since ep_matches()  
checks that the hardware maxpacket value is at least as large as the
value in the descriptor:

		if (ep->maxpacket_limit < max)
			return 0;
 
> >> * modprobe g_serial use_acm=1 n_ports=1
> >> * original version of ep_matches() (returns bulk and int)
> >> * compatible EP configuration/definition for UDC side http://lxr.free-electrons.com/source/drivers/usb/gadget/udc/pxa27x_udc.c#L2352
> >> 	USB_EP_CTRL,
> >> 	USB_EP_OUT_BULK(1),
> >> 	USB_EP_IN_BULK(2),
> >> 	USB_EP_IN_ISO(3),
> >> 	USB_EP_OUT_ISO(4),
> >> 	USB_EP_IN_INT(5),
> >> * modified EP configuration for UDC side (just changed EP3 ISO to BULK, so there is one free BULK)
> >> 	USB_EP_CTRL,
> >> 	USB_EP_OUT_BULK(1),
> >> 	USB_EP_IN_BULK(2),
> >> 	USB_EP_IN_BULK(3),	//change
> >> 	USB_EP_OUT_ISO(4),
> >> 	USB_EP_IN_INT(5),
> >>
> >> ===results===
> >> * original configuration is OK, all endpoints are found (in order ep2in-bulk, ep1out-bulk, ep3in-int), INT notification seems to work
> > 
> > I don't understand.  Above you said that the EP definition in the UDC 
> > is USB_EP_IN_ISO(3).  So how can you end up with ep3in-int?  int != ISO.
> > You should have ended up with the third endpoint being ep5in-int, 
> > because ep_matches() doesn't allow an isochronous to match a request 
> > for an interrupt endpoint.
> 
> I have changed definition of ISO to BULK only to accomplish minimal
> change of driver code (for my demonstration free BULK must be defined
> before INT - inserting new EP would require to reindex all next EPs
> and modifying links from PXA side endpoints). The USB_EP_IN_ISO(3) is
> just "unused" endpoint.

This doesn't answer my question.  I was asking about the original 
configuration, not your changed configuration.  You wrote:

> * original configuration is OK, all endpoints are found (in order
> ep2in-bulk, ep1out-bulk, ep3in-int), INT notification seems to work

But that isn't possible, because in the original configuration ep3in is
iso, not int.  Did you intend to write "ep5in-int" rather than
"ep3in-int"?

> >> * modified configuration fails:
> >>
> >> 	[ 4259.609088] pxa27x-udc pxa27x-udc: ep15:pxa_ep_enable: type mismatch
> >>
> >> by this condition: 
> >>
> >> 	http://lxr.free-electrons.com/source/drivers/usb/gadget/udc/pxa27x_udc.c#L1416
> >>
> >> because ep_matches() returns BULK.
> > 
> > Okay, that's a problem in pxa27x-udc.  Why does it insist on an exact 
> > match between the hardware endpoint type and the type contained in the 
> > descriptor?  It should accept an interrupt descriptor if the hardware 
> > type is bulk.
> 
> Hmm, making BULK EP equivalent with INT EP (when INT is requested)
> would made debugging (there is special bitfield in the config
> registers) and configuration preset (not anymore unordered set, but
> definition in the specific sequence) hell. But in other ways it can
> be OK (specification does not say that using EP marked INT as BULK
> will fail).

This business about using bulk endpoints in place of interrupt
endpoints goes back to the days when most UDCs had a very limited
selection of endpoints.  The idea was that a gadget could work even if
there weren't enough interrupt endpoints in the hardware, provided
there were extra bulk endpoints.

> I think optimal idea is custom matcher function. It would eliminate
> codes for superspeed checking on SoC which known only fullspeed ;-).

Wuldn't it also mean duplicating a lot of code?  Each custom matcher 
function would essentially have to include most of ep_matches().

> P.S. I did a basic research where UDCs differ between BULK and INT
> handling (just searching for usb_endpoint_type(), USB_ENDPOINT_XFER_*
> and usb_endpoint_xfer_*() so it returned BULK on a software side -
> irrelevant):
> 	r8a66597-udc.c (using different constants, dedicated structure entries)
> 	m66592-udc.c (same as r8a66597-udc.c)
> 	dummy_hcd.c (well it is only dummy, says "bulk is OK" for INT, but has different matching rules for HS BULK and INT)
> 	atmel_usba_udc.c (only by write of some flag)
> 	net2272.c (fails with BULK, USB_SPEED_HIGH and maxpacket != 512)
> 	at91_udc.c (only BULK is only OK with 8,16,32,64 values)
> 	pxa25x_udc.c (setting one flag when hw (?) endpoint is BULK and another if nonBULK, INT FIFO size defined as 8, BULK FIFO as 64)
> 	net2280.c (INT path has erratum, different maxpacket matching)
> 	pxa27x_udc.h (INT_FIFO_SIZE defined as 16B, BULK_FIFO_SIZE defined as 64B)
> 	mv_udc_core.c (different codepath)
> 	gr_udc.c (using mode of endpoint to print messages and register setting)
> 	fsl_qe_udc.c (different maxpacket sizes for highspeed)
> 	udc-xilinx.c (maching of different maxpacket sizes)
> 	omap_udc.c (maxpacket size definitions)

The fact that bulk and interrupt are handled differently doesn't mean 
that you aren't allowed to allocate a bulk endpoint when the gadget 
driver quested an interrupt endpoint.

On the other hand, it certainly would be better to do this only when no 
interrupt endpoints remain available.  As it stands now, 
usb_ep_autoconfig_ss() uses the first match it finds even if there is a 
better match later on.

Alan Stern
