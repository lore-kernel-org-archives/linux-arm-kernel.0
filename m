From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 1 Nov 2017 20:30:50 +0000
Subject: [RFC] Improving udelay/ndelay on platforms where that is possible
In-Reply-To: <475b9543-cc97-41b3-2924-0724fddee392@free.fr>
References: <d3f42f35-8175-58f6-78b7-3331efe64da2@sigmadesigns.com>
 <CA+55aFzy9=RtFRuJhFbF+PL_PCrkZsKtAKrq6WJo1z9eW9gLSA@mail.gmail.com>
 <20171031165629.GF9463@n2100.armlinux.org.uk>
 <CA+55aFwDquBXt_EYT3JFoWkeFsZTym5qUXig-DePXXzm07uABw@mail.gmail.com>
 <CAD=FV=V3n0gjzpL860V6cgf8JVh5pmoL+i0t63Oot19T2afTPw@mail.gmail.com>
 <20171101092618.GN9463@n2100.armlinux.org.uk>
 <475b9543-cc97-41b3-2924-0724fddee392@free.fr>
Message-ID: <20171101203049.GS9463@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 01, 2017 at 08:28:18PM +0100, Marc Gonzalez wrote:
> On 01/11/2017 10:26, Russell King - ARM Linux wrote:
> 
> > On Tue, Oct 31, 2017 at 05:23:19PM -0700, Doug Anderson wrote:
> >
> >> On Tue, Oct 31, 2017 at 10:45 AM, Linus Torvalds wrote:
> >>
> >>> So I'm very much open to udelay improvements, and if somebody sends
> >>> patches for particular platforms to do particularly well on that
> >>> platform, I think we should merge them. But ...
> >>
> >> If I'm reading this all correctly, this sounds like you'd be willing
> >> to merge <https://patchwork.kernel.org/patch/9429841/>.  This makes
> >> udelay() guaranteed not to underrun on arm32 platforms.
> > 
> > That's a mis-representation again.  It stops a timer-based udelay()
> > possibly underrunning by one tick if we are close to the start of
> > a count increment.  However, it does nothing for the loops_per_jiffy
> > udelay(), which can still underrun.
> 
> It is correct that improving the clock-based implementation does strictly
> nothing for the loop-based implementation.
> 
> Is it possible to derive a higher bound on the amount of under-run when
> using the loop-based delay on arm32?

Not really.  If you read the archived thread via URL that I gave you
when this was initially brought up, specifically the first email in
the thread, I give a full analysis of the loop-based delay, why it
gives short delays.

What the analysis says, specifically point (2) in my initial email,
is that the inaccuracy is dependent on two things:

1. the CPU speed
2. the time that the CPU has to spend executing the timer interrupt
   handler.

For any particular kernel, we could assume that there are a fixed
number of cycles to execute the timer interrupt handler.  Let's call
this t_timer.  The timer fires every t_period.

We measure how many loops we can do between two t_period interrupts,
and that includes t_timer each time.  So, the time that we're able
to measure via the delay loop is t_period - t_timer (which is the
equation I give in point (2) in that email).

If the CPU is clocked slowly, then t_timer gets larger, but t_period
remains the same.  So, the error gets bigger.  Conversely, the faster
the CPU, the smaller the error.

Further in that initial email, I give actual measured delay values
for one of my systems (I forget which) for delays from 1us up to 5ms
in 1, 2, 5 decade multiples.  Small delays are longer than desired
because of the overhead of computing the number of loops.  Long
delays are shorter because of the inaccuracies.

Note also that (1) in the original email indicates that the
loops_per_jiffy value is biased towards a smaller value rather than
a larger value - and that also adds to the "it's shorter than
requested" problem.

At the end of the email, I proposed an improvement to the ARM
implementation, which reduces the amount of underrun by correcting
the calculations to round up.  However, this adds four additional
instructions to the computation, which has the effect of making
small delays ever so slightly longer than they are already.
That said, in the last six years, ARM CPUs have become a lot
faster, so the effect of those four instructions is now reduced.

Now, if you read Linus' reply to my initial email, you'll see that
Linus stated very clearly that the error caused by that is in the
"don't care too much" (quoting Linus) category, which is what I've
been trying to tell you all this time.

The slight underrun that we get with the software loop is not
something we care about, we know that it happens and there's very
little motivation to fix it.

What does that mean?  Well, if we have a super-accurate udelay()
implementation based on timers, that's really great, it means we
can have accurate delays that won't expire before the time they're
supposed to.  I agree that's a good thing.  There's also a major
got-cha, which is if we have to fall back to using the software
based udelay(), then we immediately start loosing.  As can be
seen from the figures I've given, if you ask for a 1ms delay, it's
about 1% short, so 990us.

Do those 10us matter?  That depends on the driver, buses, and what
the delay is being used for - but the point is, with the software
loop, we _can't_ guarantee that if we ask for a 1ms delay, we'll
get at least a 1ms delay.

