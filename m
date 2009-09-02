From: dave@chronolytics.com (David F. Carlson)
Date: Wed, 2 Sep 2009 08:03:30 -0400 (EDT)
Subject: Samsung S3C6410 mainline merge coordination
In-Reply-To: <20090902031719.GK3838@prithivi.gnumonks.org>
Message-ID: <200909021203.n82C3USg020804@chronolytics.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



According to Harald Welte:
> 
> === plat-s3c/gpio.c ===
> * off-by-one error, send fix mainline

I have added the bank-k and bank-l and submitted the patch to Ben.
> 
> === suspend-to-ram ===
> * port to mainline and test, submit mainline

Another s3c issue that needs to be addressed further is the number of special purpose pins for power management, audio/video codec, otg detect, etc. that vary from mach to mach.  Many of the drivers do not have a means to use the mach-specific gpios -- and yet most are required to useful function.

The mach I am using has a whole "kluge" driver to handle the mach-specific gpios.  Oi.  These will have to be knocked down one by one for a decent save-restore to work.
> 
> 
> === adc / touchscreen ===
I too have "ported" a touchscreen impl.  I didn't know others were working it...

I have ditched the 6410-adc stuff in favor of the "common" s3c api.  From my read the 12bit adc is supported as-is via a platdata:

static struct s3c_adc_mach_info s3c_adc_platform = {
   /* s3c6410 support 12-bit resolution */
   .delay   =  10000,
   .presc   =  49,
   .resolution =  12,
};


I am also working on a "canonical" PWM backlight driver using the pwm_bl lcd support and the 6410 pwm timer support in next-s3c.  It is mostly working and should be ready to push soon.

I have a fairly decent SmartQ5/7 config and mach-smartq init file.  Much of this work (that I can test) can be back ported to the smdk6410 (that I can't test. :-)

> === video / multimedia ===
> * needs a lot of thought
> * support standard mainlien architecture wherever possible
> ** 2D accelerated framebuffer
> ** DRI/DRM/TTM/KMS
> ** V4L

I have a "port" to next-s3c of the exiting sansumg-ap-2.6 media drivers.  They load.  It is a start anyway...  Another downside to these drivers is that their memory is statically allocated a boot-time.  I have asked Ben to consider taking this "port" into next-s3c as a basis for common work since it won't get better until people can work it.

I am not sure the g2d driver is particular useful for a accel X driver.  The fifo mechanism with polling might work better than an ioctl-like interrupt blit-only based one.  It seems kinda expensive to trap the the kernel for every 2d-op.  Kinda like MSWindows then.  :-)
> 
> 

David F. Carlson    Chronolytics, Inc.  Rochester, NY
mailto:dave at chronolytics.com            http://www.chronolytics.com

"The faster I go, the behinder I get." --Lewis Carroll
