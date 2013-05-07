From: stern@rowland.harvard.edu (Alan Stern)
Date: Tue, 7 May 2013 11:15:34 -0400 (EDT)
Subject: [RFC PATCH 1/2] USB: OHCI: prepare to make ohci-hcd a library
 module
In-Reply-To: <1367920253-15207-2-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <Pine.LNX.4.44L0.1305071039560.1165-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 7 May 2013, Manjunath Goudar wrote:

> This patch prepares ohci-hcd for being split up into a core
> library and separate platform driver modules.  A generic
> ohci_hc_driver structure is created, containing all the "standard"
> values, and a new mechanism is added whereby a driver module can
> specify a set of overrides to those values.  In addition the
> ohci_restart(),ohci_suspend() and ohci_resume() routines need
> to be EXPORTed for use by the drivers.

This patch still has several problems.  For example, the description
doesn't mention the fact that ohci_init() was EXPORTed.

In fact, why was ohci_init() EXPORTed?  I don't see any reason for
this.  ohci_pci.c doesn't need to call it; just insert a call to
ohci_init() at the beginning of ohci_restart().

> In V2:
> -ohci_hcd_init(), ohci_run() and ohci_stop revert back to static routine.

They don't "revert" since they have never been non-static.  You should
say something more like "ohci_hcd_init(), ohci_run(), and ohci_stop()
are not made non-static."

> -ohci_setup() and ohci_start() functions written to generic OHCI initialization
>  for all ohci bus glue.

Fix the grammar in that sentence.  And you should mention these new
functions in the main part of the patch description, not just down here.

> diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
> index 58c14c1..a38d76b 100644
> --- a/drivers/usb/host/Makefile
> +++ b/drivers/usb/host/Makefile
> @@ -40,7 +40,9 @@ obj-$(CONFIG_USB_EHCI_TEGRA)    +=ehci-tegra.o
>  obj-$(CONFIG_USB_OXU210HP_HCD)	+= oxu210hp-hcd.o
>  obj-$(CONFIG_USB_ISP116X_HCD)	+= isp116x-hcd.o
>  obj-$(CONFIG_USB_ISP1362_HCD)	+= isp1362-hcd.o
> +
>  obj-$(CONFIG_USB_OHCI_HCD)	+= ohci-hcd.o
> +

You do not need to add these blank lines in this patch.  If you want,
you can add them in the ohci-pci patch.

>  obj-$(CONFIG_USB_UHCI_HCD)	+= uhci-hcd.o
>  obj-$(CONFIG_USB_FHCI_HCD)	+= fhci.o
>  obj-$(CONFIG_USB_XHCI_HCD)	+= xhci-hcd.o
> diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
> index 9e6de95..7922c61 100644
> --- a/drivers/usb/host/ohci-hcd.c
> +++ b/drivers/usb/host/ohci-hcd.c
> @@ -79,13 +79,7 @@ static const char	hcd_name [] = "ohci_hcd";
>  #include "pci-quirks.h"
>  
>  static void ohci_dump (struct ohci_hcd *ohci, int verbose);
> -static int ohci_init (struct ohci_hcd *ohci);
> -static void ohci_stop (struct usb_hcd *hcd);

I thought ohci_stop() wasn't going to be changed in this patch.  Why
was this line updated?

> -
> -#if defined(CONFIG_PM) || defined(CONFIG_PCI)
> -static int ohci_restart (struct ohci_hcd *ohci);
> -#endif
> -
> +static void ohci_stop(struct usb_hcd *hcd);
>  #ifdef CONFIG_PCI
>  static void sb800_prefetch(struct ohci_hcd *ohci, int on);
>  #else
> @@ -520,7 +514,7 @@ done:
>  
>  /* init memory, and kick BIOS/SMM off */
>  
> -static int ohci_init (struct ohci_hcd *ohci)
> +int ohci_init(struct ohci_hcd *ohci)
>  {
>  	int ret;
>  	struct usb_hcd *hcd = ohci_to_hcd(ohci);
> @@ -590,6 +584,7 @@ static int ohci_init (struct ohci_hcd *ohci)
>  
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(ohci_init);
>  
>  /*-------------------------------------------------------------------------*/
>  
> @@ -597,11 +592,11 @@ static int ohci_init (struct ohci_hcd *ohci)
>   * resets USB and controller
>   * enable interrupts
>   */
> -static int ohci_run (struct ohci_hcd *ohci)
> +static int ohci_run(struct usb_hcd *hcd)

Why did you change the signature of this function?  By doing so, you
just broke all the bus glue files.  (Except for ohci_pci and
ohci_platform, which explicitly get fixed below.)

Since this function remains static, there's no reason to change it.

>  {
> +	struct ohci_hcd		*ohci = hcd_to_ohci(hcd);
>  	u32			mask, val;
>  	int			first = ohci->fminterval == 0;
> -	struct usb_hcd		*hcd = ohci_to_hcd(ohci);
>  
>  	ohci->rh_state = OHCI_RH_HALTED;
>  
> @@ -767,7 +762,37 @@ retry:
>  
>  	return 0;
>  }
> +/*------------------------------------------------------------------------*/
> +
> +/* ohci generic function for all OHCI bus glue */
> +
> +static int ohci_setup(struct usb_hcd *hcd)
> +{
> +	struct ohci_hcd *ohci = hcd_to_ohci(hcd);
> +	int retval;
> +
> +	ohci->sbrn = HCD_USB11;

What is this doing here?  Why did you add this "sbrn" member to struct
ohci_hcd?

> +
> +	/* data structure init */
> +	retval = ohci_init(ohci);
> +	if (retval)
> +		return retval;
> +	ohci_usb_reset(ohci);

Why is this call here?  Doesn't ohci_init() already call
ohci_usb_reset()?

> +	return 0;
> +}
>  
> +static int ohci_start(struct usb_hcd *hcd)
> +{
> +	struct ohci_hcd *ohci = hcd_to_ohci(hcd);
> +	int	ret;

There should be a blank line between the declarations and the
executable statements.

> +	ret = ohci_run(hcd);
> +	if (ret < 0) {
> +		ohci_err(ohci, "can't start\n");
> +		ohci_stop(hcd);
> +	}
> +	return ret;
> +}
> +/*-------------------------------------------------------------------------*/
>  /*-------------------------------------------------------------------------*/

You should not duplicate this comment line.


> diff --git a/drivers/usb/host/ohci-pci.c b/drivers/usb/host/ohci-pci.c
> index 951514e..0b34b59 100644
> --- a/drivers/usb/host/ohci-pci.c
> +++ b/drivers/usb/host/ohci-pci.c
> @@ -288,7 +288,7 @@ static int ohci_pci_start (struct usb_hcd *hcd)
>  	}
>  #endif /* CONFIG_PM */
>  
> -	ret = ohci_run (ohci);
> +	ret = ohci_run(hcd);

