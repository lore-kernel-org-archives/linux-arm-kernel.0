From: johan@kernel.org (Johan Hovold)
Date: Wed, 19 Apr 2017 10:56:20 +0200
Subject: usb: dwc2: NMI watchdog: BUG: soft lockup - CPU#0 stuck for 146s
In-Reply-To: <186569458.91967.1492547106553@email.1und1.de>
References: <1795308650.27171.9a53158f-312d-40ce-80ce-8bf792d8db34.open-xchange@email.1und1.de>
 <172093673.40121.1492427140661@email.1und1.de>
 <CAD=FV=WJBTUcMPw8OgQT_jhz0H8AsH=YqWMR7LtudUKrF5-XOA@mail.gmail.com>
 <79b9b35b-0600-771f-4cd2-9e03c5ba3a25@i2se.com>
 <186569458.91967.1492547106553@email.1und1.de>
Message-ID: <20170419085620.GE2823@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 18, 2017 at 10:25:06PM +0200, Stefan Wahren wrote:
> Hi,
> 
> [add Johan]
> 
> > Stefan Wahren <stefan.wahren@i2se.com> hat am 18. April 2017 um 10:07 geschrieben:
> > 
> > 
> > Am 18.04.2017 um 00:37 schrieb Doug Anderson:
> > > Hi,
> > >
> > > On Mon, Apr 17, 2017 at 4:05 AM, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> > >> Hi,
> > >>
> > >>> Stefan Wahren <stefan.wahren@i2se.com> hat am 31. Oktober 2016 um 21:34 geschrieben:
> > >>>
> > >>>
> > >>> I inspired by this issue [1] i build up a slightly modified
> > >>> setup with a Raspberry Pi B (mainline kernel 4.9rc3), a powered
> > >>> 7 port USB hub and 5 Prolific PL2303 USB to serial convertors. I
> > >>> modified the usb_test for dwc2 [2], which only tries to open all
> > >>> ttyUSB devices one after the other.
> > >>>
> > >>> Unfortunately the complete system stuck after opening the first
> > >>> ttyUSB device ( heartbeat LED stop blinking, no reaction to
> > >>> debug UART). The only way to reanimate the system is to
> > >>> powerdown the USB hub with the USB to serial convertors.
> > >>>
> > >>> [1] - https://github.com/raspberrypi/linux/issues/1692

> i took GPIO17 to measure _dwc2_hcd_irq and GPIO18 to measure
> _dwc2_hcd_urb_enqueue (patch against 4.11rc1 below).
> 
> So i made my observations for 3 test cases:
> 
> 1) no serial converter connected (idle)
> 2) 1 FTDI serial converter connected
> 3) 1 PL2303 serial converter connected
> 
> case   | ksoftirq cpu     | mean duration | max duration  | max duration | urb_enqueue  |
>        |                  | hcd_irq       | hcd_irq       | urb_enqueue  | within 10 sec|
> -------+------------------+---------------+---------------+--------------+--------------+
> idle   | 0.0%             | 2 us          | 16.5 us       |     12 us    | 5            |
> FTDI   | 25.0%            | 8.5 us        | 18.0 us       |  31000 us    | ~ 400        |
> PL2303 | top doesn't work | 8.5 us        | 22.5 us       | 900000 us    | 4            |
> 
> So it seems the serial USB driver has also an impact. In the analyzer
> trace the FTDI triggers many smaller urb_enqueue calls in the opposite
> to the PL2303 which only has few but huge calls.

What do you mean by "huge calls" above?

Are you just keeping the ports open (i.e. with no data being received or
sent)?

FTDI devices are notorious for their status messages being sent
continuously while the port is open. You'll get a two-byte bulk-in
message every 16ms by default (these were sent every millisecond up
until recently due to a long-standing regression).

PL2303 devices have an interrupt-in endpoint which is used for status
notifications so you would not see any completion callbacks on an
otherwise idle port.

> Additional notes:
> After closing the serial connection to the FTDI the system is usable
> as before. In case of PL2303 i need to disconnect the converter in
> order to get a usable system.

Does your system lock up when you open the first pl2303 device?

> Why do they behave so differently?

So the ftdi bulk-in status messages and the pl2303 interrupt-in endpoint
could be two reasons, but I guess so could any change in timing etc.

Is your ftdi-device a Full Speed device like the pl2303?

Johan
