From: laforge@gnumonks.org (Harald Welte)
Date: Thu, 3 Sep 2009 10:56:08 +0900
Subject: Samsung S3C6410 mainline merge coordination
In-Reply-To: <20090902191626.GP25153@trinity.fluff.org>
References: <20090902031719.GK3838@prithivi.gnumonks.org>
	<200909021203.n82C3USg020804@chronolytics.com>
	<20090902191626.GP25153@trinity.fluff.org>
Message-ID: <20090903015608.GB3917@prithivi.gnumonks.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ben and others,

On Wed, Sep 02, 2009 at 08:16:26PM +0100, Ben Dooks wrote:
> > Another s3c issue that needs to be addressed further is the number of
> > special purpose pins for power management, audio/video codec, otg detect,
> > etc. that vary from mach to mach.  Many of the drivers do not have a means
> > to use the mach-specific gpios -- and yet most are required to useful
> > function.
> > 
> > The mach I am using has a whole "kluge" driver to handle the mach-specific
> > gpios.  Oi.  These will have to be knocked down one by one for a decent
> > save-restore to work.
> 
> I'm not sure what you are complaining about here 

I would also be interested in learning more details about this.  Right now
I don't understand what David is referring to, sorry.

> Most GPIO setup is done in the bootloader, but there is more that sometimes
> needs to be done in either the board file or occasionally the driver. The
> drivers that need help with this, get passed a callback function with the
> platform data to do the necessary setup (see the sdhci callbacks, i2c, etc).

yes.  Though honestly speaking, I have my doubts if this is the best solution.
On the OMAP keypad driver e.g. they simply pass an array of GPIO numbers into
the driver, where the driver then simply makes gpiolib calls to reconfigure
the GPIO's.  No special SoC specific API, no custom callbacks that every
board will have to provide or at least assign.

What do you think about this approach vs. the current one?  Would you prefer
that (and would like patches for it), or rather keep the current code?

> > I am also working on a "canonical" PWM backlight driver using the pwm_bl
> > lcd support and the 6410 pwm timer support in next-s3c.  It is mostly
> > working and should be ready to push soon.
> 
> I belive Peter Korsgaard's patch has already been merged to move the s3c24xx
> pwm code into the s3c.

It's not yet in mainline, but if you believe it has been merged, then it should
be a matter of time, right?

Which brings us to the next question: where and how should s3c/s5p related
code be (re)based on?  Right now Samsung is working with 2.6.31-rc8 mainline
(and will keep syncing) both for their submit-missing-6410 work, as well as
for their current s5pc110 related development.

I've seen that s3c-next already contains s5pc100 code.  When is that supposed
to appear in mainline?  I would really want to avoid too many different trees
around.  

I think it is possible to rebase/merge the s5pc1xx code that samsung uses for
their development once now.  But I think the amount of extra work required to
continuously sync with a separately developed s5pc1xx tree/branch is too
much of a burden that they can take at this point.

Can we somehow work on a model where Samsung accepts contributions into
their tree?  As I understand s5pc1xx is still very fast moving ahead all the
time and even Samsung does not consider their code as being finished by any
means.

I think the dualism of Samsung's code and Ben Dooks + mainline code has been a
big resource waste in the past.  I'm looking for ways how this can be avoided
for future code, where everyone works on one codebase, even before something is
finished and considered ready for mainline.

In any case, a very clear statement about which tree is supposed to be the
master for what would already help.  the bjdooks tree has many branches, some
of them are months old so I am somewhat puzzled on what their status might be.

> > I have a "port" to next-s3c of the exiting sansumg-ap-2.6 media drivers.
> > They load.  It is a start anyway...  Another downside to these drivers is
> > that their memory is statically allocated a boot-time.  I have asked Ben to
> > consider taking this "port" into next-s3c as a basis for common work since
> > it won't get better until people can work it.
> 
> Not desperately interested at the moment, thought needs to be put into
> these drivers and they can generally live on their own.

I agree.

> > I am not sure the g2d driver is particular useful for a accel X driver.
> > The fifo mechanism with polling might work better than an ioctl-like
> > interrupt blit-only based one.  It seems kinda expensive to trap the the
> > kernel for every 2d-op.  Kinda like MSWindows then.  :-)
> 
> The best I can think of at the moment is that the kernel implements a way
> to share the harware and that userspace libraries sort out the actuall
> acceleration. There has been at least two attempts I know of to try and
> export fbdev calls outside of the kernel and this seems to have fallen
> rather flat.

I agree that the current Samsung vide/media driver architecture is far from
being in line with those few standards that exist in the Linux graphics world.

Also, the hardware (which only works on phyiscal memory, i.e. physically
contiguous blocks) makes it hard to fit into Xorg that obviously deals with
virtual memory.

Furthermore, the Linux/FOSS graphics world is lacking any shared/common
infrastructure for things such as hardware video codecs.  In any case, I
personally think a lot of this should live outside the kernel, except
the framebuffer and v4l support.

So yes, this needs a lot of thought and work, and I would rather want to see
the less controversial 6410 bugfixes and drivers as well as the core support
for the s5pc100 go in soon rather than spending months and months working on
fancy jpeg accelerators...

-- 
- Harald Welte <laforge@gnumonks.org>           http://laforge.gnumonks.org/
============================================================================
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)
