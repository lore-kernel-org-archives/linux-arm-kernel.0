From: andy.gross@linaro.org (Andy Gross)
Date: Thu, 19 May 2016 16:20:50 -0500
Subject: [PATCH] usb: echi-hcd: Add ehci_setup check before echi_shutdown
In-Reply-To: <1463652776-30456-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1463652776-30456-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <CAPBZ5QcMiMEv1n=WU6aW2PGNsSPZJR42iZge_VUX4aWZ-KKzbw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 May 2016 at 05:12, Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:

<snip>

> +++ b/drivers/usb/host/ehci-hcd.c
> @@ -368,6 +368,15 @@ static void ehci_shutdown(struct usb_hcd *hcd)
>  {
>         struct ehci_hcd *ehci = hcd_to_ehci(hcd);
>
> +       /**
> +        * Protect the system from crashing at system shutdown in cases where
> +        * usb host is not added yet from OTG controller driver.
> +        * As ehci_setup() not done yet, so stop accessing registers or
> +        * variables initialized in ehci_setup()
> +        */
> +       if (!ehci->sbrn)
> +               return;
> +
>         spin_lock_irq(&ehci->lock);
>         ehci->shutdown = true;
>         ehci->rh_state = EHCI_RH_STOPPING;


Should we also not check this in ehci_suspend and ehci_resume?  If I
do suspend/resume, it crashes in a similar manner.  I know this goes
beyond the problem scope of the patch.  Perhaps I should send in an
additional patch with the code?

Are there any other places in the ehci-hcd where this needs to be checked?

Regards,

Andy
