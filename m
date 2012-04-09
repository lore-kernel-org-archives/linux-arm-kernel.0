From: tony@atomide.com (Tony Lindgren)
Date: Mon, 9 Apr 2012 13:36:51 -0700
Subject: [RESEND PATCH] ARM :OMAP2+: UART: Remove some of uart default pads
In-Reply-To: <CA+Bv8XZgKg-Om9S=CcJEDWRan0pMZ_t1aCVT31q3REmcgLntBw@mail.gmail.com>
References: <1332324149-16058-1-git-send-email-govindraj.raja@ti.com>
 <20120403181925.GH8240@atomide.com>
 <CAMrsUdLrpyGrhggi820WcR+DoHJVB8GQ1THUOO-C4LqUQtAxWQ@mail.gmail.com>
 <20120405165811.GB3785@atomide.com>
 <CAMrsUdJEY2o2CWjzSg5dabVEkpk48O5njtDU55Z3Jq2vViNJgQ@mail.gmail.com>
 <20120406181556.GC15734@atomide.com>
 <CAMrsUdKs21qtrWX0i44fvm7U2JW0L=2NgmZBHAZGmwp03XFm6w@mail.gmail.com>
 <CA+Bv8XZgKg-Om9S=CcJEDWRan0pMZ_t1aCVT31q3REmcgLntBw@mail.gmail.com>
Message-ID: <20120409203651.GB6487@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russ Dill <russ.dill@gmail.com> [120409 09:59]:
> > From: "Govindraj.R" <govindraj.raja@ti.com>
> > Date: Mon, 9 Apr 2012 15:16:52 +0530
> > Subject: [PATCH] ARM: OMAP2+: UART: Fix usage of default uart pads.

> > -static int __init
> > +int __init
> > ?omap_mux_get_by_name(const char *muxname,
> > ? ? ? ? ? ? ? ? ? ? ? ?struct omap_mux_partition **found_partition,
> > ? ? ? ? ? ? ? ? ? ? ? ?struct omap_mux **found_mux)

This can now be one one line:

int __init omap_mux_get_by_name(const char *muxname,
...


> > + ? ? ? ? ? ? ? u16 tx_mode, rx_mode;
> > +
> > + ? ? ? ? ? ? ? tx_mode = omap_mux_read(tx_partition, tx_mux->reg_offset);
> > + ? ? ? ? ? ? ? rx_mode = omap_mux_read(rx_partition, rx_mux->reg_offset);
> > +
> > + ? ? ? ? ? ? ? if (!(rx_mode & 0x07) && !(tx_mode & 0x07)) {
> > + ? ? ? ? ? ? ? ? ? ? ? default_omap_uart_pads[0].name = rx_pad_name;
> > + ? ? ? ? ? ? ? ? ? ? ? default_omap_uart_pads[0].flags ?=
> > + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? OMAP_DEVICE_PAD_REMUX | OMAP_DEVICE_PAD_WAKEUP;
> > + ? ? ? ? ? ? ? ? ? ? ? default_omap_uart_pads[0].enable = OMAP_PIN_INPUT |
> > + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? OMAP_MUX_MODE0;
> > + ? ? ? ? ? ? ? ? ? ? ? default_omap_uart_pads[0].idle = OMAP_PIN_INPUT |
> > + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? OMAP_MUX_MODE0;
> > +
> > + ? ? ? ? ? ? ? ? ? ? ? default_omap_uart_pads[1].name = tx_pad_name;
> > + ? ? ? ? ? ? ? ? ? ? ? default_omap_uart_pads[1].enable = OMAP_PIN_OUTPUT |
> > + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? OMAP_MUX_MODE0;
> > + ? ? ? ? ? ? ? ? ? ? ? bdata->pads = default_omap_uart_pads;
> 
> You are assigning this variable to a structure on the stack.
> 
> > + ? ? ? ? ? ? ? ? ? ? ? bdata->pads_cnt = ARRAY_SIZE(default_omap_uart_pads);

Also, maybe make that into a separate function with comments added that
we check that the default pins are muxed to uart rx and tx mode to start
with. Otherwise it's a bit hard to figure out what's going on here.

Then please split it into two patches: First one removes all the unsafe
muxing, then the second one enables wake-up events for the ports already
in uart rx/tx mode.

Regards,

Tony
