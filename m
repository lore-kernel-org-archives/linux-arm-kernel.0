From: r.baldyga@hackerion.com (Robert Baldyga)
Date: Sat, 25 Jul 2015 20:08:23 +0200
Subject: [PATCH v3 42/46] usb: gadget: move ep_matches() from epautoconf
 to udc-core
In-Reply-To: <87fv4cdv7v.fsf@belgarion.home>
References: <Pine.LNX.4.44L0.1507251117020.31041-100000@netrider.rowland.org>
 <87fv4cdv7v.fsf@belgarion.home>
Message-ID: <55B3D097.7090201@hackerion.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 07/25/2015 07:04 PM, Robert Jarzmik wrote:
> Alan Stern <stern@rowland.harvard.edu> writes:
>
> Hi Alan,
>
>> On Sat, 25 Jul 2015, Robert Jarzmik wrote:
>>
>>> Petr Cvek <petr.cvek@tul.cz> writes:
>>>
>>>> On 23.7.2015 21:46, Alan Stern wrote:
>>>>>> It seems that it allows using a BULK endpoint for requested INT
>>>>>> endpoint. For my PXA27x machine the original code returns BULK EP
>>>>>> even with valid INT endpoint definition (because BULK EPs are defined
>>>>>> earlier than INT EPs).
>>>>>
>>>>> Yes, it does allow a bulk endpoint to be used when an interrupt
>>>>> endpoint was requested.  However, it won't return a bulk endpoint if
>>>>> all the bulk endpoints are already in use.
>>> This cannot work for pxa27x.
>>
>> Do you mean that on pxa27x, a bulk endpoint cannot be used as an
>> interrupt endpoint?  Why not?  From the device controller's point of
>> view, there is no difference between bulk and interrupt (except
>> possibly for the maxpacket sizes and high-bandwidth usage when running
>> at high speed).
> That's the point, maxpacket size and priority.
>
> As you said, it's not that it won't work, it won't work with the priority
> expected by the software stack, ie. higher priority for ISO endpoint.

Priority is not dependent on UDC hardware capabilities. Only USB host 
decides about priority, so there is no problem from UDC point of view.

>>> The pxa27x IP has a hardware limitation which prevents an endpoint from changing
>>> its type once the UDC is enabled (see the comment at the beginning of
>>> pxa27x_udc.c).
>>>
>>> If that patchset implies that for a requested INT endpoint a BULK endpoint can
>>> be returned, that won't work. Felipe and Robert, is that what this patchset
>>> implies ?
>>
>> Sort of.  The matching code has always behaved that way and this
>> patchset does not change the behavior.
> Then all is fine I suppose, if it was working before and nothing changes, it
> will continue to work, won't it ?
>
>>>> A default PXA27x configuration returns BULK for requested INT. Which is
>>>> unfortunate, because PXA27x supports INT endpoints and has one predefined, but
>>>> this function find BULK first (one BULK is allocated and INT is never used).
>>> See above.
>>
>> See response above.
>>
>> Besides, let's say the pxa27x has one bulk and one interrupt endpoint.
>> Now suppose the gadget driver requests a bulk endpoint first.  The
>> matching code will allocate the single bulk endpoint.  Then the gadget
>> driver requests an interrupt endpoint.  The matching code cannot
>> allocate the bulk endpoint, because that endpoint is already allocated.
>> So it will allocate the interrupt endpoint.
>>
>> Thus, as you can see, under the right conditions everything will work
>> as desired.
>
> Let me give you another example :
>   - pxa27x_udc offers 3 endpoints : ep-in, ep-out, ep-iso-in
>   - a gadget driver does :
>     - request an ep-in
>     - request an ep-out
>     - request an ep-in
>     - request an ep-iso-in
> In that case, the ep-iso-in request will fail, right ? Yet I would have expected
> the second ep-in request to fail, as that's the one which cannot be serviced.

Gadget driver cannot simply request ep-in. Endpoints are matched with ep 
descriptors containing complete information about direction, type, 
maxpacketsize etc. of requested endpoint. So described situation can 
never take a place.

However if gadget driver requests more endpoints than UDC driver 
supplies it will do fail ;)

Current matching mechanism is very simple and surely will not always 
return optimal endpont set. Maybe we should try to develop something 
more sophisticated.

>
> Of course, this hypothetical case implies that pxa27x_udc is not compatible with
> this gadget driver, so it's not really relevant, is it ...
>
>>>> Because if they do, the ep_matches() function works poorly. It returns a BULK
>>>> for device (gadget) side, but host side (PC) thinks that this endpoint is an INT
>>>> and handles it in this way. But the PXA27x thinks the endpoint is a BULK and
>>>> handles it in its way (according to datasheet, settings for a BULK and an INT
>>>> transfers are not 100% compatible).
>>
>> How do they differ?
> One example I have in mind is chapter 12.4.2 of pxa27x developer manual
> "Endpoint Memory Configuration", quote follows :
>            If the USB host controller transmits more OUT data than the maximum
>            size packet for a bulk or interrupt endpoint, the UDC does not send
>            any handshake to the host controller causing the host controller to
>            time-out. If the USB host controller transmits more OUT data than the
>            maximum size packet for an isochronous endpoint, the UDC sets the data
>            packet error (DPE) bit in the Endpoint Control/Status register,
>            UDCCSRx[DPE].
>
>> Perhaps you could submit a patch that adds a "do not allocate a bulk
>> endpoint when an interrupt endpoint is requested" quirk flag to the
>> usb_gadget structure, and modify the matching code to take the new flag
>> into account.
> Well, if it was working that way already in the past, I don't see overloading
> the code with a quirk a necessity. My only need is that it continues to work.

In this patchset I'm adding 'ep_match' callback to usb_gadget_ops, which 
can be used to supply non-standard matching algorithm, so there is no 
need for new quirk.

Cheers,
Robert
