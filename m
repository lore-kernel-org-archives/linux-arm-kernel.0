From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Wed, 20 Sep 2017 11:53:12 +0200
Subject: [PATCH v1] usb: host: Implement workaround for Erratum A-007463
In-Reply-To: <20170920092441.21292-1-yinbo.zhu@nxp.com>
References: <20170920092441.21292-1-yinbo.zhu@nxp.com>
Message-ID: <20170920095312.GB16198@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 20, 2017 at 05:24:41PM +0800, yinbo.zhu at nxp.com wrote:
> From: "yinbo.zhu" <yinbo.zhu@nxp.com>
> 
> When a transaction error (defined in Section 4.10.2.3, "USB
> Transaction Error" of the xHCI Specification) occurs on the
> USB, the host controller reports this through a transfer
> event with the completion code "USB Transaction Error". When
> this happens, the endpoint is placed in the Halted state.
> In response, software must issue a Reset Endpoint command to
> transition the endpoint to the Stopped state. In order to
> restart the transfer, the driver can perform either of the
> following:
> ? Ring the doorbell again, which restarts the transfer from
>   where it stopped, or
> ? Issue a Set TR (Transfer Ring) Dequeue Pointer command for
>   the endpoint to start the transfer from a different
>   Transfer Ring pointer Consider the following scenario:
> 1. The xHCI driver prepares a control transfer read to one
>    of the device's control endpoints;
> 2. During the IN data stage, a transaction error occurs on
>    the USB, causing a transfer event with the completion
>    code "USB Transaction Error";
> 3. The driver issues a Reset Endpoint command;
> 4. The driver rings the doorbell of the control endpoint to
>    resume the transfer. In this scenario, the controller
>    may reverse the direction of the data stage from IN to OUT.
>    Instead of sending an ACK to the endpoint to poll for read
>    data, it sends a Data Packet (DP) to the endpoint. It
>    fetches the data from the data stage Transfer Request Block
>    (TRB) that is being resumed, even though the data buffer is
>    setup to receive data and not transmit it.
> NOTE
> This issue occurs only if the transaction error happens during
> an IN data stage. There is no issue if the transaction error
> happens during an OUT data stage.
> 
> Impact: When this issue occurs, the device likely responds in
> one of the following ways:
> ? The device responds with a STALL because the data stage has
> unexpectedly changed directions. The controller then generates
> a Stall Error transfer event, to which software must issue a
> Reset Endpoint command followed by a Set TR Dequeue Pointer
> command pointing to a new Setup TRB to clear the STALL condition.
> ? The device does not respond to the inverted data stage and the
> transaction times out. The controller generates another USB
> Transaction Error transfer event, to which software likely
> performs a USB Reset to the device because it is unresponsive.
> It is not expected that any of these recovery steps will cause
> instability in the system because this recovery is part of a
> standard xHCI driver and could happen regardless of the defect.
> Another possible system-level impact is that the controller
> attempts to read from the memory location pointed at by the Data
> Stage TRB or a Normal TRB chained to it. associated with this
> TRB is intended to be written by the controller, but the
> controller reads from it instead. Normally, this does not cause
> a problem. However, if the system has some type of memory
> protection where this unexpected read is treated as a bus error,
> it may cause the system to become unstable or to crash.
> 
> Workaround: If a USB Transaction Error occurs during the IN
> data phase of a control transfer, the driver must use the
> Set TR Dequeue Pointer command to either restart the data
> phase or restart the entire control transfer from the
> Setup phase.
> 
> Configs Affected:
> LS1021-20-22A-R1.0, LS1021-20-22A-R2.007463

What does this reference?

Same for the subject: line, I don't know what that means.

> Signed-off-by: yinbo.zhu <yinbo.zhu@nxp.com>
> ---
>  arch/arm/boot/dts/ls1021a.dtsi |  1 +
>  drivers/usb/dwc3/core.c        |  2 ++
>  drivers/usb/dwc3/core.h        |  2 ++
>  drivers/usb/dwc3/host.c        |  2 ++
>  drivers/usb/host/xhci-plat.c   |  3 +++
>  drivers/usb/host/xhci-ring.c   | 28 +++++++++++++++++++++++-----
>  drivers/usb/host/xhci.h        |  3 ++-
>  7 files changed, 35 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
> index 7bb9df2c1460..9f76b2b82dce 100644
> --- a/arch/arm/boot/dts/ls1021a.dtsi
> +++ b/arch/arm/boot/dts/ls1021a.dtsi
> @@ -683,6 +683,7 @@
>  			dr_mode = "host";
>  			snps,quirk-frame-length-adjustment = <0x20>;
>  			snps,dis_rxdet_inp3_quirk;
> +			snps,quirk_reverse_in_out;

Doesn't that value have to be added to some other DT documentation file?

> -		/* Issue a reset endpoint command to clear the host side
> -		 * halt, followed by a set dequeue command to move the
> -		 * dequeue pointer past the TD.
> -		 * The class driver clears the device side halt later.
> +		/*
> +		 * A-007463: After transaction error, controller switches
> +		 * control transfer data stage from IN to OUT direction.
>  		 */

What does A-007463 refer to?

> --- a/drivers/usb/host/xhci.h
> +++ b/drivers/usb/host/xhci.h
> @@ -1780,7 +1780,7 @@ struct xhci_hcd {
>  #define XHCI_STATE_DYING	(1 << 0)
>  #define XHCI_STATE_HALTED	(1 << 1)
>  #define XHCI_STATE_REMOVING	(1 << 2)
> -	unsigned int		quirks;
> +	u64            quirks;

Why change this to a u64?

thanks,

greg k-h
