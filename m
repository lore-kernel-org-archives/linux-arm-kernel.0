From: petr.cvek@tul.cz (Petr Cvek)
Date: Sun, 26 Jul 2015 02:20:04 +0200
Subject: [PATCH v3 42/46] usb: gadget: move ep_matches() from epautoconf
 to udc-core
In-Reply-To: <Pine.LNX.4.44L0.1507251715470.8892-100000@netrider.rowland.org>
References: <Pine.LNX.4.44L0.1507251715470.8892-100000@netrider.rowland.org>
Message-ID: <55B427B4.5010309@tul.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25.7.2015 23:36, Alan Stern wrote:
> On Sat, 25 Jul 2015, Petr Cvek wrote:
> 
>> On 25.7.2015 19:04, Robert Jarzmik wrote:
>>> Alan Stern <stern@rowland.harvard.edu> writes:
>>>
>>> Hi Alan,
>>>
>>>> On Sat, 25 Jul 2015, Robert Jarzmik wrote:
>>>>
>>>>> Petr Cvek <petr.cvek@tul.cz> writes:
>>>>>
>>>>>> On 23.7.2015 21:46, Alan Stern wrote:
>>>>>>>> It seems that it allows using a BULK endpoint for requested INT
>>>>>>>> endpoint. For my PXA27x machine the original code returns BULK EP
>>>>>>>> even with valid INT endpoint definition (because BULK EPs are defined
>>>>>>>> earlier than INT EPs).
>>>>>>>
>>>>>>> Yes, it does allow a bulk endpoint to be used when an interrupt 
>>>>>>> endpoint was requested.  However, it won't return a bulk endpoint if 
>>>>>>> all the bulk endpoints are already in use.
>>>>> This cannot work for pxa27x.
>>>>
>>>> Do you mean that on pxa27x, a bulk endpoint cannot be used as an
>>>> interrupt endpoint?  Why not?  From the device controller's point of
>>>> view, there is no difference between bulk and interrupt (except
>>>> possibly for the maxpacket sizes and high-bandwidth usage when running
>>>> at high speed).
>>> That's the point, maxpacket size and priority.
>>>
>>> As you said, it's not that it won't work, it won't work with the priority
>>> expected by the software stack, ie. higher priority for ISO endpoint.
>>>
>>
>> Yes, maxpacket could be problem. Datasheet has listed range (1-64)
>> for INT and specific values (8, 16, 32, 64) for BULK.
> 
> In practice I doubt this will matter.  Using a larger maxpacket size 
> than the gadget driver expects is rarely important for interrupt 
> transfers, since they almost never involve more than one packet's worth 
> of data.
> 
> So for example, if the gadget driver wants an interrupt endpoint with 
> maxpacket 42, it almost certainly will work okay if it gets a bulk 
> endpoint with maxpacket 64.

What about higher speeds (not relevant on PXA, but ep_matches() is called from usb_ep_autoconfig_ss() )? According to 

	http://wiki.osdev.org/Universal_Serial_Bus#Maximum_Data_Payload_Size_2

High speed INT endpoint has a maximum data payload 1024 B and BULK only 512 B (are other attributes of the data phase similar?). What about superspeed?

> 
>>>>> If that patchset implies that for a requested INT endpoint a BULK endpoint can
>>>>> be returned, that won't work. Felipe and Robert, is that what this patchset
>>>>> implies ?
>>>>
>>>> Sort of.  The matching code has always behaved that way and this
>>>> patchset does not change the behavior.
>>> Then all is fine I suppose, if it was working before and nothing changes, it
>>> will continue to work, won't it ?
>>
>> Yes functional behavior of this patch is same as in vanilla, I only
>> began this thread, because I have found out that someone is sending
>> patchset.
>>
>> But I found this behavior when I was trying to use g_webcam gadget. 
> 
>> I have finally gathered enough information and luck (unstable
>> machine) to try test g_serial so configuration:
>>
>> * modprobe g_serial use_acm=1 n_ports=1
>> * original version of ep_matches() (returns bulk and int)
>> * compatible EP configuration/definition for UDC side http://lxr.free-electrons.com/source/drivers/usb/gadget/udc/pxa27x_udc.c#L2352
>> 	USB_EP_CTRL,
>> 	USB_EP_OUT_BULK(1),
>> 	USB_EP_IN_BULK(2),
>> 	USB_EP_IN_ISO(3),
>> 	USB_EP_OUT_ISO(4),
>> 	USB_EP_IN_INT(5),
>> * modified EP configuration for UDC side (just changed EP3 ISO to BULK, so there is one free BULK)
>> 	USB_EP_CTRL,
>> 	USB_EP_OUT_BULK(1),
>> 	USB_EP_IN_BULK(2),
>> 	USB_EP_IN_BULK(3),	//change
>> 	USB_EP_OUT_ISO(4),
>> 	USB_EP_IN_INT(5),
>>
>> ===results===
>> * original configuration is OK, all endpoints are found (in order ep2in-bulk, ep1out-bulk, ep3in-int), INT notification seems to work
> 
> I don't understand.  Above you said that the EP definition in the UDC 
> is USB_EP_IN_ISO(3).  So how can you end up with ep3in-int?  int != ISO.
> You should have ended up with the third endpoint being ep5in-int, 
> because ep_matches() doesn't allow an isochronous to match a request 
> for an interrupt endpoint.

