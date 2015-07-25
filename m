From: petr.cvek@tul.cz (Petr Cvek)
Date: Sat, 25 Jul 2015 07:29:54 +0200
Subject: [PATCH v3 42/46] usb: gadget: move ep_matches() from epautoconf
 to udc-core
In-Reply-To: <20150723143635.GB21984@saruman.tx.rr.com>
References: <55B07048.3000609@tul.cz>
 <20150723143635.GB21984@saruman.tx.rr.com>
Message-ID: <55B31ED2.6020106@tul.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23.7.2015 16:36, Felipe Balbi wrote:
> Hi,
> 
> On Thu, Jul 23, 2015 at 06:40:40AM +0200, Petr Cvek wrote:
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
>>
>> It seems that it allows using a BULK endpoint for requested INT
>> endpoint. For my PXA27x machine the original code returns BULK EP even
>> with valid INT endpoint definition (because BULK EPs are defined
>> earlier than INT EPs).
>>
>> This part of the code is from pre git era
>>
>> 	1da177e4c3f41524e886b7f1b8a0c1fc7321cac2
>>
>> before pxa27x driver was written and only few chips was supported.
>> Does anyone know if the INT endpoints works now?
> 
> it's very difficult to read your reply when you remove all context.
> 

Ah sorry, I was hacking around PXA UDC and found possible bug in one ep_matches() function:

	http://lxr.free-electrons.com/source/drivers/usb/gadget/epautoconf.c#L75

when searching for origin of this bug I have found about this new patch series (someone could know how that part of code was created).

Petr Cvek
