From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 03 Sep 2014 10:17:27 -0600
Subject: [PATCH v3 6/9] usb: xhci: Add NVIDIA Tegra xHCI host-controller
 driver
In-Reply-To: <1409693701-16520-7-git-send-email-abrestic@chromium.org>
References: <1409693701-16520-1-git-send-email-abrestic@chromium.org>
 <1409693701-16520-7-git-send-email-abrestic@chromium.org>
Message-ID: <54073F17.2050507@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/02/2014 03:34 PM, Andrew Bresticker wrote:
> Add support for the on-chip xHCI host controller present on Tegra SoCs.
>
> The driver is currently very basic: it loads the controller with its
> firmware, starts the controller, and is able to service messages sent
> by the controller's firmware.  The hardware also supports device mode
> as well as powergating of the SuperSpeed and host-controller logic
> when not in use, but support for these is not yet implemented.

> diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c

> +static bool is_host_mbox_message(u32 cmd)
> +{
> +	switch (cmd) {
> +	case MBOX_CMD_INC_SSPI_CLOCK:
> +	case MBOX_CMD_DEC_SSPI_CLOCK:
> +	case MBOX_CMD_INC_FALC_CLOCK:
> +	case MBOX_CMD_DEC_FALC_CLOCK:
> +		return true;
> +	case MBOX_CMD_SET_BW:
> +		/*
> +		 * TODO: Request bandwidth once EMC scaling is supported.
> +		 * Ignore for now since ACK/NAK is not required for SET_BW
> +		 * messages.
> +		 */

I think that TODO belongs inside tegra_xhci_mbox_work() where the 
message would actually be handled, if implemented.
