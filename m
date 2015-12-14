From: peda@axentia.se (Peter Rosin)
Date: Mon, 14 Dec 2015 10:38:30 +0000
Subject: [RESEND RFC PATCH 0/2] Expose the PIO_ISR register on SAMA5D3
In-Reply-To: <566C6122.6040406@kernel.org>
References: <1449544808-3163-1-git-send-email-peda@lysator.liu.se>
 <CACRpkdYN=n=Q+UpLbWjxJHP-FYi_e4cHFE_d1_fR2r7QYcqgYQ@mail.gmail.com>
 <566C6122.6040406@kernel.org>
Message-ID: <85d1850f20c141b2952d93be72199fdf@EMAIL.axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jonathan Cameron [mailto:jic23 at kernel.org] wrote:
> On 11/12/15 12:53, Linus Walleij wrote:
> > Quoting extensively since I'm involving the linux-iio mailinglist.
> > 
> > The use case you describe is hand-in-glove with Industrial I/O.
> > I think you want a trigger interface from IIO and read events from
> > userspace using the IIO character device.
> > 
> > Look at the userspace examples in tools/iio for how it's used
> > in userspace, the subsystem is in drivers/iio. I suspect
> > drivers/iio/adc/polled-gpio.c or something is where you actually
> > want to go with this. The module should do all the fastpath
> > work and then expose what you actually want to know to
> > userspace using the IIO triggers or events.
> > 
> > I have used IIO myself, it is really neat for this kind of usecase,
> > and designed right from the ground up.
> > 
> > I think you whould think about how to write the right kind of
> > driver for IIO to do what you want.
> Peter has a spot of IIO experience as well :)

Right, the "DAC" I'm using to control the input level on the comparator
is actually my IIO mcp4531 potentiometer driver. But I have only
rudimentary IIO knowledge; that driver is trivial.

> I'm not sure I entirely understand what the data flows are here so I may
> get this completely wrong!
> 
> Sounds like a quick, dirty and simple 'capture unit' like you'd find on a PLC to
> me (be bit one that doesn't grab much data - I use these all the time at
> work to catch the output from beam break sensor on automated systems and
> stuff like that).  Timers often support a copy to register on a gpio
> signal but I'm not sure I've ever seen that supported in kernel either
> (some discussion about doing this in IIO occurred a while ago but I don't
> think anything ever came of it unfortunately). It was for the TI ECAP devices
> by Matt Porter (cc'd)  Not that closely related but perhaps Matt will
> have some insight here.
> 
> So:
> 
> Are we looking to synchronised control of the DAC
> feeding the comparator or is that entirely autonomous?
> (for now I'll assume autonomous - it gets interesting if
>  not - we'd need the buffered output stuff Lars has for that)
> 
> How fast are we talking?
> 
> So I think we are basically looking for fast sampling of the gpio with latching.
> 
> I suspect the rates are high enough that an IIO trigger is going to be too expensive
> (as it effectively runs as an irq).  That's fine though as they are optional if
> you have a good reason not to use them and a direct polling of the isr and filling a
> buffer might work.
> 
> We don't currently have 1 bit channel support in IIO and in this particular case
> our normal buffers are going to be very inefficient as they are kfifo based
> and hence will burn 1 byte per sample if we do this the simple way.
> The closest we have gotten to a 1 bit support was a comparator driver and
> in the end the author decided to support that via events which have way higher
> overhead than I think you want.
> 
> So if IIO is the sensible way to support this I think we need something like
> the following:
> 
> 1) 1 bit data type support in IIO - not too bad to add, though will need
>    to have some restrictions in the demux as arbitary bit channel recombining
>    would be horrible and costly.  So in the first instance we'd probably burn 1 byte
>    per 1 bit channel each sample - address this later perhaps.  If burning
>    a byte, just specify that you have a channel with realbits = 1, storagebits = 8
>    and it should all work.  I'd like to add 1 bit support fully if you are
>    interested though!
> 
> 2) A driver that can effectively check and clear the interrupt register and
>    push that to the kfifo.  Probably running a kthread to keep the overhead
>    low - something like the recent INA2XX driver is doing (though for a rather
>    different reason).  That would then shove data into the buffer at regular
>    intervals.
> 
> 3) Normal userspace code would then read this - ideally with updates to
>    correctly interpret it as boolean data.
> 
> Doesn't sound too bad - just a question of whether it will be lightweight
> enough for your use case.
> 
> Assuming I have understood even vaguely what you are doing ;)
>  
> Sounds fun.

Hmm, I've been reading the responses from you and Linus a couple of
times, and I think you have misunderstood? You talk about triggers,
fastpath, high rates and whatnot. That is not what I need and not my
itch at all! I'm not looking at getting a continuous stream of envelope
values, I only need to check the envelope value every 5 seconds or
so. Also, the whole thing is complicated by the envelope detector
being multiplexed, so that the one envelope detector can be used
for a handful of signals.

The simplified schematics are:

     -------
 -> | I1    |              -------      -------
 -> | I2  O | -> INPUT -> | A     |    |       |
 -> | I3    |             |     C | -> | gpio  |
 -> | I4    |      DAC -> | B     |    |       |
 -> | I5    |              -------      -------
     -------                 CMP          MCU
       MUX

Userspace does the following when doing this w/o the isr patches:

1. select signal using the MUX
2. set the DAC so high that INPUT is never reaching that level.
   C (and thus gpio) is now stable
3. start waiting for interrupts on gpio
4. adjust the DAC level to the level of interest
5. abort on interrupt or timeout

