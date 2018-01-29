From: xuwei5@hisilicon.com (Wei Xu)
Date: Mon, 29 Jan 2018 17:50:19 +0000
Subject: [RFC PATCH] tty: pl011: Avoid stuck-off spurious interrupts
In-Reply-To: <1517242181-20652-1-git-send-email-Dave.Martin@arm.com>
References: <1517242181-20652-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <5A6F5EDB.20405@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dave,

On 2018/1/29 16:09, Dave Martin wrote:
> Commit 9b96fbacda34 ("serial: PL011: clear pending interrupts")
> clears the RX and receive timeout interrupts on pl011 startup, to
> avoid a screaming-interrupt scenario that can occur when the
> firmware or bootloader leaves these interrupts spuriously
> asserted.
> 
> This has been noted as an issue when running Linux on qemu [1].
> 
> Unfortunately, the above fix seems to lead to potential
> misbehaviour if the RX FIFO interrupt is asserted _non_ spuriously
> on driver startup, if the RX FIFO is also already full to the
> trigger level.
> 
> Clearing the RX FIFO interrupt does not change the FIFO fill level.
> In this scenario, because the interrupt is now clear and because
> the FIFO is already full to the trigger level, no new assertion of
> the RX FIFO interrupt can occur unless the FIFO is drained back
> below the trigger level.  This never occurs because the pl011
> driver is waiting for an RX FIFO interrupt to tell it that there is
> something to read, and does not read the FIFO at all until that
> interrupt occurs.
> 
> Thus, simply clearing "spurious" interrupts on startup may be
> misguided, since there is no way to be sure that the interrupts are
> truly spurious, and things can go wrong if they are not.
> 
> This patch attempts to handle (suspected) spurious interrupts more
> robustly, by allowing the interrupt(s) to fire but quenching the
> scream.
> 
> pl011_int() runs and attempts to drain the FIFO anyway just as if
> the interrupts were real.  If the FIFO is already empty, great.  To
> avoid a screaming spurious interrupt, the RX FIFO and timeout
> interrupts are now explicitly cleared in between committing to
> drain the RX FIFO and actually draining it.  We do not have to
> worry about lost interrupts here, because we are effectively in
> polled mode inside pl011_int() until the RX FIFO becomes empty:
> 
>   * A new char received before the RX FIFO is fully drained will be
>     drained out synchronously by pl011_int() along with the other
>     chars already pending.  A new char received after the RX FIFO
>     is drained will result in correct RX FIFO interrupt assertion,
>     because emptying the RX FIFO guarantees that the RX FIFO /
>     timeout interrupt state machines are back in a sane state.
> 
>   * A new RX timeout before the RX FIFO is fully drained is no
>     problem, because pl011_int() has already committed to emptying
>     the FIFO at this point, guaranteeing that no stray chars will
>     be left behind.  A new RX timeout after the RX FIFO is fully
>     drained will result in correct interrupt assertion.
> 
> This patch does not attempt to address the case where the RX FIFO
> fills faster than it can be drained: that is a pathological
> condition that is beyond the scope of the driver to work around.
> Users cannot expect this to work unless they enable hardware flow
> control.
> 
> [1] [Qemu-devel] [Qemu-arm] [PATCH] pl011: do not put into fifo
> before enabled the interruption
> https://lists.gnu.org/archive/html/qemu-devel/2018-01/msg06446.html
> 
> Reported-by: Wei Xu <xuwei5@hisilicon.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Fixes: 9b96fbacda34 ("serial: PL011: clear pending interrupts")
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> ---
>  drivers/tty/serial/amba-pl011.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 

After commented the 1549 line in the amba-pl011.c[1] and applied this patch,
the console is not hanged any more.

The UART011_ICR is cleared in the pl011_hwinit that will clear the
RX interruption as well.
Is it OK to remove 1549 as well?
Thanks!

[1]:http://elixir.free-electrons.com/linux/v4.4/source/drivers/tty/serial/amba-pl011.c#L1549

Best Regards,
Wei
