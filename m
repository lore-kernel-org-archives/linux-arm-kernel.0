From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 15 Sep 2015 15:29:13 +0100
Subject: I.MX6 HDMI support in v4.2
In-Reply-To: <m3wpvs0wvu.fsf@t19.piap.pl>
References: <m3bnde5whx.fsf@t19.piap.pl>
 <20150907112555.GS21084@n2100.arm.linux.org.uk>
 <m337yp5gvv.fsf@t19.piap.pl>
 <1441709778.13536.8.camel@pengutronix.de>
 <m3bnd52y4s.fsf@t19.piap.pl> <m337yg2ip4.fsf@t19.piap.pl>
 <20150915101220.GQ21084@n2100.arm.linux.org.uk>
 <m3wpvs0wvu.fsf@t19.piap.pl>
Message-ID: <20150915142913.GV21084@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 15, 2015 at 01:01:25PM +0200, Krzysztof Ha?asa wrote:
> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
> > Let's not forget that Dove hardware is slower than iMX6, so I think that
> > iMX6 should manage to comfortably achieve the 16.6ms required for
> > frame-by-frame display from your program.
> 
> Interestingly, i.MX6 seems to achive about 3.2 ms, which is much faster.
> If not for the missing color planes (and scaling), it would be perfect.
> (and I only need 30 FPS).

That means iMX6 isn't synchronising to the vertical sync, so would be
subject to tearing.

> 
> > Now, as for using the GPU, X server analysis:
> > - Again about 1ms between select() and read() of the event
> > - 1ms to the first WAIT_VBLANK ioctl on the display adapter to read the
> >   last VSYNC time
> > - 200us later to map the user pointer
> > - 300us to the WAIT_VBLANK ioctl to wait for the vblank (which takes in this
> >   instance 3.5ms to fire)
> > - 130us to first attempt to submit the GPU queue, which returns -EAGAIN
> >   after 6.4ms
> > - second attempt takes 9.5ms to complete successfully
> > - 1ms (with intervening SIGALRM handler) to wait for the GPU to finish,
> >   which takes 11.5ms
> > - 450us to ask DRM to release the user pointer buffer, which takes 9.4ms
> > - 1ms (with intervening SIGALRM handler) to report completion of the operation
> > - The X server then takes about 4ms to get back to calling select().
> 
> Sure, I know it has to be slower.
> 
> So this takes (on Dove) about 50 ms (at 1024x768), thus is way too slow
> to display video at this (or higher) resolution and frame rate.
> On i.MX6q, it takes about 66 - 74 ms, depending on actual clock speed
> (frequency scaling, up to 1 GHz).

It's interesting that iMX6 takes longer - without analysing what's going
on, I'd guess that will be because the GC320's memory bandwidth is
throttled compared to Dove.

iMX6 seems to have a problem with the bus arbitration in that each master
which can access DDR is given a fixed timeslot, whether or not there are
any other masters wanting access.  Performance measurement with 64-bit
DDR has shown that out of iMX6Q,D,DL,S the iMX6DL performs the best for
raw IO as there are fewer masters (fewer CPUs and fewer peripherals
wanting DDR access), so the timeslots are bigger.

I've found that it is very difficult to get iMX6's GPUs to out-perform
neon optimised libpixman in terms of performance measurements - and I
think the reason for this is because both Neon optimised libpixman and
the GPUs are running up against the same bottleneck - the available
DDR bandwidth.  However, what you do get is CPU offload of that effort
- filling one of those non-CPU DDR access timeslots with useful work,
freeing up the CPU DDR timeslot to do other tasks.

I have no idea how much truth there is to this, this is all based upon
performance measurement, and drawing conclusions from those measurements.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
