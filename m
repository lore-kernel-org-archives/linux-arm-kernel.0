From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Thu, 26 Mar 2015 22:27:27 +0100
Subject: [PATCH v2 1/2] serial/amba-pl011: Activate TX IRQ passively
In-Reply-To: <1426262182-2298-2-git-send-email-Dave.Martin@arm.com>
References: <1426262182-2298-1-git-send-email-Dave.Martin@arm.com>
 <1426262182-2298-2-git-send-email-Dave.Martin@arm.com>
Message-ID: <20150326212727.GA21598@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 13, 2015 at 03:56:21PM +0000, Dave Martin wrote:
> The current PL011 driver transmits a dummy character when the UART
> is opened, to assert the TX IRQ for the first time
> (see pl011_startup()).  The UART is put in loopback mode temporarily,
> so the receiver presumably shouldn't see anything.
> 
> However...
> 
> At least some platforms containing a PL011 send characters down the
> wire even when loopback mode is enabled.  This means that a
> spurious NUL character may be seen at the receiver when the PL011 is
> opened through the TTY layer.
> 
> The current code also temporarily sets the baud rate to maximum and
> the character width to the minimum, to that the dummy TX completes
> as quickly as possible.  If this is seen by the receiver it will
> result in a framing error and can knock the receiver out of sync --
> turning subsequent output into garbage until synchronisation
> is reestablished.  (Particularly problematic during boot with systemd.)
> 
> To avoid spurious transmissions, this patch removes assumptions about
> whether the TX IRQ will fire until at least one TX IRQ has been seen.
> 
> Instead, the UART will unmask the TX IRQ and then slow-start via
> polling and timer-based soft IRQs initially.  If the TTY layer writes
> enough data to fill the FIFO to the interrupt threshold in one go,
> the TX IRQ should assert, at which point the driver changes to
> fully interrupt-driven TX.
> 
> This should also mean that the driver works on the SBSA Generic
> UART[1] (a cut-down PL011) without invasive changes.  The Generic
> UART lacks some features needed for the dummy TX approach to work
> (FIFO disabling and loopback).
> 
> [1] Server Base System Architecture (ARM-DEN-0029-v2.3)
>     http://infocenter.arm.com/
>     (click-thru required :/)
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> ---
>  drivers/tty/serial/amba-pl011.c |  121 +++++++++++++++++++++++++--------------
>  1 file changed, 78 insertions(+), 43 deletions(-)

Wait, I already took this patch, right?

Was there some difference here with this version?

confused,

greg k-h
