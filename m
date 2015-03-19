From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 19 Mar 2015 15:45:40 +0100
Subject: [PATCH v2] usb: ehci-orion: add more constants for register values
In-Reply-To: <Pine.LNX.4.44L0.1503191023030.1135-100000@iolanthe.rowland.org>
References: <1426773667-29488-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <Pine.LNX.4.44L0.1503191023030.1135-100000@iolanthe.rowland.org>
Message-ID: <20150319154540.786e6b4e@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Alan Stern,

On Thu, 19 Mar 2015 10:27:18 -0400 (EDT), Alan Stern wrote:

> > @@ -69,8 +75,8 @@ static void orion_usb_phy_v1_setup(struct usb_hcd *hcd)
> >  	/*
> >  	 * Reset controller
> >  	 */
> > -	wrl(USB_CMD, rdl(USB_CMD) | 0x2);
> > -	while (rdl(USB_CMD) & 0x2);
> > +	wrl(USB_CMD, rdl(USB_CMD) | USB_CMD_RESET);
> > +	while (rdl(USB_CMD) & USB_CMD_RESET);
> 
> For one thing, this use of whitespace does not make the syntax clear.  
> At the very least, it should be written as:
> 
> 	while (rdl(USB_CMD) & USB_CMD_RESET)
> 		;
> 
> so that the reader can see this is a loop with an empty body.  Right 
> now it looks like an ordinary, non-looping statement.
> 
> For another, have you considered what will happen if the hardware is 
> defective and never turns off the USB_CMD_RESET bit?  This sort of 
> thing should always be implemented with some sort of timeout.

These are indeed all valid concerns. However, as you can see, those
concerns are completely orthogonal to the patch: the original code
already has those issues.

Regarding the addition of a timeout, I unfortunately have absolutely no
idea what would be the a proper timeout value at this place. I quickly
glanced through
http://www.intel.com/content/dam/www/public/us/en/documents/technical-specifications/ehci-specification-for-usb.pdf
for the documentation of this reset bit, but couldn't spot a maximum
accepted duration for the operation.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
