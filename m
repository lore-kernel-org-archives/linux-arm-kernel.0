From: martinwguy@gmail.com (Martin Guy)
Date: Mon, 19 Apr 2010 19:52:47 +0100
Subject: [PATCH v3 1/2] spi: implemented driver for Cirrus EP93xx SPI
	controller
In-Reply-To: <q2pfa686aa41004191102qc93f09b6m941785b4cb4e32db@mail.gmail.com>
References: <cover.1271156934.git.mika.westerberg@iki.fi>
	<e0e5dc30af89f0b65fd2e5e52f9e7fe9f162516b.1271156934.git.mika.westerberg@iki.fi>
	<n2jfa686aa41004162330qae611a0u87be76ca08bfb52a@mail.gmail.com>
	<20100417110036.GC19534@gw.healthdatacare.com>
	<q2pfa686aa41004191102qc93f09b6m941785b4cb4e32db@mail.gmail.com>
Message-ID: <o2g56d259a01004191152w9c2245fdgaa2d4ac1b9e95ed7@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/19/10, Grant Likely <grant.likely@secretlab.ca> wrote:
>  >> > +static int ep93xx_spi_flush(const struct ep93xx_spi *espi, unsigned long msecs)
>  >> > +{
>  >> > +       unsigned long timeout = jiffies + msecs_to_jiffies(msecs);
>  >> > +
>  >> > +       while (ep93xx_spi_read_u16(espi, SSPSR) & SSPSR_RNE) {
>  >> > +               if (time_after(jiffies, timeout))
>  >> > +                       return -ETIMEDOUT;
>  >>
>  >> Ouch.  With the current code the driver could busy wait for 100ms!  If
>  >> flushing takes time, then don't busywait.  Bail out to some form of
>  >> deferred work.  Let the kernel get on with something else.
>  >
>  > I've never witnessed flushing to take this whole 100ms. Timeout is
>  > there just to make sure that this ends eventually. I can change it
>  > to some lower value (say few msecs or something like that).
>
>  Even with a lower value, the driver is still busywaiting which is bad
>  for latency.  If I see a lot of busywaiting, then I look very closely
>  at refactoring the driver into a state machine that can easily defer
>  work.

This function and all busywaiting should disappear now that the
interrupt-driven mode only interrupts once per four words instead of
doing a whole block transfer inside a single interrupts call.

>  >> > + * ep93xx_spi_calc_divisors() - calculates SPI clock divisors
>  >> > +
>  >> > +       /*
>  >> > +        * Calculate divisors so that we can get speed according the
>  >> > +        * following formula:
>  >> > +        *      rate = spi_clock_rate / (cpsr * (1 + scr))
>  >> > +        *
>  >> > +        * cpsr must be even number and starts from 2, scr can be any number
>  >> > +        * between 0 and 255.
>  >> > +        */
>  >> > +       for (cpsr = 2; cpsr <= 254; cpsr += 2) {
>  >> > +               for (scr = 0; scr <= 255; scr++) {
>  >>
>  >> Non-deterministic.
Eh? Some new meaning of "non-deterministic" that I wasn'f familiar with? :)

Yes, it does look gross, but max clock rate is 3.7Mhz (7.4 in rev E2
silicon), so if your slowest device is 400kHz, in practice it only
runs the inner loop from 0 to less than 10.
How slow do SPI devices go in reality? The 254*256 divisor gives 100Hz.

>  >> algebraically calculate the factors instead of an iterative loop.

>  > FIFO size is max 8 frames so there should be 8 iterations when the
>  > FIFO is full. So is it enought to to add check that we only read
>  > max 8 frames from the FIFO?
>
>  If you do it right, FIFO size shouldn't matter.  The driver should
>  easily be able to read however many are available and defer until more
>  is ready.

Again, with the new interrupt-handling code you have to know the FIFO
size because if you regulate the TX filling with the FIFO_NOT_FULL_YET
status bit you end up with 8 words in the TX FIFO plus one word being
transmitted already and that makes 9, which can  overflow the receive
buffer (I've seen this happening in practice).

    M
