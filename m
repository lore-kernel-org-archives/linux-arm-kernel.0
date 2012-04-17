From: tony@atomide.com (Tony Lindgren)
Date: Tue, 17 Apr 2012 10:47:52 -0700
Subject: [PATCH 2/2] OMAP2+: UART: Add mechanism to probe uart pins and
 configure rx wakeup
In-Reply-To: <CAMrsUd+v-qhVPLbJp1ecE2+e5ayJAQrAzALr1sviH9RDJv3aMg@mail.gmail.com>
References: <1334065246-21294-1-git-send-email-govindraj.raja@ti.com>
 <1334065246-21294-3-git-send-email-govindraj.raja@ti.com>
 <20120410161136.GF6487@atomide.com>
 <CAMrsUdK2ZqCGWtL104tBC_h-XHD0UMMFagch_eSER+92zC1FiQ@mail.gmail.com>
 <20120417014103.GA21106@atomide.com>
 <CAMrsUd+v-qhVPLbJp1ecE2+e5ayJAQrAzALr1sviH9RDJv3aMg@mail.gmail.com>
Message-ID: <20120417174752.GD21106@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Raja, Govindraj <govindraj.raja@ti.com> [120417 05:51]:
> On Tue, Apr 17, 2012 at 7:11 AM, Tony Lindgren <tony@atomide.com> wrote:
> > Hi,
> >
> > Few more comments below.
> >
> > * Raja, Govindraj <govindraj.raja@ti.com> [120411 04:53]:
> > ...
> >
> >> +static int ?__init omap_serial_fill_default_pads(struct omap_board_data *bdata,
> >> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? struct omap_uart_state *uart)
> >> +{
> >> + ? ? struct omap_mux_partition *tx_partition = NULL, *rx_partition = NULL;
> >> + ? ? struct omap_mux *rx_mux = NULL, *tx_mux = NULL;
> >> + ? ? char *rx_fmt, *tx_fmt;
> >> + ? ? int uart_nr = bdata->id + 1;
> >> +
> >> + ? ? if (bdata->id != 2) {
> >> + ? ? ? ? ? ? rx_fmt = "uart%d_rx.uart%d_rx";
> >> + ? ? ? ? ? ? tx_fmt = "uart%d_tx.uart%d_tx";
> >> + ? ? } else {
> >> + ? ? ? ? ? ? rx_fmt = "uart%d_rx_irrx.uart%d_rx_irrx";
> >> + ? ? ? ? ? ? tx_fmt = "uart%d_tx_irtx.uart%d_tx_irtx";
> >> + ? ? }
> >> +
> >> + ? ? snprintf(rx_pad_name, OMAP_UART_DEFAULT_PAD_NAME_LEN, rx_fmt,
> >> + ? ? ? ? ? ? ? ? ? ? uart_nr, uart_nr);
> >> + ? ? snprintf(tx_pad_name, OMAP_UART_DEFAULT_PAD_NAME_LEN, tx_fmt,
> >> + ? ? ? ? ? ? ? ? ? ? uart_nr, uart_nr);
> >
> > This naming won't work for the fourth port on 3630 as there are no "uart4_rx"
> > or "uart4_tx" mux entries, they are "gpmc_wait2.uart4_tx" and
> > "gpmc_wait3.uart4_tx".
> 
> But uart4 is unused on 3630 boards and boards trying to use them
> should configure them from board file.
> (I thought we agreed on this approach where only if uarts are
> available in mux mode0 those ports will be dynamically muxed for wakeup
> others should use omap_serial_init_port)
 
Right, but you're still trying to do mux_get_by_name on it to check
the pads, which will produce a warning on 3630.

> >> @@ -289,8 +354,8 @@ void __init omap_serial_board_init(struct
> >> omap_uart_port_info *info)
> >> ? ? ? ? ? ? ? bdata.pads = NULL;
> >> ? ? ? ? ? ? ? bdata.pads_cnt = 0;
> >>
> >> - ? ? ? ? ? ? if (cpu_is_omap44xx() || cpu_is_omap34xx())
> >> - ? ? ? ? ? ? ? ? ? ? omap_serial_fill_default_pads(&bdata);
> >> + ? ? ? ? ? ? if (omap_serial_fill_default_pads(&bdata, uart))
> >> + ? ? ? ? ? ? ? ? ? ? continue;
> >>
> >> ? ? ? ? ? ? ? if (!info)
> >> ? ? ? ? ? ? ? ? ? ? ? omap_serial_init_port(&bdata, NULL);
> >
> > Can't the omap_serial_board_init() now be just be omap_serial_init(void)
> > as it's not used anywhere else?
> 
> Yes sure we can remove that.

OK 

> > Anyways, this is getting too complex for the -rc series as at least 2430sdp
> > is using alternative pins for the first uart. Let's patch to remove just
> > the uart4 entry for 3630 for the -rc and then we can properly fix this
> > for the next merge window.
> 
> Okay. in that case the earlier patch [1] should be fine to solve the
> gpmc issue observed and ehci issue on beagle-xm.

I'll just use your first patch to remove _all_ the muxing for omap_serial_init().
That's really the only safe thing we can do for the -rc cycle.

This means we rely on bootloader settings for console muxing and wake-up
bits, but that's just what we need to live with until next merge window.

And for the next merge window, I think we should only automatically enable
the wake-up event bits if the port is in serial mode, and not do any other
muxing. Something like:

void __init omap_serial_init(void)
{
        struct omap_uart_state *uart;
        struct omap_board_data bdata;

        list_for_each_entry(uart, &uart_list, node) {
                bdata.id = uart->num;
                bdata.flags = 0;
                bdata.pads = NULL;
                bdata.pads_cnt = 0;
                omap_serial_check_wakeup(&bdata);
                omap_serial_init_port(&bdata, NULL);
        }

        omap_serial_board_init(NULL);
}

Where omap_serial_check_wakeup() just enables the wake-up if the
port is already muxed to uart mode. So it turns out we can't bail
out for unmuxed uarts because some boards use alternative pads like
2430sdp does for the first uart.

Regards,

Tony