I have changed definition of ISO to BULK only to accomplish minimal change of driver code (for my demonstration free BULK must be defined before INT - inserting new EP would require to reindex all next EPs and modifying links from PXA side endpoints). The USB_EP_IN_ISO(3) is just "unused" endpoint.

> 
>> * modified configuration fails:
>>
>> 	[ 4259.609088] pxa27x-udc pxa27x-udc: ep15:pxa_ep_enable: type mismatch
>>
>> by this condition: 
>>
>> 	http://lxr.free-electrons.com/source/drivers/usb/gadget/udc/pxa27x_udc.c#L1416
>>
>> because ep_matches() returns BULK.
> 
> Okay, that's a problem in pxa27x-udc.  Why does it insist on an exact 
> match between the hardware endpoint type and the type contained in the 
> descriptor?  It should accept an interrupt descriptor if the hardware 
> type is bulk.

Hmm, making BULK EP equivalent with INT EP (when INT is requested) would made debugging (there is special bitfield in the config registers) and configuration preset (not anymore unordered set, but definition in the specific sequence) hell. But in other ways it can be OK (specification does not say that using EP marked INT as BULK will fail).

> 
>> g_serial later disables INT notification
>>
>> 	[ 4259.609871] g_serial gadget: acm ttyGS0 can't notify serial state, -22
>>
>> So this function is waiting regression, all it takes is just one
>> change into the PXA27x EP configuration or change of allocation order
>> for endpoints in a gadget. And it limits other existing gadget from
>> being supported too (PXA can have only 23 endpoints including
>> different altsetting/interface/cfg combinations).
>>
>> It could be easily fixed by gadget_is_pxa27x() function. 
> 
> Or one of the other techniques we have mentioned.  The inability to use 
> the same endpoint in more than one alternate setting is quite a nasty 
> limitation, however.

I think optimal idea is custom matcher function. It would eliminate codes for superspeed checking on SoC which known only fullspeed ;-).


P.S. I did a basic research where UDCs differ between BULK and INT handling (just searching for usb_endpoint_type(), USB_ENDPOINT_XFER_* and usb_endpoint_xfer_*() so it returned BULK on a software side - irrelevant):
	r8a66597-udc.c (using different constants, dedicated structure entries)
	m66592-udc.c (same as r8a66597-udc.c)
	dummy_hcd.c (well it is only dummy, says "bulk is OK" for INT, but has different matching rules for HS BULK and INT)
	atmel_usba_udc.c (only by write of some flag)
	net2272.c (fails with BULK, USB_SPEED_HIGH and maxpacket != 512)
	at91_udc.c (only BULK is only OK with 8,16,32,64 values)
	pxa25x_udc.c (setting one flag when hw (?) endpoint is BULK and another if nonBULK, INT FIFO size defined as 8, BULK FIFO as 64)
	net2280.c (INT path has erratum, different maxpacket matching)
	pxa27x_udc.h (INT_FIFO_SIZE defined as 16B, BULK_FIFO_SIZE defined as 64B)
	mv_udc_core.c (different codepath)
	gr_udc.c (using mode of endpoint to print messages and register setting)
	fsl_qe_udc.c (different maxpacket sizes for highspeed)
	udc-xilinx.c (maching of different maxpacket sizes)
	omap_udc.c (maxpacket size definitions)
	
> 
> Alan Stern
> 

Petr Cvek
