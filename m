From: balbi@ti.com (Felipe Balbi)
Date: Fri, 15 Feb 2013 15:34:39 +0200
Subject: [RFC/RFT PATCH 2/2] SERIAL: OMAP: Remove the idle handling from
 the driver
In-Reply-To: <511E35D8.1030109@ti.com>
References: <1360930135-32092-1-git-send-email-santosh.shilimkar@ti.com>
 <20130215125740.GB16558@arwen.pp.htv.fi> <511E35D8.1030109@ti.com>
Message-ID: <20130215133439.GF16558@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Feb 15, 2013 at 06:49:20PM +0530, Santosh Shilimkar wrote:
> >>@@ -279,8 +259,6 @@ static void serial_omap_stop_tx(struct uart_port *port)
> >>  		serial_out(up, UART_IER, up->ier);
> >>  	}
> >>
> >>-	serial_omap_set_forceidle(up);
> >>-
> >>  	pm_runtime_mark_last_busy(up->dev);
> >>  	pm_runtime_put_autosuspend(up->dev);
> >>  }
> >>@@ -348,7 +326,6 @@ static void serial_omap_start_tx(struct uart_port *port)
> >>
> >>  	pm_runtime_get_sync(up->dev);
> >>  	serial_omap_enable_ier_thri(up);
> >>-	serial_omap_set_noidle(up);
> >
> >this patch is changing behavior. Currently driver has:
> >
> >start_tx()
> >get_sync()
> >set_noidle()
> >put_autosuspend()
> >
> >....
> >
> >stop_tx()
> >get_sync()
> >set_force_idle()
> >put_autosuspend()
> >
> >with this change, you will have:
> >
> >start_tx()
> >get_sync()
> >set_noidle()
> >put_autosuspend()
> >set_force_idle()
> >
> >this in itself might be enough to go back to corrupted serial if
> >put_autosuspend is so quick that set_force_idle() is called before all
> >data has been shifted out of FIFO and through the UART lines.
> >
> Really. Infact the old sequence was buggy because you are setting
> force_idle even before suspending the device. And that force idle

then that bug has to be fixed first and patch needs to be sent to stable
before we change that part of the code, wouldn't you agree ?

> isn't really force idle but setting ip to smart idle. Just look at
> what serial.c

indeed.

> >Before doing this, you should at least test that removing
> >pm_runtime_mark_last_busy() and pm_runtime_put_autosuspend() from
> >start_tx() and removing pm_runtime_get_sync() from stop_tx() works fine.
> >
> Seems to work for me with above changes as well. Can you please
> try out and see if you see any issue. I doubt you will...

what I'm saying is that current code, as you put it yourself, is buggy,
so we ought to fix the bugs first before changing behavior. If not for
anything else, at least to have a clean tree which we can bisect.

> >Also, $SUBJECT isn't improving the situation regarding UART Wakeup,
> >there is still the regression of UART never being wakeup capable.
> >
> You are mixing the stuff here. The subject is correct.

->enable_wakeup() sets the IP to smart_idle_wakeup, which is done on
SYSC register. If $SUBJECT wants to fix SYSC usage, it ought to fix them
all.

> >I wonder what are your ideas to sort that part out, I mean, how do you
> >plan to implement ->set_wake() for the tty port ?
> >
> That is not related to module idle modes. It is for ioring and that
> needs pin control support. As you can see the patch doesn't touch
> omap_uart_enable_wakeup(). Thats needs pincontrol support so that

see above.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130215/889f9422/attachment-0001.sig>
