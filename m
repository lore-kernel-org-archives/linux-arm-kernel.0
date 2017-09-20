From: mathias.nyman@linux.intel.com (Mathias Nyman)
Date: Wed, 20 Sep 2017 15:57:21 +0300
Subject: [PATCH v1] usb: host: Implement workaround for Erratum A-007463
In-Reply-To: <20170920092441.21292-1-yinbo.zhu@nxp.com>
References: <20170920092441.21292-1-yinbo.zhu@nxp.com>
Message-ID: <59C265B1.6020909@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20.09.2017 12:24, yinbo.zhu at nxp.com wrote:
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
>    where it stopped, or
> ? Issue a Set TR (Transfer Ring) Dequeue Pointer command for
>    the endpoint to start the transfer from a different
>    Transfer Ring pointer Consider the following scenario:
> 1. The xHCI driver prepares a control transfer read to one
>     of the device's control endpoints;
> 2. During the IN data stage, a transaction error occurs on
>     the USB, causing a transfer event with the completion
>     code "USB Transaction Error";
> 3. The driver issues a Reset Endpoint command;
> 4. The driver rings the doorbell of the control endpoint to
>     resume the transfer. In this scenario, the controller
>     may reverse the direction of the data stage from IN to OUT.
>     Instead of sending an ACK to the endpoint to poll for read
>     data, it sends a Data Packet (DP) to the endpoint. It
>     fetches the data from the data stage Transfer Request Block
>     (TRB) that is being resumed, even though the data buffer is
>     setup to receive data and not transmit it.

Sound very odd,
Can you check the xhci side if the data stage TRB in the control
endpoint ring still looks valid after endpoint reset?
That is, make sure that the data stage TRB still has DIR bit 16 set.

If something zeroed that TRB then the DIR bit it would be set to 0
which means DIR OUT.
Reset endpoint command forces xHC hardware to re-read the TRB from
memory  (i.e. the endpoint ring).
zeroing the trb could happen for example if the TRB gets turned
into a no-op.

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


This is already the intended workflow.
We should already queue a new Set TR Dequeue pointer if
we receive a transaction error on the TD the xHC is processing.
the whole control transfer (SETUP, DATA and STATUS) is one TD.

code flow when we receive a TRANSACTION_ERROR in finish_td:

xhci_requires_manual_halt_endpoint() // true due to transaction error
   xhci_cleanup_halted_endpoint(EP_HARD_RESET);
     ep->ep_state |= EP_HALTED;
     xhci_queue_reset_ep();
     xhci_cleanup_stalled_ring();
       xhci_find_new_dequeue_state()
       xhci_queue_new_dequeue_state()

what your code does different is that it skips the reset endpoint command.

It's also possible this is toggle/sequence number issue,
you could try issuing a EP_SOFT_RESET endpoint reset instead.

-Mathias
