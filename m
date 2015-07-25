From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 25 Jul 2015 13:04:51 +0200
Subject: [PATCH v3 42/46] usb: gadget: move ep_matches() from epautoconf
 to udc-core
In-Reply-To: <55B31FC9.1000407@tul.cz> (Petr Cvek's message of "Sat, 25 Jul
 2015 07:34:01 +0200")
References: <Pine.LNX.4.44L0.1507231542520.25082-100000@netrider.rowland.org>
 <55B31FC9.1000407@tul.cz>
Message-ID: <87oaj0ebvw.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Petr Cvek <petr.cvek@tul.cz> writes:

> On 23.7.2015 21:46, Alan Stern wrote:
>>> It seems that it allows using a BULK endpoint for requested INT
>>> endpoint. For my PXA27x machine the original code returns BULK EP
>>> even with valid INT endpoint definition (because BULK EPs are defined
>>> earlier than INT EPs).
>> 
>> Yes, it does allow a bulk endpoint to be used when an interrupt 
>> endpoint was requested.  However, it won't return a bulk endpoint if 
>> all the bulk endpoints are already in use.
This cannot work for pxa27x.

The pxa27x IP has a hardware limitation which prevents an endpoint from changing
its type once the UDC is enabled (see the comment at the beginning of
pxa27x_udc.c).

If that patchset implies that for a requested INT endpoint a BULK endpoint can
be returned, that won't work. Felipe and Robert, is that what this patchset
implies ?

> A default PXA27x configuration returns BULK for requested INT. Which is
> unfortunate, because PXA27x supports INT endpoints and has one predefined, but
> this function find BULK first (one BULK is allocated and INT is never used).
See above.

> Because if they do, the ep_matches() function works poorly. It returns a BULK
> for device (gadget) side, but host side (PC) thinks that this endpoint is an INT
> and handles it in this way. But the PXA27x thinks the endpoint is a BULK and
> handles it in its way (according to datasheet, settings for a BULK and an INT
> transfers are not 100% compatible).
>
> I cannot test "INT as BULK" behavior for the gadget functions, because all
> gadgets which works on PXA27x does not use INT endpoints (some allocate the
> endpoint but never use it).
Ah a bit of history here.

At least gadget zero does, and it's my main testing point for pxa27x_udc.
Then there should be g_serial (no acm nor obex), but that's something I have not
tried since 2009 ...

For history also, there was already an attempt a long time ago for epautoconf
revamping, done by Rodolfo Giometti IIRC.

Anyway, I need pxa27x_udc to remain functional, so I'd like to understand if
something will stop working, Robert B.

Cheers.

-- 
Robert
