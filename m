From: petr.cvek@tul.cz (Petr Cvek)
Date: Sat, 25 Jul 2015 21:25:36 +0200
Subject: [PATCH v3 42/46] usb: gadget: move ep_matches() from epautoconf
 to udc-core
In-Reply-To: <55B3D097.7090201@hackerion.com>
References: <Pine.LNX.4.44L0.1507251117020.31041-100000@netrider.rowland.org>
 <87fv4cdv7v.fsf@belgarion.home> <55B3D097.7090201@hackerion.com>
Message-ID: <55B3E2B0.9050106@tul.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25.7.2015 20:08, Robert Baldyga wrote:
>>
>> Let me give you another example :
>>   - pxa27x_udc offers 3 endpoints : ep-in, ep-out, ep-iso-in
>>   - a gadget driver does :
>>     - request an ep-in
>>     - request an ep-out
>>     - request an ep-in
>>     - request an ep-iso-in
>> In that case, the ep-iso-in request will fail, right ? Yet I would have expected
>> the second ep-in request to fail, as that's the one which cannot be serviced.
> 
> Gadget driver cannot simply request ep-in. Endpoints are matched with ep descriptors containing complete information about direction, type, maxpacketsize etc. of requested endpoint. So described situation can never take a place.
> 
> However if gadget driver requests more endpoints than UDC driver supplies it will do fail ;)

Yes and returning of BULK instead of INT can cause it (only defined BULK gets eaten by requested INT).

> 
> Current matching mechanism is very simple and surely will not always return optimal endpont set. Maybe we should try to develop something more sophisticated.

I can test it (as I'm trying to get to work other gadgets like g_webcam, g_audio, g_hid and possibly function composites).

> 
>>
>> Of course, this hypothetical case implies that pxa27x_udc is not compatible with
>> this gadget driver, so it's not really relevant, is it ...
>>
>>>>> Because if they do, the ep_matches() function works poorly. It returns a BULK
>>>>> for device (gadget) side, but host side (PC) thinks that this endpoint is an INT
>>>>> and handles it in this way. But the PXA27x thinks the endpoint is a BULK and
>>>>> handles it in its way (according to datasheet, settings for a BULK and an INT
>>>>> transfers are not 100% compatible).
>>>
>>> How do they differ?
>> One example I have in mind is chapter 12.4.2 of pxa27x developer manual
>> "Endpoint Memory Configuration", quote follows :
>>            If the USB host controller transmits more OUT data than the maximum
>>            size packet for a bulk or interrupt endpoint, the UDC does not send
>>            any handshake to the host controller causing the host controller to
>>            time-out. If the USB host controller transmits more OUT data than the
>>            maximum size packet for an isochronous endpoint, the UDC sets the data
>>            packet error (DPE) bit in the Endpoint Control/Status register,
>>            UDCCSRx[DPE].
>>
>>> Perhaps you could submit a patch that adds a "do not allocate a bulk
>>> endpoint when an interrupt endpoint is requested" quirk flag to the
>>> usb_gadget structure, and modify the matching code to take the new flag
>>> into account.
>> Well, if it was working that way already in the past, I don't see overloading
>> the code with a quirk a necessity. My only need is that it continues to work.
> 
> In this patchset I'm adding 'ep_match' callback to usb_gadget_ops, which can be used to supply non-standard matching algorithm, so there is no need for new quirk.

Yeah that would be better, every UDC to handle its way.

> 
> Cheers,
> Robert
> 

Petr
