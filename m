From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 23 Jul 2015 15:46:50 -0400 (EDT)
Subject: [PATCH v3 42/46] usb: gadget: move ep_matches() from epautoconf
 to udc-core
In-Reply-To: <55B07048.3000609@tul.cz>
Message-ID: <Pine.LNX.4.44L0.1507231542520.25082-100000@netrider.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 23 Jul 2015, Petr Cvek wrote:

> Hello,
> 
> Is this:
> 
> 	case USB_ENDPOINT_XFER_INT:
> 		/* Bulk endpoints handle interrupt transfers,
> 		 * except the toggle-quirky iso-synch kind
> 		 */
> 		if (!ep->caps.type_int && !ep->caps.type_bulk)
> 			return 0;
> 
> ... or original:
> 
> 			switch (type) {
> 			case USB_ENDPOINT_XFER_INT:
> 				/* bulk endpoints handle interrupt transfers,
> 				 * except the toggle-quirky iso-synch kind
> 				 */
> 				if ('s' == tmp[2])	{// == "-iso"
> 					return 0;
> 
> code still valid? 

It's hard to understand your question.  Are you asking whether this 
code is still present in the current version of the kernel?  You can 
find out for yourself easily enough.

> It seems that it allows using a BULK endpoint for requested INT
> endpoint. For my PXA27x machine the original code returns BULK EP
> even with valid INT endpoint definition (because BULK EPs are defined
> earlier than INT EPs).

Yes, it does allow a bulk endpoint to be used when an interrupt 
endpoint was requested.  However, it won't return a bulk endpoint if 
all the bulk endpoints are already in use.

> This part of the code is from pre git era
> 
> 	1da177e4c3f41524e886b7f1b8a0c1fc7321cac2
> 
> before pxa27x driver was written and only few chips was supported.
> Does anyone know if the INT endpoints works now?

What makes you think they might not work?

Alan Stern
