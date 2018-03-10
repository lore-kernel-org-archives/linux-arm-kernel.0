From: pavel@ucw.cz (Pavel Machek)
Date: Sat, 10 Mar 2018 13:00:53 +0100
Subject: Nokia N900: v4.16-rc4: oops in iio when grepping sysfs
In-Reply-To: <1bb9aa1e-1a78-5d1c-d2d6-f2cd6b925f31@metafoo.de>
References: <20180309221220.GA15272@amd> <20180309222821.GA16973@kroah.com>
 <20180309230124.GA17721@amd>
 <1bb9aa1e-1a78-5d1c-d2d6-f2cd6b925f31@metafoo.de>
Message-ID: <20180310120053.GB31614@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On Sat 2018-03-10 12:19:29, Lars-Peter Clausen wrote:
> On 03/10/2018 12:01 AM, Pavel Machek wrote:
> [...]
> >> What file are you opening to cause this?
> > 
> > Strace says:
> > 
> > openat(7, "in_intensity_both_thresh_rising_en",
> >>> O_RDONLY|O_LARGEFILE|O_NOFOLLOW) = 3
> > fstat64(3, {st_mode=S_IFREG|0644, st_size=4096, ...}) = 0
> > ioctl(3, SNDCTL_TMR_TIMEBASE or TCGETS, 0xbe83b714) = -1 ENOTTY
> >>> (Inappropriate ioctl for device)
> > read(3,
> > Message from syslogd at localhost at Mar  9 23:54:39 ...
> >  kernel:[ 3097.357696] Internal error: Oops: 80000007 [#2] ARM
> > 
> > So that would be:
> > 
> > ./devices/platform/68000000.ocp/48072000.i2c/i2c-2/2-0029/iio:device1/events/in_intensity_both_thresh_rising_en
> > 
> > And indeed, manually cat-ing that file reproduces the problem.
> > 
> > pavel at n900:/sys/devices/platform/68000000.ocp/48072000.i2c/i2c-2/2-0029/iio:device1$
> > cat name
> > tsl2563
> > 
> > I can not find tsl2563 in MAINTAINERS, file is
> > ./drivers/iio/light/tsl2563.c . I added few people pointed by git log.
> 
> The driver registers event attributes, but does not provide a handle to
> access those attributes.
> 
> Now the question is how to best handle this case.
> 
> 1) Return an error when the device is registered and abort registration
> 2) Skip registering the event attributes
> 3) Skip registering the event attributes, but print a warning
> 4) Register the attributes, but return an error when they are accessed
> 
> I'd prefer 2 since it offers a nice method of disabling all events for a
> device (e.g. if not interrupt is provided).

2 works for me.

Tested-by: Pavel Machek <pavel@ucw.cz>
Reported-by: Pavel Machek <pavel@ucw.cz>

Now grep -ri asdfasdf /sys finishes.

Thanks,
								Pavel

> --- a/drivers/iio/industrialio-event.c
> +++ b/drivers/iio/industrialio-event.c
> @@ -477,7 +477,8 @@ int iio_device_register_eventset(struct iio_dev
>  	struct attribute **attr;
> 
>  	if (!(indio_dev->info->event_attrs ||
> -	      iio_check_for_dynamic_events(indio_dev)))
> +	      iio_check_for_dynamic_events(indio_dev)) ||
> +	    !indio_dev->info->read_event_config)
>  		return 0;
> 
>  	indio_dev->event_interface =

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180310/b613357c/attachment.sig>
