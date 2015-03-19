From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 19 Mar 2015 10:27:18 -0400 (EDT)
Subject: [PATCH v2] usb: ehci-orion: add more constants for register values
In-Reply-To: <1426773667-29488-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <Pine.LNX.4.44L0.1503191023030.1135-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 19 Mar 2015, Thomas Petazzoni wrote:

> This commit adds new register values for the USB_CMD and USB_MODE
> registers, which allows to avoid the usage of a number of magic values
> in orion_usb_phy_v1_setup().
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

The new symbol values are fine.  But (side issue) ...

> @@ -69,8 +75,8 @@ static void orion_usb_phy_v1_setup(struct usb_hcd *hcd)
>  	/*
>  	 * Reset controller
>  	 */
> -	wrl(USB_CMD, rdl(USB_CMD) | 0x2);
> -	while (rdl(USB_CMD) & 0x2);
> +	wrl(USB_CMD, rdl(USB_CMD) | USB_CMD_RESET);
> +	while (rdl(USB_CMD) & USB_CMD_RESET);

For one thing, this use of whitespace does not make the syntax clear.  
At the very least, it should be written as:

	while (rdl(USB_CMD) & USB_CMD_RESET)
		;

so that the reader can see this is a loop with an empty body.  Right 
now it looks like an ordinary, non-looping statement.

For another, have you considered what will happen if the hardware is 
defective and never turns off the USB_CMD_RESET bit?  This sort of 
thing should always be implemented with some sort of timeout.

Alan Stern