If the measurement timed out, I know that the signal is weaker than the
given DAC threshold, and can go back to 4 with a lower DAC level. If the
measurement was interrupted, I need to go back to 2 in order to set a
higher DAC level when point 4 is reached.

The actual INPUT envelope is found out by repeating this until we
run out of bits in the DAC (i.e. using a binary search pattern).

In my use case, I don't pretend to detect signals lower than 20Hz, so
my timeout is 50ms.

With the isr patches, the above transforms into:

1. select signal using the MUX
2. set the DAC so high that INPUT is never reaching that level.
   C (and thus gpio) is now stable
3. read the isr bit to clear it
4. adjust the DAC level to the level of interest
5. read the isr bit again after 50ms

The result is available directly in the isr bit, no interrupts needed.
If I happen to wait longer than 50ms, that's not a problem either. With
the isr register version, there is simply no need to do any of this
with any critical urgency.

The actual INPUT envelope is found out in the same way as in the
interrupt case, by looping until we run out of DAC bits.

So, my problem is that doing this with the interrupt version
introduces a risk that you get a never-ending flood of interrupts if
INPUT has a frequency that's high enough. User space may never get
a chance to say that more interrupts are not interesting. Or,
at least, the device may be tied up with handling totally pointless
interrupts for an unacceptable amount of time before user space
gets to run.

INPUT may be an external signal to the device, and while I could add
specs that state a max frequency and then blame the end user in case of
trouble, I would very much like it if it was not possible the kill the
device by applying the "right" signal.



I have realized that I could work with one-shot-interrupts. Then the
urgency to disable interrupts go away, as only one interrupt would
be served. That was not my immediate solution though, as I have been
using isr type registers in this way several times before.

One gain with the interrupt approach is that you may not need to wait
the full 50ms for each measurement, but I can't say that I care much
about that.

If this is to be done in IIO, I imagine that the sanest thing would
be to integrate the whole DAC-loop and present a finished envelope
value to user space? This envelope detector would have to be pretty
configurable, or it will be next to useless to anybody but me.

I could imaging that this new IIO driver should be able to work
with any DAC type device, which in my case would be the mcp4531
dpot. Which is not a DAC, maybe that could be solved with a new
dac-dpot driver, applicable to cases where a dpot is wired as a
simple voltage divider? The new IIO driver also needs to know how
to get a reading from the comparator. I think the driver should
support having a latch between the comparator and the gpio, so it
need to know how to optionally "reset the comparator". That
would have solved the whole problem, you would never have seen
any of this if I had such a latch on my board. But the isr
register is a latch, so...

Regardless, I think such a driver still needs support from gpio
and/or pinctrl. Either exposing the isr register or supporting
one-shot-interrupts that disarm themselves before restoring the
processor interrupt flag (maybe that exists?). Otherwise the
core problem remains unsolved. Also, this imaginary IIO driver
probably have to be totally oblivious of the MUX, or the number
of possibilities explode.

Cheers,
Peter

> > Yours,
> > Linus Walleij
> > 
> > On Tue, Dec 8, 2015 at 4:20 AM, Peter Rosin <peda@lysator.liu.se> wrote:
> >> From: Peter Rosin <peda@axentia.se>
> >>
> >> Hi!
> >>
> >> I have a signal connected to a gpio pin which is the output of
> >> a comparator. By changing the level of one of the inputs to the
> >> comparator, I can detect the envelope of the other input to
> >> the comparator by using a series of measurements much in the
> >> same maner a manual ADC works, but watching for changes on the
> >> comparator over a period of time instead of only the immediate
> >> output.
> >>
> >> Now, the input signal to the comparator might have a high frequency,
> >> which will cause the output from the comparator (and thus the GPIO
> >> input) to change rapidly.
> >>
> >> A common(?) idiom for this is to use the interrupt status register
> >> to catch the glitches, but then not have any interrupt tied to
> >> the pin as that could possibly generate pointless bursts of
> >> (expensive) interrupts.
> >>
> >> So, these two patches expose an interface to the PIO_ISR register
> >> of the pio controllers on the platform I'm targetting. The first
> >> patch adds some infrastructure to the gpio core and the second
> >> patch hooks up "my" pin controller.
> >>
> >> But hey, this seems like an old problem and I was surprised that
> >> I had to touch the source to do it. Which makes me wonder what I'm
> >> missing and what others needing to see short pulses on a pin but not
> >> needing/wanting interrupts are doing?
> Basically a capture unit... Be it one that doesn't grab anything else
> at the moment.
> >>
> >> Yes, there needs to be a way to select the interrupt edge w/o
> >> actually arming the interrupt, that is missing. And probably
> >> other things too, but I didn't want to do more work in case this
> >> is a dead end for some reason...
> >>
> >> Cheers,
> >> Peter
> >>
> >> Peter Rosin (2):
> >>   gpio: Add isr property of gpio pins
> >>   pinctrl: at91: expose the isr bit
> >>
> >>  Documentation/gpio/sysfs.txt   |   12 ++++++++++
> >>  drivers/gpio/gpiolib-sysfs.c   |   30 ++++++++++++++++++++++++
> >>  drivers/gpio/gpiolib.c         |   15 ++++++++++++
> >>  drivers/pinctrl/pinctrl-at91.c |   50 ++++++++++++++++++++++++++++++++++++----
> >>  include/linux/gpio/consumer.h  |    1 +
> >>  include/linux/gpio/driver.h    |    2 ++
> >>  6 files changed, 106 insertions(+), 4 deletions(-)
> >>
> >> --
> >> 1.7.10.4
> >>
