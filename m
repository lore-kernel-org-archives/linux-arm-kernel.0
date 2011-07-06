From: balbi@ti.com (Felipe Balbi)
Date: Wed, 6 Jul 2011 10:34:02 +0300
Subject: [PATCH 15/15] pxa2[57]x_udc: drop gpio_pullup handling
In-Reply-To: <4E140F2C.2010900@gmail.com>
References: <1309871321-11305-1-git-send-email-dbaryshkov@gmail.com>
	<1309871321-11305-16-git-send-email-dbaryshkov@gmail.com>
	<4E13772B.2090406@free.fr>
	<CALT56yP5yNPZoJ_+6a4t2t6rY_hmej5fc-NG02Jef-QiXHrc=Q@mail.gmail.com>
	<20110706072042.GC10729@legolas.emea.dhcp.ti.com>
	<4E140F2C.2010900@gmail.com>
Message-ID: <20110706073401.GE10729@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jul 06, 2011 at 11:30:52AM +0400, Dmitry Eremin-Solenikov wrote:
> On 06.07.2011 11:20, Felipe Balbi wrote:
> >hi,
> >
> >On Wed, Jul 06, 2011 at 12:58:48AM +0400, Dmitry Eremin-Solenikov wrote:
> >>On 7/6/11, Robert Jarzmik<robert.jarzmik@free.fr>  wrote:
> >>>On 07/05/2011 03:08 PM, Dmitry Eremin-Solenikov wrote:
> >>>>Now as all drivers were converted to using gpio-vbus, drop gpio-pullup
> >>>>handling from pxa UDC drivers, thus simplifying them a bit.
> >>>
> >>>Is this patch compliant with USB 2 specification regarding maximum time
> >>>between pullup triggering and UDC ready to answer the "RESET" packet and
> >>>be assigned an address ?
> >>>
> >>>This is the sequence I'm worried about :
> >>>   (1) The gpio-vbus is loaded
> >>>   (2) The pxa27x_udc is loaded
> >>>   (3) USB cable is plugged
> >>>       =>  VBUS is sensed
> >>>   (4) gpio-vbus pulls up the D+ (Dmitry, is that right ?)
> >>>   (5) the host waits for UDC to settle (100 ms ?)
> >>>   (5) set address packet(s) are sent from host to UDC
> >>>   (6) UDC is not enabled, as no gadget is registered
> >>>       =>  UDC doesn't answer
> >>>       =>  usb host cannot assign it an address
> >>>   (7) a gadget is loaded (g_ether for example)
> >>>       =>  UDC is enabled, but too late
> >>>
> >>>Alan, Gregh, could you confirm point (5) about a maximum time between D+
> >>>line activation and UDC duty to repond to "set address" packets, as well
> >>>as the consequence of point (6) where the usb device is rejected because
> >>>no address could be assigned ?
> >>>
> >>>Dmitry, could you confirm the the D+ pullup is done at point (4) ?
> >>
> >>No, I can't confirm this. IIUC, evrything happens in abit different way:
> >>(4) trancseiver notifies udc about VBUS sense
> >>(5) a gadget is loaded (g_ether for example)
> >>(6) gadget asks udc to enale  pullup
> >>(7) udc tells gpio_vbus to enable pullup.
> >
> >yeah, with udc-core.c we only enable pullup after gadget driver is
> >loaded.
> >
> >290                 ret = bind(udc->gadget);
> >291                 if (ret)
> >292                         goto err1;
> >293                 ret = usb_gadget_udc_start(udc->gadget, driver);
> >294                 if (ret) {
> >295                         driver->unbind(udc->gadget);
> >296                         goto err1;
> >297                 }
> >298                 usb_gadget_connect(udc->gadget);
> >
> >but this is the new style bind() and many UDCs still need to be
> >converted.
> 
> This was working before the udc-core. If it doesn't work now for
> unconverted drivers (PXA e.g.) that's really a huge regression!

the difference is that before every UDC had to implement that by itself
and now we're moving the common parts to a generic layer. If your UDC
already implemented it this way when exporting
usb_gadget_probe_driver(), then no changes for you, but I guarantee
there where UDCs which didn't mind being careful with data pullups and
would connect even though a gadget driver was nowhere to be seen ;-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 490 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110706/a135c906/attachment.sig>
