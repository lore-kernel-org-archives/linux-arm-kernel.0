From: gdavis@mvista.com (George G. Davis)
Date: Fri, 8 Jan 2010 12:44:44 -0500
Subject: SMP issues on ARM11 MPCore
In-Reply-To: <SNT109-W597ECAF29FF35A1CFC84D0A7730@phx.gbl>
References: <SNT109-W391FD03251D32533FAE84DA77F0@phx.gbl>
	<20100101205850.GI16220@n2100.arm.linux.org.uk>
	<SNT109-W597ECAF29FF35A1CFC84D0A7730@phx.gbl>
Message-ID: <20100108174444.GA824@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Mac Lin,

On Tue, Jan 05, 2010 at 04:02:22PM +0000, mkl lin wrote:
> 
> 
> > These two sounds like a problem with interrupts - userspace console IO
> > is interrupt driven, whereas kernel console IO is not.
> 
> Thanks for Russell's
> advice, after some tracing, I found that my IER (Interrupt Enable
> Register) of the serial port is 0 under case 1!!
> 
> Case 2 is
> actually the same with case 1. Case 1 would come first, if I don't keep
> input things and let it finish its slow printing, it would then become
> case 2.
> 
> UART_BUG_THRE are detected and enabled on my platform, causing serial8250_backup_timeout to be used.
> 
> There
> are many places that do ( get IER, clear IER, restore IER ), like
> serial8250_console_write called by printk, and
> serial8250_backup_timeout. serial8250_backup_timeout is not protected
> by spinlock, causing the race condition, and result in wrong IER value.
> 
> Following patch fix this issue. Case 3 and Case 4 are still often seen, but not case 1 and case 2.
> 
> Best Regards,
> Mac Lin
> diff --git a/kernels/linux-2.6.31.1-X/drivers/serial/8250.c b/kernels/linux-2.6.31.1-X/drivers/serial/8250.c
> index 288a0e4..55602c3 100644
> --- a/kernels/linux-2.6.31.1-cavm1/drivers/serial/8250.c
> +++ b/kernels/linux-2.6.31.1-cavm1/drivers/serial/8250.c
> @@ -1752,6 +1758,8 @@ static void serial8250_backup_timeout(unsigned long data)

If you still need resolution on the serial8250_backup_timeout problem,
you should probably consider submitting an RFC/PATCH to the
linux-serial at vger.kernel.org or  linux-kernel at vger.kernel.org.

--
Regards,
George
