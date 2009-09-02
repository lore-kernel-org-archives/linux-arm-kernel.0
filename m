From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 2 Sep 2009 20:16:26 +0100
Subject: Samsung S3C6410 mainline merge coordination
In-Reply-To: <200909021203.n82C3USg020804@chronolytics.com>
References: <20090902031719.GK3838@prithivi.gnumonks.org>
	<200909021203.n82C3USg020804@chronolytics.com>
Message-ID: <20090902191626.GP25153@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 02, 2009 at 08:03:30AM -0400, David F. Carlson wrote:
> 
> 
> According to Harald Welte:
> > 
> > === plat-s3c/gpio.c ===
> > * off-by-one error, send fix mainline
> 
> I have added the bank-k and bank-l and submitted the patch to Ben.
> > 
> > === suspend-to-ram ===
> > * port to mainline and test, submit mainline
> 
> Another s3c issue that needs to be addressed further is the number of special purpose pins for power management, audio/video codec, otg detect, etc. that vary from mach to mach.  Many of the drivers do not have a means to use the mach-specific gpios -- and yet most are required to useful function.
> 
> The mach I am using has a whole "kluge" driver to handle the mach-specific gpios.  Oi.  These will have to be knocked down one by one for a decent save-restore to work.

I'm not sure what you are complaining about here (not helped by your mail
client's inability to wrap to something readable on a terminal - i.e. 76
characters per line).

Most GPIO setup is done in the bootloader, but there is more that sometimes
needs to be done in either the board file or occasionally the driver. The
drivers that need help with this, get passed a callback function with the
platform data to do the necessary setup (see the sdhci callbacks, i2c, etc).

I belive we've got this pretty much under control.

> I am also working on a "canonical" PWM backlight driver using the pwm_bl lcd support and the 6410 pwm timer support in next-s3c.  It is mostly working and should be ready to push soon.

I belive Peter Korsgaard's patch has already been merged to move the s3c24xx
pwm code into the s3c.
 
> I have a fairly decent SmartQ5/7 config and mach-smartq init file.  Much of this work (that I can test) can be back ported to the smdk6410 (that I can't test. :-)
> 
> > === video / multimedia ===
> > * needs a lot of thought
> > * support standard mainlien architecture wherever possible
> > ** 2D accelerated framebuffer
> > ** DRI/DRM/TTM/KMS
> > ** V4L
> 
> I have a "port" to next-s3c of the exiting sansumg-ap-2.6 media drivers.  They load.  It is a start anyway...  Another downside to these drivers is that their memory is statically allocated a boot-time.  I have asked Ben to consider taking this "port" into next-s3c as a basis for common work since it won't get better until people can work it.

Not desperately interested at the moment, thought needs to be put into
these drivers and they can generally live on their own.

> I am not sure the g2d driver is particular useful for a accel X driver.  The fifo mechanism with polling might work better than an ioctl-like interrupt blit-only based one.  It seems kinda expensive to trap the the kernel for every 2d-op.  Kinda like MSWindows then.  :-)

The best I can think of at the moment is that the kernel implements a way
to share the harware and that userspace libraries sort out the actuall
acceleration. There has been at least two attempts I know of to try and
export fbdev calls outside of the kernel and this seems to have fallen
rather flat.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
