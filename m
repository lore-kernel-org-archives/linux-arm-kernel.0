From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Thu, 8 Mar 2012 14:22:34 -0800
Subject: [PATCH v4] USB: Support for LPC32xx SoC
In-Reply-To: <1331244574-32570-1-git-send-email-stigge@antcom.de>
References: <1331244574-32570-1-git-send-email-stigge@antcom.de>
Message-ID: <20120308222234.GA25576@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 08, 2012 at 11:09:34PM +0100, Roland Stigge wrote:
> This patch adds OHCI support to the LPC32xx ARM platform
> 
> Signed-off-by: Roland Stigge <stigge@antcom.de>
> 
> ---
>  Applies to v3.3-rc6
> 
>  Since v3, only the machine_is_*() dependencies have been pulled into
>  the machine dependent functions.

Better, but:

>  static void pnx4008_unset_usb_bits(void)
>  {
> -	start_int_mask(SE_USB_OTG_ATX_INT_N);
> -	start_int_mask(SE_USB_OTG_TIMER_INT);
> -	start_int_mask(SE_USB_I2C_INT);
> -	start_int_mask(SE_USB_INT);
> -	start_int_mask(SE_USB_NEED_CLK_INT);
> -	start_int_mask(SE_USB_AHB_NEED_CLK_INT);
> +	if (machine_is_pnx4008()) {

The function is called "pnx4008...", so why would any code path that is
not this hardware call this?

I think there's a disconnect between what you think a pnx4008 machine
is, and what I think it is, or what this code is running on and thinks
it is.

So, should this function just be called something else, for the type of
hardware (lpc32xx?), and then do this check within the function?

Again, consistancy is key.  Note how not all of the pnc4008_*()
functions make this check, which implies that something is not
consistant here...

thanks,

greg k-h
