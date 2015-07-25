From: petr.cvek@tul.cz (Petr Cvek)
Date: Sat, 25 Jul 2015 07:34:01 +0200
Subject: [PATCH v3 42/46] usb: gadget: move ep_matches() from epautoconf
 to udc-core
In-Reply-To: <Pine.LNX.4.44L0.1507231542520.25082-100000@netrider.rowland.org>
References: <Pine.LNX.4.44L0.1507231542520.25082-100000@netrider.rowland.org>
Message-ID: <55B31FC9.1000407@tul.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23.7.2015 21:46, Alan Stern wrote:
> On Thu, 23 Jul 2015, Petr Cvek wrote:
> 
>> Hello,
>>
>> Is this:
>>
>> 	case USB_ENDPOINT_XFER_INT:
>> 		/* Bulk endpoints handle interrupt transfers,
>> 		 * except the toggle-quirky iso-synch kind
>> 		 */
>> 		if (!ep->caps.type_int && !ep->caps.type_bulk)
>> 			return 0;
>>
>> ... or original:
>>
>> 			switch (type) {
>> 			case USB_ENDPOINT_XFER_INT:
>> 				/* bulk endpoints handle interrupt transfers,
>> 				 * except the toggle-quirky iso-synch kind
>> 				 */
>> 				if ('s' == tmp[2])	{// == "-iso"
>> 					return 0;
>>
>> code still valid? 
> 
> It's hard to understand your question.  Are you asking whether this 
> code is still present in the current version of the kernel?  You can 
> find out for yourself easily enough.

I'm asking if there are still UDCs which require this quirk. If not, we should change it to:

	if ('n' != tmp[2])	{// != "-int"

so it will only return INT endpoints. Or if there are one or two which does not support interrupt endpoints, it would be (in my opinion) more practical to make a special case for them than force all other UDCs to use a BULK endpoint when they have an INT endpoint.

> 
>> It seems that it allows using a BULK endpoint for requested INT
>> endpoint. For my PXA27x machine the original code returns BULK EP
>> even with valid INT endpoint definition (because BULK EPs are defined
>> earlier than INT EPs).
> 
> Yes, it does allow a bulk endpoint to be used when an interrupt 
> endpoint was requested.  However, it won't return a bulk endpoint if 
> all the bulk endpoints are already in use.

A default PXA27x configuration returns BULK for requested INT. Which is unfortunate, because PXA27x supports INT endpoints and has one predefined, but this function find BULK first (one BULK is allocated and INT is never used).

> 
>> This part of the code is from pre git era
>>
>> 	1da177e4c3f41524e886b7f1b8a0c1fc7321cac2
>>
>> before pxa27x driver was written and only few chips was supported.
>> Does anyone know if the INT endpoints works now?
> 
> What makes you think they might not work?

Because if they do, the ep_matches() function works poorly. It returns a BULK for device (gadget) side, but host side (PC) thinks that this endpoint is an INT and handles it in this way. But the PXA27x thinks the endpoint is a BULK and handles it in its way (according to datasheet, settings for a BULK and an INT transfers are not 100% compatible).

I cannot test "INT as BULK" behavior for the gadget functions, because all gadgets which works on PXA27x does not use INT endpoints (some allocate the endpoint but never use it).

> 
> Alan Stern
> 

Petr Cvek
