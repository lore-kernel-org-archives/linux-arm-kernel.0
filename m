From: arnd@linaro.org (Arnd Bergmann)
Date: Thu, 7 Feb 2013 19:41:22 +0000
Subject: [PATCH 04/10] USB: EHCI: make ehci-orion a separate driver
In-Reply-To: <5113e5f0.c84e420a.08c3.ffffbe9a@mx.google.com>
References: <yes> <1360258447-27247-1-git-send-email-yes>
 <5113e5f0.c84e420a.08c3.ffffbe9a@mx.google.com>
Message-ID: <201302071941.22422.arnd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 07 February 2013, manjunath.goudar at linaro.org wrote:
> @@ -155,7 +155,7 @@ static inline unsigned ehci_read_frame_index(struct ehci_hcd *ehci)
>   * before driver shutdown. But it also seems to be caused by bugs in cardbus
>   * bridge shutdown:  shutting down the bridge before the devices using it.
>   */
> -static int handshake (struct ehci_hcd *ehci, void __iomem *ptr,
> +int handshake(struct ehci_hcd *ehci, void __iomem *ptr,
>                       u32 mask, u32 done, int usec)
>  {
>         u32     result;

I had not noticed this before, but apparently it belongs into the
tegra patch that you dropped, rather than this patch.

Same thing for all the changes below.

> @@ -172,9 +172,9 @@ static int handshake (struct ehci_hcd *ehci, void __iomem *ptr,
>         } while (usec > 0);
>         return -ETIMEDOUT;
>  }
> -
> +EXPORT_SYMBOL_GPL(handshake);
>  /* check TDI/ARC silicon is in host mode */
> -static int tdi_in_host_mode (struct ehci_hcd *ehci)
> +static int tdi_in_host_mode(struct ehci_hcd *ehci)
>  {
>         u32             tmp;
>  
> @@ -186,7 +186,7 @@ static int tdi_in_host_mode (struct ehci_hcd *ehci)
>   * Force HC to halt state from unknown (EHCI spec section 2.3).
>   * Must be called with interrupts enabled and the lock not held.
>   */
> -static int ehci_halt (struct ehci_hcd *ehci)
> +int ehci_halt(struct ehci_hcd *ehci)
>  {
>         u32     temp;
>  
> @@ -215,9 +215,9 @@ static int ehci_halt (struct ehci_hcd *ehci)
>         return handshake(ehci, &ehci->regs->status,
>                           STS_HALT, STS_HALT, 16 * 125);
>  }
> -
> +EXPORT_SYMBOL_GPL(ehci_halt);
>  /* put TDI/ARC silicon into EHCI mode */
> -static void tdi_reset (struct ehci_hcd *ehci)
> +void tdi_reset(struct ehci_hcd *ehci)
>  {
>         u32             tmp;
>  
> @@ -231,12 +231,12 @@ static void tdi_reset (struct ehci_hcd *ehci)
>                 tmp |= USBMODE_BE;
>         ehci_writel(ehci, tmp, &ehci->regs->usbmode);
>  }
> -
> +EXPORT_SYMBOL_GPL(tdi_reset);
>  /*
>   * Reset a non-running (STS_HALT == 1) controller.
>   * Must be called with interrupts enabled and the lock not held.
>   */
> -static int ehci_reset (struct ehci_hcd *ehci)
> +int ehci_reset(struct ehci_hcd *ehci)
>  {
>         int     retval;
>         u32     command = ehci_readl(ehci, &ehci->regs->command);
> @@ -272,7 +272,7 @@ static int ehci_reset (struct ehci_hcd *ehci)
>                         ehci->resuming_ports = 0;
>         return retval;
>  }
> -
> +EXPORT_SYMBOL_GPL(ehci_reset);
>  /*
>   * Idle the controller (turn off the schedules).
>   * Must be called with interrupts enabled and the lock not held.
> @@ -352,7 +352,7 @@ static void ehci_silence_controller(struct ehci_hcd *ehci)
>   * This forcibly disables dma and IRQs, helping kexec and other cases
>   * where the next system software may expect clean state.
>   */
> -static void ehci_shutdown(struct usb_hcd *hcd)
> +void ehci_shutdown(struct usb_hcd *hcd)
>  {
>         struct ehci_hcd *ehci = hcd_to_ehci(hcd);
>  
> @@ -366,7 +366,7 @@ static void ehci_shutdown(struct usb_hcd *hcd)
>  
>         hrtimer_cancel(&ehci->hrtimer);
>  }
> -
> +EXPORT_SYMBOL_GPL(ehci_shutdown);

	Arnd
