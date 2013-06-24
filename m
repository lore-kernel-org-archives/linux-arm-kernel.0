From: ming.lei@canonical.com (Ming Lei)
Date: Mon, 24 Jun 2013 19:49:42 +0800
Subject: [PATCH v2 1/4] USB: HCD: support giveback of URB in tasklet
 context
In-Reply-To: <1372066925-23579-2-git-send-email-ming.lei@canonical.com>
References: <1372066925-23579-1-git-send-email-ming.lei@canonical.com>
 <1372066925-23579-2-git-send-email-ming.lei@canonical.com>
Message-ID: <CACVXFVO9z7pqxgVbrz-gwWQ9LaiMrRWHKo4LD=b-u66Kx8DUtA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 24, 2013 at 5:42 PM, Ming Lei <ming.lei@canonical.com> wrote:
> +
> +static void init_giveback_urb_bh(struct usb_hcd *hcd)
> +{
> +       if (!hcd_giveback_urb_in_bh(hcd))
> +               return;

Sorry, the above check isn't needed, and the below check isn't
needed too. I will fix it in V3.

> +
> +       __init_giveback_urb_bh(&hcd->high_prio_bh);
> +       __init_giveback_urb_bh(&hcd->low_prio_bh);
> +}
> +
> +static void exit_giveback_urb_bh(struct usb_hcd *hcd)
> +{
> +       if (!hcd_giveback_urb_in_bh(hcd))
> +               return;
> +
> +       /*
> +        * tasklet_kill() isn't needed here because:
> +        * - driver's disconnec() called from usb_disconnect() should
> +        *   make sure its URBs are completed during the disconnect()
> +        *   callback
> +        *
> +        * - it is too late to run complete() here since driver may have
> +        *   been removed already now
> +        *
> +        * Using tasklet to run URB's complete() doesn't change this
> +        * behavior of usbcore.
> +        */
> +}
> +


Thanks,
--
Ming Lei
