From: petr.cvek@tul.cz (Petr Cvek)
Date: Sat, 25 Jul 2015 21:14:56 +0200
Subject: [PATCH v3 42/46] usb: gadget: move ep_matches() from epautoconf
 to udc-core
In-Reply-To: <87fv4cdv7v.fsf@belgarion.home>
References: <Pine.LNX.4.44L0.1507251117020.31041-100000@netrider.rowland.org>
 <87fv4cdv7v.fsf@belgarion.home>
Message-ID: <55B3E030.3030402@tul.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25.7.2015 19:04, Robert Jarzmik wrote:
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
> 

Yes, maxpacket could be problem. Datasheet has listed range (1-64) for INT and specific values (8, 16, 32, 64) for BULK.


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

Yes functional behavior of this patch is same as in vanilla, I only began this thread, because I have found out that someone is sending patchset. 

But I found this behavior when I was trying to use g_webcam gadget. 

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
>  - pxa27x_udc offers 3 endpoints : ep-in, ep-out, ep-iso-in
>  - a gadget driver does :
>    - request an ep-in
>    - request an ep-out
>    - request an ep-in
>    - request an ep-iso-in
> In that case, the ep-iso-in request will fail, right ? Yet I would have expected
> the second ep-in request to fail, as that's the one which cannot be serviced.
> 
> Of course, this hypothetical case implies that pxa27x_udc is not compatible with
> this gadget driver, so it's not really relevant, is it ...

I have finally gathered enough information and luck (unstable machine) to try test g_serial so configuration:

* modprobe g_serial use_acm=1 n_ports=1
* original version of ep_matches() (returns bulk and int)
* compatible EP configuration/definition for UDC side http://lxr.free-electrons.com/source/drivers/usb/gadget/udc/pxa27x_udc.c#L2352
	USB_EP_CTRL,
	USB_EP_OUT_BULK(1),
	USB_EP_IN_BULK(2),
	USB_EP_IN_ISO(3),
	USB_EP_OUT_ISO(4),
	USB_EP_IN_INT(5),
* modified EP configuration for UDC side (just changed EP3 ISO to BULK, so there is one free BULK)
	USB_EP_CTRL,
	USB_EP_OUT_BULK(1),
	USB_EP_IN_BULK(2),
	USB_EP_IN_BULK(3),	//change
	USB_EP_OUT_ISO(4),
	USB_EP_IN_INT(5),

===results===
* original configuration is OK, all endpoints are found (in order ep2in-bulk, ep1out-bulk, ep3in-int), INT notification seems to work
* modified configuration fails:

	[ 4259.609088] pxa27x-udc pxa27x-udc: ep15:pxa_ep_enable: type mismatch

by this condition: 

	http://lxr.free-electrons.com/source/drivers/usb/gadget/udc/pxa27x_udc.c#L1416

because ep_matches() returns BULK. g_serial later disables INT notification

	[ 4259.609871] g_serial gadget: acm ttyGS0 can't notify serial state, -22

So this function is waiting regression, all it takes is just one change into the PXA27x EP configuration or change of allocation order for endpoints in a gadget. And it limits other existing gadget from being supported too (PXA can have only 23 endpoints including different altsetting/interface/cfg combinations).

It could be easily fixed by gadget_is_pxa27x() function. 

Petr
