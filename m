From: neilb@suse.de (NeilBrown)
Date: Fri, 3 Feb 2012 23:07:20 +1100
Subject: patch "tty: serial: OMAP: ensure FIFO levels are set correctly
 in non-DMA" added to tty tree
In-Reply-To: <CAAL8m4ztuB-kJvLGd=8PqPCLFcvPW9AQcdcFQ+e03vDT240vog@mail.gmail.com>
References: <13274430881471@kroah.org>
 <alpine.DEB.2.00.1201251156361.5324@utopia.booyaka.com>
 <20120126042155.GA3185@suse.de>
 <alpine.DEB.2.00.1201252124470.11174@utopia.booyaka.com>
 <20120126191604.GA15516@suse.de>
 <alpine.DEB.2.00.1201261225520.32667@utopia.booyaka.com>
 <alpine.DEB.2.00.1202021302070.586@utopia.booyaka.com>
 <20120203150708.386951d2@notabene.brown>
 <CAAL8m4ztuB-kJvLGd=8PqPCLFcvPW9AQcdcFQ+e03vDT240vog@mail.gmail.com>
Message-ID: <20120203230720.28666cc6@notabene.brown>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 3 Feb 2012 12:26:14 +0530 Govindraj <govindraj.ti@gmail.com> wrote:

> On Fri, Feb 3, 2012 at 9:37 AM, NeilBrown <neilb@suse.de> wrote:
> > On Thu, 2 Feb 2012 13:03:01 -0700 (MST) Paul Walmsley <paul@pwsan.com> wrote:
> >
> >> Hi Greg,
> >>
> >> On Thu, 26 Jan 2012, Paul Walmsley wrote:
> >>
> >> > On Thu, 26 Jan 2012, Greg KH wrote:
> >> >
> >> > > Ok, I've just reverted both of these patches for now, please send new
> >> > > ones when you have them.
> >> >
> >> > Thanks. ?A pull request is at the bottom of this message. ?The patches
> >> > are also available from the mailing list archives here:
> >> >
> >> > http://marc.info/?l=linux-arm-kernel&m=132754676014389&w=2
> >> > http://marc.info/?l=linux-arm-kernel&m=132754677914395&w=2
> >> > http://marc.info/?l=linux-arm-kernel&m=132754676014388&w=2
> >>
> >> Any comments on these?
> >
> > Can I comment??... ?They are good but ....
> >
> > I've tried two approaches to getting serial behaviour that I am happy with.
> > They are with and without runtime pm.
> >
> > If I enable runtime pm by setting power/autosuspend_delay_ms (e.g. to 5000)
> > then CPUIDLE enters lower states and I think it uses less power but I
> > sometimes lose the first char I type (that is known) but also I sometimes get
> > corruption on output.
> >
> > The problem seems to be that we turn off the clocks when the kernel's ring
> > buffer is empty rather than waiting for the UART's fifo to be empty.
> > So I get corruption near the end of a stream of output ... not right at the
> > end so something must be turning the clocks back on somehow.
> >
> > I can remove this effect with:
> >
> > diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
> > index f809041..c7ef760 100644
> > --- a/drivers/tty/serial/omap-serial.c
> > +++ b/drivers/tty/serial/omap-serial.c
> > @@ -440,7 +440,8 @@ static unsigned int serial_omap_tx_empty(struct uart_port *port)
> > ? ? ? ?spin_lock_irqsave(&up->port.lock, flags);
> > ? ? ? ?ret = serial_in(up, UART_LSR) & UART_LSR_TEMT ? TIOCSER_TEMT : 0;
> > ? ? ? ?spin_unlock_irqrestore(&up->port.lock, flags);
> > - ? ? ? pm_runtime_put(&up->pdev->dev);
> > + ? ? ? pm_runtime_mark_last_busy(&up->pdev->dev);
> > + ? ? ? pm_runtime_put_autosuspend(&up->pdev->dev);
> > ? ? ? ?return ret;
> > ?}
> >
> 
> But looking into it UART_LSR_TEMT("include/linux/serial_reg.h") => 0x40
> 
> from omap trm:
> 
> TX_SR_E => bit 6
> "Read 0x1: Transmitter hold (TX FIFO) and shift registers are empty."
> 
> So it means all data from tx fifo has shifted out and no pending data in
> tx fifo.
> 
> But we had used UART_LSR_THRE (0x20) here for tx fifo emptiness comparison
> then  from omap trm
> 
> TX_FIFO_E => bit 5
> 
> "Read 0x1: Transmit hold register (TX FIFO) is empty.
> The transmission is not necessarily complete"
> 
> So I think all data has been shifted out from tx fifo for
> serial_omap_tx_empty check.