If you hadn't changed ohci_run(), this wouldn't be needed.

>  	if (ret < 0) {
>  		ohci_err (ohci, "can't start\n");
>  		ohci_stop (hcd);
> diff --git a/drivers/usb/host/ohci-platform.c b/drivers/usb/host/ohci-platform.c
> index c3e7287..545c657 100644
> --- a/drivers/usb/host/ohci-platform.c
> +++ b/drivers/usb/host/ohci-platform.c
> @@ -46,7 +46,7 @@ static int ohci_platform_start(struct usb_hcd *hcd)
>  	struct ohci_hcd *ohci = hcd_to_ohci(hcd);
>  	int err;
>  
> -	err = ohci_run(ohci);
> +	err = ohci_run(hcd);

Likewise here.

>  	if (err < 0) {
>  		ohci_err(ohci, "can't start\n");
>  		ohci_stop(hcd);
> diff --git a/drivers/usb/host/ohci.h b/drivers/usb/host/ohci.h
> index d329914..455e9b1 100644
> --- a/drivers/usb/host/ohci.h
> +++ b/drivers/usb/host/ohci.h
> @@ -357,7 +357,6 @@ struct ohci_hcd {
>  	 * I/O memory used to communicate with the HC (dma-consistent)
>  	 */
>  	struct ohci_regs __iomem *regs;
> -

You shouldn't make unrelated changes, like removing this blank line or 
the one below.

>  	/*
>  	 * main memory used to communicate with the HC (dma-consistent).
>  	 * hcd adds to schedule for a live hc any time, but removals finish
> @@ -373,7 +372,6 @@ struct ohci_hcd {
>  	struct ed		*periodic [NUM_INTS];	/* shadow int_table */
>  
>  	void (*start_hnp)(struct ohci_hcd *ohci);
> -
>  	/*
>  	 * memory management for queue data structures
>  	 */
> @@ -392,7 +390,7 @@ struct ohci_hcd {
>  	unsigned long		next_statechange;	/* suspend/resume */
>  	u32			fminterval;		/* saved register */
>  	unsigned		autostop:1;	/* rh auto stopping/stopped */
> -
> +	u8			sbrn;
>  	unsigned long		flags;		/* for HC bugs */
>  #define	OHCI_QUIRK_AMD756	0x01			/* erratum #4 */
>  #define	OHCI_QUIRK_SUPERIO	0x02			/* natsemi */
> @@ -718,3 +716,29 @@ static inline u32 roothub_status (struct ohci_hcd *hc)
>  	{ return ohci_readl (hc, &hc->regs->roothub.status); }
>  static inline u32 roothub_portstatus (struct ohci_hcd *hc, int i)
>  	{ return read_roothub (hc, portstatus [i], 0xffe0fce0); }
> +
> +/* Declarations of things exported for use by ohci platform drivers */
> +
> +struct ohci_driver_overrides {
> +	const char	*product_desc;
> +	size_t		extra_priv_size;
> +	int		(*reset)(struct usb_hcd *hcd);
> +};
> +
> +extern void	ohci_init_driver(struct hc_driver *drv,
> +				const struct ohci_driver_overrides *over);
> +extern int	ohci_init(struct ohci_hcd *ohci);
> +extern int	ohci_restart(struct ohci_hcd *ohci);
> +#ifdef CONFIG_PM
> +extern int	ohci_suspend(struct usb_hcd *hcd, bool do_wakeup);
> +extern int	ohci_resume(struct usb_hcd *hcd, bool hibernated);
> +#else
> +static inline int ohci_suspend(struct usb_hcd *hcd, bool do_wakeup)
> +{
> +	return 0;
> +}
> +static inline int ohci_resume(struct usb_hcd *hcd, bool hibernated)
> +{
> +	return 0;
> +}
> +#endif

The #else part of this isn't needed, and I doubt very much that it
would work correctly if it was needed.

Alan Stern
