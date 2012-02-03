From: govindraj.ti@gmail.com (Govindraj)
Date: Fri, 3 Feb 2012 12:26:14 +0530
Subject: patch "tty: serial: OMAP: ensure FIFO levels are set correctly in
 non-DMA" added to tty tree
In-Reply-To: <20120203150708.386951d2@notabene.brown>
References: <13274430881471@kroah.org>
 <alpine.DEB.2.00.1201251156361.5324@utopia.booyaka.com>
 <20120126042155.GA3185@suse.de>
 <alpine.DEB.2.00.1201252124470.11174@utopia.booyaka.com>
 <20120126191604.GA15516@suse.de>
 <alpine.DEB.2.00.1201261225520.32667@utopia.booyaka.com>
 <alpine.DEB.2.00.1202021302070.586@utopia.booyaka.com>
 <20120203150708.386951d2@notabene.brown>
Message-ID: <CAAL8m4ztuB-kJvLGd=8PqPCLFcvPW9AQcdcFQ+e03vDT240vog@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 3, 2012 at 9:37 AM, NeilBrown <neilb@suse.de> wrote:
> On Thu, 2 Feb 2012 13:03:01 -0700 (MST) Paul Walmsley <paul@pwsan.com> wrote:
>
>> Hi Greg,
>>
>> On Thu, 26 Jan 2012, Paul Walmsley wrote:
>>
>> > On Thu, 26 Jan 2012, Greg KH wrote:
>> >
>> > > Ok, I've just reverted both of these patches for now, please send new
>> > > ones when you have them.
>> >
>> > Thanks. ?A pull request is at the bottom of this message. ?The patches
>> > are also available from the mailing list archives here:
>> >
>> > http://marc.info/?l=linux-arm-kernel&m=132754676014389&w=2
>> > http://marc.info/?l=linux-arm-kernel&m=132754677914395&w=2
>> > http://marc.info/?l=linux-arm-kernel&m=132754676014388&w=2
>>
>> Any comments on these?
>
> Can I comment??... ?They are good but ....
>
> I've tried two approaches to getting serial behaviour that I am happy with.
> They are with and without runtime pm.
>
> If I enable runtime pm by setting power/autosuspend_delay_ms (e.g. to 5000)
> then CPUIDLE enters lower states and I think it uses less power but I
> sometimes lose the first char I type (that is known) but also I sometimes get
> corruption on output.
>
> The problem seems to be that we turn off the clocks when the kernel's ring
> buffer is empty rather than waiting for the UART's fifo to be empty.
> So I get corruption near the end of a stream of output ... not right at the
> end so something must be turning the clocks back on somehow.
>
> I can remove this effect with:
>
> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
> index f809041..c7ef760 100644
> --- a/drivers/tty/serial/omap-serial.c
> +++ b/drivers/tty/serial/omap-serial.c
> @@ -440,7 +440,8 @@ static unsigned int serial_omap_tx_empty(struct uart_port *port)
> ? ? ? ?spin_lock_irqsave(&up->port.lock, flags);
> ? ? ? ?ret = serial_in(up, UART_LSR) & UART_LSR_TEMT ? TIOCSER_TEMT : 0;
> ? ? ? ?spin_unlock_irqrestore(&up->port.lock, flags);
> - ? ? ? pm_runtime_put(&up->pdev->dev);
> + ? ? ? pm_runtime_mark_last_busy(&up->pdev->dev);
> + ? ? ? pm_runtime_put_autosuspend(&up->pdev->dev);
> ? ? ? ?return ret;
> ?}
>

But looking into it UART_LSR_TEMT("include/linux/serial_reg.h") => 0x40

from omap trm:

TX_SR_E => bit 6
"Read 0x1: Transmitter hold (TX FIFO) and shift registers are empty."

So it means all data from tx fifo has shifted out and no pending data in
tx fifo.

But we had used UART_LSR_THRE (0x20) here for tx fifo emptiness comparison
then  from omap trm

TX_FIFO_E => bit 5

"Read 0x1: Transmit hold register (TX FIFO) is empty.
The transmission is not necessarily complete"

So I think all data has been shifted out from tx fifo for
serial_omap_tx_empty check.

>
> i.e. when the tx buffer is empty, so turn the clocks off immediately, but
> wait a while for the fifo to empty. ?Hopefully the auto-suspend time is
> enough.
>

[...]

>
> p.s. who should I formally submit OMAP-UART patches to? ?I have a couple of
> others such as the below that I should submit somewhere.
>
>
> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
> index 247d894..35a649f 100644
> --- a/arch/arm/mach-omap2/serial.c
> +++ b/arch/arm/mach-omap2/serial.c
> @@ -54,11 +54,9 @@
>
> ?struct omap_uart_state {
> ? ? ? ?int num;
> - ? ? ? int can_sleep;
>
> ? ? ? ?struct list_head node;
> ? ? ? ?struct omap_hwmod *oh;
> - ? ? ? struct platform_device *pdev;
> ?};
>
> ?static LIST_HEAD(uart_list);
> @@ -381,8 +379,6 @@ void __init omap_serial_init_port(struct omap_board_data *bd
>
> ? ? ? ?oh->mux = omap_hwmod_mux_init(bdata->pads, bdata->pads_cnt);
>
> - ? ? ? uart->pdev = pdev;
> -
> ? ? ? ?oh->dev_attr = uart;
>
> ? ? ? ?if (((cpu_is_omap34xx() || cpu_is_omap44xx()) && bdata->pads)

Acked-by: Govindraj.R <govindraj.raja@ti.com>

Please post out this part as a patch,
I think this change has to go through linux-omap tree.

--
Thanks,
Govindraj.R
