From: richardcochran@gmail.com (Richard Cochran)
Date: Thu, 14 May 2015 13:30:54 +0200
Subject: [PATCH 2/2] misc: Add initial Digital Timing Engine (DTE) driver
 for cygnus
In-Reply-To: <5553DD7D.8090905@broadcom.com>
References: <1429744923-2007-1-git-send-email-jonathar@broadcom.com>
 <5543CD73.2030902@broadcom.com>
 <20150501203004.3add2c95@lxorguk.ukuu.org.uk>
 <9193036.7UYD2OGJHk@wuerfel> <554D1649.2030106@broadcom.com>
 <20150513153544.GC2065@localhost.localdomain>
 <5553AAEA.30503@broadcom.com>
 <20150513202716.GA15878@localhost.localdomain>
 <5553DD7D.8090905@broadcom.com>
Message-ID: <20150514113054.GB1580@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 13, 2015 at 04:25:49PM -0700, Jonathan Richardson wrote:
> On 15-05-13 01:27 PM, Richard Cochran wrote:
> > If the ISR is delivering batches of time stamps, then the interrupt
> > rate aught to be the highest rate that the system can support.
> 
> It to nanosecond precision so it can be ridiculously quick.

Your interrupt rate directly controls the worst case delay between the
time the event occurs and the time the application (or stack) obtains
the time stamp.  You want this delay to be as short as possible, but
you cannot afford to bog down the entire operating system.  I would
suggest a fixed value of 1000 Hz (with perhaps a debugfs knob).

What a poor hardware design.  Oh well.

> Having separate FIFO's allows process A to only retrieve channel 1
> timestamps.

Having lots of different processes reading time stamps directly, and
trying to match them up with various HW events after the fact, is not
way to go.  Instead, kernel time stamp consumers should pair the time
stamps with the associated events and then provide the time
information conveniently over the existing APIs. (See also my last
comment.)

> Our original non PTP driver ioctl (DTE_GET_TIMESTAMP) solved that
> problem because we could specify a channel. We're now trying to adapt it
> to PTP so we don't have to write a new "DTE" user and kernel side API.

For mainline, we want the best interface possible.  Sometimes that
means that programs based on out-of-tree interfaces will need to be
changed.

> > Ideally, there will be kernel consumers for most of the channels, and
> > they will forward the time stamps in a way appropriate to their
> > subsystem.  For example, network devices will use so_timestamping. 
> > Any "leftover" channels can go through the generic PTP interface.
> 
> I'll look more into so_timestamping to see how that's used but we wanted
> one generic interface to get timestamps from channels because anything
> can be hooked up to a channel.

I definitely do *not* want one generic interface.  The task of
matching time stamps with hardware events belongs to the kernel.  For
random GPIOs, the existing PTP ioctl is plenty good enough, but for
other devices (network, audio) more work is needed.

One huge lacuna in your patch series is the code that associates the
time stamps with events.  How is this supposed to work?

So far you have:

+enum dte_client {
+       DTE_CLIENT_MIN = 0,
+       DTE_CLIENT_I2S0_BITCLOCK = 0,
+       DTE_CLIENT_I2S1_BITCLOCK,
+       DTE_CLIENT_I2S2_BITCLOCK,
+       DTE_CLIENT_I2S0_WORDCLOCK,
+       DTE_CLIENT_I2S1_WORDCLOCK,
+       DTE_CLIENT_I2S2_WORDCLOCK,
+       DTE_CLIENT_LCD_CLFP,
+       DTE_CLIENT_LCD_CLLP,
+       DTE_CLIENT_GPIO14,
+       DTE_CLIENT_GPIO15,
+       DTE_CLIENT_GPIO22,
+       DTE_CLIENT_GPIO23,
+       DTE_CLIENT_MAX,
+};

Network devices are not present at all.  No idea why LCD signals are
included.  For the i2s, this appears to stamp the audio clock.  But
which audio sample has been stamped?  Or do you only care about
frequency and not phase?

For the next round, please include John Stulz, Thomas Gleixner,
netdev, and the appropriate audio list on CC.

Thanks,
Richard
