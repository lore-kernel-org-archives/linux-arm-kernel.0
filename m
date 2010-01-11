From: simon.kagstrom@netinsight.net (Simon Kagstrom)
Date: Mon, 11 Jan 2010 10:57:24 +0100
Subject: 21285 serial driver deadlock(?) fix
In-Reply-To: <20dd1d411001051037o74fb1187j608889fae0271547@mail.gmail.com>
References: <1262039226.28196.125.camel@localhost>
	<20100104091156.0f384dec@marrow.netinsight.se>
	<20dd1d411001051037o74fb1187j608889fae0271547@mail.gmail.com>
Message-ID: <20100111105724.6a9f799c@marrow.netinsight.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(Added the list to To: as well)

On Tue, 5 Jan 2010 21:37:42 +0300
Steve M <stevenm86@gmail.com> wrote:

> I know little of the serial layer, but I am not certain that it is a good
> idea to put _nosync directly into the stop_tx function, since this is a
> function whose pointer is given out to the upper layer. We may only want the
> nosync behavior from within the ISR, but waiting for the ISR to complete in
> other cases may be more appropriate.

Well, I think serial21285_stop_tx also needs _nosync since it too is
called from an interrupt handler:

  static irqreturn_t serial21285_tx_chars(int irq, void *dev_id)
  {
	[...]
	if (uart_circ_empty(xmit))
		serial21285_stop_tx(port);
  } 

Of course, we could make an unsynced version of the stop_tx/stop_rx
which is called from the local interrupt handlers, and a synchronous
one which gets called from the structure.


I don't know if the function pointers in uart_ops would run into some
problem with the _nosync versions? I haven't seen any problems during
my tests here with them at least.

// Simon
