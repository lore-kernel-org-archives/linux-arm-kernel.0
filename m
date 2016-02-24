From: dianders@chromium.org (Doug Anderson)
Date: Tue, 23 Feb 2016 16:22:16 -0800
Subject: [PATCH RESEND 2/2] usb: dwc2: Move host-specific core functions
 into hcd.c
In-Reply-To: <8c76999579912385f7aa371960e5321864d5d86c.1456260533.git.johnyoun@synopsys.com>
References: <cover.1456260533.git.johnyoun@synopsys.com>
 <8c76999579912385f7aa371960e5321864d5d86c.1456260533.git.johnyoun@synopsys.com>
Message-ID: <CAD=FV=VXJdEH0+h2UWmh5++N9uax4NLujXStqS2fgWB-qw2UgA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

John,

On Tue, Feb 23, 2016 at 1:33 PM, John Youn <johnyoun@synopsys.com> wrote:

> +u32 dwc2_calc_frame_interval(struct dwc2_hsotg *hsotg)

You seem to have lost the function comments for
dwc2_calc_frame_interval().  Was that intentional?  If not, can you
add them back?


> +/**
> + * dwc2_hc_do_ping() - Starts a PING transfer
> + *
> + * @hsotg: Programming view of DWC_otg controller
> + * @chan:  Information needed to initialize the host channel
> + *
> + * This function should only be called in Slave mode. The Do Ping bit is set in
> + * the HCTSIZ register, then the channel is enabled.
> + */
> +void dwc2_hc_do_ping(struct dwc2_hsotg *hsotg, struct dwc2_host_chan *chan)

Presumably can be static?  ...and remove prototype from "core.h"?


> +/**
> + * dwc2_core_init() - Initializes the DWC_otg controller registers and
> + * prepares the core for device mode or host mode operation
> + *
> + * @hsotg:         Programming view of the DWC_otg controller
> + * @initial_setup: If true then this is the first init for this instance.
> + */
> +int dwc2_core_init(struct dwc2_hsotg *hsotg, bool initial_setup)

Presumably can be static?  ...and remove prototype from "core.h"?


> +/**
> + * dwc2_core_host_init() - Initializes the DWC_otg controller registers for
> + * Host mode
> + *
> + * @hsotg: Programming view of DWC_otg controller
> + *
> + * This function flushes the Tx and Rx FIFOs and flushes any entries in the
> + * request queues. Host channels are reset to ensure that they are ready for
> + * performing transfers.
> + */
> +void dwc2_core_host_init(struct dwc2_hsotg *hsotg)

Presumably can be static?  ...and remove prototype from "core.h"?


Other than those nits, things look good.  I didn't analyze exactly
where you placed all the functions but a quick glance shows that they
seem sanely organized.  :)

I picked these back to my chromeos-3.14 kernel (with many many dwc2
backports) and I confirmed that I can still compile the kernel, boot
it, and use USB.  I also confirmed no warnings were introduced for me.
I'm only testing HOST, not gadget mode.

Feel free to add my Reviewed-by and Tested-by once nits are fixed up.

-Doug