Useful and interesting - thanks.
However what it really shows me is that I was misunderstanding the code
(If I spent the time to verify every conclusion that I jumped to, I'd never
get anywhere :-( ).  Better clarify that now.

So this function - serial_omap_tx_empty() is called to test if the
tx queue is empty.

It is called in a loop at the end of uart_wait_until_sent.

uart_wait_until_sent it calls from various places, but particularly when
doing an 'stty' ioctl.

The loop isn't a very tight loop though it would be tighter if jiffies were
smaller.  As it is it checks every jiffy and usually loops 3 times when I
see corruption.

So when I

   cat somefile

to the serial console, most of the file comes out fine.  But after 'cat'
finishes and returns to the shell - while some chars are still in the FIFO - 
the shell does an 'stty' ioctl to make sure the settings are still OK.
This ioctl calls serial_omap_tx_empty which calls pm_resume_put() which
immediately suspends the uart, which seems to stop some clock - even though
we think it shouldn't.

(If is use 'dash' instead of 'bash', that shell doesn't fiddle with stty, and
I don't see any corruption).

After a bit more experimentation, I find that if either UART3 or UART4 (which
are numbers 2 and 3 is sysfs!!!) have auto_suspend_delay set to -1, then I
don't see any corruption.
But if both are set to 5000, then I do.

(The settings of UART1 and UART2 seem to be irrelevant - presumably because
they are in CORE, not PER).

So if either uart wants PER_48M_FCLK on, then it stays on.  But if neither
explicitly request it and are only keeping it on by being active ... then
there is room for a hiccup it seems.
Or maybe it isn't the clocks ... maybe the problem is that PER goes into
RET mode, which it does for about 40msec.

If I run
 cat /sys/kernel/debug/pm_debug/time; stty 115200; \
 cat /sys/kernel/debug/pm_debug/time

then I see corruption near the end of the first output of the 'time' file,
and the time that PER is in RET goes up by about 40msec.
This could be because the clock goes off, or maybe it has some other cause
that I'm not aware of.

So yeah - I was quite wrong in my original analysis, thanks for encouraging
me to sort it out.



This is awfully similar to the problem I had with HDQ - clock seeming to
disappear when it should not.

There is something important I'm missing.... time to go back to the TRM I
guess..



> 
> >
> > i.e. when the tx buffer is empty, so turn the clocks off immediately, but
> > wait a while for the fifo to empty. ?Hopefully the auto-suspend time is
> > enough.
> >
> 
> [...]
> 
> >
> > p.s. who should I formally submit OMAP-UART patches to? ?I have a couple of
> > others such as the below that I should submit somewhere.
> >
> >
> > diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
> > index 247d894..35a649f 100644
> > --- a/arch/arm/mach-omap2/serial.c
> > +++ b/arch/arm/mach-omap2/serial.c
> > @@ -54,11 +54,9 @@
> >
> > ?struct omap_uart_state {
> > ? ? ? ?int num;
> > - ? ? ? int can_sleep;
> >
> > ? ? ? ?struct list_head node;
> > ? ? ? ?struct omap_hwmod *oh;
> > - ? ? ? struct platform_device *pdev;
> > ?};
> >
> > ?static LIST_HEAD(uart_list);
> > @@ -381,8 +379,6 @@ void __init omap_serial_init_port(struct omap_board_data *bd
> >
> > ? ? ? ?oh->mux = omap_hwmod_mux_init(bdata->pads, bdata->pads_cnt);
> >
> > - ? ? ? uart->pdev = pdev;
> > -
> > ? ? ? ?oh->dev_attr = uart;
> >
> > ? ? ? ?if (((cpu_is_omap34xx() || cpu_is_omap44xx()) && bdata->pads)
> 
> Acked-by: Govindraj.R <govindraj.raja@ti.com>
> 
> Please post out this part as a patch,
> I think this change has to go through linux-omap tree.

I'll do that, thanks.

NeilBrown

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 828 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120203/97abd7e5/attachment.sig>
