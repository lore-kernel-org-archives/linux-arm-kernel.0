From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Wed, 06 Jun 2012 12:39:55 +0300
Subject: [PATCH v4] usb: ehci-hcd: notify phy when connect change
In-Reply-To: <1338946190-19105-1-git-send-email-richard.zhao@freescale.com>
References: <1337912665-16615-4-git-send-email-richard.zhao@freescale.com>
 <1338946190-19105-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <87mx4g93tg.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Richard Zhao <richard.zhao@freescale.com> writes:

> It still has below limitations:
> - it does not work for multi-phy ehci
> - the best place is after debounce, but I can't get
>   phy there
>
> Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> ---
>  drivers/usb/host/ehci-hcd.c |   15 +++++++++++++++
>  1 files changed, 15 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
> index b100f5f..724ac471 100644
> --- a/drivers/usb/host/ehci-hcd.c
> +++ b/drivers/usb/host/ehci-hcd.c
> @@ -928,6 +928,21 @@ static irqreturn_t ehci_irq (struct usb_hcd *hcd)
>  			pstatus = ehci_readl(ehci,
>  					 &ehci->regs->port_status[i]);
>  
> +			/* FIXME:
> +			 * - it does not work for multi-phy ehci
> +			 * - the best place is after debounce, but I can't get
> +			 *   phy there
> +			 */
> +			if (unlikely(ehci->transceiver &&
> +					(pstatus & PORT_CSC))) {

I don't think you need parens around (pstatus & PORT_CSC), since it
should already have higher precedence.

> +				if (pstatus & PORT_CONNECT)
> +					usb_phy_notify_connect(
> +						ehci->transceiver, i);
> +				else
> +					usb_phy_notify_disconnect(
> +						ehci->transceiver, i);
> +			}
> +
>  			if (pstatus & PORT_OWNER)
>  				continue;
>  			if (!(test_bit(i, &ehci->suspended_ports) &&
> -- 
> 1.7.5.4