Now, what does this 1% equate to for a timer based delay?  If the
timer ticks at 10MHz, so giving a 100ns resolution, and we miss
one by one tick, that's a 100ns error.  If you now look at the
figures a measured from the software udelay(), that's peanuts
compared to the error with the software loop.

If your timer ticks at 1MHz, then maybe it's a bigger problem as
the error would be 1us, but then do you really want to use a
1MHz counter to implement udelay() which suffers from not knowing
where in its count cycle you start - if you request 1us, and you
wait for two ticks, you could be waiting close to 2us.  Probably
not the best choice if you're trying to bitbang a serial bus since
it'll make everything twice as slow as using the software delay
loop!

It's really all about balances and tradeoffs.

> > If we want udelay() to have this behaviour, it needs to _always_ have
> > this behaviour irrespective of the implementation.  So that means
> > the loops_per_jiffy version also needs to be fixed in the same way,
> > which IMHO is impossible.
> 
> Let's say some piece of HW absolutely, positively, unequivocally,
> uncompromisingly, requires a strict minimum of 10 microseconds
> elapsing between operations A and B.
> 
> You say a driver writer must not write udelay(10);

Correct, because udelay() may return early.

> They have to take into account the possibility of under-delay.
> How much additional delay should they add?
> 10%? 20%? 50%? A percentage + a fixed quantity?
> 
> If there is an actual rule, then it could be incorporated in the
> loop-based implementation?

Well, there are two ways that udelay() gets used:

1. As a busy-wait for short intervals while waiting for hardware to
   produce an event, such as:

                /* wait */
                timeout = 1000;
                do {
                        tc_read(DP0_LTSTAT, &value);
                        udelay(1);
                } while ((!(value & LT_LOOPDONE)) && (--timeout));
                if (timeout == 0) {
                        dev_err(tc->dev, "Link training timeout!\n");

   Here, the "timeout" will be way over-estimated, so that a short
   udelay() has little effect, and to give the hardware more than
   enough time to respond.  The same is done in other drivers, eg:

        hdmi_phy_wait_i2c_done(hdmi, 1000);

static bool hdmi_phy_wait_i2c_done(struct dw_hdmi *hdmi, int msec)
{
        u32 val;

        while ((val = hdmi_readb(hdmi, HDMI_IH_I2CMPHY_STAT0) & 0x3) == 0) {
                if (msec-- == 0)
                        return false;
                udelay(1000);
        }
        hdmi_writeb(hdmi, val, HDMI_IH_I2CMPHY_STAT0);

   It probably doesn't take anywhere near 1 _second_ for the PHY to
   complete the write operation, but the point is to allow progress
   to be made if it did rather than the kernel just coming to a dead
   stop.

2. Drivers that use udelay() to produce bus timings, eg, i2c-algo-bit.c.
   The value of adap->udelay is the period of the clock.  There are
   a fairly small set of standard I2C bus maximum frequencies (100kHz,
   400kHz, we'll ignore the higher ones because they're not relevant
   here):

drivers/i2c/busses/i2c-hydra.c:     .udelay            = 5,
drivers/i2c/busses/i2c-versatile.c: .udelay    = 30,
drivers/i2c/busses/i2c-simtec.c:    pd->bit.udelay = 20;
drivers/i2c/busses/i2c-parport.c:   .udelay            = 10, /* ~50 kbps */
drivers/i2c/busses/i2c-parport.c:           adapter->algo_data.udelay = 50; /* ~10 kbps */
drivers/i2c/busses/i2c-acorn.c:     .udelay            = 80,
drivers/i2c/busses/i2c-via.c:       .udelay            = 5,
drivers/i2c/busses/i2c-parport-light.c:     .udelay            = 50,

   So we have 200kHz, 33kHz, 50kHz, 100kHz, 20kHz, 12kHz, etc.
   However, note that some of those (eg, parport) are writing to an
   ISA bus, and ISA buses are comparitively slow, and will reduce
   the cycle time below that of the specified delay.

   These figures are probably arrived at by repeated test and
   measurement of the bus behaviour over a range of conditions, rather
   than any particular fixed "we need to inflate by a particular %age
   and add a fixed value".

   I've been there - I've had a parallel port bit-banging a serial
   protocol using a driver with udelay(), and if you want it to
   perform with the minimum of overhead, it's very much a case of
   "connect the 'scope, measure the behaviour, adjust the software
   to cater for the overheads while leaving a margin."

All in all, there is not any nice answer to "I want udelay() to be
accurate" or even "I want udelay() to return only after the minimum
specified time".  There are ways we can do it, but the point is that
the kernel _as a whole_ can not make either of those guarantees to
driver authors, and driver authors must not rely on these functions
to produce accurate delays.

I'm sorry that I can't give you exact figures to your question, but
I'm trying to give you the full understanding about why this is the
case, and why you should not make the assumptions you want to about
these functions.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
